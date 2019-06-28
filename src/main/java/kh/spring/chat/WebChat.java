package kh.spring.chat;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value="/chat", configurator=HttpSessionSetter.class)
public class WebChat {
	//멀티쓰레드
	//참여한 사람들의 소켓정보를 알고있어야 모두에게 뿌려줄수 있다.
	//웹소켓 세션이 생긴다. (http세션이랑 다름)

	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<Session>());
	private static Map<Session,	String> idList = new HashMap<Session, String>();
	//멀티채팅때 싱크로나이즈드.
	
	@OnMessage
	public void onMessage(String message, Session session) throws Exception {

		synchronized (clients) {
			for(Session each : clients) {
				if(each != session) {//자기자신에게는 메세지를 보내지 않음		
					each.getBasicRemote().sendText("<div class=you>"+idList.get(session)+" 님 : "+ message + "</div>");
				}else {
					each.getBasicRemote().sendText("<div class=me>나 : "+ message + "</div>");
				}
			}
		}
	}

	@OnOpen
	public void onOpen(Session session, EndpointConfig ec) {
		//함수이름은 달라도 상관없지만, 어노테이션 OnOpen은 꼭 있어야한다.
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		HttpSession hsession = (HttpSession) ec.getUserProperties().get("hsession");
		String id = (String) hsession.getAttribute("loginID");
		System.out.println(id);
		//이런식으로 활용~!
			
		System.out.println(sdf.format(System.currentTimeMillis())+" : 접속자 발생");
		clients.add(session);
		idList.put(session, id);
	}

	@OnClose
	public void onClose(Session session) {
		clients.remove(session);
	}
}

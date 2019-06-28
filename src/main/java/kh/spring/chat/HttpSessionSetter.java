package kh.spring.chat;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

public class HttpSessionSetter extends ServerEndpointConfig.Configurator{
	//extends 한거 : 이너클래스
	
	@Override
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response) {
		HttpSession hsession = (HttpSession) request.getHttpSession();
		//로그인한 사람만 채팅에 접속하도록하고, 고정된 아이디로 채팅함.
		//1. 이 세션값을 sec에 저장해놓고, 
		sec.getUserProperties().put("hsession", hsession);
		
		System.out.println(hsession);
		System.out.println(sec);
		System.out.println(sec.getUserProperties());
		//2. onOpen 에 EndpointConfig  를 매개변수로 받는다.
		// Handshake 해주는 이 클래스가 연결고리!
		// 꼭 이 방법만 있는건 아니다.
	}
}

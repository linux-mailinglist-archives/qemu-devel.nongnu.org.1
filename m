Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F87C8016
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD57-0005R8-Cn; Fri, 13 Oct 2023 03:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4x-00045S-08
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4v-0007BH-6f
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-406650da82bso18278685e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183963; x=1697788763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szRY5OVua4jMraaGx0Wxad48cfHGRUEd9LK/mYhb6Xk=;
 b=UoQ4a9zC5w15munDEKDgWeakaaQuJlizDeD6EMPom50ThQLYpgWeYYThXQPB//TmAn
 3buHUdeJhn/Zz2i8ev8be08oBleTtSuwcihI70d8iITMkGo/bgaKEWoErvWMIcaMCluO
 2ee464b+bm6g6y/yTByo7SgnGVQce7uHfnY6Ipn3AVIh5Zr/Q70qouhesnL1jIAb9oDH
 J5oCudlL24P3iKal4JPEvNiNerypjJjH0ZUcNEE/4XmSFzn+vWZys448kjgyUHRK16nL
 joROdEsd2BF038fRgMB1YTgs9+SN/r3r7cAwDaB4gw/Fsj97+sbtrItsPG21EodfEGJN
 8TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183963; x=1697788763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szRY5OVua4jMraaGx0Wxad48cfHGRUEd9LK/mYhb6Xk=;
 b=ToyJJglsCcsU/ILjzh06SSo6P91nbhs2R7DMvH4WB912I2IIRR+CkDZyo4uGj+FJyF
 VVuCaAKOGS47xYHuItCB+qx46flBhRQI/3qmlatMttuRfO/k4NH0s9QwF6eg+rSrL6Tx
 uKKWFcdf9kTZWdWTVR3kQvYXwBWHCgxRvsvNpYAASWUisO17rMvOkdezxkIXj3DuB+ZB
 KiSxGIl5vmhnxXrU7z/L4lYd+NyoxXWkc7h3dRu3vvElJYIBhxzRTMtqYvNNBAF96NUi
 w/jYqG1vxY2rJD+pw0XVuQltMwHgJUSC1S7doOvWHf+2h2ga8YJH6N3FjUqKdW6RVXNF
 aFzA==
X-Gm-Message-State: AOJu0Yzh9W/E1l0Cqr5INhHqlTXweJOK89I0k5s+mV5jjceMg0gqPFGj
 UW42NQr2UpHfi7P/ATORfONYnR8AW1PCZh75SzA=
X-Google-Smtp-Source: AGHT+IFBKoEqwd6Kd6y7Vquwu31imb1BODlqywIP9lR8/QPbQ2uYXJ7s1kpIowq5CFQMh0g0W4RqLQ==
X-Received: by 2002:a05:600c:20b:b0:404:fc52:a3c6 with SMTP id
 11-20020a05600c020b00b00404fc52a3c6mr23944835wmi.25.1697183963582; 
 Fri, 13 Oct 2023 00:59:23 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:23 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v2 51/78] chardev: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:18 +0300
Message-Id: <7f3ef498c442a160fb72d745b975decba7e4bbe4.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 73947da188..1562e066a4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -549,34 +549,34 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
 static char *qemu_chr_compute_filename(SocketChardev *s)
 {
     struct sockaddr_storage *ss = &s->sioc->localAddr;
     struct sockaddr_storage *ps = &s->sioc->remoteAddr;
     socklen_t ss_len = s->sioc->localAddrLen;
     socklen_t ps_len = s->sioc->remoteAddrLen;
     char shost[NI_MAXHOST], sserv[NI_MAXSERV];
     char phost[NI_MAXHOST], pserv[NI_MAXSERV];
     const char *left = "", *right = "";
 
     switch (ss->ss_family) {
     case AF_UNIX:
         return g_strdup_printf("unix:%s%s",
                                ((struct sockaddr_un *)(ss))->sun_path,
                                s->is_listen ? ",server=on" : "");
     case AF_INET6:
         left  = "[";
         right = "]";
-        /* fall through */
+        fallthrough;
     case AF_INET:
         getnameinfo((struct sockaddr *) ss, ss_len, shost, sizeof(shost),
                     sserv, sizeof(sserv), NI_NUMERICHOST | NI_NUMERICSERV);
         getnameinfo((struct sockaddr *) ps, ps_len, phost, sizeof(phost),
                     pserv, sizeof(pserv), NI_NUMERICHOST | NI_NUMERICSERV);
         return g_strdup_printf("%s:%s%s%s:%s%s <-> %s%s%s:%s",
                                qemu_chr_socket_protocol(s),
                                left, shost, right, sserv,
                                s->is_listen ? ",server=on" : "",
                                left, phost, right, pserv);
 
     default:
         return g_strdup_printf("unknown");
     }
 }
-- 
2.39.2



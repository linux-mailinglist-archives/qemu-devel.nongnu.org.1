Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E517C7F1F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCzE-0004iN-RP; Fri, 13 Oct 2023 03:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxv-0001K9-4B
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxb-0005GV-Iw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-405361bb9f7so19252315e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183510; x=1697788310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szRY5OVua4jMraaGx0Wxad48cfHGRUEd9LK/mYhb6Xk=;
 b=ublIUZfnjQ373T60q6lqe4wIPkNPgdjSk0DLd3+GyCZzFX4pQITcJXVTjhFAV6BoOt
 Eaiussk+J+um8UPYQn5+0xS7VPFR08bCjuAyz6JzMDlcBnyHulAM+HNffUveR0PGaPwD
 rNhSxHPD0ZJQFDPbb3bo6eQwCx3QLvQTUHwi43+XOe/ycd3LGi2MY+5uPnguoCx/cUXJ
 eE2T0VgVgSLfWndfdFybxkY01wz7dT8CCiZvLqPFHpOg1TNc0JVliJGv22rt6kPEvjsB
 mBtLMx0M8YxzzoihwuSSO71okcCbqDhkaMmV+2jJrNLn2GW/NdsmdPyU9VqgOpvgedm6
 ZZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183510; x=1697788310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szRY5OVua4jMraaGx0Wxad48cfHGRUEd9LK/mYhb6Xk=;
 b=QhgrFkoK+wk8rF+W4QAyEJvhBuV6mKgWytOZUDUiAETSW4Ui+f79lJ5XV3LOmuPGH5
 0KhfrKU+FF77Zbmtb6S6X+nbnA0wwupK99cjOU6iUWMF/yHkTmjwmeTtEszOJIrwi9Rm
 Cfvb4IoSchhcmyTwkAgP1XDwFYG1q+odkBPc8mOKfrHuSfDt2RM85+2IamRn9jwK6riH
 xGvb8p5hxQGd9gIeH+xqCSyOvbJXd5jCdd+flQEYWEGurA8Ku1Wlz6YxANZEk2JkKvCQ
 LEIJRcyjKYUEiMQyyXGuDha+amZXUF/rLj2QYFs3KV5VktQAg6MKRaQVb+M94lZVywXd
 CwBQ==
X-Gm-Message-State: AOJu0Yy3b3IQmTqzAHXvWviZPjFA29peSomSVzBmyADZLybx90Pci8YC
 C6RIQf/xzFSnVd6zb0bh0gRWu7ULyUMVbXwBwzA=
X-Google-Smtp-Source: AGHT+IH2j3UgqrykNuunVSa2DHAf7+YZVc3HJCW81f2o4DJoMpOh3+vnHTOvpabc/bIHT43wp2LqnA==
X-Received: by 2002:a5d:4b0c:0:b0:32d:9524:386b with SMTP id
 v12-20020a5d4b0c000000b0032d9524386bmr2978347wrq.32.1697183509935; 
 Fri, 13 Oct 2023 00:51:49 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:49 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 51/78] chardev: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:09 +0300
Message-Id: <7f3ef498c442a160fb72d745b975decba7e4bbe4.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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



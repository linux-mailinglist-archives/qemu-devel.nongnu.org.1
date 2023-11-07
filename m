Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2117E3372
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:05:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPU-00018j-Nx; Mon, 06 Nov 2023 22:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COY-000787-Aw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000hT-6n
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:50 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so37335855ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326274; x=1699931074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3B5AGwWmkfcW3PKZyiJ5NeRwC9XFMc7EJS0UPbJQ5t0=;
 b=cTKAAm1yJNzK7bdDlBt0GLvUj7/tZjZ0KhSJHtanKtqBrruChjWyC3elpGl+AJiHlw
 VG0rf/CO28It3bZ3SLaNCcz4mq+Kjfeiy1qLftsuEeev+/E3it16NHlf0e1GUOU/jWfy
 jp9bxtHhDv/PmU4rrEcHvLV0q5ao0xa+ZECKbIntKZV7P0X4npHgSvEiNrUjhMwNmTEq
 VokI513C/AZeFxqBv1kis8htPJ8JjQWdsowhjavOxdGvi9nflGtmm8eLXeDSLL5DqiF7
 ZibHqZuTUlJgFtGKxQQtxrSIDTtAQtIVUJTfcWCJ9ExLRT02i90CeNfQT7o0nYDNeguy
 fSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326274; x=1699931074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3B5AGwWmkfcW3PKZyiJ5NeRwC9XFMc7EJS0UPbJQ5t0=;
 b=ULy5CIW2/S5gZnUEK+1ArncoTduihrWtJOZvQQWbQJSgKqqnxK9QCfcjuwlk0tfFr7
 LYc4igpqS2ACaxvzuELIYV47lPUzzyhn6IWSTfOQQUz9cg54mFb8BnPmsFbnRlahn5rd
 tEPLzPstxyD86QAOAa5TmxVELVdjktvkqd9OZDgjc+Pg2V6EjiRxbW8QmrKqWnzZAeY5
 IGs7po79pLwBgKiNt6De6WW80Ps1nLvGOud6+04V5XDlgPWN6on5BTUVW/Za8Z/nUeiY
 V025vcAaANge8JRG2ajHlf1CwHy3agGmd1goQNaBXjAGf99w6szZon4bP16PcNPm9hu+
 Iraw==
X-Gm-Message-State: AOJu0YwpZsTNeqbe0ChE/wS0AyIamdCJkrKyV3pHxxhyj7qIpsUGdM9h
 3z85TyBDF6MRPC0/ag/lO2DYGqQwzZ7u1Si4C9k=
X-Google-Smtp-Source: AGHT+IHUUdH3V+BMC9qHPAu35R6oa75L6r6b1mgilQ2PKuVMDvslVkIV59MfG+89TPD1+E54gnLQGg==
X-Received: by 2002:a17:902:bc42:b0:1ca:87e0:93e3 with SMTP id
 t2-20020a170902bc4200b001ca87e093e3mr26242256plz.7.1699326274465; 
 Mon, 06 Nov 2023 19:04:34 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/85] linux-user/hppa: Fixes for TARGET_ABI32
Date: Mon,  6 Nov 2023 19:03:17 -0800
Message-Id: <20231107030407.8979-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avoid target_ulong and use abi_* types.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index 17920e9ceb..d08a97dae6 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -86,7 +86,7 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
 
 static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
 {
-    target_ulong psw;
+    abi_ulong psw;
     int i;
 
     __get_user(psw, &sc->sc_gr[0]);
@@ -150,10 +150,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     haddr = ka->_sa_handler;
     if (haddr & 2) {
         /* Function descriptor.  */
-        target_ulong *fdesc, dest;
+        abi_ptr *fdesc, dest;
 
         haddr &= -4;
-        fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(target_ulong), 1);
+        fdesc = lock_user(VERIFY_READ, haddr, 2 * sizeof(abi_ptr), 1);
         if (!fdesc) {
             goto give_sigsegv;
         }
-- 
2.34.1



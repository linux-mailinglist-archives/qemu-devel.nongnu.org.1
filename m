Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A28DA7DEA40
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:41:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYs-00070b-LG; Wed, 01 Nov 2023 21:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXu-0005nv-E8
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:31:19 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXs-0001f1-Uq
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:54 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5b9a453d3d3so334510a12.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888651; x=1699493451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3B5AGwWmkfcW3PKZyiJ5NeRwC9XFMc7EJS0UPbJQ5t0=;
 b=OnjQckTdpPDFM6w6umRkTbVNrEflA88mj5OprcflX0yLF50KwtZDwv6MtUrq9ipV03
 Bnv7UNpNOp1WhiZmiItbfBCgq9o0CJhD1ST0rO3Am2z6yC1uwidczm9K7dM8zQwqYPBL
 f6/amKjiLiY1phwvcZZ/1h/6yszXVLKnuPLu0U+JyscrdQjllYaktByVZwKZbA7lpQv+
 niYWxuPxUdK6yM6+mAnca7+1vlpsskqd9FO3s51hW6K14htk3o0LTGnXKgNsriUnHHKT
 OqQH+bS+FQuYGsyilEN+P1J39nPDlDuAWn6BB4f6bf/WuY2IsK3YbctXqRtJnB/gZ8pA
 LH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888651; x=1699493451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3B5AGwWmkfcW3PKZyiJ5NeRwC9XFMc7EJS0UPbJQ5t0=;
 b=X/cykDmbu/DhnzTAeOSIPpQ7B4AKYwS4sw0fSpHLP9EYefXs/CsWQI5OQfmcgvBNlX
 f672YYj+86r+7r5+Lf/mOxkU5S0g7t2g9A+249z6JqFFBbEfaMNNSOwt9GtnX7oLrisY
 i6FK74WwGEFEd7z9da9Y98GczhE5FxWikH5BQgQWWbbJ3R5YeCHAtz2Bl7zyp8GqOXjs
 IS+j0Bhy0zdYFXAexYDqAl4VajwYq8yDXxEgH7EJQgUmdGpAQ6mIdPoS5R2bmUac7Vy9
 W5PmxNVD6vfrGU4lMFOFTtmM+KR1kudcPJ+LiGwhLaQgWeDMSCyYVMXLzdW5GS/5LfMd
 noWA==
X-Gm-Message-State: AOJu0YyAgKk1yWQKx0govVma44euj0TWe8rim2WYQX9UiUqtbbxHdEya
 cNBgSXTVmc4COXPPt8X1ukJ/AfmZKM4C0Ty+ZP0=
X-Google-Smtp-Source: AGHT+IFYyfCU2uhv5x2f5LwNwEmd6xkI+aHo7Aw4Pduqrip4i1MpZ5/AguWgdKQ+nve3Ua6FPhcJPw==
X-Received: by 2002:a05:6a21:193:b0:15d:c274:2eb1 with SMTP id
 le19-20020a056a21019300b0015dc2742eb1mr19697154pzb.10.1698888651243; 
 Wed, 01 Nov 2023 18:30:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 37/88] linux-user/hppa: Fixes for TARGET_ABI32
Date: Wed,  1 Nov 2023 18:29:25 -0700
Message-Id: <20231102013016.369010-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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



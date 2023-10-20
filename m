Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98F07D1773
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLu-0007pW-PF; Fri, 20 Oct 2023 16:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLl-0007lt-8N
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLg-0008EJ-3G
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ba172c5f3dso1169952b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834637; x=1698439437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtkaJF9+gMYoqpzUR8ATyW8aKIy9V4St1iGFcMEqLNY=;
 b=Q1kQJfKi0tLI6b2j2sfX3Ct8L/VNVY4Leijjc9HzBwts34D7JovNpFb/F9PNb9Imxd
 sbYN1kUL81zZRKscpn3mmWHdSoAACULSeZzwsqedrKLeizHhnbBXit5u1VxwFB4yaVSO
 nqOwbnqxZfpsmSW6UnZ1ydxt/kC0yFPpEQXTp78+ZgyVpNb5WsBj+d1zZF3oa3NiaL7U
 FcxhrBadfuGHAsLCsokyQFjgAt3zxD2X5gzNH82U10ZEH0LMoNGD59EVN/JhujWL5igX
 SdNjQpMzIQYF2Zfy4wi2fRFkyhJfZsxBAYWn2/CxHtrNRkVMGwG/UPoCx40hhfQ8RjOH
 MS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834637; x=1698439437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtkaJF9+gMYoqpzUR8ATyW8aKIy9V4St1iGFcMEqLNY=;
 b=ad9zRFLH+8L5YdEBz9lkt2mrg7zOT3vFlpCbnggG0Ev+9JgY5Uy//egrJURsGenMcO
 cTuoYTcX37IHbq+bBjf+huveKfFNgQySGxeXyEqH0P+p3vN0+PeKrQJIV8JAWuwaNsiR
 zmW0CkdyNO4AYyRczrdcHiSY5GvVJgI5AY7sJCPyJw0ebsv72gt2wT0DUIkCOjXAsY88
 +IFI8vyKZkNyoHKp4bEtkY8tUZeLm7X16PDiijr5WyeMIGaU5lEeX4HGXTLVzXGhVdTU
 ExlHI4p5AlDJaqSbTXs+ONZSnxUEr/DVbzDTWaQGg8uyik/lSN/4w9/10DFht8kBASfj
 GCuA==
X-Gm-Message-State: AOJu0YwjVUcl5DeUAi5MnktahASDo/lb4EyD7C0kxm5Ijs5hRQ7+TJP7
 Vrelwwl+prhB5a7Q/ftC0FajEVyY3i/M70gI1WA=
X-Google-Smtp-Source: AGHT+IGM//x5ApiXin/v3nGC26YxLavWQe1ptKNFzJjWZ1x/zIB48HDQf5DRgDfmhQmpXDq3+vPXeA==
X-Received: by 2002:a05:6a21:47c6:b0:174:f06:34dc with SMTP id
 as6-20020a056a2147c600b001740f0634dcmr2418905pzc.28.1697834637418; 
 Fri, 20 Oct 2023 13:43:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 27/65] linux-user/hppa: Fixes for TARGET_ABI32
Date: Fri, 20 Oct 2023 13:42:53 -0700
Message-Id: <20231020204331.139847-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Avoid target_ulong and use abi_* types.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/hppa/signal.c b/linux-user/hppa/signal.c
index ec5f5412d1..4400ce4df4 100644
--- a/linux-user/hppa/signal.c
+++ b/linux-user/hppa/signal.c
@@ -72,7 +72,7 @@ static void setup_sigcontext(struct target_sigcontext *sc, CPUArchState *env)
 
 static void restore_sigcontext(CPUArchState *env, struct target_sigcontext *sc)
 {
-    target_ulong psw;
+    abi_ulong psw;
     int i;
 
     __get_user(psw, &sc->sc_gr[0]);
@@ -146,10 +146,10 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
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



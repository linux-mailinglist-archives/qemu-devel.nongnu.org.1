Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD937DC1C9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:21:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeL-0001Ll-Tk; Mon, 30 Oct 2023 17:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdf-0000yn-N6
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:38 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZda-0006TW-KM
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so6033385ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700649; x=1699305449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DJYOGFevT1c73O/W4pBjxGvOP2r/M3Vo19QIR1W5oz0=;
 b=P3sO90mNgq42Zz67d72qsug/RpH+FJbh4I4Pghaxum+ipOKr801MEEBxGKVlhOe8hO
 D/Eqt8PiMDbNGg8L5x87/DmlgDN8rYjXoUIEqqhcu58Lew/G7cjVMCq90uBAs57XxT6F
 QSXIjzJrpgaccqk+8gPNf2VlCHTJYUM5A9jPb/TvLhe0BIWQoveCAzpC/JOixHMIwYMy
 BzL+IIMdXUpp4CLsm6hb3tfFFWK3J9WLilkE+JAQMV2WNSEkLM/xVIcFo+9tsl8f52Qm
 ez3FqlPZTcPtpvwgDAeHuoNBi7IJj4PscrZh6yn3hNezIkdX85yyzs1xhyXHPd8LVE8H
 MMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700649; x=1699305449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DJYOGFevT1c73O/W4pBjxGvOP2r/M3Vo19QIR1W5oz0=;
 b=mKSsZWYUshnw9VhqUNEU/IdsSeuwHYqyyBwVpCsXNOydZFNM61LcXdIrfdcTuLPc1N
 tVFmk469m73iUeJDKTzgEmrGihuKeQVkhbAV6ZHBbCXvwI/ZNs/OlPbx5HS7H9wnKY4z
 QgR6GqqENEMmPIKVcXblFIQIeKEISqsdsYtYsngrL7OOkCrgtZ7luzcB146FkUwKwjmc
 6VpA/CWWLk/Gc8HPXgoY2jjYyyzdk/kIVVoWC2RrLP+MmcH9OBWJFCYAegvVM7hlL0F0
 UgI7PNb+9lcYi6621KN699mMk+nVRyJGWHjvN6Hnp5m0lMFeINZDzjO87Wbb4l0EbYGO
 cMyA==
X-Gm-Message-State: AOJu0YyCRgBhjJqalKF18gpcPk0pXz7Jk7b5uG8vAFxnlJwo+KBQhv2O
 DR85I91U1sp7wx8j+JkLF2ncih6np4E83PSc5SY=
X-Google-Smtp-Source: AGHT+IGSVocVrdfNALT5tH654foqKTWqgcXSxeSo88PjfACJuZ0FGuj9sPcmmE8ThS8vTbHh+8z+4g==
X-Received: by 2002:a17:903:228f:b0:1cc:543b:b361 with SMTP id
 b15-20020a170903228f00b001cc543bb361mr2327939plh.43.1698700649052; 
 Mon, 30 Oct 2023 14:17:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/21] linux-user: Fix guest signal remapping after adjusting
 SIGABRT
Date: Mon, 30 Oct 2023 14:17:07 -0700
Message-Id: <20231030211727.165090-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The arithmetic within the loop was not adjusted properly after SIGRTMIN
was stolen for the guest SIGABRT.  The effect was that the guest libc
could not send itself __SIGRTMIN to wake sleeping threads.

Fixes: 38ee0a7dfb4b ("linux-user: Remap guest SIGABRT")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1967
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 3b8efec89f..b35d1e512f 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -536,11 +536,10 @@ static void signal_table_init(void)
     host_to_target_signal_table[SIGABRT] = 0;
     host_to_target_signal_table[hsig++] = TARGET_SIGABRT;
 
-    for (; hsig <= SIGRTMAX; hsig++) {
-        tsig = hsig - SIGRTMIN + TARGET_SIGRTMIN;
-        if (tsig <= TARGET_NSIG) {
-            host_to_target_signal_table[hsig] = tsig;
-        }
+    for (tsig = TARGET_SIGRTMIN;
+         hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
+         hsig++, tsig++) {
+        host_to_target_signal_table[hsig] = tsig;
     }
 
     /* Invert the mapping that has already been assigned. */
-- 
2.34.1



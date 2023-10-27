Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1617DA342
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 00:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwV3c-0007RL-I4; Fri, 27 Oct 2023 18:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwV3b-0007RD-8t
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 18:11:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwV3Z-0003on-IW
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 18:11:55 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so2172800a91.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698444711; x=1699049511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sRY84Su7XMV7uRNIb1/RJ3dBq2s8KkQA/2NcctEFcXo=;
 b=CkJ3PrmOwVwHnUHbYDQHbsZHMxxnXDLyQKZYW5bG1DDr28Pe8wHLkMaxlrFm2H6FqU
 jkoK8lAQkI6c/rx2vwaWps8eginno/bQDiE+TQEJFyo8puDfw3grZkjrF9TLj1F45K5E
 Tbotf++4YB2YGzhZVZDH3olJ2skoiYiK0+irNj3/+hzwVfEnF/LQBsoQq1q9WUG4FVIu
 YGsYHA3RQuLUvDcdVs80JqwFnoqTmz35gHOWerGaB+TDSla/mxsnp0gBsSE8awf/R5np
 XFdj7HNTnvulPpcV0gTm8njcF7gH4GfEGpMtaoMPHvm3O8vIUU97QwKmMC5U9iSq0R21
 TdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698444711; x=1699049511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sRY84Su7XMV7uRNIb1/RJ3dBq2s8KkQA/2NcctEFcXo=;
 b=O37hPHEV4W4j1S+yj9uVb02EVrLHV1KQvzbYU7/0KzLUuAwLd2pM2w9ntrHQIb5yZd
 J7bPbAXxBLEkghOuYi8eVLHhtdP3X4s/l0HxCyvaFrM7+p0scnEgOEJX5iIFvJslmieh
 eggE2YAnI1I1+MoGRc0ieTQPvuSvfgCsfUt3V5WvgaCNk4oHbRkaNhDHEiDphPObYJ3p
 4polCOuu+cacM59h2FNdkOvAQSs5zsY9oix/EYsaInOz1J1NLufEUDA++QCqoNCQRFhs
 GSAGwgyS2JBRVvMinjlOQm/KYNj7ROZLP05dOEDVP0yBKOqrVOvEZBkcXItGEGAouo4p
 smpw==
X-Gm-Message-State: AOJu0YwS2dILzNka4YURG8oWnMqIJ3/E4zuoQcCD9TSOUUU8aj7y9aFT
 ea9TopU+PdlGMR9E8MkhDPoLKCpf03VjQpbK2mA=
X-Google-Smtp-Source: AGHT+IEAklOCwC6Fwq1iOyPfqqcwcx8jc9BlL6V3jVJdIsRUPFfvkajMXL7Evs3NDO29mrpqrx//GA==
X-Received: by 2002:a17:90b:f06:b0:27d:694f:195d with SMTP id
 br6-20020a17090b0f0600b0027d694f195dmr3890744pjb.6.1698444711449; 
 Fri, 27 Oct 2023 15:11:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 p20-20020a17090ad31400b0026cecddfc58sm3674768pju.42.2023.10.27.15.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 15:11:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christophe.lyon@linaro.org,
	laurent@vivier.eu
Subject: [PATCH] linux-user: Fix guest signal remapping after adjusting SIGABRT
Date: Fri, 27 Oct 2023 15:11:50 -0700
Message-Id: <20231027221150.19807-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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



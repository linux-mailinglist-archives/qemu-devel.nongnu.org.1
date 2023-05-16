Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594AF705836
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:00:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0eL-0002lb-9m; Tue, 16 May 2023 15:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0000Lg-F7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:52 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cC-0003ks-BJ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:46 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-24e1d272b09so49421a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266340; x=1686858340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bikJAOfrqavvtaG/OvbZaIR8VQshwzSewGm6mEpCNLg=;
 b=qymJs5hFQcBNk7pgtlWLdEnvMh88D878yzujIu2US9RswMaMfdIsGG7O5pbJd4BXSx
 2j8W7ns3Pr/FD7bmJqR3ATH/5qYpJYjU4OHOdnjYTg0r+2wdpQ+9HvpUzg6NkoeyJrU6
 yWAg0g5BD8PyI3STTkyCywvCxMtO3G7lK1SIxT3IhEn5w4jPW/cg731/NAMU1RGH0m9D
 x9+EUEG2B/TaFUIpcEm6+F2CTwKxB0qm+KDN56cze3T84l+SuvApWPpmSFGFGYEXUtTN
 17dXCMrlcT/tjx05eAZ6GS9zaC8Z6CSh3vM6ReviZRxLdAglDbKAd7SXTvLiH+MxBoJK
 qbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266340; x=1686858340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bikJAOfrqavvtaG/OvbZaIR8VQshwzSewGm6mEpCNLg=;
 b=SUQijEXW1WkyTwCZRwux9NkQgFj2HDTWLgOqMOsl69C/OcPB6gIQNjA7BmUdgN7VYT
 CLiXCiXNhciEUyS/nn9QRMgn/HMUhitQLrPu2eb5bU3oXX6rpO7dsLPd1gYjpFcyfnoP
 GoY9F1Ks9WjPs/96SQYeM0+TiLV3wPhQbl5XZV+N8uxqohNRh8hbodUO5Jy/D0BTXfWe
 dnNZE5yB5IzF87EL37VQ1DX7Nx2ONdLsCxykYJVAq4yWgp5vVTq/kOwbQLqu8bRhbJ8r
 XkPOROkXl+IijC2BJyjTLdH7tco1dWbt4ROMZN1fJetpKUXxysP0KvuCV54OFD/oQ4BT
 eRtQ==
X-Gm-Message-State: AC+VfDxEDEMoj2lQ0zsbSXUSlwsDmn1CMBAyIKAJKh/j5q60Bw5QtXUv
 JviD8Q38AH0njL6Gebzoknsc2jwXmSbQyYSZiL0=
X-Google-Smtp-Source: ACHHUZ5/k2+cwP4y/HQ8mc+LXAuQyA5XHxwA1GOPUh6m+PG2zG6KWhD6SdnYvJoO67LoIh2i82GWgw==
X-Received: by 2002:a17:90a:d24f:b0:24e:4a1a:39a4 with SMTP id
 o15-20020a17090ad24f00b0024e4a1a39a4mr39553102pjw.17.1684266340481; 
 Tue, 16 May 2023 12:45:40 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 60/80] accel/tcg: Merge do_gen_mem_cb into caller
Date: Tue, 16 May 2023 12:41:25 -0700
Message-Id: <20230516194145.1749305-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

As do_gen_mem_cb is called once, merge it into gen_empty_mem_cb.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 04facd6305..907c5004a4 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -92,27 +92,6 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
                                 void *userdata)
 { }
 
-static void do_gen_mem_cb(TCGv vaddr, uint32_t info)
-{
-    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
-    TCGv_i32 meminfo = tcg_temp_ebb_new_i32();
-    TCGv_i64 vaddr64 = tcg_temp_ebb_new_i64();
-    TCGv_ptr udata = tcg_temp_ebb_new_ptr();
-
-    tcg_gen_movi_i32(meminfo, info);
-    tcg_gen_movi_ptr(udata, 0);
-    tcg_gen_ld_i32(cpu_index, cpu_env,
-                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    tcg_gen_extu_tl_i64(vaddr64, vaddr);
-
-    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, vaddr64, udata);
-
-    tcg_temp_free_ptr(udata);
-    tcg_temp_free_i64(vaddr64);
-    tcg_temp_free_i32(meminfo);
-    tcg_temp_free_i32(cpu_index);
-}
-
 static void gen_empty_udata_cb(void)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
@@ -147,7 +126,23 @@ static void gen_empty_inline_cb(void)
 
 static void gen_empty_mem_cb(TCGv addr, uint32_t info)
 {
-    do_gen_mem_cb(addr, info);
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_i32 meminfo = tcg_temp_ebb_new_i32();
+    TCGv_i64 addr64 = tcg_temp_ebb_new_i64();
+    TCGv_ptr udata = tcg_temp_ebb_new_ptr();
+
+    tcg_gen_movi_i32(meminfo, info);
+    tcg_gen_movi_ptr(udata, 0);
+    tcg_gen_ld_i32(cpu_index, cpu_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    tcg_gen_extu_tl_i64(addr64, addr);
+
+    gen_helper_plugin_vcpu_mem_cb(cpu_index, meminfo, addr64, udata);
+
+    tcg_temp_free_ptr(udata);
+    tcg_temp_free_i64(addr64);
+    tcg_temp_free_i32(meminfo);
+    tcg_temp_free_i32(cpu_index);
 }
 
 /*
-- 
2.34.1



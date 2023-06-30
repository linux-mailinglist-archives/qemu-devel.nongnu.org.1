Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF77743A6D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFByx-0007oO-Ls; Fri, 30 Jun 2023 07:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFByv-0007n0-5Y
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:08:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFByt-0004Fy-2h
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:08:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso996701f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 04:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688123281; x=1690715281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zw89zKLqPKWuYUFPdNCjuM/qmbFyEcz+s90r+GpMGWs=;
 b=D+EXyhbOnYaxJMqy1yQ5Sc5jMciIZabilxdLL2wqtizSxzbMNC1Nwxj+5nNsz0LZaM
 C0h8EGQAGKIyVxbp67oM9eNKXGufxeQ2DqWQ1Eb95QLEv4Vg3eZg7RK29Gw+Ksq1QBHJ
 5sgsqmCiLK5NNXZ+8pHxmq+1Kjau7nmhhyr0GxkWlnsT07thstfusajHeuqj7tT/8DAv
 6cIOqMwj5+fbouDDI2np4iH5RvrdqTCBH5r07nnP+OLho955nAFHrU3iMXta2rPWGF3i
 qlEZltQnlqsJXzkNFW0bGUkYbBMzLYOxhKZFXO4zJmp0Fpx75tHPsyKr9RbcLxQ+5Yv1
 +0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688123281; x=1690715281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zw89zKLqPKWuYUFPdNCjuM/qmbFyEcz+s90r+GpMGWs=;
 b=bhWFjTzpHWZGtGuBwKaBLdQ7rebmZgDXhk2KbpwzJw4zzAjlmjv6Fvnf7PCjfPgnxO
 0aKYi1fyIqQBcqAHI7rdIzAFfV0LXABaEGARhYapjGB1pRRcPeVBQT1WPM6Sto5xU/Wx
 1NYmL/EUVb5uSLwBLjVLKiwBtzUZPbUqcj77GXGSiALebn+SYCDd/hW93Y+SAgDxqiMx
 U9YuWpK0Cx2LXtTOusqspoM960ZYtoiGH9oluratIDtch0mDkd/0pNqs3pDrTW+mkrLF
 vri+77UBqylGmxGeLujUIpnxbVt0pNMKE3+bmsoRWEAnayUcwbOfPrRX+hRQpZG4z6AA
 fnpA==
X-Gm-Message-State: ABy/qLak/HgAnu3zzjCp6xbHqANr3fL0gYug5nxWGChyPVBNMAfdAbXv
 m1CaxCiSdcpAW88t91u0iAkdFA==
X-Google-Smtp-Source: APBJJlFCniEtcCNFutXmVRpCnGrfT48PWdmIwmbK7Njnv1nfczJ4KTSCPyEiU6BeJB4aXC4ApylDeA==
X-Received: by 2002:adf:fe0e:0:b0:313:df08:7b88 with SMTP id
 n14-20020adffe0e000000b00313df087b88mr1916048wrr.16.1688123281288; 
 Fri, 30 Jun 2023 04:08:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x18-20020adff0d2000000b003141e86e751sm2173621wro.5.2023.06.30.04.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 04:08:01 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FEEA1FFBB;
 Fri, 30 Jun 2023 12:08:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: make arm_casq_ptw CONFIG_TCG only
Date: Fri, 30 Jun 2023 12:07:56 +0100
Message-Id: <20230630110757.417758-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The ptw code is accessed by non-TCG code (specifically arm_pamax and
arm_cpu_get_phys_page_attrs_debug) but most of it is really only for
TCG emulation. Seeing as we already assert for a non TARGET_AARCH64
build lets extend the test rather than further messing with the ifdef
ladder.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
NB: I need this because I'm about to change the probe action is calls
and probes are very definitely TCG only operations through cputlb.c.
---
 target/arm/ptw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 422bf7e3b1..8cac685aa6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -628,7 +628,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#ifdef TARGET_AARCH64
+#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
@@ -708,7 +708,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 
     return cur_val;
 #else
-    /* AArch32 does not have FEAT_HADFS. */
+    /* AArch32 and non TCG guests do not have FEAT_HADFS. */
     g_assert_not_reached();
 #endif
 }
-- 
2.39.2



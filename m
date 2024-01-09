Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB19828855
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:39:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDFQ-00089a-P5; Tue, 09 Jan 2024 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNDF9-00088P-0l
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:38:18 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNDF2-0005oB-7i
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:38:11 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so1721300f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704811086; x=1705415886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/BAAkIR06a0xBg8aGBGeK/Zu3znoiAARSVRC2ZZbjsY=;
 b=FYvb4CGQ6PORoiUwWxQiHVC/CXrODTFF5JrDGoR7ZkpsGj+mgbf+v+SNVIIfVYxJsf
 teVz1wlGuOqqxisPRu1WZ9kXOmwIsbFovDVkfuq7lwF6UhwP9j0EvuPn4lVh221Sp/cX
 J6nQ7zm+Wb6E6E3iCwbHWhgf60C2gq2EwmIH/0pRnmvc1K8tTKrQqps9R0dgifgFKHLL
 iiSatLBHn3G6HSK2WNmOwRey7sqmHd0tO/G9nKp4hA9yQ6AbWD/OAaPTN3ifUbvtqKMg
 LX3EEC3dmo563Qothd7XSwC47Sq2jZlWFh0MJWUJyfTKnRuv3w6dAQm/Mm4VFBn13b0B
 snWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704811086; x=1705415886;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/BAAkIR06a0xBg8aGBGeK/Zu3znoiAARSVRC2ZZbjsY=;
 b=AaqFwjU0NHoqlt7tSiZXWeOHxkIDutU+kC7uvYmBm1rYMXPhnRbWqMzvWTYVdgocx1
 Zp9thj9NM0u/aV19PG9grMo0rTf225XJqEVhXi9GR/G/uN2CNYVMBCGJS/YzLUpH/Zqa
 ZYOzPuZgqEBEJ7dwS51LARBIHG2rhEagMxyIhDO94tvruBg5oOGOvbAyXw+Sl3T542m2
 wNSOO6xSt+PEgDusX4IkDSo9j+2krDLkn5Z83s6YQvapMB2U6dtAxccR0B45TPeXzWtv
 ixHnXRMnMz4FREaFLCdtVRYwdM5+6ybnypnNcgU00gyPDbbE8hmklLkrqK0Nz0fO6z7r
 JKnA==
X-Gm-Message-State: AOJu0Yw5dhUNHAuielS5b9ZbMgYOEupwUD/4/QxPuPfa9KEHBzGDxv4j
 dCtA1iWRfMATKRZrDeOKq4TXeIxnljDg+Q==
X-Google-Smtp-Source: AGHT+IEU8zP3IoTnRHVihVmEsLVR9nyj1XO0eOhMYbgqml3tZuJIiWv1JTuj1+RPFhLt9RoZLb4oVQ==
X-Received: by 2002:a05:600c:3488:b0:40e:52ab:d09b with SMTP id
 a8-20020a05600c348800b0040e52abd09bmr338077wmq.50.1704811085654; 
 Tue, 09 Jan 2024 06:38:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a5d5486000000b003375d8b0460sm2596466wrv.1.2024.01.09.06.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:38:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: arm_pamax() no longer needs to do feature
 propagation
Date: Tue,  9 Jan 2024 14:38:04 +0000
Message-Id: <20240109143804.1118307-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

In arm_pamax(), we need to cope with the virt board calling this
function on a CPU object which has been inited but not realize.
We used to do propagation of feature-flag implications (such as
"V7VE implies LPAE") at realize, so we have some code in arm_pamax()
which manually checks for both V7VE and LPAE feature flags.

In commit b8f7959f28c4f36 we moved the feature propagation for
almost all features from realize to post-init. That means that
now when the virt board calls arm_pamax(), the feature propagation
has been done. So we can drop the manual propagation handling
and check only for the feature we actually care about, which
is ARM_FEATURE_LPAE.

Retain the comment that the virt board is calling this function
with a not completely realized CPU object, because that is a
potential beartrap for later changes which is worth calling out.

(Note that b8f7959f28c4f36 actually fixed a bug in the arm_pamax()
handling: arm_pamax() was missing a check for ARM_FEATURE_V8, so it
incorrectly thought that the qemu-system-arm 'max' CPU did not have
LPAE and turned off 'highmem' support in the virt board.  Following
b8f7959f28c4f36 qemu-system-arm 'max' is treated the same as
'cortex-a15' and other v7 LPAE CPUs, because the generic feature
propagation code does correctly propagate V8 -> V7VE -> LPAE.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1762b058aec..0da1caae117 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -95,7 +95,10 @@ static const uint8_t pamax_map[] = {
     [6] = 52,
 };
 
-/* The cpu-specific constant value of PAMax; also used by hw/arm/virt. */
+/*
+ * The cpu-specific constant value of PAMax; also used by hw/arm/virt.
+ * Note that machvirt_init calls this on a CPU that is inited but not realized!
+ */
 unsigned int arm_pamax(ARMCPU *cpu)
 {
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
@@ -110,13 +113,8 @@ unsigned int arm_pamax(ARMCPU *cpu)
         return pamax_map[parange];
     }
 
-    /*
-     * In machvirt_init, we call arm_pamax on a cpu that is not fully
-     * initialized, so we can't rely on the propagation done in realize.
-     */
-    if (arm_feature(&cpu->env, ARM_FEATURE_LPAE) ||
-        arm_feature(&cpu->env, ARM_FEATURE_V7VE)) {
-        /* v7 with LPAE */
+    if (arm_feature(&cpu->env, ARM_FEATURE_LPAE)) {
+        /* v7 or v8 with LPAE */
         return 40;
     }
     /* Anything else */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AFE749EBE
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPif-0004Qs-Vo; Thu, 06 Jul 2023 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHPid-0004QY-Sr
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:12:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qHPib-0005lB-Vl
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:12:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142970df44so660036f8f.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 07:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688652744; x=1691244744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y8EcAtZee2xyMmG6qvAV2IgEtPw0oRg5VwhrhipzSYs=;
 b=JN2+eRKcb487n3IfDnwMiVDYw2P006KKtXU2S9h1ZJAPmy95/wStwSLHd1VdQy/EJN
 8hajgfH4gM+YCfQn5LEiLOL/ijpFZOVDrvOypr/sNyU+fMFyowL+S2VDK1YCCl2WU5bF
 Bk8PevrnrUuMcbAb025Hyv3/QEjNN699K8c+lRlCLxcZeGtdSzwLgesIgQwtHLfZ1gLN
 iBJkj8jOrzVaG05a30+W2FMQda6jTbwhZW+0FkqcqKq5jK2Y53DkJccAJkhHOji2cfCl
 5q0jk6Eio+pGjCBx3hgKlNVz7wApFLHhkh4xP5JxXs0amNI3r8bQmqHC6CKNZl52d9DC
 OF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688652744; x=1691244744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y8EcAtZee2xyMmG6qvAV2IgEtPw0oRg5VwhrhipzSYs=;
 b=LGi9RwLYZ1VYlWgoE6Tq/x9+x+ayeD4YJtAcCTJqCUYU1UH6WvuQiMyi9pb7a9OhSd
 DbwKB7zizKbUrIgP6mgux/wQvSpTgdx0Y9ySyD4hiY49bNn4YdN6WZEDzbuNxUr3doa6
 TV578hpFMe0ofDXqSwpuLgp9vIcc9MnG26rYqp0xBFXzyK1EkZ6q5aROb0P8uKjh/yI/
 UGjRZycYrOpPjCBAomXf9TWwntg9PszQgrah7qF3qiATJsVLXImQ9Ix6R+wtGl6mYvJs
 QGekGR64ZhJgTP7WOnW8L8ucoXtHA+53GiLc/izNn77EPr2HMNYcHyUvER/3TZe4Dpbg
 30pg==
X-Gm-Message-State: ABy/qLZbFnHw7x1MtAvzFr1X1FohZNVXTFz5jDRxO2LkJMmIFe/qFZNU
 fXC1eaLA4xJIcyXMLmzNpURv0Q==
X-Google-Smtp-Source: APBJJlFJgWRxWaHJgV8sOVJ/YWnZ4ECzdYKGUSrV6xYuFzVCKfZfyA1xo7HbiKERtxCvHffgDKy/CQ==
X-Received: by 2002:adf:e790:0:b0:314:824:3777 with SMTP id
 n16-20020adfe790000000b0031408243777mr1689836wrm.48.1688652744037; 
 Thu, 06 Jul 2023 07:12:24 -0700 (PDT)
Received: from localhost.localdomain ([2.219.138.198])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adff992000000b003142e438e8csm2008708wrr.26.2023.07.06.07.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:12:23 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] target/arm: Fix ptw parameters in S1_ptw_translate() for
 debug contexts
Date: Thu,  6 Jul 2023 15:08:51 +0100
Message-ID: <20230706140850.3007762-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x430.google.com
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

Arm TF-A fails to boot via semihosting following a recent change to the
MMU code. Semihosting attempts to read parameters passed by TF-A in
secure RAM via cpu_memory_rw_debug(). While performing the S1
translation, we call S1_ptw_translate() on the page table descriptor
address, with an MMU index of ARMMMUIdx_Phys_S. At the moment
S1_ptw_translate() doesn't interpret this as a secure access, and as a
result we attempt to read the page table descriptor from the non-secure
address space, which fails.

Fixes: fe4a5472ccd6 ("target/arm: Use get_phys_addr_with_struct in S1_ptw_translate")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
I'm not entirely sure why the semihosting parameters are accessed
through stage-1 translation rather than directly as physical addresses,
but I'm not familiar with semihosting.
---
 target/arm/ptw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9aaff1546a..e3a738c28e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -465,10 +465,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         S1Translate s2ptw = {
             .in_mmu_idx = s2_mmu_idx,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
-            .in_secure = s2_mmu_idx == ARMMMUIdx_Stage2_S,
-            .in_space = (s2_mmu_idx == ARMMMUIdx_Stage2_S ? ARMSS_Secure
-                         : space == ARMSS_Realm ? ARMSS_Realm
-                         : ARMSS_NonSecure),
+            .in_secure = is_secure,
+            .in_space = space,
             .in_debug = true,
         };
         GetPhysAddrResult s2 = { };
-- 
2.41.0



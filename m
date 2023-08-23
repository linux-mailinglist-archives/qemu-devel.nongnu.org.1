Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEEC785126
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhxI-0006Vq-Nm; Wed, 23 Aug 2023 03:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhxG-0006VY-Lb
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:07:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qYhxE-00043z-SQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:07:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so4708571f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 00:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1692774419; x=1693379219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JvqFLjsjUTfJaLVSyxitLTq0Nr1RR6VPuAyEzznU0UI=;
 b=GydaORqqhoj+sAjFy7p8afEBY+demOKM3Cg/wBbBrITF3g4jqHB2pRGFBK9J9xVKBK
 MAPpGYIUOmWWZ7MwafXKd69OaQjSwgH64aUTvCGuNdJpXE7EhQi/1uoCe4i7b68f2DRj
 TJ3BWHJKd2LRnVqzB0DTMJvEplDDXafvmggo3XZcDGz8gWJcR2smvVVeA/+jqOOAifst
 98tEHQ4XhbRqR6qpxFk+xD0w8dJ1v6RoqE8t4pysSMdsOnc7yBUT3Z1JMwK+zxZfeTZz
 uhepJJN894hKnGHpOcaYrIR+IWQ1FyoTVNWtaWwv5XpqzQGuPO27YerT8jgo2ViSwjKT
 /E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692774419; x=1693379219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvqFLjsjUTfJaLVSyxitLTq0Nr1RR6VPuAyEzznU0UI=;
 b=OpwCo3nV5tNOB+9DAOSLb5UEnFS29JAJOpRpsqfyajntZU6tvcHjhrXKFPc9jo1551
 vDL4CbdhRyNtoVsSnb1LTB7G3rC8NPSfvZPOB7vwtV5XxxJmHHveSNOtd7aW5m4bQuOi
 eZ+1oAn+hKk2oOTK/QhWI/hAWNP3M4pE3v//Kp5xuY+XuS+ErCiFE6/g9djBVzbvklqg
 BYIPWjtT5u+wjSSBamClxl/895Ds4G18TRr31QAVeRbBMkpPYGSVa/YgDVkmHcr6PZCb
 svABcDXyl3Kl6RV2a5M+a6ywnUK/nR1s/ue4TmHETMTOrEPSsalvqtJ2SL6M56FbQ5PQ
 aDPw==
X-Gm-Message-State: AOJu0Yy7bmkZJL8fVQfFUuj2qno2cSbAev5VfaLgW5SSeNiTF50I3y+0
 Z413xH+08ZL6Imvdk8o59ph8FP9+WWsDusAQu9E=
X-Google-Smtp-Source: AGHT+IG7x4XgWfcWuMVrSB1O5RNZFrF7vvbwlnQ/jgAIu/HiHoOhMGAuzVIgpvqnpFrQe14/0ZAIqA==
X-Received: by 2002:adf:fb87:0:b0:314:1b4d:bb27 with SMTP id
 a7-20020adffb87000000b003141b4dbb27mr7272910wrr.64.1692774419059; 
 Wed, 23 Aug 2023 00:06:59 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:d434:6b1d:751:97d0])
 by smtp.gmail.com with ESMTPSA id
 c3-20020adfe703000000b0031433443265sm17924811wrm.53.2023.08.23.00.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 00:06:58 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/3] hw/misc/sifive_test.c: replace exit(0) with proper
 shutdown
Date: Wed, 23 Aug 2023 09:06:56 +0200
Message-Id: <20230823070656.363032-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42d.google.com
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

This replaces the exit(0) call by a shutdown request, ensuring a proper
cleanup of Qemu. Otherwise, some connections like gdb could be broken
without being correctly flushed.

Signed-off-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/misc/sifive_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/misc/sifive_test.c b/hw/misc/sifive_test.c
index 56df45bfe5..ab0674f8fe 100644
--- a/hw/misc/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
 #include "hw/misc/sifive_test.h"
+#include "sysemu/sysemu.h"
 
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -41,7 +42,8 @@ static void sifive_test_write(void *opaque, hwaddr addr,
         case FINISHER_FAIL:
             exit(code);
         case FINISHER_PASS:
-            exit(0);
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+            return;
         case FINISHER_RESET:
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
-- 
2.25.1



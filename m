Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4E716266
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zdQ-0002rd-0h; Tue, 30 May 2023 09:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zdM-0002r0-SZ; Tue, 30 May 2023 09:43:32 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zdL-0007Ev-DP; Tue, 30 May 2023 09:43:32 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b04949e5baso15347295ad.0; 
 Tue, 30 May 2023 06:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685454209; x=1688046209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uh1u106OVywcy2ZQGFPd+cFOo//ADNiQgQJlyVmbnFI=;
 b=qx+vyTbjDocNASRCn9xLjvnsP5giqTAbC0pN22Jx++3BW2AVJW1m/Svk2rILfRZJga
 Ua9fMyiH63jjkIeNWmt8SzgShqCSSv0htTonQ6i4dbwXtRB9yUK6jztzgZnhpJs8PYbk
 5JJRrSErW+5v3pUn6/vS+WDefcrZu23qcortddQQ6OxU8bVf4K8tLphzXosYNnj2MnUx
 NzUqh/oZ4UuOQQOvJHq03IcMpfnWxws4NU5Wxf6iuWFhWqIzp0iW9Qbhx8FRK2TlLJ//
 Ey5ma/xS7mIrTFk84R15x3/6pObou8nXtUBeyQKS+5mkggMymWRjvDyVec3g8Dp5VjFW
 W2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454209; x=1688046209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uh1u106OVywcy2ZQGFPd+cFOo//ADNiQgQJlyVmbnFI=;
 b=Pz29vXJWSsRzRHP0xCrOy4sFQa+95Eg5YdjqioR2E4XdiO4o+XN51rYwTPyD0GQoPv
 lg4IxeDVsnqTCHvCuu1pDuO419E12IJ+5j0OwBpkF1/MAty/wwQ/9tIdy299PTefz9Qw
 mP/ZrAkrwvZi4EalfXoyhNRSrpua9yzstpKBM/JJrO1/YNv+ea1c6p1dfvcV+tljXaZV
 Y/Zk0X7Wmeb/PhxBkm1HlP1UPBJEXNk4t0Gs/n8cn7TqMLjfVsX7sp6E3Dk1IGXyJPrW
 IB7GF37aNW8J5AZRgRpzdZOsewObxw18gU9SE8BQa4do6rJhyjrqwwFR7gAmnBf/A4xu
 Maog==
X-Gm-Message-State: AC+VfDyXIsRI+3YN10fIsz93VB2+cEhDlT57plDK9LJz9Y5Zq+i9xP4X
 8cu8taWxmkLa9GnkFih+BtAgA60QkTU=
X-Google-Smtp-Source: ACHHUZ45hilqeibjAOXAALOe1p92y2yFCxM62mEtNKDuEbWxz0YOqjoyTUmoqzzda1sXhKZ411uXxg==
X-Received: by 2002:a17:902:e811:b0:1b0:61dc:db67 with SMTP id
 u17-20020a170902e81100b001b061dcdb67mr2436425plg.30.1685454209093; 
 Tue, 30 May 2023 06:43:29 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a170902a50300b001ab12ccc2a7sm10314568plq.98.2023.05.30.06.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:43:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v1 1/2] target/ppc: PMU do not clear MMCR0[FCECE] on
 performance monitor alert
Date: Tue, 30 May 2023 23:43:12 +1000
Message-Id: <20230530134313.387252-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

FCECE does not get cleared according to the ISA v3.1B.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/power8-pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index c4c331c6b5..af065115f2 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -289,7 +289,6 @@ static void fire_PMC_interrupt(PowerPCCPU *cpu)
     pmu_update_cycles(env);
 
     if (env->spr[SPR_POWER_MMCR0] & MMCR0_FCECE) {
-        env->spr[SPR_POWER_MMCR0] &= ~MMCR0_FCECE;
         env->spr[SPR_POWER_MMCR0] |= MMCR0_FC;
 
         /* Changing MMCR0_FC requires summaries and hflags update */
-- 
2.40.1



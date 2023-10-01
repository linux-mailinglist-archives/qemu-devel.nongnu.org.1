Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC8F7B4668
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 10:55:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmsCx-0000pi-JK; Sun, 01 Oct 2023 04:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmsCk-0000ov-GL
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 04:53:37 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qmsCi-0000VI-Ne
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 04:53:34 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 3374943FF1;
 Sun,  1 Oct 2023 08:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1696150408; bh=cIpJmsdI+UMBxDqiMLVVhtfrvKKSePArEbN+XX0226w=;
 h=From:To:Cc:Subject:Date;
 b=hNKQgGO6vVzIAHJ3l4i5V49K3QlwV+IG7C4JC6nmdnYAT7fjjwlhu0UsNAajK5Kdr
 CJMN0FzyyXgcHuBNzeoAUnW4l5DflLxgSWJ0ypa75a04bjRBlmMB9H1dWdzNpeIUFU
 zbKydXxknleEdgBk0LtUo80c+6PZkIrVGoc6zSJY=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] linux-user/elfload: Enable LSX/LASX in HWCAP for LoongArch
Date: Sun,  1 Oct 2023 16:53:05 +0800
Message-ID: <20231001085315.1692667-1-c@jia.je>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Since support for LSX and LASX is landed in QEMU recently, we can update
HWCAPS accordingly.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 linux-user/elfload.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index db75cd4b33..f11f25309e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1237,6 +1237,14 @@ static uint32_t get_elf_hwcap(void)
         hwcaps |= HWCAP_LOONGARCH_LAM;
     }
 
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
+        hwcaps |= HWCAP_LOONGARCH_LSX;
+    }
+
+    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
+        hwcaps |= HWCAP_LOONGARCH_LASX;
+    }
+
     return hwcaps;
 }
 
-- 
2.41.0



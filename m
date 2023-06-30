Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD45743359
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 05:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF5F4-0008K8-NG; Thu, 29 Jun 2023 23:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5F2-0008Ia-Ci; Thu, 29 Jun 2023 23:56:16 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5F0-0002CF-Ph; Thu, 29 Jun 2023 23:56:16 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b711c3ad1fso1254384a34.0; 
 Thu, 29 Jun 2023 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688097373; x=1690689373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0KT/8N4hyWU3xN4MlL2wP6UCF5bIyh9M+oLmJhD3eo=;
 b=MyxoonBPPL57JfMoDgoV4NFfD6b5/PSlQbmQ8Txn1DW+u4QG6pciw4kvHtoYOdTFCI
 pBgHXuAJ69Ol9KMg9hJzD7hAH342qGpF27si8eG3J03gmBxCTOItk1kVjDzqzQyQD6BY
 o1PBYXiqAXoD9+OZGpWELRXyK3sxzpAxcblT3+R9PDhJeCMxwX9waBWUPR6sn5wMh0o+
 K52p8ip/SvaVMzR4QSyGwUUipBHcMzBGszBmHqkoA0BKtxvPheoeRAEupZsWuvYb2GYt
 TB2LUJcUvdMAaWuf6MApuvMi87/XKf6fOE0PMewPWPCy/DPAS0B0FsLHtFR3n0LvMcE5
 V1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688097373; x=1690689373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f0KT/8N4hyWU3xN4MlL2wP6UCF5bIyh9M+oLmJhD3eo=;
 b=gKOdVhYOQtU0kprShy3nctZVicHp5qNIObBjjHBDTQRYzu8E0BVyUJKH4HlIkn7TUq
 tbYbDSV3BlZO19CMEdDAhQ3qB4FLDELEcAoEmu+R/50CQTAhs+xTTcX/8LoO/WIEB9Lb
 qqaEY8rCMKGks9Iv5kBoWbqE1GYYgVky8KtAH28ZbTuqRtucDoFG+C0d8nBF8xpMZKs9
 qDivsu+87QHYdZwL84T3RyromzROX/Q9TtikDKakS+BV0voiUukH2F7JbDgAzrmjj2D/
 /PvfBcDochwGdj6aeWPHKUtmunkn7OkpZtV1AHN87ePNi7NvmTkgPy5JKeQyWtMAR8bR
 3FDA==
X-Gm-Message-State: AC+VfDx2gJdJsj3HnCv5MZ0UcjpAQqVERjG4d0lOrt6+2ljLNjsnyq2o
 Oaqgp1DaGZ1cm9K2TE/4yZM=
X-Google-Smtp-Source: ACHHUZ4yX6Umobp4JlDJQ5IncSougBZ66au6stGAQ91KDoXgsjc2l0QRJNDj0UiG3hsb6BYproVg9g==
X-Received: by 2002:a9d:7ad5:0:b0:6b8:969f:df31 with SMTP id
 m21-20020a9d7ad5000000b006b8969fdf31mr1804815otn.9.1688097373085; 
 Thu, 29 Jun 2023 20:56:13 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a195d00b0025ef39c0f87sm10639290pjh.0.2023.06.29.20.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:56:12 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH 4/4] ppc/pnv: Return zero for core thread state xscom
Date: Fri, 30 Jun 2023 13:25:47 +0930
Message-Id: <20230630035547.80329-5-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630035547.80329-1-joel@jms.id.au>
References: <20230630035547.80329-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=joel.stan@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Firmware now warns if booting in LPAR per core mode (PPC bit 62). So
this warning doesn't trigger report the core thread state is 0.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7fff2fd9e298..98356d7f6538 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -116,6 +116,8 @@ static const MemoryRegionOps pnv_core_power8_xscom_ops = {
 #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
 #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
 
+#define PNV9_XSCOM_EC_CORE_THREAD_STATE    0x10ab3
+
 static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
                                            unsigned int width)
 {
@@ -134,6 +136,9 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
     case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
         val = 0x0;
         break;
+    case PNV9_XSCOM_EC_CORE_THREAD_STATE:
+        val = 0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
                   addr);
@@ -408,6 +413,8 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
  * POWER10 Quads
  */
 
+#define PNV10_XSCOM_EC_PC_PMC_CORE_THREAD_STATE 0x28412
+
 static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
                                             unsigned int width)
 {
@@ -415,6 +422,9 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
     uint64_t val = -1;
 
     switch (offset) {
+    case PNV10_XSCOM_EC_PC_PMC_CORE_THREAD_STATE:
+        val = 0;
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
                       offset);
-- 
2.40.1



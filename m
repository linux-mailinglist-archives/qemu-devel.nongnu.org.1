Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E03BA75CFB4
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMt7u-00031T-0X; Fri, 21 Jul 2023 12:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMt7r-0002xf-Gn
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:37:07 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMt7p-00059s-Qp
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:37:07 -0400
Received: by mail-yb1-xb43.google.com with SMTP id
 3f1490d57ef6-cefa8fe4cbeso2044316276.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689957424; x=1690562224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijmrvsQ+xZzl5dG2FfioPPf11zWI2IrXAZmlY53iqe8=;
 b=kBBkXWLAIposs8Vvw5ryzVTR1Y5pX6ZV7oyHb+pESXSHL7AchAD9QYsuxt1mDozKhL
 BFPUJ8WyAY6FL8Ukz3Z+d6DeeOmlNwskzdHr5QvoAeeJK3/NPUwV8NSmE13y+EZ9Uegh
 qG+t/aMvbf11Yr39J9dHsfQDJZEUbguWsc0fthH9ETQ4zEj39HfUM+jk1dfqd9a8SrWc
 AQoX2CN+jlF8vQPhRnn0cIBB3d8zApUzIZ6sivbJai8cOMGPtKX+Pd9Pr8kGtY3dPUz1
 05D7CTIYt5e6k1UPG0DvFEimHNVwyhimoaD+EUj39D+lLDBxSw/iCBajmnMbGxcYGQbn
 b7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689957424; x=1690562224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijmrvsQ+xZzl5dG2FfioPPf11zWI2IrXAZmlY53iqe8=;
 b=OfLxSNjGauYl/nrNDE8l1YJtkJVWDcUWipp5tOz80sM5py6UeRSGXbX5tE4/oum/1U
 8TrqoJgza655Mwt7nvev3bDUvZ1e5i2woVs7qwrJVx1GQZCSbOJpQQ0lozpiLZjNFzui
 3AxHIX2O+3jsB6T1ixRtX9G1tIp2rkujwbxEwBf4HzJYULyivn+p0fWnU+Imwq96Ily2
 H5++g3KFan9Y7cn5PL+c06iiPDY5lBeQlg88JxIr4ugSuW4JEZoH2iZzXAyeme1cCtku
 gYrKyPmamJ0VnAfuQInEBtp2lOUzv/hkY1fjUj4ekodS7MYmWQWfDV7QKCG8BE89DWKe
 93Aw==
X-Gm-Message-State: ABy/qLYdFDQPWMd1riEVTNunglAkeDryu0IvbssDol/wlkqxM3DEl+5D
 O28ZTUOARccOLnmxZSvvAqjf4/7B1pbK
X-Google-Smtp-Source: APBJJlH7vPrqdLJ+4kAEg7wrCo+qdg3fckTPJsNsGcsEVRnLliRkT0tHqhNEr0Ra/nP60EGHAvE9aA==
X-Received: by 2002:a25:d003:0:b0:cec:821a:e20b with SMTP id
 h3-20020a25d003000000b00cec821ae20bmr2141726ybg.2.1689957424576; 
 Fri, 21 Jul 2023 09:37:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v196-20020a25c5cd000000b00c62e0df7ca8sm863822ybe.24.2023.07.21.09.37.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 09:37:04 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH 1/4] cxl/mailbox: change CCI cmd set structure to be a member,
 not a refernce
Date: Fri, 21 Jul 2023 12:35:04 -0400
Message-Id: <20230721163505.1910-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230721163505.1910-1-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yb1-xb43.google.com
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

This allows devices to have fully customized CCIs, along with complex
devices where wrapper devices can override or add additional CCI
commands without having to replicate full command structures or
pollute a base device with every command that might ever be used.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 18 ++++++++++++++----
 include/hw/cxl/cxl_device.h |  2 +-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2819914e8d..ddee3f1718 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1373,9 +1373,19 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
                                  bg_timercb, cci);
 }
 
+static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256]) {
+    for (int set = 0; set < 256; set++) {
+        for (int cmd = 0; cmd < 256; cmd++) {
+            if (cxl_cmds[set][cmd].handler) {
+                cci->cxl_cmd_set[set][cmd] = cxl_cmds[set][cmd];
+            }
+        }
+    }
+}
+
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_sw;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1383,7 +1393,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set;
+    cxl_copy_cci_commands(cci, cxl_cmd_set);
     cci->d = d;
  
     /* No separation for PCI MB as protocol handled in PCI device */
@@ -1398,7 +1408,7 @@ static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
 void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
                                size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_t3_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
@@ -1414,7 +1424,7 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
 
 void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf, size_t payload_max)
 {
-    cci->cxl_cmd_set = cxl_cmd_set_usp_mctp;
+    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c68981b618..9a3c8b2dfa 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -163,7 +163,7 @@ typedef struct CXLEventLog {
 } CXLEventLog;
 
 typedef struct CXLCCI {
-    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
         uint16_t opcode;
         uint16_t effect;
-- 
2.39.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5375B86A
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 22:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMZoV-0000RW-RC; Thu, 20 Jul 2023 15:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMZoT-0000Gi-Sf
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:59:49 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qMZoS-0004aj-8D
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 15:59:49 -0400
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-403a7066bc8so10368541cf.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689883186; x=1690487986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVuZVz0OWzFFhOA5aHSeimJ6uxprk8dzRJn6x8ojC30=;
 b=llzTWYrPFpN+6xm9HTVBnQrzY6AAO1+67Fv7H7c5+2WeCzj6Ots4Du0JQh39i2yLMB
 B6dYQkGC67voHz1aOcDo/Ez0yYwwtLvxffCIRasYg/J2BFt9fFHz3Izjcwiq1ediCcbm
 kRBYwWJjWXal76fg9IYBhB9yhlbm8qGdjonknUY7B0J/hk0ihYxsyYekJL9fizfdttJW
 Ofl4cXBHdRzMNITUJ6sZEjJE2zuz/03Axr4uxxivMaOoEtCGg7s6017fHoLpLj31eRg9
 RXYq2NmSXj/57OhA2uUPUjiYkq2SzaEiMB1hZdkddvc8lubuWjPO1dlk03cLk40OFdKO
 9puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689883186; x=1690487986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVuZVz0OWzFFhOA5aHSeimJ6uxprk8dzRJn6x8ojC30=;
 b=PU9XTIGnmtm2TxIQDCBxO12abVfQCS/mZzrBpvV1edasmmqSq3JrxAGUfLnmFU+reh
 wKXfUu3koigRC/lzBnXDtMUXb3Pi5mMIEDeHzteOPpiYJJH7Y6BH8xbznwVBmWfSW6p+
 9NHL1r3mieO9xObhTl4QnlqJVrG8VW87Tu89YFM1H2bCo4kXEMTQ01In0HEp+CbWK1AE
 DgIKqTlbZkg6HcNjXyFB2rqIrBuwrlIjYyOvwCxzjg7UZegtnleIdAnFrs9Qcq0wXPMg
 e27tYZ9kZhRsZxdbltP5P+A6nSv5QLR4EE1EXWgqNXrtTaOCUur0OMnM970d6HcWbzG5
 GGBA==
X-Gm-Message-State: ABy/qLZQiwZ/x9Ntt5M3dwJGkLTcnj6lqghlK876SJmBDdfpj/wU8+cQ
 P6ho6rXbTnsY8hlNiGpOIyBeWyO4D1Kh
X-Google-Smtp-Source: APBJJlFF7Fh7WwTG1b6+BcGwCCNZogSf0pEY/96T2g3/FqOSVWXBA+PH7/MyemFtT2z7W/3wO0VSnw==
X-Received: by 2002:a05:622a:7:b0:400:9896:b0fa with SMTP id
 x7-20020a05622a000700b004009896b0famr74617qtw.64.1689883186676; 
 Thu, 20 Jul 2023 12:59:46 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 bw14-20020a05622a098e00b00404e686bcd1sm672078qtb.72.2023.07.20.12.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 12:59:46 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Gregory Price <gregory.price@memverge.com>
Subject: [RFC 1/2] cxl/mailbox: change CCI cmd set structure to be a member,
 not a refernce
Date: Thu, 20 Jul 2023 15:58:20 -0400
Message-Id: <20230720195819.17905-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230720195819.17905-1-gregory.price@memverge.com>
References: <20230720195819.17905-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=gourry.memverge@gmail.com; helo=mail-qt1-x843.google.com
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
 hw/cxl/cxl-mailbox-utils.c         |  18 ++++++++++++++----
 include/hw/cxl/cxl_device.h        |   2 +-
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



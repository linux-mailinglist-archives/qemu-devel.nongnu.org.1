Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF44F796DBD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2G1-0006EI-Qd; Wed, 06 Sep 2023 19:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fr-0006Cz-7y
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:16 -0400
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qe2Fm-0006bT-Tq
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 19:48:15 -0400
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-58fae4a5285so4269167b3.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044085; x=1694648885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3TXSZttiLwQUf7LpcHreKd5DddM8bjWjzB8x7ZghXc=;
 b=B5+Z3AqcRmKkZ/cPH8Gay62TF8S2aEX7ICblaGI89pnUfAt4+/AHwqm2NRqqLdzQro
 XFzGGhGM/Lt2J/mivHunNR8CqKubQB7LqTqJGXNMDTDC5lI78Wvu2aIYUWLIlC/STcWJ
 63R69rEAfIS1d5ArBeXMNv5iCw86GCeNZNq1TPbW0CcxxSTmvWPtZET4wSX9A3IL2Lxt
 dQlXMcIuXiwPO07BzxzYNkuIiMp4y0oH2wFQF0DrEXT5WNuMXL86+eXFRGYeZafmOe3u
 soU/YITenXH6t6OQSQmGvpCbITuNtPrMAukkJePu2Z3C5eP+f4RNmQPM0q3znx+MTSXK
 PSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044085; x=1694648885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3TXSZttiLwQUf7LpcHreKd5DddM8bjWjzB8x7ZghXc=;
 b=gvFBgj1UyTcG9nSZ+u35DEHx0wsI5XOY9N0edBxEY0on5ZPmbzel1hTJvbIJfQAQPK
 3RQ4QmBff1bjup28tX/TLH21B6uYjZCoeOsSOoJmIKmwth2D9BQuxD41UR+Fq1Oy8uSP
 U5OIz0t9DnsSrkbPqUk05BTfXDnQUcXbnSywfbdF2cSr8Tm5y0YqL208uJQCC7uiwXRX
 2GoFO39q8CnXrifazPO1aQdNW1j9ZdBmeYOXER7eXaeG6jxzEzL1a/QTFU2cG0lI+jEk
 IBBVk1Z1En3tapdR/9a6vlF/X8f3nAFJ43XZpnYMQiwnmeyOEf4SEu5ZmOppmoM69ITS
 quxg==
X-Gm-Message-State: AOJu0YxrG6I7zCWc5I3LXE72dPqZyqNVVwlb9g0yUo7SXHr4ylPCno6L
 NtlkpeA1GEdTbRerw4gmo5c46mHQs9m5
X-Google-Smtp-Source: AGHT+IFkOIfbSKj11YwpbzpzJ6Eum4HrDx9FlBBhPK+AeC3/cGJ9KHg82RM0QZl1Sr5foj/nyMhJqw==
X-Received: by 2002:a05:690c:290b:b0:598:7885:7b7e with SMTP id
 eg11-20020a05690c290b00b0059878857b7emr14387412ywb.18.1694044084880; 
 Wed, 06 Sep 2023 16:48:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 v191-20020a8148c8000000b005832fe29034sm332107ywa.89.2023.09.06.16.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 16:48:04 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org, junhee.ryu@sk.com,
 kwangjin.ko@sk.com, Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v3 5/6] cxl/mailbox,
 type3: Implement MHD get info command callback
Date: Tue,  5 Sep 2023 20:15:16 -0400
Message-Id: <20230906001517.324380-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230906001517.324380-1-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1141;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1141.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For multi-headed type 3 devices, this command reports logical device
mappings for each head.  Implement a callback which can be
initialized by MHD devices to field these commands.

Reports "unsupported" if the command is called but the callback is
not implemented.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 21 +++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b64bbdf45d..3177a59de3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -91,6 +91,8 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
+    MHD = 0x55,
+        #define GET_MHD_INFO 0x0
 };
 
 /* CCI Message Format CXL r3.0 Figure 7-19 */
@@ -184,6 +186,23 @@ static CXLRetCode cmd_tunnel_management_cmd(const struct cxl_cmd *cmd,
     return CXL_MBOX_INVALID_INPUT;
 }
 
+/*
+ * CXL r3.0 section 7.6.7.5.1 - Get Multi-Headed Info (Opcode 5500h)
+ */
+static CXLRetCode cmd_mhd_get_info(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    if (cvc->mhd_get_info) {
+        return cvc->mhd_get_info(cmd, payload_in, len_in, payload_out,
+                                 len_out, cci);
+    }
+    return CXL_MBOX_UNSUPPORTED;
+}
+
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
                                          uint8_t *payload_out, size_t *len_out,
@@ -1598,6 +1617,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
         cmd_media_clear_poison, 72, 0 },
+    [MHD][GET_MHD_INFO] = {"GET_MULTI_HEADED_INFO",
+        cmd_mhd_get_info, 2, 0},
 };
 
 static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 1fb3ffeca8..307d7c1fd8 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -2120,6 +2120,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
     cvc->set_cacheline = set_cacheline;
+    cvc->mhd_get_info = NULL;
     cvc->mhd_access_valid = NULL;
 }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 37893f8626..4a5d4bd98b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -508,6 +508,12 @@ struct CXLType3Class {
     bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 
     /* Multi-headed Device */
+    CXLRetCode (*mhd_get_info)(const struct cxl_cmd *cmd,
+                               uint8_t *payload_in,
+                               size_t len_in,
+                               uint8_t *payload_out,
+                               size_t *len_out,
+                               CXLCCI *cci);
     bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
 };
 
-- 
2.39.1



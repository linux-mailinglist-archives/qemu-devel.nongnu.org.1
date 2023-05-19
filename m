Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AEB709A86
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Tm-00072S-8c; Fri, 19 May 2023 10:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tf-0006ru-P2
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tc-0003t5-Cj
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6iHPJFfV/9vWifWqb0iM28PQLKjUavjqG0T5tG7KkDY=;
 b=U4I5keXEoQYTmmBdeYadoe/NY4DT3xXa72Kk1Oqbsz5UaqfTSV1P5Gt2YKWKfyRLF7leP6
 bPAXDuMTINrhxmqXrlGNZb8zkDd69ADMs0bqXgIHMolOCUil2LgczHSzLenHYQ7sY17r7Z
 S9+cZDOyzXihjWvnLlabKMPtxb9dvYE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-NrQFOboOPWK1tEuPbCcjLg-1; Fri, 19 May 2023 10:53:00 -0400
X-MC-Unique: NrQFOboOPWK1tEuPbCcjLg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ef455ba61cso2271874e87.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507979; x=1687099979;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6iHPJFfV/9vWifWqb0iM28PQLKjUavjqG0T5tG7KkDY=;
 b=cD5YyvH04wX9IC5q03i64MOb5I0+JPGenSEw4IcfM8e4Tkb0ehujMBN0Dh+EZUf7TL
 qjBmuedPSpv2y3D8F6iNy4YtLy1rbzKzMN4UeNoRhoiCwKEolno/+D47HwLZ0d67QDoc
 uk/ueCOGkLSejMIykTR5PoGI/Gk1vFoDX8FOK1zGLgiuH3GamG3arz7Y164bfpDFzCHT
 Ss/wwb8h2YwBa9BjgcEYwBK6TJWm/2y8f/Lt9tJBFezKE5Q+eep6k2oEnv00g9d83X9c
 HlhsgLpL98p4DYln50LW8KYfTLjRzHTDJJp3JhfZa1P8ganhqZnSKesYD71ur/PIcHCo
 C72g==
X-Gm-Message-State: AC+VfDyOmO2BwS7JCn6+xeOXd4Ivlj1eNHNtlLW7t0kLhVHXIdr6eMCN
 klLK80SMB0+73/n0VcczvjsUBaoEjpcIBXpAoVnpTWSc99/i9NolsQPgtaaHgdk94RAsBOuf57c
 siwj2AAbjsAHwKb9PIZRuuTQxiaO+UO8Be2iMUVzkmIsCJV6EwmtkkJKkIieWbyWO1siP
X-Received: by 2002:ac2:4556:0:b0:4f1:5015:43c4 with SMTP id
 j22-20020ac24556000000b004f1501543c4mr978931lfm.38.1684507979066; 
 Fri, 19 May 2023 07:52:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SC6vwFKscVqaQGy9EbZqcVFaBBikaNwXTMe8eAbS8p4H/D7/mGMittX8t/pzJb6GvADXeDQ==
X-Received: by 2002:ac2:4556:0:b0:4f1:5015:43c4 with SMTP id
 j22-20020ac24556000000b004f1501543c4mr978921lfm.38.1684507978767; 
 Fri, 19 May 2023 07:52:58 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 d5-20020ac244c5000000b004d5a5d90d83sm626319lfm.60.2023.05.19.07.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:52:58 -0700 (PDT)
Date: Fri, 19 May 2023 10:52:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/40] hw/cxl: rename mailbox return code type from ret_code
 to CXLRetCode
Message-ID: <b6aab4597173f5d112a8aa0f3ded502cfb7042a9.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Given the increasing usage of this mailbox return code type, now
is a good time to switch to QEMU style naming.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20230423162013.4535-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ed663cc04a..7b2aef0d67 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,7 +23,7 @@
  *     FOO    = 0x7f,
  *          #define BAR 0
  *  2. Implement the handler
- *    static ret_code cmd_foo_bar(struct cxl_cmd *cmd,
+ *    static CXLRetCode cmd_foo_bar(struct cxl_cmd *cmd,
  *                                  CXLDeviceState *cxl_dstate, uint16_t *len)
  *  3. Add the command to the cxl_cmd_set[][]
  *    [FOO][BAR] = { "FOO_BAR", cmd_foo_bar, x, y },
@@ -90,10 +90,10 @@ typedef enum {
     CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
     CXL_MBOX_MAX = 0x17
-} ret_code;
+} CXLRetCode;
 
 struct cxl_cmd;
-typedef ret_code (*opcode_handler)(struct cxl_cmd *cmd,
+typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
                                    CXLDeviceState *cxl_dstate, uint16_t *len);
 struct cxl_cmd {
     const char *name;
@@ -105,16 +105,16 @@ struct cxl_cmd {
 
 #define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
     uint16_t __zero##name = size;                                         \
-    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
-                               CXLDeviceState *cxl_dstate, uint16_t *len) \
+    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
+                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
     {                                                                     \
         *len = __zero##name;                                              \
         memset(cmd->payload, 0, *len);                                    \
         return CXL_MBOX_SUCCESS;                                          \
     }
 #define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
-    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
-                               CXLDeviceState *cxl_dstate, uint16_t *len) \
+    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
+                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
     {                                                                     \
         return CXL_MBOX_SUCCESS;                                          \
     }
@@ -125,9 +125,9 @@ DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
 DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
 
 /* 8.2.9.2.1 */
-static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
-                                             CXLDeviceState *cxl_dstate,
-                                             uint16_t *len)
+static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
+                                               CXLDeviceState *cxl_dstate,
+                                               uint16_t *len)
 {
     struct {
         uint8_t slots_supported;
@@ -159,9 +159,9 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.3.1 */
-static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
-                                  CXLDeviceState *cxl_dstate,
-                                  uint16_t *len)
+static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
+                                    CXLDeviceState *cxl_dstate,
+                                    uint16_t *len)
 {
     uint64_t time, delta;
     uint64_t final_time = 0;
@@ -181,7 +181,7 @@ static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.3.2 */
-static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
+static CXLRetCode cmd_timestamp_set(struct cxl_cmd *cmd,
                                   CXLDeviceState *cxl_dstate,
                                   uint16_t *len)
 {
@@ -201,9 +201,9 @@ static const QemuUUID cel_uuid = {
 };
 
 /* 8.2.9.4.1 */
-static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
-                                       CXLDeviceState *cxl_dstate,
-                                       uint16_t *len)
+static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len)
 {
     struct {
         uint16_t entries;
@@ -224,9 +224,9 @@ static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.4.2 */
-static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
-                                 CXLDeviceState *cxl_dstate,
-                                 uint16_t *len)
+static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate,
+                                   uint16_t *len)
 {
     struct {
         QemuUUID uuid;
@@ -265,9 +265,9 @@ static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.5.1.1 */
-static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
-                                           CXLDeviceState *cxl_dstate,
-                                           uint16_t *len)
+static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
+                                             CXLDeviceState *cxl_dstate,
+                                             uint16_t *len)
 {
     struct {
         char fw_revision[0x10];
@@ -309,9 +309,9 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
-                                           CXLDeviceState *cxl_dstate,
-                                           uint16_t *len)
+static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
+                                              CXLDeviceState *cxl_dstate,
+                                              uint16_t *len)
 {
     struct {
         uint64_t active_vmem;
@@ -339,9 +339,9 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
-                                 CXLDeviceState *cxl_dstate,
-                                 uint16_t *len)
+static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate,
+                                   uint16_t *len)
 {
     struct {
         uint32_t offset;
@@ -364,9 +364,9 @@ static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
-                                 CXLDeviceState *cxl_dstate,
-                                 uint16_t *len)
+static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate,
+                                   uint16_t *len)
 {
     struct set_lsa_pl {
         uint32_t offset;
-- 
MST



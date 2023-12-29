Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5838201C2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLu-0000C9-DS; Fri, 29 Dec 2023 16:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLq-0008Lk-NK
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:06 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLn-0007EY-77
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:06 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b1589a75so1481096b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885101; x=1704489901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=izfNzYDpLE+8KKtYZNbE9Cly+hRboP1BshDphjqE/aM=;
 b=NZD2SeQxdKaexV3cLhFd/RLJLv7OS1HCDM+FHtzb5vX1EEBi8NyIPehTwxO3cJBxZ/
 QNQR4GEZx5uViE34A7lKYOtaNPCdwXodorSfvyu2LFxobnTo4SkOtsmu1X3UKoGSYzXI
 QOQaXbNtErGVv6Ls3pMINvbclmxTXOo5uKFmpd3PvAFa2gnk/vWzi0RqUwyiZOY8pCXE
 Pp8n01zYBSA6pvDefJPFikbi9fGLpJNn8VB7MF+zNlAK/7VnfpWef7TKlh3YOaiEcZnY
 cJ/RTGN8sKsLxZ9bvz9J+Y2g3QuvTrk/65d2QdYxT1dWRB5qllpP0iHwwSYPhkokFfNs
 vc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885101; x=1704489901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izfNzYDpLE+8KKtYZNbE9Cly+hRboP1BshDphjqE/aM=;
 b=nreXE9uiIVp/qfweEhOKtBgrG4qZYPtnCI3GaXMEaeMUpo6W5fSRPKHvSsmUriGFYS
 GBDVC0KTyEYj4xoM9s0Gjoa7EpoBhaKnujyYlHDZ+RtSqVmrO+s6Py6xnFcTN/fPmzBl
 VEXlNJ5s+g4iSUaT24bOZM0H0NnQnkHrAuup7zOjG7LuKoaMnsrnKUBFr4tvPTSR5pMT
 rzBBk3p/U/oaPHqb+Sl9tyCITkLayHl3tNJDRUkHBbPPzC2vM5A+N4OiJEDu8iJ/cg+8
 x/3xhR9+bAstR676CV/9A5S7W6SdDfzPGz5XkBwk6D0PrukmXdNBwLG/Kkbq62TZ3lYI
 yjrw==
X-Gm-Message-State: AOJu0Yzpke1DVbOvpSlk5z2oYyS3aS2kIUi7BAwPvg/wXS/Pzy64o8qb
 2EJUNXfD8s/uQ4Fj4+alRkEQe6RJgBuQCS3P8mtZ7B//bO93wA==
X-Google-Smtp-Source: AGHT+IGyW3ojMazCp7NlWcOuIs4kRhDHuEbggul71YDSZqvEaeiDz0abi7L+kgonFruSvhVhTzs0Xg==
X-Received: by 2002:aa7:93b9:0:b0:6d9:97f5:392e with SMTP id
 x25-20020aa793b9000000b006d997f5392emr4819512pff.44.1703885101513; 
 Fri, 29 Dec 2023 13:25:01 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/71] hw/hyperv: Constify VMState
Date: Sat, 30 Dec 2023 08:23:04 +1100
Message-Id: <20231229212346.147149-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-30-richard.henderson@linaro.org>
---
 hw/hyperv/vmbus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c64eaa5a46..c86d1895ba 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -526,7 +526,7 @@ static const VMStateDescription vmstate_gpadl = {
     .name = "vmbus/gpadl",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VMBusGpadl),
         VMSTATE_UINT32(child_relid, VMBusGpadl),
         VMSTATE_UINT32(num_gfns, VMBusGpadl),
@@ -1489,7 +1489,7 @@ static const VMStateDescription vmstate_channel = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = channel_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, VMBusChannel),
         VMSTATE_UINT16(subchan_idx, VMBusChannel),
         VMSTATE_UINT32(open_id, VMBusChannel),
@@ -2380,7 +2380,7 @@ const VMStateDescription vmstate_vmbus_dev = {
     .name = TYPE_VMBUS_DEVICE,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(instanceid.data, VMBusDevice, 16),
         VMSTATE_UINT16(num_channels, VMBusDevice),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(channels, VMBusDevice,
@@ -2549,7 +2549,7 @@ static const VMStateDescription vmstate_post_message_input = {
     .name = "vmbus/hyperv_post_message_input",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /*
          * skip connection_id and message_type as they are validated before
          * queueing and ignored on dequeueing
@@ -2572,7 +2572,7 @@ static const VMStateDescription vmstate_rx_queue = {
     .version_id = 0,
     .minimum_version_id = 0,
     .needed = vmbus_rx_queue_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(rx_queue_head, VMBus),
         VMSTATE_UINT8(rx_queue_size, VMBus),
         VMSTATE_STRUCT_ARRAY(rx_queue, VMBus,
@@ -2589,7 +2589,7 @@ static const VMStateDescription vmstate_vmbus = {
     .minimum_version_id = 0,
     .pre_load = vmbus_pre_load,
     .post_load = vmbus_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(state, VMBus),
         VMSTATE_UINT32(version, VMBus),
         VMSTATE_UINT32(target_vp, VMBus),
@@ -2598,7 +2598,7 @@ static const VMStateDescription vmstate_vmbus = {
                          vmstate_gpadl, VMBusGpadl, link),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_rx_queue,
         NULL
     }
@@ -2643,7 +2643,7 @@ static const VMStateDescription vmstate_vmbus_bridge = {
     .name = TYPE_VMBUS_BRIDGE,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_POINTER(bus, VMBusBridge, vmstate_vmbus, VMBus),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1



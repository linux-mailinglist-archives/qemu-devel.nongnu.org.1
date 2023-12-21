Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE32181AD30
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:20:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9aT-0003Yy-Ln; Wed, 20 Dec 2023 22:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aR-0003To-6A
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:03 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aP-00041a-EN
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:02 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78102c516a7so21980885a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128740; x=1703733540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SlB8P/leqDg1bu4o4tGhME8GwPFQiWOSejGbw1OQDic=;
 b=xLkYvkFjOkgo2PiO385haQiOuTOx+/l5Bb3fOUHffZ+wRaEdEj4VX0LTzztqjSjaae
 8Rh7nFrR1r8RESlh+K9EboFNgjHz6tOOncvJhLkmOhkQdg0rVi+H8gkrYGzG8sjMFVpV
 2z5jzH7Kc0UlTLS2pNnFRyIxbu/vaK29mkHG1ACFMwAqtAaxDjk0QrkP4giqTVlyv8hD
 evISwuBPZXge1aQnJngxhghhJboGtYKu6CPmgkyZBi6vsXVnQLfmepQO7kdbYSR/t2SJ
 fm2jJ964LOTvrKSkQwiCAYFs8FvClaUuZSJWgX6C0xyCWc3aBHbLHX24wmq0z997hVem
 iGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128740; x=1703733540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlB8P/leqDg1bu4o4tGhME8GwPFQiWOSejGbw1OQDic=;
 b=TiOird3VaVRbOEv7jGUdeNk70IwF5vanZgXBRSGlwqtXgvAuz+cwvN2Z9vAxZ5rxBt
 iIhPLJuffsMdHlUdcJgnWJlVqcWwbdpyYQYjl5Szdw6cgXWBjxOGW2kjrDbALpJ0wyU1
 UNnA1hNfh13LisSfoeArJPfQYEbeA+kcelU654DCnhbw3TWMPX156xTbjPWmEw/Br6by
 9Hxv4TFOAawjogEAugFtgJU3fPHO5r03Fhvx1vrz72x6EUp6nhSr67u+mCJ2civDmdcd
 8Y2V4SWaWNfOMs5yyXw/kGBl2Bb5D1HWjZ1tLAP6MIyUPHOXbW/BKLJek2I7g/pyXhqF
 Ue0w==
X-Gm-Message-State: AOJu0YyQZRhz9m6l1GGc8vZ2L6NQqXfsg8Wv/96MQV7G4BcNYXfnyPqg
 p7/juNVBShcDx+uGFALR4mpbMvqES+3bWLGTHJBX8ble
X-Google-Smtp-Source: AGHT+IGNSKVuF5+1cyd3v/6b6gjk1ghWQHS4ejUCLeoRUoFyvDjR051oSl5ti0fAi0GTCwKRdJmY8A==
X-Received: by 2002:a05:620a:4944:b0:77f:2f1b:ad3b with SMTP id
 vz4-20020a05620a494400b0077f2f1bad3bmr22737279qkn.146.1703128740542; 
 Wed, 20 Dec 2023 19:19:00 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/71] hw/hyperv: Constify VMState
Date: Thu, 21 Dec 2023 14:16:10 +1100
Message-Id: <20231221031652.119827-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
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



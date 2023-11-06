Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EFD7E1AA4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:03:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta6-0005JQ-Do; Mon, 06 Nov 2023 01:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZZ-0004ZZ-9Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:57 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZX-0001RH-Gu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:57 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so37704895ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253934; x=1699858734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZ5ZOT33XSJfzFXzv9z0z0E/PDyNVWXUtYL4PDowdaE=;
 b=PTaUSNwrpvF8uZO2atkEHj/6nIed6Tifeb2AdqvKuG97WcI05p566eWlKdhKM7m0/l
 c61C1ZuX5/dekD1N4xrOOv6lKZM6NQA8pMFv1vJU+HOWl52vmrtIEXo2E7QxMaQaN6Ra
 CXPYQDtkvTNN6Il+7Bf92TU0iOIBUfBJBomNXfziZC7GjjIHqh7iguc+yrg1guRWh9bb
 WnHvKsd9LWn44DROVstVi4c/jqVHFe2MRxiZ5Ct60YHOuKCT4xYTaG+rUPhvAzlMC1xS
 SBCHZoDfiIn6BtnY2OtI6kkL8No3ep4tM2QDobYS4nWdCBEhnUcSSEZNoRe7YGrYb48H
 6BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253934; x=1699858734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZ5ZOT33XSJfzFXzv9z0z0E/PDyNVWXUtYL4PDowdaE=;
 b=ElnZEQST8LHm/FqqlabtOHqYZoKzdDdp3X0qB8wNuxf4iL26EtBLU+Uu3+GvlA0pO1
 8THVJ8rWw55d1QJFUosXm8sZXHEJWonpR/4HtCByoL2hIdnkpLwqL8t/VVBULwrUk486
 hBLhbYTv6Z8GRv03hHCrORaJTfEj1rBmzwjlSESiDCcrW3/CuHPXt+XdRfZZpFUkCq1a
 8tcIwDiazbIlYoc696LbGyxJkQZziClVSAqgOKT0vwB3YsjZFxGjeO1BqxFl8Bam9Xsg
 RbCnn+LaLLxf3uvDcwBJY3kOnJdDfkHG5l9d8tvfS5wZRY8C0o2DYKzDM22aouSlwGcL
 hS4Q==
X-Gm-Message-State: AOJu0YzZHRTggQrhm1o3foQa3sIqsX2oESAQj04XltNy5RyrqLtjYkX5
 5EChF2GMrwZartKCNnrRD+feCYxYv0G1rel70t8=
X-Google-Smtp-Source: AGHT+IFQQOnMBegE6HGvj/+tYd6BxCcxOEkfxIoC5hrPFrUli/hsnlUCK0eR0Pe2jcSQb+GNqjv1og==
X-Received: by 2002:a17:903:807:b0:1cc:2a23:cbab with SMTP id
 kr7-20020a170903080700b001cc2a23cbabmr25271665plb.27.1699253934178; 
 Sun, 05 Nov 2023 22:58:54 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 29/71] hw/hyperv: Constify VMState
Date: Sun,  5 Nov 2023 22:57:45 -0800
Message-Id: <20231106065827.543129-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 271289f902..7183f4e367 100644
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



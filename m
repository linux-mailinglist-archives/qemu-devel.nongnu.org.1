Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16A81AD6D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9g8-0005Kg-OE; Wed, 20 Dec 2023 22:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9g5-00050d-SN
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:54 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9g3-00012F-PA
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:53 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f2fc389e6so1642836d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129091; x=1703733891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cLUn92LVjUNiVWyXyuw53pna1KCJNikzdMOtBv78RRs=;
 b=a/ewVvWv+d5vJBxXy0MEHrjFJ/eWuYuPp2J8izGJ16O5rNFWm2c8nvnwG4CRDL6mwm
 Gpep3HNNG1AcQe95okaFgYfahd7goLPqk0Z58aQhB6sAWgwxUzQnGYrU+RMlymIc7xNN
 UD4cM0Imz+NG3Uyp8MSPQnLbJbaDJPN5Z8qiryrviYNMEINOs8vZIIOFyIECwF+KJoM6
 FOf2H5WiyLQWzYWBSrFFKH0N1309pAwprZGnQ1SFE1Rl9w2HFbuyRsucI20D4yUC3vH2
 OUXglZ1sQgz5cHcX3T7M/BpdIu2GTnBll5p6k1XInrpKCzVMht53dubFlioIMfJqKd/q
 Hb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129091; x=1703733891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cLUn92LVjUNiVWyXyuw53pna1KCJNikzdMOtBv78RRs=;
 b=wGiFSjf0buX0Y1X/OQhkj3L9Fa8sdNttgZQynxru8xLaGS7hXoKKN//4Pa6qPPCs3N
 lfeb4Jhmthtf+Jd7gmY1/Wuj2g4Bh1onwnWTttW8zW7ZDqWMoj5futOzsc6sIz9kSoeO
 N876bqx9GtRdg1Bc36vRCyIzrllVjxeVVFyx7hxBydt1qSXftgxP8c/aOvj25xeSf30T
 EHFzum5ONmlJ07X39EakiqloRbZGXfkGYROGhvS6JaqaR0+nsG3YH77Zz5d2VGi1RWbk
 z+qcUL45ryWYWfIrZXUELYmJZZArOfyvSA/SJc01w9HnTBgCGQF2sHPBnjzz9sfvjPzk
 hj9A==
X-Gm-Message-State: AOJu0Yylw6ZledGF3PVIHZPY3OnxWA8E2rn0JrTeJutQ8miw/jyItEfj
 yILL+D3V2hJJ1p8PZIYjRZvsWhlaGysgQxCMFVXTBsqK
X-Google-Smtp-Source: AGHT+IHG0dqQHVqjkMJlYJ8KYwaeUdFEVGHbgMoR0y2IvwZvTwcqm2ZdDwV+IIRi/8I9OL0szJzX7A==
X-Received: by 2002:ad4:5eca:0:b0:67f:953:f3a4 with SMTP id
 jm10-20020ad45eca000000b0067f0953f3a4mr14632471qvb.107.1703129090915; 
 Wed, 20 Dec 2023 19:24:50 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 70/71] tests/unit/test-vmstate: Constify VMState
Date: Thu, 21 Dec 2023 14:16:51 +1100
Message-Id: <20231221031652.119827-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf32.google.com
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

While const data in tests is not particularly important,
this makes a grep test clear across the tree.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/unit/test-vmstate.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 0b7d5ecd68..c4f9faa273 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -197,7 +197,7 @@ static const VMStateDescription vmstate_simple_primitive = {
     .name = "simple/primitive",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(b_1, TestSimple),
         VMSTATE_BOOL(b_2, TestSimple),
         VMSTATE_UINT8(u8_1, TestSimple),
@@ -299,7 +299,7 @@ static const VMStateDescription vmstate_simple_arr = {
     .name = "simple/array",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16_ARRAY(u16_1, TestSimpleArray, 3),
         VMSTATE_END_OF_LIST()
     }
@@ -341,7 +341,7 @@ static const VMStateDescription vmstate_versioned = {
     .name = "test/versioned",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(a, TestStruct),
         VMSTATE_UINT32_V(b, TestStruct, 2), /* Versioned field in the middle, so
                                              * we catch bugs more easily.
@@ -412,7 +412,7 @@ static const VMStateDescription vmstate_skipping = {
     .name = "test/skip",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(a, TestStruct),
         VMSTATE_UINT32(b, TestStruct),
         VMSTATE_UINT32_TEST(c, TestStruct, test_skip),
@@ -524,7 +524,7 @@ const VMStateDescription vmsd_tst = {
     .name = "test/tst",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(i, TestStructTriv),
         VMSTATE_END_OF_LIST()
     }
@@ -542,7 +542,7 @@ const VMStateDescription vmsd_arps = {
     .name = "test/arps",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(ar, TestArrayOfPtrToStuct,
                 AR_SIZE, 0, vmsd_tst, TestStructTriv),
         VMSTATE_END_OF_LIST()
@@ -630,7 +630,7 @@ const VMStateDescription vmsd_arpp = {
     .name = "test/arps",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_ARRAY_OF_POINTER(ar, TestArrayOfPtrToInt,
                 AR_SIZE, 0, vmstate_info_int32, int32_t*),
         VMSTATE_END_OF_LIST()
@@ -685,7 +685,7 @@ static const VMStateDescription vmstate_q_element = {
     .name = "test/queue-element",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(b, TestQtailqElement),
         VMSTATE_UINT8(u8, TestQtailqElement),
         VMSTATE_END_OF_LIST()
@@ -696,7 +696,7 @@ static const VMStateDescription vmstate_q = {
     .name = "test/queue",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT16(i16, TestQtailq),
         VMSTATE_QTAILQ_V(q, TestQtailq, 1, vmstate_q_element, TestQtailqElement,
                          next),
@@ -821,7 +821,7 @@ typedef struct TestGTreeInterval {
     .name = "interval",                                \
     .version_id = 1,                                   \
     .minimum_version_id = 1,                           \
-    .fields = (VMStateField[]) {                       \
+    .fields = (const VMStateField[]) {                 \
         VMSTATE_UINT64(low, TestGTreeInterval),        \
         VMSTATE_UINT64(high, TestGTreeInterval),       \
         VMSTATE_END_OF_LIST()                          \
@@ -839,7 +839,7 @@ typedef struct TestGTreeMapping {
     .name = "mapping",                                \
     .version_id = 1,                                  \
     .minimum_version_id = 1,                          \
-    .fields = (VMStateField[]) {                      \
+    .fields = (const VMStateField[]) {                \
         VMSTATE_UINT64(phys_addr, TestGTreeMapping),  \
         VMSTATE_UINT32(flags, TestGTreeMapping),      \
         VMSTATE_END_OF_LIST()                         \
@@ -915,7 +915,7 @@ static const VMStateDescription vmstate_domain = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_load = domain_preload,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(id, TestGTreeDomain),
         VMSTATE_GTREE_V(mappings, TestGTreeDomain, 1,
                         vmstate_interval_mapping,
@@ -940,7 +940,7 @@ static const VMStateDescription vmstate_qlist_element = {
     .name = "test/queue list",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, TestQListElement),
         VMSTATE_END_OF_LIST()
     }
@@ -951,7 +951,7 @@ static const VMStateDescription vmstate_iommu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_load = iommu_preload,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(id, TestGTreeIOMMU),
         VMSTATE_GTREE_DIRECT_KEY_V(domains, TestGTreeIOMMU, 1,
                                    &vmstate_domain, TestGTreeDomain),
@@ -963,7 +963,7 @@ static const VMStateDescription vmstate_container = {
     .name = "test/container/qlist",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, TestQListContainer),
         VMSTATE_QLIST_V(list, TestQListContainer, 1, vmstate_qlist_element,
                         TestQListElement, next),
@@ -1414,7 +1414,7 @@ static int tmp_child_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_tmp_back_to_parent = {
     .name = "test/tmp_child_parent",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(f, TestStruct),
         VMSTATE_END_OF_LIST()
     }
@@ -1424,7 +1424,7 @@ static const VMStateDescription vmstate_tmp_child = {
     .name = "test/tmp_child",
     .pre_save = tmp_child_pre_save,
     .post_load = tmp_child_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(diff, TmpTestStruct),
         VMSTATE_STRUCT_POINTER(parent, TmpTestStruct,
                                vmstate_tmp_back_to_parent, TestStruct),
@@ -1435,7 +1435,7 @@ static const VMStateDescription vmstate_tmp_child = {
 static const VMStateDescription vmstate_with_tmp = {
     .name = "test/with_tmp",
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(a, TestStruct),
         VMSTATE_UINT64(d, TestStruct),
         VMSTATE_WITH_TMP(TestStruct, TmpTestStruct, vmstate_tmp_child),
-- 
2.34.1



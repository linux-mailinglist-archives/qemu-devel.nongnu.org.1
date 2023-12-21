Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0A81AD78
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:27:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fr-0002aR-P8; Wed, 20 Dec 2023 22:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fp-0002Le-CX
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:37 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fn-00010k-MT
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:37 -0500
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f147c04b7so1909856d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129074; x=1703733874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAff7NfKLGsZIuLEI++nBQMcWTneKvjKIjS8kdqu5s0=;
 b=eXaAbXjU1rRjWFOPTFYOeAQiKWC2eVC94Trhbu00oRCYErtxvxMifuiJWA5SlQ0ON2
 Kr/rVMiJ6PTzsGnIAdnT/KiqCCyRXm4sPNqBVOjDPFY7H4G551vYhOkQDUE+n4l9B5wR
 yaxGZ9YKGPC2FPb3eQJHg30x2MCKcddjbRm0mK+YXhhR1qpAsvBBfB32FWn0rcojah7g
 wO6NgLHQKp+5qmZrdwt6IfobBQd9MG27PO6edbr3d2CMyUdZS2ggLpT5WcJBmX52meTb
 b7Zn2WY8Xrmte59DljxabD5v/1ZQnhdpQdunhmoV8IXO+rflHC8TWf41wdS6hetmHBa8
 ytcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129074; x=1703733874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iAff7NfKLGsZIuLEI++nBQMcWTneKvjKIjS8kdqu5s0=;
 b=j13Q9xJb2zNPTWfhvluTR2JFVeXUHGJ2xZdbhg7QznReOCQ0R6JNmF51jM7RiWg3OY
 94vFYrYy5is93zx11bBb4gtOaFF0lNGJpd0Ie7RwUKwgFdH7hoEYIVILFI1S1rhOzvLO
 VZXBFypNXLIhSg6EFw0q4itsik2yzVvb3GlFYnobqNMsyGvJwQubVQHJaTJQb9UiyFPU
 Cd7Cmbk7J3eV1VpB2JdHJZzCIVWDfwDUq+sLait2fIfKDYlUOav4Vwl19Ah5ebrAgAB2
 eL2cmlvjFpxlG2ypIt2KeY389BrST97MTmt3hHzYQX6SN0KrmAoVvmLzajud2o84X46u
 2yOA==
X-Gm-Message-State: AOJu0Yx9AukVwJ5UP/Dw9CEnFeXa+WmpabZZ3s+ZOT+KEhHqFg5lazJ2
 EdY7V82t2MjgzjEAZU6NZB5mGz9vkbVKlLWIrPKqUtQJ
X-Google-Smtp-Source: AGHT+IGJfdLQi/JlcR0yUq2wvZMxkAzUCadmxTljvMPOS4rLLRfqZnP/1T/Hdkl4uprKM01+ZpXghA==
X-Received: by 2002:a05:6214:20ad:b0:67f:808f:d30e with SMTP id
 13-20020a05621420ad00b0067f808fd30emr805328qvd.32.1703129074735; 
 Wed, 20 Dec 2023 19:24:34 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 66/71] migration: Constify VMState
Date: Thu, 21 Dec 2023 14:16:47 +1100
Message-Id: <20231221031652.119827-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf35.google.com
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/global_state.c |  2 +-
 migration/savevm.c       | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8ec0..8ee15dbb06 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -131,7 +131,7 @@ static const VMStateDescription vmstate_globalstate = {
     .post_load = global_state_post_load,
     .pre_save = global_state_pre_save,
     .needed = global_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(size, GlobalState),
         VMSTATE_BUFFER(runstate, GlobalState),
         VMSTATE_END_OF_LIST()
diff --git a/migration/savevm.c b/migration/savevm.c
index 39148636cc..3d0f459389 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -438,7 +438,7 @@ static const VMStateDescription vmstate_target_page_bits = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_target_page_bits_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(target_page_bits, SaveState),
         VMSTATE_END_OF_LIST()
     }
@@ -454,7 +454,7 @@ static const VMStateDescription vmstate_capabilites = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_capabilites_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_V(caps_count, SaveState, 1),
         VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_count, 1,
                                     vmstate_info_capability,
@@ -499,7 +499,7 @@ static const VMStateDescription vmstate_uuid = {
     .minimum_version_id = 1,
     .needed = vmstate_uuid_needed,
     .post_load = vmstate_uuid_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY_V(uuid.data, SaveState, sizeof(QemuUUID), 1),
         VMSTATE_END_OF_LIST()
     }
@@ -512,12 +512,12 @@ static const VMStateDescription vmstate_configuration = {
     .post_load = configuration_post_load,
     .pre_save = configuration_pre_save,
     .post_save = configuration_post_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(len, SaveState),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, SaveState, 0, NULL, len),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription *[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_target_page_bits,
         &vmstate_capabilites,
         &vmstate_uuid,
-- 
2.34.1



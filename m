Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD108201D5
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQG-0000FW-Dt; Fri, 29 Dec 2023 16:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ9-0008Tp-7Y
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:37 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ5-0000Qp-KV
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:31 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6dbff975a2aso2216254a34.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885368; x=1704490168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5Dr0gvZkgxAFIFd99X2103QipE5kAtlXBBE09Dt2kw=;
 b=arRmigMo2ANGmQj9Na/5HTFJL3myNhe96LTSK7+S2npekjxWN1VKmeEXire8cxZMJU
 WcogBwGcyHDbhuoPJlUZLu675uSn9sDVjxmZ/iv4xlggU3lH9N9hn/AycAmcLXozjWgF
 QCyVyAPku0GgN48OrLI870OUfRPXIz4EypGHZCKdYChEnI0JfXSzhIw58iuHvC3laOA7
 d1YBv2AYY/7KKEYUk2rGc5vbF84t8XQWYylysD9EJyCjJuHd2hWyftDTgxDrgPkHbRkf
 xxOlK0im+Wzx9e7/uQA2/dzQDzdl9DhPo18hL/Uj9M2rjFHEg3cQyvegfRRTA0Vgedrk
 iXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885368; x=1704490168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5Dr0gvZkgxAFIFd99X2103QipE5kAtlXBBE09Dt2kw=;
 b=PlwkJdM5Iutwfz5yoCQWkJr7P6evGgzpZqMh9raiRf4NIPMVOjNYJuvwqDH7Mn5B77
 gf9peF3evFDXFZ5km8stYTgiGVfpxftUNJSHwwrPs3PuydmsDPHg8dA2wEN4ibBP4/R3
 zFQOUj7zCOBmw+WsRkd7rp8sEPsX+r1mqQvtPsb+Xm/3vWSmQOv5On+7FcBAKheZPTmO
 O2SsUXhy0AlrJOozeJPdNFJGVXJFck3EFSj9K70SAUDTu9/XOgQ2mFUoEZoFROksdc9m
 y47G1IZjOLhpQDPcG/O5c3bKg0L0Y7705T6sWaJsFqeevOE7fiypA24IGHNbefBy9TEN
 XkZw==
X-Gm-Message-State: AOJu0YwjBoK7pn/pfwWAp8AorgqPwIVErevO2pjw08cS0H/x1HxzCcSf
 baqYHxmE9QII96oKRWgOQ0zP4U/Xw3lU2jleY0vd09u9d+4Vpw==
X-Google-Smtp-Source: AGHT+IHQRra/yClJ4uot59JHBxOCTeJsRE2r1aOzguNLXXBiV1ckwrC7Vvod2G0uxRAT9yTYp4y0Iw==
X-Received: by 2002:a9d:63c6:0:b0:6dc:386:a263 with SMTP id
 e6-20020a9d63c6000000b006dc0386a263mr4415143otl.51.1703885368601; 
 Fri, 29 Dec 2023 13:29:28 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>
Subject: [PULL 66/71] migration: Constify VMState
Date: Sat, 30 Dec 2023 08:23:41 +1100
Message-Id: <20231229212346.147149-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
Message-Id: <20231221031652.119827-67-richard.henderson@linaro.org>
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
index eab62330b6..c8d08fa079 100644
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



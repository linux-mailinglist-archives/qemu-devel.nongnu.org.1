Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E197E1AEE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg1-0006FM-D5; Mon, 06 Nov 2023 02:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-00018d-CW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcx-00021o-At
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:39 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5bd85b1939aso299701a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254146; x=1699858946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUaZzOjb2MerZr+3oV1g5npES+t2Hi7CdffCA/NWB2Q=;
 b=DOd01H0+aH1Wqe9y2UBcblBxtJKzd4Eymewj8mkHf/nNyPDLPmRhu0q3ZEYkNS5a8e
 aPvGLmSXWbN+UabdgWspMgjR+WKpI3ecSXufsqYwYc9E0W2+NTT7xj6UyyOADMaGgFbM
 eqGqf/6VzEPe7i9EI+2k4d4eRnM2IMKqWiLs7Te2ubQ0A74Rk2AUdC1EmIiIu6O9GPmN
 pCIMmZtTEVXyoggbj8osd6JxqELP260wbhzrJdOn2sebrMpB2wxRr8HGmcgeOAb89+RP
 Tjw41fv8SwY4UTlyBnIl+DCydcVEVerQtSXOBZRLQL8On7+w5YE0QoFWK5YYwxLfeueG
 sobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254146; x=1699858946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUaZzOjb2MerZr+3oV1g5npES+t2Hi7CdffCA/NWB2Q=;
 b=Qv2CUKfwKJL06VNsh08WSA3bifp0TUJ9EL4uxfOWlkRGqg4hwkgqI8l8dRHsTwhuo0
 F0PWA1/6Mq85gFWCp69f39sjexOhBCzXEa5d948sPdwDzEiSQrvMDe9MeswhbMeh8wae
 hS3d9ZN5EJZQCAEah5jQMmUZnhoi/H5R7oi8Y+aQliajj8fNwXGxkcXSgXFVEgP3Hfy2
 KLtcz0FpyviZBhrF+lTG35xMSLyphjekz3ivAj93JmQXlZW+YYMPGU+ERzr+lhz663fw
 sHahguCKAi89B3nz1ovzWM1A+WdiggFDUWEZDGrki4JVTyuuDgvbSuQDJuI3AuXmEeO9
 LjWw==
X-Gm-Message-State: AOJu0YzJcABaL5k4arQJYfPfJM0Q60QkU0OkNbPteqFY3h2KTi5gGap4
 pCmqVtRzrtWoe35ilshTnEYdh7FRSxHkrQ2pPNo=
X-Google-Smtp-Source: AGHT+IGqS+a2cw16cflfn593eBHNcCAWS9YZPoEBT2zDQ/HMpWsUajLZGWPmai1GBPVP6Zjhop568g==
X-Received: by 2002:a17:90b:3746:b0:280:c85d:450 with SMTP id
 ne6-20020a17090b374600b00280c85d0450mr9849398pjb.44.1699254145767; 
 Sun, 05 Nov 2023 23:02:25 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 66/71] migration: Constify VMState
Date: Sun,  5 Nov 2023 22:58:22 -0800
Message-Id: <20231106065827.543129-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
index 77a81937cd..a42469bcc3 100644
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



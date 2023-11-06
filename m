Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDE77E1AC0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:09:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztgB-0006vS-8w; Mon, 06 Nov 2023 02:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-00017v-3P
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcw-00021i-Eg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:37 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2800c221af2so3994741a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254144; x=1699858944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cigOVxgg+B2yxtbKQ8IseMLL4cIZebVeVVStUQxgnpQ=;
 b=Y+F9p4UuR9yfjkWKz5OV7givVHkHcrEF0xUQNp9U/ZzQ8eODhfOYJI9P8UbYjUL7nc
 ahz1Q7K6Qz9wewjaDoFcFHm/EWF/OwwKOwZH5mP/RSdJ5JxqeNTJkLiJLU09Uz50Xlxf
 EAm+aV4HnjnqQV8FUsoCf1YGLEuEyzgIF1xw02oPRiIqkF8XTIPHGJs/dGhuwdZqopvj
 WV/Ag6DgLYVdshhnzzbZzJS/MENJseJvil2mdNkVwtm1k/T+d3O6OPUzAFVcTp+CUZjR
 gK+vl3gFzW23kPJwH/zhHHLI6gKEQ9K4D+v18++WDmYNmi3Qs/wvX0fsKRioAMz0y4Sa
 o6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254144; x=1699858944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cigOVxgg+B2yxtbKQ8IseMLL4cIZebVeVVStUQxgnpQ=;
 b=sK1q2R24CHX4Q66ASGImQpBwObeQ15wwgovlXXV0td55cO9QEJJ9MCyu7Ojm3b9gAy
 7VJioojcfvEBZZFPyG5EZOMUhHRnDR2FpiDd9nFEd7T/ui8lhpmq0ZxeM7RJcaSIBApg
 4dmJfn08ac+mnNdScHm9R6EyyBARWdCZ+McxtJz87japxoZMps5a/loqXeVaiT4cqu4t
 w/B4oWLlC/EpskO/FCsWdnNMdxFa68ukimaEZmsbxUU3ly0PY6jXbG9YjVWSdHJpfVed
 qqsI0fsgUWZb6yadyh/J8TqDqJ22VT7J1vnZWfr5uOv4EAySu7clJHHwUDSB02UzFaRi
 lcwg==
X-Gm-Message-State: AOJu0Yzj8G4sTdonBlJ1JRIp6IEDqd8KIOo5V1TYC0U0iZonOL8LC76A
 VdvNxgODR8BfD/VfBN0ifWsdM5G1u97d7TriBo4=
X-Google-Smtp-Source: AGHT+IEhA5ET5ONb69q6lXwIDR5edG5R9zRWWjFjz4DYLSEROk5XZYTaKBvKSwP6zxUjGvUtnOSKCw==
X-Received: by 2002:a17:90b:4c8f:b0:280:2609:6d51 with SMTP id
 my15-20020a17090b4c8f00b0028026096d51mr18393504pjb.18.1699254144726; 
 Sun, 05 Nov 2023 23:02:24 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 65/71] cpu-target: Constify VMState
Date: Sun,  5 Nov 2023 22:58:21 -0800
Message-Id: <20231106065827.543129-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 cpu-target.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 79363ae370..c16b8942d6 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -88,7 +88,7 @@ static const VMStateDescription vmstate_cpu_common_exception_index = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_common_exception_index_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(exception_index, CPUState),
         VMSTATE_END_OF_LIST()
     }
@@ -106,7 +106,7 @@ static const VMStateDescription vmstate_cpu_common_crash_occurred = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpu_common_crash_occurred_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(crash_occurred, CPUState),
         VMSTATE_END_OF_LIST()
     }
@@ -118,12 +118,12 @@ const VMStateDescription vmstate_cpu_common = {
     .minimum_version_id = 1,
     .pre_load = cpu_common_pre_load,
     .post_load = cpu_common_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(halted, CPUState),
         VMSTATE_UINT32(interrupt_request, CPUState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_cpu_common_exception_index,
         &vmstate_cpu_common_crash_occurred,
         NULL
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27DA7E1ABC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:08:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg8-0006gv-DO; Mon, 06 Nov 2023 02:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-00018f-CW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcz-00022D-92
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:39 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5bd6ac9833fso483481a12.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254146; x=1699858946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wP/TkDWVSVJqvgDwz7D9SOOabbihQTPsWePRhRJgejc=;
 b=MkBpatohcPggXAnUQgjErz39eq5oJdkG0szGCjqigJtPrs5zhaxpywbcRGF5wc5gaG
 +jKOIX3QDCNIhSnpZCAdDElokShGHDLf0GjxVyScGMVXD32t+cDP9kVvJXf81tHuB4ls
 /dv4E9b5JuchpGAu05JXd9n48VU+0khgBhH0I343mw85AltTiK9792pZy9h+XS5SQ9gP
 WGbNogkPh8Xg8dEbaxPzyiwEQkKmQoiJ7TuOGqF79yYxYq5arW0cuYa8RI4kUjeOJS9k
 Bo21SwsBHYRwaOkDEMwxgS24AjPV6Pyo1e03GLmk5zHVJUG62WnE0yNpOXJXzmEGwamF
 eynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254146; x=1699858946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wP/TkDWVSVJqvgDwz7D9SOOabbihQTPsWePRhRJgejc=;
 b=fn4Y82g0WoYaqyKE3LqHf7haA12Ow/YgGRtqwF7ckvaw+hOCTpVYelIb4NIlyaB7mx
 dWUzPzmv3d/7JS/qvukY02UiW/H6iFBy/Tqv2BSfyn8tR6vHDN/Rptx8BsP3B14dajFq
 m+C3miN/gtYY+wPxhsWb6spyPLejaFA35svgNKbP0RQgnrM9nHg9tVV5FyoCsO55FxNF
 G5W4qZXLcyPM1/FfXtD9gVwRQ+MU8n3ErsPxIhDBWJ4slaElgfXty82ocY6ixNt/bA5b
 yGggztvxbLxREBx/Gn7tplyzDWAC+BMLV+FJoiVnfTG9QkBu0gF6KfULnNAKN2huRFs/
 Xujw==
X-Gm-Message-State: AOJu0YyLu4jpVL4qhRgBQLa+AFc+++iZVg9A8QrP8qYGkpQIB36R47nh
 +FCaRvsf64BBQGy+nR20j91ex48/RYdAp/SUOGg=
X-Google-Smtp-Source: AGHT+IFosUjpUkrMUIV3J0lgHBQpffppIvPQmiHEFChWL49pdJIGcPO6PANGn1VTFFAbbvSL9W7QHw==
X-Received: by 2002:a17:90a:1a03:b0:280:f4a:86b4 with SMTP id
 3-20020a17090a1a0300b002800f4a86b4mr21644502pjk.17.1699254146537; 
 Sun, 05 Nov 2023 23:02:26 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 67/71] system: Constify VMState
Date: Sun,  5 Nov 2023 22:58:23 -0800
Message-Id: <20231106065827.543129-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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
 system/cpu-timers.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 7452d97b67..bdf3a41dcb 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -165,7 +165,7 @@ static const VMStateDescription icount_vmstate_warp_timer = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = warp_timer_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(vm_clock_warp_start, TimersState),
         VMSTATE_TIMER_PTR(icount_warp_timer, TimersState),
         VMSTATE_END_OF_LIST()
@@ -177,7 +177,7 @@ static const VMStateDescription icount_vmstate_adjust_timers = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = adjust_timers_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(icount_rt_timer, TimersState),
         VMSTATE_TIMER_PTR(icount_vm_timer, TimersState),
         VMSTATE_END_OF_LIST()
@@ -189,7 +189,7 @@ static const VMStateDescription icount_vmstate_shift = {
     .version_id = 2,
     .minimum_version_id = 2,
     .needed = icount_shift_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT16(icount_time_shift, TimersState),
         VMSTATE_INT64(last_delta, TimersState),
         VMSTATE_END_OF_LIST()
@@ -204,12 +204,12 @@ static const VMStateDescription icount_vmstate_timers = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = icount_state_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(qemu_icount_bias, TimersState),
         VMSTATE_INT64(qemu_icount, TimersState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &icount_vmstate_warp_timer,
         &icount_vmstate_adjust_timers,
         &icount_vmstate_shift,
@@ -221,13 +221,13 @@ static const VMStateDescription vmstate_timers = {
     .name = "timer",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT64(cpu_ticks_offset, TimersState),
         VMSTATE_UNUSED(8),
         VMSTATE_INT64_V(cpu_clock_offset, TimersState, 2),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &icount_vmstate_timers,
         NULL
     }
-- 
2.34.1



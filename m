Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213281AD6A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9g6-0004w2-M8; Wed, 20 Dec 2023 22:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9g3-0004bQ-2X
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:51 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fr-000110-Sv
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:50 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f0cfd3650so1900496d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129079; x=1703733879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF6RByRWB5kknZ5Gye+CLok3Pr4ZHRs2xTICvgnggfc=;
 b=bB13eB+qS3DtjIFItSsmsiPIdfm2IlIf4i1jIvNve9s4+h0uFu5r+K0bTA2WohMHqm
 dgWrfeZlIdv0txFcQd+klk3aHTgHNxj6bnlTsnI+FNz5A5RK1Rqd9FGmCDvwpmNoS8LX
 2uiKB5mOdl92+s8XB5DucGQwRMxH96LBztjCUMEHh5sk88c7AN4Io9rxbhE7+5A/Imv7
 9BOynqvQuvP+F+t3SyHXT+EL3j6/MwUdAgdSszCBX5eN85PFEiHXWK/hFKTIt4VgdC48
 Ac6Sd8P2SBN4tdG+J4NjJupJxIeSXjiuYVyHnSh3+IHCJKYmuXh10eKWIKilu1OtZedM
 o/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129079; x=1703733879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UF6RByRWB5kknZ5Gye+CLok3Pr4ZHRs2xTICvgnggfc=;
 b=BHiBREzF1Ut9BV4mJCjyAkT9YW9qhxWMj5/T/+SyP4nOSbdZMFFIkPn8W9KpZo1qTR
 HITXMV0CxbRSLLTvBFFtEBESbeljMCBqY4ZN0QUg126DoAKLhPh1kZeue/+NPoGon7rT
 ZhaUXbf4uz6l/K7z1nA/TYiL9ysNhKJZfLodKV2rqMuETRdJvi7oQ4knpzNa1DWjw0Nc
 rScuKCMKiaKfzaVoY9Vp2oGI5ciGKD+Mxx+j/OZVyRG6oBqvtQQRRf3Y4YTjxKcUTxph
 db7LreL+ssxG46TveyDbTUmWgZ18wMBzIB32kksnX5Otf0cJjicL6E6+22eNbHjtAWbj
 Vu3w==
X-Gm-Message-State: AOJu0YxgiCK/D3s6s4GrezoBJXmRvjMWzb/dN3GJWmd4vThJGRnJbFQS
 C5kTHELtPiJHsPrwJN5kB8DHUI6p8SLPlwF16xJap7VX
X-Google-Smtp-Source: AGHT+IGHQY7ZsTPSM03qJMs6gceCrF/opN8ZJFf9d1Ub+tUxlBJ+bmi7ZH5VVH3zz2Xcc79YaP1b5w==
X-Received: by 2002:a05:6214:2603:b0:67f:6a10:aa1a with SMTP id
 gu3-20020a056214260300b0067f6a10aa1amr3577581qvb.86.1703129079020; 
 Wed, 20 Dec 2023 19:24:39 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 67/71] system: Constify VMState
Date: Thu, 21 Dec 2023 14:16:48 +1100
Message-Id: <20231221031652.119827-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



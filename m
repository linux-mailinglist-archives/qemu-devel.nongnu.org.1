Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 226B18201DE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQJ-0000nW-MI; Fri, 29 Dec 2023 16:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQD-0000AD-M0
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:38 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ8-0000R1-V4
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:34 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bbd6e37a9bso1280079b6e.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885371; x=1704490171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Y5DZJN4hv2XQe15PGcXdVWgl56bQTxp89hl5EeXrWM=;
 b=K6AnqXvh/GpqgphPu9NCTzz+qgBI9KQV244O0KPOO2RZfrcMAjoBz+ErtfgA6EjgdX
 hD/W7hKauLZbzJy7j+k/6fxX9AoUU521QTkimBIhs8OxW0WtwOei30J3h6S1fzeb53/7
 r1xDAu8OGf2h98VF8YITqqGIrxyWtFM+sp4EmMIeIIricDTY9ph8RuY4qaLL8pAFYhcK
 SNsfyju62bYlD7+cO/jqJg8XMV8y1BrK/ElFIfpgG17gpcb2Xtu3h+XLtYNRaE44Ri4O
 dFnbyqbl7tFvvvv6LC0HSbX283QjkajQmJ7/c4UtBfd9vbNTQSTmWisEQd1qVK1mkfDO
 QhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885371; x=1704490171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Y5DZJN4hv2XQe15PGcXdVWgl56bQTxp89hl5EeXrWM=;
 b=luHO+1YQCgo+y3+9uEuuklqt8Z9oiCfvoWD4H9xHJlgSjgIh3ldZFo2oeg2ZK5nmlp
 DUxX86P/nxgo2p2nsWy9H53ywE+RsRsgqerWQNUmriVDRjiVlMmDWRUwK1OrVgcSmMiF
 GlfSn69EiUF35GVkVW3NygDXP2aS6E1ID9DCYYMTJS5iZqiEfomOWz8Qfp+OZRxJT0oS
 iPfu9HLCjzNVG23KLaOcekYwymtquu2D3SfFopd0+GUxnDesWY4uAFf+hz8T00RH672Z
 7DO8y21IHXeJ9MtYPFNDXo2NbmixlmueaSzo1FuMemS6gUjt28fKpviS2oKacL73u2jx
 kywg==
X-Gm-Message-State: AOJu0Yyph7foD7Zmhz/wRzpLJMyG5olJUEjPXSHQPZSU08WKXQ4C0qYo
 jXi1mXdy2zDrluKOsDPc94ATVVeduf3RkRK4eMRMC6xVp0CNxA==
X-Google-Smtp-Source: AGHT+IG7+ubMnUfaI9fPV/7IoLDbicMi3tG2Nyp8wnHmhnNgizvYeEoM38n/Wep8/sc4JKLL1bpwRA==
X-Received: by 2002:a05:6808:f0e:b0:3bb:ce11:5d3c with SMTP id
 m14-20020a0568080f0e00b003bbce115d3cmr4828044oiw.73.1703885371598; 
 Fri, 29 Dec 2023 13:29:31 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 67/71] system: Constify VMState
Date: Sat, 30 Dec 2023 08:23:42 +1100
Message-Id: <20231229212346.147149-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-68-richard.henderson@linaro.org>
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



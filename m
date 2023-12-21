Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 984C481AD31
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:20:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Zt-0008Dl-IZ; Wed, 20 Dec 2023 22:18:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zr-00087d-5q
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:27 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zp-0003tB-FK
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:26 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7810917125bso19413085a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128704; x=1703733504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55GqNzFzxTGLqp8I3PrV1yIkLTAvTwTk9yNDaqit+JA=;
 b=x2MMovMLgKXksOpgoZ9h7hXEApLunbk2Gfb/YbONG8WBACU4VynMzOjq44+VUJHW9I
 iLFydvUKlLI6cMlVhFxoLHlb/7MlKLGRqDqvxjP0nruUs7R9gjqblMQFLg6d68L/pxds
 jRLDyRICCC5p/K6l5PuEvWVOqR3DJadc1VD8CwjNYzgsMRvQlmhXYlSQbG45SI3GOln+
 i6/rAi9GLleq5zGR8vb/EtABzSVUF2pJr5cejXDLo/+0iBt90h5IA8jaWsUabus4Nnow
 VTAAKSO6ViuFDdneN5Qs0xgeVy1hTKUicS2merzTRFstjMbqGSmqlOKdpqhdInStKG2a
 rlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128704; x=1703733504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55GqNzFzxTGLqp8I3PrV1yIkLTAvTwTk9yNDaqit+JA=;
 b=oSDiFC6WrILMi89nSwg7X89R5aFYtuBGe+FbFPiic1ZfEQkTxUJwjaTlKRPB2IrF71
 wAwhHribom2BY+/Jqn/LLaTXtJ0hziq1bUWajnvq2fc2kIKfvS6bFhuqryuoo+eNAbwH
 GtnH8BpvS+sdWEAex5aYv4lLo9E6m8Kfrvd3KUvmGoIfNBJhu/CpWdwzVLUimrMUoTV5
 I0I0oGhMrsw/8S8UDKDpj0h1dDukmlpDjziBUeiX5eTDpe/goIdd/dopr2PEujSo0EFh
 IFHXbdWjUfGeU5G7q3rotQKjwfoJOYcAe1D+jKlF5ov0IHSeFB+vdzzq5j06mNAMNg8p
 qIoA==
X-Gm-Message-State: AOJu0Yw1/nt2Cd0Iwm72qNPsGS0WnIc3d41y2viA8/SXuNSLep4KMzHt
 BxuRVkqR0CofbChAc+PZOeF9rS0XM1S7Y8asXlw088lN
X-Google-Smtp-Source: AGHT+IFnO8xxsBdLWpFAGdOxVaLXudUXPSDy/EaPVpo40vvg5tieGOMyuXWeIpzIX5W16ae6Midr+w==
X-Received: by 2002:a05:620a:278b:b0:77e:fba3:4f29 with SMTP id
 g11-20020a05620a278b00b0077efba34f29mr26030143qkp.127.1703128704710; 
 Wed, 20 Dec 2023 19:18:24 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 19/71] hw/core: Constify VMState
Date: Thu, 21 Dec 2023 14:16:00 +1100
Message-Id: <20231221031652.119827-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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
---
 hw/core/clock-vmstate.c | 6 +++---
 hw/core/or-irq.c        | 6 +++---
 hw/core/ptimer.c        | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/core/clock-vmstate.c b/hw/core/clock-vmstate.c
index 7eccb6d4ea..e831fc596f 100644
--- a/hw/core/clock-vmstate.c
+++ b/hw/core/clock-vmstate.c
@@ -41,7 +41,7 @@ const VMStateDescription vmstate_muldiv = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = muldiv_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(multiplier, Clock),
         VMSTATE_UINT32(divider, Clock),
         VMSTATE_END_OF_LIST()
@@ -53,11 +53,11 @@ const VMStateDescription vmstate_clock = {
     .version_id = 0,
     .minimum_version_id = 0,
     .pre_load = clock_pre_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(period, Clock),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_muldiv,
         NULL
     },
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 1df4bc05a7..13907df026 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -94,7 +94,7 @@ static const VMStateDescription vmstate_or_irq_extras = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_extras_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT16_UNSAFE(levels, OrIRQState, num_lines, 0,
                                      vmstate_info_bool, bool),
         VMSTATE_END_OF_LIST(),
@@ -105,11 +105,11 @@ static const VMStateDescription vmstate_or_irq = {
     .name = TYPE_OR_IRQ,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL_SUB_ARRAY(levels, OrIRQState, 0, OLD_MAX_OR_LINES),
         VMSTATE_END_OF_LIST(),
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_or_irq_extras,
         NULL
     },
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index e03165febf..b1517592c6 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -441,7 +441,7 @@ const VMStateDescription vmstate_ptimer = {
     .name = "ptimer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(enabled, ptimer_state),
         VMSTATE_UINT64(limit, ptimer_state),
         VMSTATE_UINT64(delta, ptimer_state),
-- 
2.34.1



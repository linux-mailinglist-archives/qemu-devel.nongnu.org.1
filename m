Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B3A7E1AAE
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:05:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZw-0004gl-Nk; Mon, 06 Nov 2023 01:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZR-0004Vu-2f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:49 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZO-0001PE-U1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so32847035ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253926; x=1699858726; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcCSJZtm5FNm+Vqe6T4fCpsxXN5Xn7N6xYLpXpl9d3A=;
 b=EOVQq6uo9SwXubLgPz5g2Rrg1ILu+gBfpB6accsKwvxO8U6k8AGebvJgOCgMs7uiP6
 HR7IKPqHxzZQmWr+Ic+ys+WbtWb6zFjbvOfyMruA+4cklJdSiojj+BruzE4ptbOWwvwU
 ZOFi6nelWjUVJTgSYiWwdvlgmvUTB1i2l1BfNVl4CIFcFYW+KTNSu9jAtFgJaz4J9QWD
 P+loFiH1clxvQXMuOmwmdtwU/B3+q2Sh95u9dXX9UXrI7SdOEsFJbcJIczKab0veQ2Tf
 oR1bVd+E8DNOH11IQ53G0pK2EkalEdrGUlkjmqbH15nMmzYvgX/6Up1qScBMm8RIUEGU
 MtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253926; x=1699858726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcCSJZtm5FNm+Vqe6T4fCpsxXN5Xn7N6xYLpXpl9d3A=;
 b=lWD7+XdS/WNNyz8lITTRAdbM9cra40b2kYr/r8uJ2L8P5OVXpRt+I6yBzZORAIUTjq
 a4t8UQK/iUofdY3H/FKu0sf7d/+XJDo9nZUviaDn6Q9iZKYW/DojeyJjQWlIM/ikagxN
 lbMLQ990+ZfJhq9LeIaCINaQHlh0hG27jhYngnrqvHsQKFXI66Q/yvrXUnA3ZMbOYYUj
 2cIrs2Q+O4OyqoG04hHVhUUCMPePdrO9r6f36/vCXzEDTUl6DT92ZQLtW6WJabuFKU+g
 Qu6V92Ih5u56bWHBrfAI0imdlgg+TUQb96aAhbT9+cWEsC7pVYt4/IoLOCsTu8EDsVi+
 REPA==
X-Gm-Message-State: AOJu0YwypGZXJZjJjyx814KEmn6vTQLlxPrqga8l0bx2MQhsMl+3ZFkq
 8/hyWp+95vlDw5bDvXsyIuNiqMQqk6qQEffumus=
X-Google-Smtp-Source: AGHT+IFVRs2cBXGHLlcyVzdIowGvZs0ijV6kemXHMI7XFSMQWi9qIlEtjD7Tbzjxc8ag6oRDp0bvBQ==
X-Received: by 2002:a17:902:d4d1:b0:1bc:1e17:6d70 with SMTP id
 o17-20020a170902d4d100b001bc1e176d70mr14495187plg.24.1699253925788; 
 Sun, 05 Nov 2023 22:58:45 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 19/71] hw/core: Constify VMState
Date: Sun,  5 Nov 2023 22:57:35 -0800
Message-Id: <20231106065827.543129-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C468482019C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:25:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLT-0007DU-0a; Fri, 29 Dec 2023 16:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLR-0007CY-DG
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:41 -0500
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLP-0006nt-OE
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:41 -0500
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-35fe8a4b311so26505195ab.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885078; x=1704489878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qxy3UL4B8AxC1Jq+djISZlpE1zvXiAaDiE1NgzJw8Vw=;
 b=pwbKDwAv09IDReFS3A3qDFioLgTbBEq1aeWA08NHlPGGL5JKW/7lyx0hXyfAcvtY0c
 qnr1Vh2PIbrKhq0YHexMIFX/BmEdYftDB7prcWMxfXwFtXC9g8dhxABMjdQSCgbWLrJl
 jAuQt+0ijF/rc6VXBS4kzr/XvTlDcUV9/SufNSYKPYc+/102k9RhbNDliwGqrk1pCKa1
 QZYHt9+MEDSHLkdSNijIA5qYY4VYbsDiT5GA7r3G+s6EDwYcg+Lg9dvSI/NBdVjz4qAp
 uv/lmIlS04tJofQx3zcIXsAy36YjPCfzuEEREIQ3FAM4+dzcyWK0nN77aSMAlVMHGurx
 TJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885078; x=1704489878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qxy3UL4B8AxC1Jq+djISZlpE1zvXiAaDiE1NgzJw8Vw=;
 b=P1wrelpaChFhqn7p0McHS6rzvevm4EYR+/kJsy85qBocKiSzXSqJu6fnyOoKH5S7T3
 IqpWEmp+ijvNXEmGgQI/wu3KYauNceOh05+Xdi3F+CQ/NOhDCU0MXVf6Xf+qofEREuDK
 r3uCKRPAu5uuVIVPbFTpWSrEBIkmpUoXVPfqsJuWgCpCauSevEP7XGe2/QFBjBGnYvgv
 QgQshdLBEhd8a0OXSic2tPmwO7iaLan4ZfHBoy6yBgTF3wY4/6aIkY5Gf84YXhYqyqwL
 NRux05QJycf6HQOT7oYu7y9uBCiBwX7Y8242hMTu4syc583JwfrucK0uLRK3C/9DmigR
 wZ7g==
X-Gm-Message-State: AOJu0YwCW26z3S1kFghZ0gJEypuC2ymNbpRbI6Ut1tJevUUyzpVrtBEW
 xIu3iKIDVk9GUK255BgA0ux77jCBnhTipcWsjh3bfnrDoEsPWQ==
X-Google-Smtp-Source: AGHT+IFMUP/6SbAHgOXLTXDk+M/bG4T7cUSIVVKceekgwuESwqaJhKHIl+VCkhfqfK3hbNmb9G6rEA==
X-Received: by 2002:a05:6e02:3004:b0:360:35f:55e8 with SMTP id
 bd4-20020a056e02300400b00360035f55e8mr10202260ilb.53.1703885078694; 
 Fri, 29 Dec 2023 13:24:38 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/71] hw/core: Constify VMState
Date: Sat, 30 Dec 2023 08:22:54 +1100
Message-Id: <20231229212346.147149-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
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
Message-Id: <20231221031652.119827-20-richard.henderson@linaro.org>
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



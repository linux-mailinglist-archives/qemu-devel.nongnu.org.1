Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676D681AD45
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9b3-0006SY-O3; Wed, 20 Dec 2023 22:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9b1-0006LA-DJ
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:39 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9b0-00047V-1r
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:39 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7810b3c4fa9so106728685a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128777; x=1703733577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GK0r0bvGCZ9eQqWkzgeODTyST+S/GfSxl8+D4j9zUNc=;
 b=KXRG8vK5Oaqrr4cT4ftU55ev3pR9eF1OH0R9ExgeVh3fK9KeXYaJBBkxdpyU3pbfDH
 rX7bozsEGAlhhKTX8f7lr8r2hTsH/rpveEc5fjRS5TefgztiyNIc598TGHb+LzbIfL5f
 f8GH6x7XMbFUjPJAVGqQ/qt7f9Hsf8EFsFBhvROqbF6kyT9unB5JESzlbIW+HvEAwvDW
 9KuLrvlN+TD77fs8sE6bEPgiMr5OnKXDhTI/ekv50sC2nvTfmkatn9pl97t4UUZyEZzv
 k9bShqzF6jenjmfASqQBCwR345kapHBoZzyju6aP6AJvltLHiER/Iduvvc/jR/xSkV1Q
 7eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128777; x=1703733577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GK0r0bvGCZ9eQqWkzgeODTyST+S/GfSxl8+D4j9zUNc=;
 b=V9crQ+5Q4vUaTSubPrPRYsFxNC1ItLIlWCYKMVjZ1NXXXYcbm4xnUnVrFhX+Kms/4/
 hL65P7KK2aooDY1RJy3KAQ4Vp4UPefBByjwMCW7mZ6A3QZZNsTmEuI88JFzLItDKb1aC
 jco6uo8ErULeACfxMYygHYtxIrPcyJ5LNnz4+b5plzHj+2ry4buHk56cyRECSh8LqfWd
 CGXcer4DcijtMAOz3C+w8xrl4/0WPiZcU1foHF4g4lYi2Q+FPHO99ACVp7gmgYa91d2r
 s2VfJhoZry9lIPOapZFo7nSCg+5jf5yGBvrVbj1vTUMM8839KlhqB035Wia70kdjAT+3
 mWyA==
X-Gm-Message-State: AOJu0YwEtKSr7jHqSfEn+UehsRALIkBxbX11ATboGBgrgVKP/LurM4Go
 VUOEdhqFlT3vSWQtew80KsNnGNy3ZdaIEqdNEPMkr2le
X-Google-Smtp-Source: AGHT+IEWrDvVq/oTaxGy2FrrcqFlEnh5lKt09jkMGfGdF0BstB/k6geoyxgjtl55j+BOHH7Nd8T7WA==
X-Received: by 2002:ae9:e507:0:b0:77f:347a:6210 with SMTP id
 w7-20020ae9e507000000b0077f347a6210mr49549qkf.49.1703128777174; 
 Wed, 20 Dec 2023 19:19:37 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 39/71] hw/m68k: Constify VMState
Date: Thu, 21 Dec 2023 14:16:20 +1100
Message-Id: <20231221031652.119827-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72e.google.com
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
 hw/m68k/next-cube.c | 4 ++--
 hw/m68k/q800-glue.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index fabd861941..baca38bf39 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -996,7 +996,7 @@ static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(ram, NextRtc, 32),
         VMSTATE_UINT8(command, NextRtc),
         VMSTATE_UINT8(value, NextRtc),
@@ -1011,7 +1011,7 @@ static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
         VMSTATE_UINT32(int_mask, NeXTPC),
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index f413b1599a..b5a7713863 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -189,7 +189,7 @@ static const VMStateDescription vmstate_glue = {
     .name = "q800-glue",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(ipr, GLUEState),
         VMSTATE_UINT8(auxmode, GLUEState),
         VMSTATE_TIMER_PTR(nmi_release, GLUEState),
-- 
2.34.1



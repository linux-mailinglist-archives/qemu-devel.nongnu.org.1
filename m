Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C3E81AD32
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:20:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZW-0007Yw-Tu; Wed, 20 Dec 2023 22:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZT-0007Yb-VS
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:03 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZS-0003oA-KW
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:03 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-42782692142so2380311cf.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128681; x=1703733481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FD5wy/U9+bZCbaz0itBRFKutSZtCYzbYclfjlyxHVl0=;
 b=gi2lSAav05VqO4QvkLpmXaWDwXWg1+ONdTL1fYBV09jc6Sygh7ah3V3P676Abj/LuE
 DzV+97+TvGjd2q4VB32IpQlGfgZaONUvtOGWq/1jarJS1hPgbLhRgRX6aa1h3cxqtpM9
 vXfHS6r1+zKEhl1qiPwH/a7YklPwh+6TDNC89nyrl6vhgdQkkczM4Od4UnUFJpijzWkk
 Qi7AfSUN6NUp6K75HBFf6ysC75yBF2/98F3kTQfNV+8numamR5d2aYzfVU6jyNukHTwF
 GASJdxSkh2C3CqQdfipMHtq2Myr4yTut9v3qLkXmQdM5bOG+IJArroZ04fQe8K2ZsUEg
 pxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128681; x=1703733481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FD5wy/U9+bZCbaz0itBRFKutSZtCYzbYclfjlyxHVl0=;
 b=n4SGohmBHd7oYbchKhxRwzD4OiJoNVc+KAfBuvWf6DvLLgpDYg9/LJ6GMDokD5tYJ6
 xJ0QEY9kKTOiu20/Cm1TIY06wVJEA9xVTzlvRN+ZYaEHCCE9jvn1lgPLs8BnINkHdQWt
 j6oSJMO3izv+d1qB1FdGaRSeXbwEV1wfJQAGndxWy+6K7Knhfw04kQ147nPVh/RJZ1nv
 jikQ1N/0PLEj/ZwrJhIuHj32ajczpsYYyv6zEFxQYi4SqaKKliPGzalAK2EauOGUUENF
 fnzK/NxQuIXHQSA13HyBs3mQ9tQeKPYNzHSxYDF4MqFYGlkKs/U+F+2+pDV1EF1hAidS
 Sq8Q==
X-Gm-Message-State: AOJu0YyxZKvVoZNg669M9H+jFYpbBVCZ6lOd1OMD7mqmtNomeo/wzifR
 Sfx1/+CHK2ce2mORLzC8Ol39ShPJO1WOgZGDon3wJUWD
X-Google-Smtp-Source: AGHT+IEz1rbIobH5wVO14bCbmGGkoiUvwgmBCzgokUokiF/LfDQ13R84PlJfAQBHiKVmPRuT0QNWoA==
X-Received: by 2002:ac8:7d4e:0:b0:427:8319:16fa with SMTP id
 h14-20020ac87d4e000000b00427831916famr3370453qtb.15.1703128681067; 
 Wed, 20 Dec 2023 19:18:01 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/71] target/openrisc: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:54 +1100
Message-Id: <20231221031652.119827-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x831.google.com
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
 target/openrisc/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index b7d7388640..3574e571cb 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -25,7 +25,7 @@ static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
         VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
@@ -36,7 +36,7 @@ static const VMStateDescription vmstate_cpu_tlb = {
     .name = "cpu_tlb",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
         VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
@@ -71,7 +71,7 @@ static const VMStateDescription vmstate_env = {
     .name = "env",
     .version_id = 6,
     .minimum_version_id = 6,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
         VMSTATE_UINTTL(ppc, CPUOpenRISCState),
@@ -135,7 +135,7 @@ const VMStateDescription vmstate_openrisc_cpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CPU(),
         VMSTATE_STRUCT(env, OpenRISCCPU, 1, vmstate_env, CPUOpenRISCState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1



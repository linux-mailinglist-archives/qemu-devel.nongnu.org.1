Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097881AD4E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Zl-0007j3-Qv; Wed, 20 Dec 2023 22:18:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zj-0007cp-Q6
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:19 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Zi-0003ph-At
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:19 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-781045f1d23so22376585a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128696; x=1703733496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSRKoHjlOWEZu2eNFJmmFp8t2vE+PeEbwst6EsDj2Is=;
 b=mbXlQN+xgafjy6i88hcsBE9sJpDoOEcx37YxE7LH0YShrc1Xqh1+ALRQT/ksJGGJSS
 VkYcyz/P3AYrhbS3pW8yx3Otq4G8+ntsuIFuBOIiqSZeXRSO2Be182jgWIAL+0vq1yIO
 AwEciJuY8M7k8P2pbDUW0RRjgAQDl1mEJQNutNMH9XTeUiIud1avoLy5xAPYtgPeAF/x
 09eSy4pTdE7M+7yHOBTKF0dKosV8FVVLWOvLZMvmoZVufKiHhFbEWx5EOg9/aDDOzVuc
 DxWMahAzeq9SNFEidoYtp8EbLSkxk4fSY+3ccJSgUJlJm/jwX+LffbegFWyBkQdUXK/0
 Ntsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128696; x=1703733496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSRKoHjlOWEZu2eNFJmmFp8t2vE+PeEbwst6EsDj2Is=;
 b=VdgpVslxmZRfHgrNIQWn0TrK6Wwg2snLnj2GHwkmjmcbnBYibNSOdE8jI01CBGVJsb
 AnGFSEtHqwQqprXPX9wYgN9lE6aNON1YL06s+yGFg8o4w/OVLyOCy9BUEwtwbYJfASP1
 VBS9BT0nKhCNt8aAu94EgqcDKnrMXX18tFQj0BVHSOoYUBvnKEj0XjiQMsnBP04fMrNY
 5WTCb3SDM/ZHMnMSgeEZmLyk4QU+GUkEhPNLLEhPExW7s9K51VHbCgJjgj6B8ukm/d6V
 UIOQ1HRN0wSrGcjmEZNcuMG2tEI7jLQX2abYmjwUrt6Ldlbc6xsY2vkqyLK0KouRcs3t
 jIqg==
X-Gm-Message-State: AOJu0YwoDLNCejdsLje8lm5sMWB9U63rXmNLGy12kFhNNY/czT9khURI
 JLKCymUsn0OdMBbQU58z0yQVIRklRvKBUTFexTu1ah8z
X-Google-Smtp-Source: AGHT+IHKfPPYTA3qnp75Y8zHF8A2rhEgKCLDIh1py4WUPkw3+vurpGRrcYc2nU2+soow4y+WW7H65w==
X-Received: by 2002:a05:620a:563a:b0:77f:439:8128 with SMTP id
 vv26-20020a05620a563a00b0077f04398128mr25895842qkn.69.1703128696680; 
 Wed, 20 Dec 2023 19:18:16 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2 17/71] target/sparc: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:58 +1100
Message-Id: <20231221031652.119827-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x729.google.com
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

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 44dfc07014..2b5686c330 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -10,7 +10,7 @@ static const VMStateDescription vmstate_cpu_timer = {
     .name = "cpu_timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(frequency, CPUTimer),
         VMSTATE_UINT32(disabled, CPUTimer),
         VMSTATE_UINT64(disabled_mask, CPUTimer),
@@ -29,7 +29,7 @@ static const VMStateDescription vmstate_trap_state = {
     .name = "trap_state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tpc, trap_state),
         VMSTATE_UINT64(tnpc, trap_state),
         VMSTATE_UINT64(tstate, trap_state),
@@ -42,7 +42,7 @@ static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(tag, SparcTLBEntry),
         VMSTATE_UINT64(tte, SparcTLBEntry),
         VMSTATE_END_OF_LIST()
@@ -147,7 +147,7 @@ const VMStateDescription vmstate_sparc_cpu = {
     .version_id = SPARC_VMSTATE_VER,
     .minimum_version_id = SPARC_VMSTATE_VER,
     .pre_save = cpu_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gregs, SPARCCPU, 8),
         VMSTATE_UINT32(env.nwindows, SPARCCPU),
         VMSTATE_VARRAY_MULTIPLY(env.regbase, SPARCCPU, env.nwindows, 16,
-- 
2.34.1



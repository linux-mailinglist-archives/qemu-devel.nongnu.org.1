Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A918201A9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLQ-0007B0-DL; Fri, 29 Dec 2023 16:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLO-000793-S5
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:38 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLM-0006kS-BE
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:38 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so2214424b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885074; x=1704489874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LI81JsuIm1ZNENuf49HeeV43cGqA8WHtNsvGxM/VR4U=;
 b=zUPAC5o0o9tpb7WMrXxdhEzriw2DjTnvElApjqwG9LurOfJc2LPwhD2yfj7pm1y8nf
 4/u9sqEa1/cBfrBMmFzjOHDOlSlAAcXPvOdp/hI1puNRvAHuN9LOgRGlFI6twpA0Akpz
 n1FMePHc5ZNjuXGwNFgnQDyhDhI6Vw+8dR36YQZoRKWmfKNNr+jIaIehAiI1zm/PTXjM
 989B+L5HvTCDLpkUbNBEVMONzQwYG+Bw+4YwydNa7c+fTtK7g4v/vfj4UCYMmhvQihIC
 UHF/OF6n0rIAPJjcDti2XNEWx9+Be2vvbJdunu0YmbgU0JGPgi7lgQARGYggfGnZtAZG
 5Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885074; x=1704489874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LI81JsuIm1ZNENuf49HeeV43cGqA8WHtNsvGxM/VR4U=;
 b=WwWN+GrIOYN/8ZcQvys7K/H+n10C9w+nyGL1pL3vTxZ6XLYFJW/y9Vmt0ba9DK11mQ
 CltVdOySy7XEmsV5DcOwZCuEBh2lNQct+XHwbcaSKVwsU7gYgo1GuqLfLI1CI8x644WE
 5FDMJInw/5Ywz2uO1nymruwL/BfcgmWF6LA4aF5NTIrooi1I/A45at2UJzeLYtfCRXL5
 l8i0fQtN2yjm+AzLP+ak9zVwj2p7Mwo/60UkUVMbOvmB3nscv+I3EOATQddgLkRtAdfV
 w8qlnsueVbwg7SyqhjKrE7UBywSkwb8jLkeCSM9bHAJ+cIUqfVEm6GOb11T9UCGzB78M
 9p0w==
X-Gm-Message-State: AOJu0YyvQWR6myXa4vyauc9NF4DHpqC/fT4G7P2568NXOI4e9yO4zkze
 DNLUKkSLLqNU9R7UnH5rDS/gfxN32xQMKFnxWfBpoyOxdJzgJw==
X-Google-Smtp-Source: AGHT+IEabpwosUgHXhdi0ul+3hgT2lRxv7nRe0GFe4FApMrhgNfUXk2MU4sSRLMcp6sCa3Uk+g6Bdw==
X-Received: by 2002:aa7:8b48:0:b0:6d9:8f6f:6b7e with SMTP id
 i8-20020aa78b48000000b006d98f6f6b7emr11500576pfd.56.1703885074032; 
 Fri, 29 Dec 2023 13:24:34 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 17/71] target/sparc: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:52 +1100
Message-Id: <20231229212346.147149-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Message-Id: <20231221031652.119827-18-richard.henderson@linaro.org>
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



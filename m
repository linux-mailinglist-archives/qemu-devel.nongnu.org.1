Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8281AD4F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZR-0007Wy-VC; Wed, 20 Dec 2023 22:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZQ-0007Uv-Ip
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:00 -0500
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZP-0003nq-0A
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:00 -0500
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7811dba1d5dso18163185a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128678; x=1703733478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AFzh7chlq8L+JCC/XZfJPBd+42r5XtptQoNPZ9V4uc=;
 b=hvhwipuv8pngnGVAev8AF/SjeC0h9+RO7wRA1mZwoT/NDV2VedFoMhsT9r7gDSitHR
 MzFcY1kOLlEuhERJFiBlbBanOWOyt/G0TJFzECxyuq5ZrnSf083scCJmtfHjhcSnOkgv
 JJfa++AVRyNa4LAFut0F0s+JwjYfK6ahfWehlZ8nbVCbPlx6R8vTUpuxg3IFwO8hLJ1n
 iRTqw8P7z4C4ZLP3qL2lB8KmFPmxF9gzwyEwQ9+D4jGFjt8ilKWv6XwhmsGRX1ElUYWp
 0d8Z+2jS0gm+7E2gJdQvuF5YOzGqlYOqcMDLtcD3lTG7s1yeRRsx/w6vxU6mdYnIroLT
 KYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128678; x=1703733478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AFzh7chlq8L+JCC/XZfJPBd+42r5XtptQoNPZ9V4uc=;
 b=dFW+tIdnIC/6am+NViF6aORlmuuoLOfFXBMcT1pcQHhxhxYxQgb6kK9ECMIfLPLinR
 OwAda/bG7AFOPZ3DwJcGsyU3hWTkQNo0dFXMqqSzocAdSHf67CGsMVSAvXA0MMtgJYRQ
 u01j288yIkFdQVtjEhZHi0Rk1d6KwmU4EFeF+qAhAMQeOre3H76eLcXyJk4xLPPk8tPY
 rUnmARhuzmxrxMfHzYzr1ccH5znMqbSIlM0Utmql0wf8NVdv0AxGm+/8FBzB7JCXNipK
 fKgflch37yRq+nZRjQD/Gz3K7GSOBOo/lP26ygJ1zAKvMrpRH1Lb8lAv1DL9n46hARE4
 d9vw==
X-Gm-Message-State: AOJu0YzSyEXeQHg7Hbr1pcVNPtSyyaT29ZcRIJJS7Jrx4m6jLQqX6iEE
 XBkBEUKjEXoTW+MHRbUWTfbhUoCZDfF5IOSWXS0AlKUS
X-Google-Smtp-Source: AGHT+IFe5PbfTe24bNTo7qB4WQWRPdlNT9f68vIdPprb1WhXiwIlaK4ve6q9+GkU6J189V901TQhJw==
X-Received: by 2002:a05:620a:2989:b0:77e:fba4:3a41 with SMTP id
 r9-20020a05620a298900b0077efba43a41mr28793365qkp.151.1703128677849; 
 Wed, 20 Dec 2023 19:17:57 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/71] target/mips: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:53 +1100
Message-Id: <20231221031652.119827-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72c.google.com
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
 target/mips/sysemu/machine.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 80d37f9c2f..218f4c3a67 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -44,7 +44,7 @@ static int put_fpr(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-const VMStateInfo vmstate_info_fpr = {
+static const VMStateInfo vmstate_info_fpr = {
     .name = "fpr",
     .get  = get_fpr,
     .put  = put_fpr,
@@ -56,21 +56,21 @@ const VMStateInfo vmstate_info_fpr = {
 #define VMSTATE_FPR_ARRAY(_f, _s, _n)                           \
     VMSTATE_FPR_ARRAY_V(_f, _s, _n, 0)
 
-static VMStateField vmstate_fpu_fields[] = {
+static const VMStateField vmstate_fpu_fields[] = {
     VMSTATE_FPR_ARRAY(fpr, CPUMIPSFPUContext, 32),
     VMSTATE_UINT32(fcr0, CPUMIPSFPUContext),
     VMSTATE_UINT32(fcr31, CPUMIPSFPUContext),
     VMSTATE_END_OF_LIST()
 };
 
-const VMStateDescription vmstate_fpu = {
+static const VMStateDescription vmstate_fpu = {
     .name = "cpu/fpu",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = vmstate_fpu_fields
 };
 
-const VMStateDescription vmstate_inactive_fpu = {
+static const VMStateDescription vmstate_inactive_fpu = {
     .name = "cpu/inactive_fpu",
     .version_id = 1,
     .minimum_version_id = 1,
@@ -79,7 +79,7 @@ const VMStateDescription vmstate_inactive_fpu = {
 
 /* TC state */
 
-static VMStateField vmstate_tc_fields[] = {
+static const VMStateField vmstate_tc_fields[] = {
     VMSTATE_UINTTL_ARRAY(gpr, TCState, 32),
 #if defined(TARGET_MIPS64)
     VMSTATE_UINT64_ARRAY(gpr_hi, TCState, 32),
@@ -103,14 +103,14 @@ static VMStateField vmstate_tc_fields[] = {
     VMSTATE_END_OF_LIST()
 };
 
-const VMStateDescription vmstate_tc = {
+static const VMStateDescription vmstate_tc = {
     .name = "cpu/tc",
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = vmstate_tc_fields
 };
 
-const VMStateDescription vmstate_inactive_tc = {
+static const VMStateDescription vmstate_inactive_tc = {
     .name = "cpu/inactive_tc",
     .version_id = 2,
     .minimum_version_id = 2,
@@ -119,11 +119,11 @@ const VMStateDescription vmstate_inactive_tc = {
 
 /* MVP state */
 
-const VMStateDescription vmstate_mvp = {
+static const VMStateDescription vmstate_mvp = {
     .name = "cpu/mvp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(CP0_MVPControl, CPUMIPSMVPContext),
         VMSTATE_INT32(CP0_MVPConf0, CPUMIPSMVPContext),
         VMSTATE_INT32(CP0_MVPConf1, CPUMIPSMVPContext),
@@ -190,7 +190,7 @@ static int put_tlb(QEMUFile *f, void *pv, size_t size,
     return 0;
 }
 
-const VMStateInfo vmstate_info_tlb = {
+static const VMStateInfo vmstate_info_tlb = {
     .name = "tlb_entry",
     .get  = get_tlb,
     .put  = put_tlb,
@@ -202,11 +202,11 @@ const VMStateInfo vmstate_info_tlb = {
 #define VMSTATE_TLB_ARRAY(_f, _s, _n)                           \
     VMSTATE_TLB_ARRAY_V(_f, _s, _n, 0)
 
-const VMStateDescription vmstate_tlb = {
+static const VMStateDescription vmstate_tlb = {
     .name = "cpu/tlb",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(nb_tlb, CPUMIPSTLBContext),
         VMSTATE_UINT32(tlb_in_use, CPUMIPSTLBContext),
         VMSTATE_TLB_ARRAY(mmu.r4k.tlb, CPUMIPSTLBContext, MIPS_TLB_MAX),
@@ -221,7 +221,7 @@ const VMStateDescription vmstate_mips_cpu = {
     .version_id = 21,
     .minimum_version_id = 21,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* Active TC */
         VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1, vmstate_tc, TCState),
 
-- 
2.34.1



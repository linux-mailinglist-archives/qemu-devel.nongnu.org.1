Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47582019A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:25:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLG-0006y0-1h; Fri, 29 Dec 2023 16:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLD-0006xD-Hh
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:27 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLA-0006dC-Nz
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:27 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2044d093b3fso4451643fac.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885063; x=1704489863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mm4+MbG9/Lxz7kczYlcLTiw7gqQVGMuSdlqX7t/TGnQ=;
 b=UGSxTEN8rzWp5WTSvqkVDkwVFtSSR6UIqoZOc5E7BsjNp8WKzBluKNEXm/GaHp/Shg
 2tibF1H3u+IIMTVGrRohUMnP04Z8BrkRMZDew1q5GmjtdmTVOlgTCFPqrWmxjZQSunYC
 9TIwcRc9H1Ir5AYdigF1nQrfu55YoctYQC86Jd+TIJnbGNOYaxxYkzwR+zxcd6vLn/4g
 zcGdPvdGz8mktA5D24lkyIZRtIve1RyaDofppkRjlZzXw+bO//wyr5vYh7VBZbDfAgDr
 0VFSqy4VUqZVuJ8cr7gLCpagSZs8FIJYAjSg7QcnLOOUiiMP8FdJXDUWPR+7AtseO4b+
 +5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885063; x=1704489863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mm4+MbG9/Lxz7kczYlcLTiw7gqQVGMuSdlqX7t/TGnQ=;
 b=bQyLAzYp1DfPEmf4AHe6VXE6O9zb9GnTrDbsjlkMIsRCGU7drkyC0cVFzgBX6LdYEb
 Ifd8K1Q/z+2lxhMwxWpHRnqfPrTdjbgmgubJFnLNRMRnw97yVUiDu69HjyQw3zZJwD1x
 Gu7Vj4DS3C36/YTJDESKPr2fs1QCZ7eDBSjzUgVLcxyF8kodU5lRzP7OKxQCrT49DEPA
 T+JP0/YkwAfmxNGiH9mJisCwTb2cAW3e0R0LSJafw1sDNqlYfjHTUCy1iYvcu0fKkLw6
 sslUuuAmL1R5Z/TQyAgRaQr4t7ehykHxomx1E/bcrFHVIjS1YHO1uj/jmRxiasjdXjr/
 blqg==
X-Gm-Message-State: AOJu0YwOmm7jDXQQOPCTj5+e7cAMOkL2AUnXum5TFJIKK2YdoL1KLvL4
 ghCFb9LEbaDpIslsnbW4g1vjWK9gRVgWNm2N+ThigQQhZQ+agw==
X-Google-Smtp-Source: AGHT+IFdl1V4+fy65GQgJYrf32biJ/i+8z2An25A9Qotmx923CvUQ2uv32uc0B1Rrwur1yZSiQHnEw==
X-Received: by 2002:a05:6870:238f:b0:203:a48b:6ad4 with SMTP id
 e15-20020a056870238f00b00203a48b6ad4mr15710572oap.93.1703885062984; 
 Fri, 29 Dec 2023 13:24:22 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/71] target/mips: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:47 +1100
Message-Id: <20231229212346.147149-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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
Message-Id: <20231221031652.119827-13-richard.henderson@linaro.org>
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



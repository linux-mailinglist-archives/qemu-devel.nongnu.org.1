Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3847E341C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRm-00057p-Bv; Mon, 06 Nov 2023 22:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRc-0004mO-Dp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:00 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRV-0001P9-OJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:00 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso5526977b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326472; x=1699931272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5R4Ejp1tf3eAAlnOmMDj473kePszpAfYWj5OPHnPKtM=;
 b=LJeSzIxEK3rOH/lbHpxa4URxMLutFCCnLsXJNiULpKw1zc5Ymd5svoHhiI7JiRV2Re
 d9AMmjOxz5FNLy2IMZBwz6R5rP2tnC9+r/rkPT4cH6rdm2Rghlp+wN+w+chTejft6Vbz
 y4SWnZCdNbwylBHMMXjSyfryD9aZUDDyRLDFR8SkCXq7RK8nyW5twcURamLFGKtjpcck
 KYdotl/EkzYouPg/QCYA2ozvbUXMnH6C/b7e2TBS+4RmaFfPTc0wz1xfkc6Wizx+L4PB
 u4TUxrHxKj63voD/CmWnfuKgGgkpCoscde8sI1FqCj5/oZAz3A+uRnUiUs+Zu/M4cMIb
 Jb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326472; x=1699931272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5R4Ejp1tf3eAAlnOmMDj473kePszpAfYWj5OPHnPKtM=;
 b=s6kzdxEp43+Nkix+VTDzdRi9pQn4MgpMQdymI8iFhAg0j9vt+1f0vSHlX+c0XbNhr8
 8hQW5O8OdUTWQv4wi+6p20HDZfmCMK6EpSXjQxiUyKbiL4h5IeM7FHsr7+Hl28tXdDLz
 wyf85CVu8n0vdG9HwHqMyXCs7fkLQrc7UD3m3QeM2ZXICHPE2hmYRxpBYrqN5+I+36kx
 L//3J2HWYKM+OzG4Lq6rVMP6fcBvSmzeZnoSPuti/P27qnL01Xn8xK9hA0DpgiL3p8LH
 5y3bdM2HiatQu6Be34QVfpoqkp6GmW5TdVPteSCqw3e0hc+TbvpAatng3gf8lmWIktlM
 FsuA==
X-Gm-Message-State: AOJu0YxIeSxLVKidsMw9PYoLv+3C+MEzRK7yYYYLoTybqryGlXya2f8f
 xjkT5jQTv9jZhgH5B5ev1LzAzwhk+5bOVnr7C08=
X-Google-Smtp-Source: AGHT+IFwfLQ6lBoVLOpqmz8KxyRZUzBCwFOhgLlivZU9kw3FJlharL9YAm7tjwoLTeo27EgT/eKHIw==
X-Received: by 2002:a05:6a20:958b:b0:160:97a3:cae9 with SMTP id
 iu11-20020a056a20958b00b0016097a3cae9mr41891238pzb.54.1699326472199; 
 Mon, 06 Nov 2023 19:07:52 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/85] target/hppa: Adjust vmstate_env for pa2.0 tlb
Date: Mon,  6 Nov 2023 19:03:40 -0800
Message-Id: <20231107030407.8979-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Split out the tlb to a subsection so that it can be separately
versioned -- the format is only partially following the architecture
and is partially guided by the qemu implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/machine.c | 93 ++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 36 deletions(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index f6df4deac5..2f8e8cc5a1 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -44,28 +44,30 @@ static const VMStateInfo vmstate_psw = {
     .put = put_psw,
 };
 
-/* FIXME: Use the PA2.0 format, which is a superset of the PA1.1 format.  */
 static int get_tlb(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field)
 {
     HPPATLBEntry *ent = opaque;
-    uint32_t val;
+    uint64_t val;
 
     ent->itree.start = qemu_get_be64(f);
+    ent->itree.last = qemu_get_be64(f);
     ent->pa = qemu_get_be64(f);
-    val = qemu_get_be32(f);
+    val = qemu_get_be64(f);
 
-    ent->entry_valid = extract32(val, 0, 1);
-    ent->access_id = extract32(val, 1, 18);
-    ent->u = extract32(val, 19, 1);
-    ent->ar_pl2 = extract32(val, 20, 2);
-    ent->ar_pl1 = extract32(val, 22, 2);
-    ent->ar_type = extract32(val, 24, 3);
-    ent->b = extract32(val, 27, 1);
-    ent->d = extract32(val, 28, 1);
-    ent->t = extract32(val, 29, 1);
-
-    ent->itree.last = ent->itree.start + TARGET_PAGE_SIZE - 1;
+    if (val) {
+        ent->t = extract64(val, 61, 1);
+        ent->d = extract64(val, 60, 1);
+        ent->b = extract64(val, 59, 1);
+        ent->ar_type = extract64(val, 56, 3);
+        ent->ar_pl1 = extract64(val, 54, 2);
+        ent->ar_pl2 = extract64(val, 52, 2);
+        ent->u = extract64(val, 51, 1);
+        /* o = bit 50 */
+        /* p = bit 49 */
+        ent->access_id = extract64(val, 1, 31);
+        ent->entry_valid = 1;
+    }
     return 0;
 }
 
@@ -73,27 +75,30 @@ static int put_tlb(QEMUFile *f, void *opaque, size_t size,
                    const VMStateField *field, JSONWriter *vmdesc)
 {
     HPPATLBEntry *ent = opaque;
-    uint32_t val = 0;
+    uint64_t val = 0;
 
     if (ent->entry_valid) {
         val = 1;
-        val = deposit32(val, 1, 18, ent->access_id);
-        val = deposit32(val, 19, 1, ent->u);
-        val = deposit32(val, 20, 2, ent->ar_pl2);
-        val = deposit32(val, 22, 2, ent->ar_pl1);
-        val = deposit32(val, 24, 3, ent->ar_type);
-        val = deposit32(val, 27, 1, ent->b);
-        val = deposit32(val, 28, 1, ent->d);
-        val = deposit32(val, 29, 1, ent->t);
+        val = deposit64(val, 61, 1, ent->t);
+        val = deposit64(val, 60, 1, ent->d);
+        val = deposit64(val, 59, 1, ent->b);
+        val = deposit64(val, 56, 3, ent->ar_type);
+        val = deposit64(val, 54, 2, ent->ar_pl1);
+        val = deposit64(val, 52, 2, ent->ar_pl2);
+        val = deposit64(val, 51, 1, ent->u);
+        /* o = bit 50 */
+        /* p = bit 49 */
+        val = deposit64(val, 1, 31, ent->access_id);
     }
 
     qemu_put_be64(f, ent->itree.start);
+    qemu_put_be64(f, ent->itree.last);
     qemu_put_be64(f, ent->pa);
-    qemu_put_be32(f, val);
+    qemu_put_be64(f, val);
     return 0;
 }
 
-static const VMStateInfo vmstate_tlb = {
+static const VMStateInfo vmstate_tlb_entry = {
     .name = "tlb entry",
     .get = get_tlb,
     .put = put_tlb,
@@ -147,7 +152,24 @@ static int tlb_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_tlb_fields[] = {
+    VMSTATE_ARRAY(tlb, CPUHPPAState,
+                  ARRAY_SIZE(((CPUHPPAState *)0)->tlb),
+                  0, vmstate_tlb_entry, HPPATLBEntry),
+    VMSTATE_UINT32(tlb_last, CPUHPPAState),
+    VMSTATE_END_OF_LIST()
+};
+
+static const VMStateDescription vmstate_tlb = {
+    .name = "env/tlb",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = vmstate_tlb_fields,
+    .pre_load = tlb_pre_load,
+    .post_load = tlb_post_load,
+};
+
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT64_ARRAY(gr, CPUHPPAState, 32),
     VMSTATE_UINT64_ARRAY(fr, CPUHPPAState, 32),
     VMSTATE_UINT64_ARRAY(sr, CPUHPPAState, 8),
@@ -176,24 +198,23 @@ static VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT64(iasq_b, CPUHPPAState),
 
     VMSTATE_UINT32(fr0_shadow, CPUHPPAState),
-
-    VMSTATE_ARRAY(tlb, CPUHPPAState, ARRAY_SIZE(((CPUHPPAState *)0)->tlb),
-                  0, vmstate_tlb, HPPATLBEntry),
-    VMSTATE_UINT32(tlb_last, CPUHPPAState),
-
     VMSTATE_END_OF_LIST()
 };
 
+static const VMStateDescription *vmstate_env_subsections[] = {
+    &vmstate_tlb,
+    NULL
+};
+
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = vmstate_env_fields,
-    .pre_load = tlb_pre_load,
-    .post_load = tlb_post_load,
+    .subsections = vmstate_env_subsections,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, HPPACPU, 1, vmstate_env, CPUHPPAState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1



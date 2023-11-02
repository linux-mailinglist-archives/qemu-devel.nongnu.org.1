Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 652027DEA3C
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:40:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMc9-0007NV-Dn; Wed, 01 Nov 2023 21:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb8-0006Y5-Td
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMb4-0001y4-Lh
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so3238525ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888849; x=1699493649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AN07pJMTsiIlY8LB6MnLf8VE2u/chTuU0HpC7BaSLTY=;
 b=PxczQ4CCJ0KLgZJHj0KiUzgNaG1TADUbcYGdsVuCAs/obrAwTHJD/GqolnIxjPz6Gl
 JW8RoWs7nAhBt4Hup6VMhRW9mlloltzw66y0YfiEySC6zkOqpJyxl2hSfcDne1KRoOvZ
 4Xa52vGu0lt4nn9tWiAtAKGVRkxRf6TO83bqk5eBUd6q29KdqAsSpxNKq5qasIYqcYCA
 AG92mktpPzmI0o0iPsdOQG7NDWUNmaWmobSftaIaXBbZ0NOp0pLcUHyDydl1klyRxlG2
 fcpu5oEkI7HfMbYD6sXirJbiTpl7rEdvUVZy7pi16g21ree2IR03SmhsrXUKaCCv5D3A
 1e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888849; x=1699493649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AN07pJMTsiIlY8LB6MnLf8VE2u/chTuU0HpC7BaSLTY=;
 b=TfcBMRQokOlMHoJRNKjbmOZAxVVtZOVzhan8yOVpjAHhxET8ZaqNvW5ymxZcjIXAOG
 eHE9sIeY1a8CEWgi7fXCNtK3W2ynEbcRcfeXvRDKOM16rP0qYqE6FkRj0+zATHNlTJXP
 AOrRoRWUOJuZj7Hs9n3XcJ7wzutP6O0Hs/RLsObn7L28pMTfQeGu0PiJwZmdOmG7JNVA
 V+D++frg+pwLdcn71cbV31UNmEFZM4zO65P6Mw7cps2WUyYLTARP9Wld425fP5LidNvl
 eogkITFSlAwnaTQ+BRsIdDJdEaK2AD51PfEdJhFv7fWyrAG9s4QCRnXiDA6PAC+h4gR4
 ++hQ==
X-Gm-Message-State: AOJu0YxT0fNY5Amz8yUdstKkpL9DC1O2bKwcKEE9lZ04Ny8XnSgeBEIv
 JISE31FRf8dZDATrDt4uG6fkvRTxufZlpsNlv1Y=
X-Google-Smtp-Source: AGHT+IGX9bRI8gPCIyi+xcsnbHsefRWXDvJIGZYrBzbFnLi/lJGpyV+IF59xX+BkIrfsJ0zs4Q4TOQ==
X-Received: by 2002:a17:902:da8d:b0:1cc:548d:423b with SMTP id
 j13-20020a170902da8d00b001cc548d423bmr10571397plx.60.1698888849426; 
 Wed, 01 Nov 2023 18:34:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 60/88] target/hppa: Adjust vmstate_env for pa2.0 tlb
Date: Wed,  1 Nov 2023 18:29:48 -0700
Message-Id: <20231102013016.369010-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index f6df4deac5..823e6af7ee 100644
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
+    .name = "cpu/tlb",
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



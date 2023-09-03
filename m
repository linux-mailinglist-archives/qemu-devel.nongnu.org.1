Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D315B790AE1
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfIz-0004Qk-Fg; Sun, 03 Sep 2023 01:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHg-0002pI-OA
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:28 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHe-0001ly-Bb
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:28 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so2170425ad.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717465; x=1694322265;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=roTMe45HmgofN3+MiGETn4+wzF2HiB60U2BiLq2radc=;
 b=tND6qTCMIDzQsdW27MJYhvLI8mg0X7XN1IVwL15k6a3Lnbims3r1ct8AoV0LUhOI0a
 cNIvpDnBAmBHhAIWZsq9Pz7mMVRqsXWgsQPdV/N9BwH57XHuXF90nWHNtG80P8zawdby
 9NhGT9d0pHPkdqz1LtG4hxwn9Jq2QdRX9aFXVxTjRqeBmel6RAwnztA6E3uxf3+f1gz2
 h8XyjUU41x4cnhPhy2lMdVPu0vPN/zv6jqQd1EWQSodC1Cu68ckuqKe3tpNEBlwioDV+
 T6v6KU4PbeeIfSiq72QGgLEtFKYzCTuDZmxTQGJKxnF+eSFvw4lnYlkhFc9eKx04CBUB
 F/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717465; x=1694322265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=roTMe45HmgofN3+MiGETn4+wzF2HiB60U2BiLq2radc=;
 b=W31tszST706ZY7fvyT1rZ49xsbDlarMnSkfuppAHyjBDPlygqS2XEVdDtmq0ov8L6s
 U9CSPYXsDX+wYFfA5XKsdG7LiCZMV27CPxPxlqSIMrv+2oxReAgGjU1YLKIT0XIrNVJq
 gElJGzxX5GQFQnnz7njt7YKEo9GQWZvYx1kwPPNCuZVJHu4ONIYaK6uJ1wv6hZTAIRFW
 7ozZVaEECty+khW9YmbwWUgkWXsmt1+QA6U+8bvA11JTLSSLwqPPVNWZAX4/yDgSvz0c
 m3KxDr2cTeNCGPZwQycVJFuNjZ1iUIGPdSmIFonChVbBMVXMnxRtpfS3CvyEB1YLXbED
 bBgg==
X-Gm-Message-State: AOJu0YwFht7N5GPpDFKtWbUDcC6rVMOWC8ZIeR1rsP3l0DDE4NLK1IrB
 TLe/B5xnx64aIraPeTzd7gzo7T5BbAyZkme/H2s=
X-Google-Smtp-Source: AGHT+IHl24W9GXfRGd9q78L1R+DJ2mv+sKQxx37+u9t5i0eRQgInPB7JZncCqOZBnf2Hg2ShkYp/JA==
X-Received: by 2002:a17:903:110d:b0:1c1:e818:1e76 with SMTP id
 n13-20020a170903110d00b001c1e8181e76mr8603173plh.6.1693717464978; 
 Sat, 02 Sep 2023 22:04:24 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:04:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 13/18] gdbstub: Expose functions to read registers
Date: Sun,  3 Sep 2023 14:03:21 +0900
Message-ID: <20230903050338.35256-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

gdb_foreach_feature() enumerates features that are useful to identify
registers. gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  6 ++++++
 gdbstub/gdbstub.c      | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 5bfaaa0306..cb6b3b17bd 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -59,6 +59,12 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+void gdb_foreach_feature(CPUState *cpu,
+                         void (* callback)(void *, const GDBFeature *, int),
+                         void *opaque);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9217fc7900..215d5d4fa5 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -483,7 +483,25 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+void gdb_foreach_feature(CPUState *cpu,
+                         void (* callback)(void *, const GDBFeature *, int),
+                         void *opaque)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    GDBRegisterState *r;
+
+    if (!cc->gdb_core_feature) {
+        return;
+    }
+
+    callback(opaque, cc->gdb_core_feature, 0);
+
+    for (r = cpu->gdb_regs; r; r = r->next) {
+        callback(opaque, r->feature, r->base_reg);
+    }
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
-- 
2.42.0



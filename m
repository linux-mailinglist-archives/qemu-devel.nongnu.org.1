Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2C09E650E
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 04:31:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJP2x-00019u-By; Thu, 05 Dec 2024 22:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tJP2q-00019O-9e
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:30:20 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thesamprice@gmail.com>)
 id 1tJP2o-0000Ai-6Y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 22:30:19 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7f4325168c8so1017706a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733455815; x=1734060615; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u/MCNMtiNBDNFOc6pwZpliNFrUM3yCgiKIhArSG/AcE=;
 b=a4FSdKZWL362txGEbkE0tz7FrLN0n/MfaliKaPhTULD/+3m+hrub09KGLFyhvrvuZS
 K018iQ/e9qaWrS01wdjg9nE0a3fvMk04595b6ro9Ov+1jOiLjaqETysaJihiDssjIZpf
 H0OXAXDIMIKTLxTiF3nIfBr1k9SJxlhulB2OvKen7o7At4Xnffa6niFmS4hR7UAViwnm
 uIchU1yFD8PaZiIsr7Xq0605DSFg/FYmSqN1QWH15XKBfz8l/wuFAiqLjGMChjkFtHdo
 ibLAY4zhhRe16WVAdpi3MaA93UqWeENPPBFh1Ba9NwY2sLIJx96j3jwAqW1MAUZ5crPt
 X5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733455815; x=1734060615;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u/MCNMtiNBDNFOc6pwZpliNFrUM3yCgiKIhArSG/AcE=;
 b=CtgUkxv2IqP2KxPl+PKasqZTIcZXcE1GrXoSeqvXPx7BOmmcsVl5ccRgJ3HdJm92LT
 Uh8OG79Rd6F8ocYpTbldz8HnNNBu+DL8oOGFKrzLeSe43NnExUB+kaQP9GmEU5rQrOkd
 7VI3ZC2HmD7WsOsnwJvLBkaExDfVsGrA0+fmkFqZBztogLQxjGj3o/ch0JFqGQsa/Ync
 77DM7C32x84C95dINIOBx8WfjPR/4vimmK+GqXmYWY2RCqmVNoiv/XaJeztIfqqZYHt4
 JI6vJ1DOx1NAyKe63IeG1n08SKTVGStkqlIl6oYHtdMxNfpRj0ipxgLsehp+7JzMJOdr
 PtiQ==
X-Gm-Message-State: AOJu0YyHPq2mYG6xJrxQi85PutkTMnLr7yurpYxZ7qQuKCpwc3tpb/yf
 rWXMpuILst8055KsbW7x87f9xQ1vw9w/Qdgfbi3cHumzUIBUCKAnYuiV7jvvx7rtY1nkvdTzdGq
 yyUv8+wNIKbT9C9gysXH/UBSbnER2Ct1X
X-Gm-Gg: ASbGncsJuXsdXWQYFUT1GNN3pJV8cBDOAmXhht6vgVhN8W1/9PzspAaO1f8hnGy+JGj
 e14/qjM0Eh59IlIiL54AbgBrNPXUuqhcdVzec
X-Google-Smtp-Source: AGHT+IHPJpEuRRMNs6d8q8mYxoG6H+Pv+Uhp1OitDKl8QvjaNp1s5jyj6QArK04ZCow0z1Mrn0Z/cpwJvhGoBKarOKg=
X-Received: by 2002:a17:90b:1a8c:b0:2ee:693e:ed7c with SMTP id
 98e67ed59e1d1-2ef6ab2552cmr2557440a91.33.1733455814905; Thu, 05 Dec 2024
 19:30:14 -0800 (PST)
MIME-Version: 1.0
From: Sam Price <thesamprice@gmail.com>
Date: Thu, 5 Dec 2024 22:29:59 -0500
Message-ID: <CAEekfLYJqvMDf5A_Yj=N6jMGQ4oj3rC+fv3xcCCfSBy8TDaY-Q@mail.gmail.com>
Subject: Subject: [PATCH] loader: Add register setting support via cli
To: qemu-devel@nongnu.org
Cc: alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=thesamprice@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I needed to set the registers prior to boot up to mimic what uboot
would do prior to loading a binary.  This adds a generic option of reg
to the loader command, it uses the existing gcc commands for setting
register values.

I'm sorry I couldn't figure out how to work the git send-email
properly.  Configuring it with my gmail became too cumbersome, and my
work email was also challenging to configure.

I have the file staged here.
https://gitlab.com/thesamprice/qemu/-/tree/loader?ref_type=heads
I am unsure of how to add tests for this.
I could continue working too polish this off with instructions from
others if it is desired for the main line.

Signed-off-by: Sam Price <thesamprice@gmail.com>
---

---
 hw/core/generic-loader.c         | 28 ++++++++++++++++++++++++++++
 include/hw/core/generic-loader.h |  6 +++++-
 roms/SLOF                        |  2 +-
 roms/edk2                        |  2 +-
 roms/openbios                    |  2 +-
 roms/opensbi                     |  2 +-
 roms/seabios                     |  2 +-
 roms/seabios-hppa                |  2 +-
 tests/lcitool/libvirt-ci         |  2 +-
 9 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index ea8628b892..ebda8ac43f 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -55,6 +55,19 @@ static void generic_loader_reset(void *opaque)
         }
     }

+    for (int i = 0; i < 31; i++) {
+        if (s->has_register_defaults[i]) {
+            CPUClass *cc = CPU_GET_CLASS(s->cpu);
+            uint8_t buf[sizeof(uint64_t)];
+            memcpy(buf, &s->register_defaults[i], sizeof(uint64_t));
+            if (cc && cc->gdb_write_register) {
+                cc->gdb_write_register(s->cpu, buf, i);
+            }
+        }
+    }
+
+
+
     if (s->data_len) {
         assert(s->data_len <= sizeof(s->data));
         dma_memory_write(s->cpu->as, s->addr, &s->data, s->data_len,
@@ -172,6 +185,20 @@ static void generic_loader_realize(DeviceState
*dev, Error **errp)
     } else {
         s->data = cpu_to_le64(s->data);
     }
+
+    /* Store the CPU register default if specified */
+    if (s->reg) {
+        int reg_num;
+        if (sscanf(s->reg, "r%d", &reg_num) == 1 &&
+                    reg_num >= 0 && reg_num < 31) {
+            s->register_defaults[reg_num] = s->data;
+            s->has_register_defaults[reg_num] = true;
+        } else {
+            error_setg(errp, "Unsupported register: %s", s->reg);
+            return;
+        }
+    }
+
 }

 static void generic_loader_unrealize(DeviceState *dev)
@@ -186,6 +213,7 @@ static Property generic_loader_props[] = {
     DEFINE_PROP_BOOL("data-be", GenericLoaderState, data_be, false),
     DEFINE_PROP_UINT32("cpu-num", GenericLoaderState, cpu_num, CPU_NONE),
     DEFINE_PROP_BOOL("force-raw", GenericLoaderState, force_raw, false),
+    DEFINE_PROP_STRING("reg", GenericLoaderState, reg),
     DEFINE_PROP_STRING("file", GenericLoaderState, file),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/core/generic-loader.h b/include/hw/core/generic-loader.h
index 19d87b39c8..d81e1632fd 100644
--- a/include/hw/core/generic-loader.h
+++ b/include/hw/core/generic-loader.h
@@ -35,10 +35,14 @@ struct GenericLoaderState {
     uint32_t cpu_num;

     char *file;
-
+    char *reg;
     bool force_raw;
     bool data_be;
     bool set_pc;
+
+    /* Add an array for storing default register values */
+    bool has_register_defaults[31];  /* Track if a default value is provided */
+    uint64_t register_defaults[31];  /* Default values for registers r0-r30 */
 };

 #define TYPE_GENERIC_LOADER "loader"
diff --git a/roms/SLOF b/roms/SLOF
index 3a259df244..6b6c16b4b4 160000
--- a/roms/SLOF
+++ b/roms/SLOF
@@ -1 +1 @@
-Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
+Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
diff --git a/roms/edk2 b/roms/edk2
index 4dfdca63a9..f80f052277 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
+Subproject commit f80f052277c88a67c55e107b550f504eeea947d3
diff --git a/roms/openbios b/roms/openbios
index c3a19c1e54..af97fd7af5 160000
--- a/roms/openbios
+++ b/roms/openbios
@@ -1 +1 @@
-Subproject commit c3a19c1e54977a53027d6232050e1e3e39a98a1b
+Subproject commit af97fd7af5e7c18f591a7b987291d3db4ffb28b5
diff --git a/roms/opensbi b/roms/opensbi
index 43cace6c36..057eb10b6d 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
+Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
diff --git a/roms/seabios b/roms/seabios
index a6ed6b701f..ea1b7a0733 160000
--- a/roms/seabios
+++ b/roms/seabios
@@ -1 +1 @@
-Subproject commit a6ed6b701f0a57db0569ab98b0661c12a6ec3ff8
+Subproject commit ea1b7a0733906b8425d948ae94fba63c32b1d425
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index a528f01d7a..673d2595d4 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit a528f01d7abd511d3cc71b7acaab6e036ee524bd
+Subproject commit 673d2595d4f773cc266cbf8dbaf2f475a6adb949
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 9ad3f70bde..9bff3b763b 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 9ad3f70bde9865d5ad18f36d256d472e72b5cbf3
+Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb
-- 
2.45.2


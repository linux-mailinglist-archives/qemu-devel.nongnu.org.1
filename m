Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF05874C39
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Mar 2024 11:21:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAsD-0004Vp-8f; Thu, 07 Mar 2024 05:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAsB-0004Vh-AZ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:11 -0500
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1riAs6-00072u-LG
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:21:11 -0500
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-365a681e949so1585785ab.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709806865; x=1710411665;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DA8YPsa0OXQme2Bi1zvzEkGMO6/tiDahixJX2f3DNcQ=;
 b=He+VTJZui/xLc39E48O+a+Ca81ApVDhULELKPVgSVUfSldDF1U2ZKQeWEX/Y3oEsM7
 lhHrWf43tk7GGjixPPTXPlSLpf+b9rYrks8V9f+ZtY6SG9e3rjj+iDxBNlvEUzxBAkbp
 GvLoKNKwiHX7J/eep8SAkXxstiDO0vr30EP6yy4LetVC8DygmWOm6rtEqNHicze0AXgF
 arKGnccW8DZYg9cZFd+Hbho66hc9xqtAOFOoW+IFcHMAzl5h+6UM/oznGaFFjn89YCNU
 SbjgzKmCnptZpRYYDsMA2WW5mOV093YOnBzMMkGC8mz8G+1LQvhvgPRKE9lps3CCqa0k
 VrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709806865; x=1710411665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA8YPsa0OXQme2Bi1zvzEkGMO6/tiDahixJX2f3DNcQ=;
 b=i82whMGC16k7+wiTPrKu2WET4n88EsdS3dhb21Ivinadyl+ua68OrhKhfImo2CNyYB
 G/gNVh1jtIRFMcpRFvols6yZkQ/Y9LwLM/VmmLKLPuKvu1xiPU4/H/PnCY4vhVnAULbZ
 PcI37sEuMrdH0dJHuhG9BtE16h2onA0cZuP2hJd/0FysyZzwRJoFM5bAApHqAes+CQHf
 AivNiX8febd8/KD0WS/wZvEQos8qAT1rUu5K2Xs5S8j1G4JMsUDavrT2tKD3tyDyAu4t
 tC9OT/ZAIMu68Ziz4kW8ZVkryyzU0int5DhkOfu6hYFKnY3TnhVyKmomD+4OLuccu6YT
 stgQ==
X-Gm-Message-State: AOJu0Yz+wrCkqvSU13UcF2AAk0Jwxww36nb6Vmqi/kigRA7xQvZ4/O2L
 Nb8y8FhMdEKYe4LJaOWvlIXF11lz7XyEhktl3tIRW7cvFvxrR9kytQC/+/g7EeE=
X-Google-Smtp-Source: AGHT+IGY35H0kGzyRGQTj7kRLdVmiY1xv1badnMu1En0zNsKUyAtBW+1f5vZyo+xAI1PW7PnZVDrKg==
X-Received: by 2002:a92:ca0c:0:b0:365:ff00:dc6a with SMTP id
 j12-20020a92ca0c000000b00365ff00dc6amr7896587ils.13.1709806865241; 
 Thu, 07 Mar 2024 02:21:05 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 x19-20020a056a00189300b006e65d4679d2sm838039pfh.153.2024.03.07.02.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:21:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 07 Mar 2024 19:20:48 +0900
Subject: [PATCH v4 05/19] contrib/elf2dmp: Fix error reporting style in
 addrspace.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-elf2dmp-v4-5-4f324ad4d99d@daynix.com>
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
In-Reply-To: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::133;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/addrspace.h |  4 ++--
 contrib/elf2dmp/addrspace.c |  8 ++++----
 contrib/elf2dmp/main.c      | 47 +++++++++++++++++++++------------------------
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index c868d6473873..2ad30a9da48a 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -39,7 +39,7 @@ void pa_space_destroy(struct pa_space *ps);
 void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb);
 void va_space_set_dtb(struct va_space *vs, uint64_t dtb);
 void *va_space_resolve(struct va_space *vs, uint64_t va);
-int va_space_rw(struct va_space *vs, uint64_t addr,
-        void *buf, size_t size, int is_write);
+bool va_space_rw(struct va_space *vs, uint64_t addr,
+                 void *buf, size_t size, int is_write);
 
 #endif /* ADDRSPACE_H */
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 4c127c9b1ec4..c995c723ae80 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -226,8 +226,8 @@ void *va_space_resolve(struct va_space *vs, uint64_t va)
     return pa_space_resolve(vs->ps, pa);
 }
 
-int va_space_rw(struct va_space *vs, uint64_t addr,
-        void *buf, size_t size, int is_write)
+bool va_space_rw(struct va_space *vs, uint64_t addr,
+                 void *buf, size_t size, int is_write)
 {
     while (size) {
         uint64_t page = addr & ELF2DMP_PFN_MASK;
@@ -238,7 +238,7 @@ int va_space_rw(struct va_space *vs, uint64_t addr,
 
         ptr = va_space_resolve(vs, addr);
         if (!ptr) {
-            return 1;
+            return false;
         }
 
         if (is_write) {
@@ -252,5 +252,5 @@ int va_space_rw(struct va_space *vs, uint64_t addr,
         addr += s;
     }
 
-    return 0;
+    return true;
 }
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 8a71e2efd281..09af39422f1e 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -79,9 +79,9 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
     bool decode = false;
     uint64_t kwn, kwa, KdpDataBlockEncoded;
 
-    if (va_space_rw(vs,
-                KdDebuggerDataBlock + offsetof(KDDEBUGGER_DATA64, Header),
-                &kdbg_hdr, sizeof(kdbg_hdr), 0)) {
+    if (!va_space_rw(vs,
+                     KdDebuggerDataBlock + offsetof(KDDEBUGGER_DATA64, Header),
+                     &kdbg_hdr, sizeof(kdbg_hdr), 0)) {
         eprintf("Failed to extract KDBG header\n");
         return NULL;
     }
@@ -97,8 +97,8 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
             return NULL;
         }
 
-        if (va_space_rw(vs, KiWaitNever, &kwn, sizeof(kwn), 0) ||
-                va_space_rw(vs, KiWaitAlways, &kwa, sizeof(kwa), 0)) {
+        if (!va_space_rw(vs, KiWaitNever, &kwn, sizeof(kwn), 0) ||
+            !va_space_rw(vs, KiWaitAlways, &kwa, sizeof(kwa), 0)) {
             return NULL;
         }
 
@@ -122,7 +122,7 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
 
     kdbg = g_malloc(kdbg_hdr.Size);
 
-    if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
+    if (!va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
         eprintf("Failed to extract entire KDBG\n");
         g_free(kdbg);
         return NULL;
@@ -286,7 +286,7 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
         return 1;
     }
 
-    if (va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
+    if (!va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
         eprintf("Failed to extract KdVersionBlock\n");
         return 1;
     }
@@ -352,8 +352,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         WinContext64 ctx;
         QEMUCPUState *s = qe->state[i];
 
-        if (va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
-                    &Prcb, sizeof(Prcb), 0)) {
+        if (!va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
+                         &Prcb, sizeof(Prcb), 0)) {
             eprintf("Failed to read CPU #%d PRCB location\n", i);
             continue;
         }
@@ -363,8 +363,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
             continue;
         }
 
-        if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
-                    &Context, sizeof(Context), 0)) {
+        if (!va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
+                         &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
             continue;
         }
@@ -372,7 +372,7 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         printf("Filling context for CPU #%d...\n", i);
         win_context_init_from_qemu_cpu_state(&ctx, s);
 
-        if (va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
+        if (!va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
             eprintf("Failed to fill CPU #%d context\n", i);
             continue;
         }
@@ -396,8 +396,8 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
         return 1;
     }
 
-    if (va_space_rw(vs, base + dos_hdr->e_lfanew,
-                &nt_hdrs, sizeof(nt_hdrs), 0)) {
+    if (!va_space_rw(vs, base + dos_hdr->e_lfanew,
+                     &nt_hdrs, sizeof(nt_hdrs), 0)) {
         return 1;
     }
 
@@ -406,9 +406,7 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
         return 1;
     }
 
-    if (va_space_rw(vs,
-                base + data_dir[idx].VirtualAddress,
-                entry, size, 0)) {
+    if (!va_space_rw(vs, base + data_dir[idx].VirtualAddress, entry, size, 0)) {
         return 1;
     }
 
@@ -470,9 +468,8 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
         return false;
     }
 
-    if (va_space_rw(vs,
-                base + debug_dir.AddressOfRawData,
-                rsds, sizeof(*rsds), 0)) {
+    if (!va_space_rw(vs, base + debug_dir.AddressOfRawData,
+                     rsds, sizeof(*rsds), 0)) {
         eprintf("Failed to resolve OMFSignatureRSDS\n");
         return false;
     }
@@ -488,9 +485,9 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
         return false;
     }
 
-    if (va_space_rw(vs, base + debug_dir.AddressOfRawData +
-                offsetof(OMFSignatureRSDS, name), pdb_name, sizeof(PDB_NAME),
-                0)) {
+    if (!va_space_rw(vs, base + debug_dir.AddressOfRawData +
+                     offsetof(OMFSignatureRSDS, name),
+                     pdb_name, sizeof(PDB_NAME), 0)) {
         eprintf("Failed to resolve PDB name\n");
         return false;
     }
@@ -556,8 +553,8 @@ int main(int argc, char *argv[])
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
 
-    if (va_space_rw(&vs, state->idt.base,
-                &first_idt_desc, sizeof(first_idt_desc), 0)) {
+    if (!va_space_rw(&vs, state->idt.base,
+                     &first_idt_desc, sizeof(first_idt_desc), 0)) {
         eprintf("Failed to get CPU #0 IDT[0]\n");
         goto out_ps;
     }

-- 
2.44.0



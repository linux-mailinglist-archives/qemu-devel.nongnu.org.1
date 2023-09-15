Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA77A2427
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCCp-0003Ne-UY; Fri, 15 Sep 2023 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCn-0003MO-Ot
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:09 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qhCCl-0000L3-6m
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:02:09 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5007abb15e9so4055813e87.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694797324; x=1695402124;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ftC+g7kcyTDI9qRSERzH52xT8C77XKKARe67AM6V0M=;
 b=uPcL4daw0NtmYsNCmseAgVmDHHINPIcswR/ET+nD+qfTha0MaTRH1PUHkgutbGnt6q
 KfKSzMz42MupfYAKbG3pbuYwmoNBSCM3LDighHczwy/tWC9K4Yf3Gqvh/sRXoo/OTZck
 i4UVlB086t8MDbehx3/1ii0qkHJCfvol1szOVnQ6fWmQ3RjZnwhyaVb7BOph7QAqENSd
 LR4dIVBGtPUpdg0QfG55EWycQ+DXGcR9MhQv4C9B5FRQurfR1dD7wJFbecXzSCiBsS0e
 +QdC3bdC4K6Dml9y6bupmN0+1LM52zy/sH+Z/Z0klXqdnw0L7OwWMgxmSrP6rtTUg5pu
 GzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797324; x=1695402124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ftC+g7kcyTDI9qRSERzH52xT8C77XKKARe67AM6V0M=;
 b=OiyXuGa3GFECfrJUvao4AhdmRd4C06qq/4K+NWv3H8XBU0AZw3Ngbiv+Ynduik9bV9
 CTPshXwkM3DMcrISXHAL+MUGi2zf1SuAYttvd0S10F7g1sP+X9CSmEgq3psFu34rkwKa
 Rq5BS6tFmkDa5oQRzyNe80WuIFrQk7tqSmSbYJMbk+1b6En/B82e2GpsaVwSF9Z5OZr+
 1vEIE36lPsguq4XrPfVHVikSdWjLFNNBjVO3DcUyAvrOohba/6L+AiPAgrd5vVpq6vri
 GZwV8EjC6+rOblWwpLrxIhWgDhFtSNI+mMe9u2JBjQ/1GkBerhqTOJlCgPDGyQXmRfU6
 awcg==
X-Gm-Message-State: AOJu0YzZssXQQ5c8Q9rWOam3+gokoDSLdci++r8GtYNQfeyAwcsaoNX7
 Zty3OQPDSxWGHjpZYnS3G140tA==
X-Google-Smtp-Source: AGHT+IHHUH/R1AiMDQc71t7Sn0+4SjrOwqcNDWeUlgsS+TTyVMrgZxV4RFJjUfrPifRKb2U/2YTERQ==
X-Received: by 2002:a05:6512:234f:b0:501:b97a:9f50 with SMTP id
 p15-20020a056512234f00b00501b97a9f50mr2842570lfu.65.1694797324119; 
 Fri, 15 Sep 2023 10:02:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-8.nat.spd-mgts.ru.
 [109.252.90.8]) by smtp.gmail.com with ESMTPSA id
 u7-20020a056512040700b005009ab1992esm690431lfk.154.2023.09.15.10.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 10:02:03 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH v2 1/5] elf2dmp: replace PE export name check with PDB name
 check
Date: Fri, 15 Sep 2023 20:01:49 +0300
Message-Id: <20230915170153.10959-2-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230915170153.10959-1-viktor@daynix.com>
References: <20230915170153.10959-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::133;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x133.google.com
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

PE export name check introduced in d399d6b179 isn't reliable enough,
because a page with the export directory may be not present for some
reason. On the other hand, elf2dmp retrieves the PDB name in any case.
It can be also used to check that a PE image is the kernel image. So,
check PDB name when searching for Windows kernel image.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2165917

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/main.c | 93 +++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 6d4d18501a..bb6744c0cd 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -411,89 +411,64 @@ static int write_dump(struct pa_space *ps,
     return fclose(dmp_file);
 }
 
-static bool pe_check_export_name(uint64_t base, void *start_addr,
-        struct va_space *vs)
-{
-    IMAGE_EXPORT_DIRECTORY export_dir;
-    const char *pe_name;
-
-    if (pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_EXPORT_DIRECTORY,
-                &export_dir, sizeof(export_dir), vs)) {
-        return false;
-    }
-
-    pe_name = va_space_resolve(vs, base + export_dir.Name);
-    if (!pe_name) {
-        return false;
-    }
-
-    return !strcmp(pe_name, PE_NAME);
-}
-
-static int pe_get_pdb_symstore_hash(uint64_t base, void *start_addr,
-        char *hash, struct va_space *vs)
+static bool pe_check_pdb_name(uint64_t base, void *start_addr,
+        struct va_space *vs, OMFSignatureRSDS *rsds)
 {
     const char sign_rsds[4] = "RSDS";
     IMAGE_DEBUG_DIRECTORY debug_dir;
-    OMFSignatureRSDS rsds;
-    char *pdb_name;
-    size_t pdb_name_sz;
-    size_t i;
+    char pdb_name[sizeof(PDB_NAME)];
 
     if (pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
                 &debug_dir, sizeof(debug_dir), vs)) {
         eprintf("Failed to get Debug Directory\n");
-        return 1;
+        return false;
     }
 
     if (debug_dir.Type != IMAGE_DEBUG_TYPE_CODEVIEW) {
-        return 1;
+        eprintf("Debug Directory type is not CodeView\n");
+        return false;
     }
 
     if (va_space_rw(vs,
                 base + debug_dir.AddressOfRawData,
-                &rsds, sizeof(rsds), 0)) {
-        return 1;
+                rsds, sizeof(*rsds), 0)) {
+        eprintf("Failed to resolve OMFSignatureRSDS\n");
+        return false;
     }
 
-    printf("CodeView signature is \'%.4s\'\n", rsds.Signature);
-
-    if (memcmp(&rsds.Signature, sign_rsds, sizeof(sign_rsds))) {
-        return 1;
+    if (memcmp(&rsds->Signature, sign_rsds, sizeof(sign_rsds))) {
+        eprintf("CodeView signature is \'%.4s\', \'%s\' expected\n",
+                rsds->Signature, sign_rsds);
+        return false;
     }
 
-    pdb_name_sz = debug_dir.SizeOfData - sizeof(rsds);
-    pdb_name = malloc(pdb_name_sz);
-    if (!pdb_name) {
-        return 1;
+    if (debug_dir.SizeOfData - sizeof(*rsds) != sizeof(PDB_NAME)) {
+        eprintf("PDB name size doesn't match\n");
+        return false;
     }
 
     if (va_space_rw(vs, base + debug_dir.AddressOfRawData +
-                offsetof(OMFSignatureRSDS, name), pdb_name, pdb_name_sz, 0)) {
-        free(pdb_name);
-        return 1;
+                offsetof(OMFSignatureRSDS, name), pdb_name, sizeof(PDB_NAME),
+                0)) {
+        eprintf("Failed to resolve PDB name\n");
+        return false;
     }
 
     printf("PDB name is \'%s\', \'%s\' expected\n", pdb_name, PDB_NAME);
 
-    if (strcmp(pdb_name, PDB_NAME)) {
-        eprintf("Unexpected PDB name, it seems the kernel isn't found\n");
-        free(pdb_name);
-        return 1;
-    }
-
-    free(pdb_name);
+    return !strcmp(pdb_name, PDB_NAME);
+}
 
-    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds.guid.a, rsds.guid.b,
-            rsds.guid.c, rsds.guid.d[0], rsds.guid.d[1]);
+static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
+{
+    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds->guid.a, rsds->guid.b,
+            rsds->guid.c, rsds->guid.d[0], rsds->guid.d[1]);
     hash += 20;
-    for (i = 0; i < 6; i++, hash += 2) {
-        sprintf(hash, "%.02x", rsds.guid.e[i]);
+    for (unsigned int i = 0; i < 6; i++, hash += 2) {
+        sprintf(hash, "%.02x", rsds->guid.e[i]);
     }
 
-    sprintf(hash, "%.01x", rsds.age);
-
-    return 0;
+    sprintf(hash, "%.01x", rsds->age);
 }
 
 int main(int argc, char *argv[])
@@ -515,6 +490,7 @@ int main(int argc, char *argv[])
     KDDEBUGGER_DATA64 *kdbg;
     uint64_t KdVersionBlock;
     bool kernel_found = false;
+    OMFSignatureRSDS rsds;
 
     if (argc != 3) {
         eprintf("usage:\n\t%s elf_file dmp_file\n", argv[0]);
@@ -562,7 +538,8 @@ int main(int argc, char *argv[])
         }
 
         if (*(uint16_t *)nt_start_addr == 0x5a4d) { /* MZ */
-            if (pe_check_export_name(KernBase, nt_start_addr, &vs)) {
+            printf("Checking candidate KernBase = 0x%016"PRIx64"\n", KernBase);
+            if (pe_check_pdb_name(KernBase, nt_start_addr, &vs, &rsds)) {
                 kernel_found = true;
                 break;
             }
@@ -578,11 +555,7 @@ int main(int argc, char *argv[])
     printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
             (char *)nt_start_addr);
 
-    if (pe_get_pdb_symstore_hash(KernBase, nt_start_addr, pdb_hash, &vs)) {
-        eprintf("Failed to get PDB symbol store hash\n");
-        err = 1;
-        goto out_ps;
-    }
+    pe_get_pdb_symstore_hash(&rsds, pdb_hash);
 
     sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
     printf("PDB URL is %s\n", pdb_url);
-- 
2.21.0



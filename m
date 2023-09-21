Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBF7A9849
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNci-0002D4-Mv; Thu, 21 Sep 2023 13:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcg-0002C9-Uf
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcN-0007iG-Vx
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-313e742a787so820267f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317854; x=1695922654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vZDpPDL7VYx+NDtQ2pIz8KgGd+MM5dll5CqhqvtnfHo=;
 b=p4oBAAb5WRhVfPXj838iDyoLzqwu9lsAqLPZcEsgnblA/vMp2UyQcdAisqpLAmi7Iv
 l/BL1eggAnjgTBvEnPKkpK99VeWCPtZgAhR2T5nNdLAHdi2kFYPPVTq1VTqFnwuR+yVh
 zGi7Y2qLMxy1k4IDvCaHC6Uv3a/JgUKs5wwerCcyZ218H8R2xIeMe5J4OEIXU5kZaTvw
 H08seop1nSNuFjxieL6oq0w3euUt7/XyzsK6vO+YoOOzCdEVDTrmsF0BUXxbyNhWD+Es
 jdItVcNUMt0SOb0ox1bWbMKM2dMJQfyKq4dd/RONSowBSsJDFRLPaMVCYlnJEwinjL9m
 dEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317854; x=1695922654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZDpPDL7VYx+NDtQ2pIz8KgGd+MM5dll5CqhqvtnfHo=;
 b=rkQnjIGlKDAjvMZPIvZCj8VI3o2cn0EOgCVKWBDZPa3gZMNFL3ntqrGwJv5oGP5ZzY
 LZPzwNF0g3c0Zq97llYgl3KHZnsFJleB+CncqyUbfVqWj6lB/oBKXK25gCevgnCEdVwt
 1CyFswwtSS2BG38db/73dxxSZ/Wde+oQHCOf2MhpN0l0vq2AKbaq6ux7rDrXKZ26a+qQ
 aQP+bq9IizJh3XePCrO2odbQiaewmkgcqgtRw8fI3WxrwBBrFwYjPm9K07jivA+DVgMv
 C3fU329h3y2XyAVHioBVulNZOgLA/UF9yLtBddSEobe/kymYiNG7XjQVQ3MRJkxJC0SJ
 YX5w==
X-Gm-Message-State: AOJu0YyrOnHi0QAayei9gd3gm8LPxFQ+iAnZ8OGnwUcVcVc7wjZEqERR
 liBMhRQB7YnZvWwUcQCUljHjJo0yELYr/2YVllI=
X-Google-Smtp-Source: AGHT+IGfGhlJ71UO5PON7FYd2p1+Q2BMpYQhtY0fpYVm4q+u3Mif34p61SgrFnwD/1EJz3Vj7JfO9Q==
X-Received: by 2002:adf:cc8c:0:b0:320:2b29:7041 with SMTP id
 p12-20020adfcc8c000000b003202b297041mr199934wrj.24.1695317854416; 
 Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/30] elf2dmp: replace PE export name check with PDB name check
Date: Thu, 21 Sep 2023 18:37:16 +0100
Message-Id: <20230921173720.3250581-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Viktor Prutyanov <viktor@daynix.com>

PE export name check introduced in d399d6b179 isn't reliable enough,
because a page with the export directory may be not present for some
reason. On the other hand, elf2dmp retrieves the PDB name in any case.
It can be also used to check that a PE image is the kernel image. So,
check PDB name when searching for Windows kernel image.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2165917

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230915170153.10959-2-viktor@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 93 +++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 60 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 6d4d18501a3..bb6744c0cd6 100644
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
+    return !strcmp(pdb_name, PDB_NAME);
+}
 
-    free(pdb_name);
-
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
2.34.1



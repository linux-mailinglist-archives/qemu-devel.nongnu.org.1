Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA87CEC1A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0s-0003e8-UQ; Wed, 18 Oct 2023 19:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0r-0003Xg-CZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:41 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0o-0000EJ-5h
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:41 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-35754465cb3so27427085ab.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671896; x=1698276696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2oYojizKTJe59+z2rFn3jhqwAzCHsM3phmz2spMImU=;
 b=X/LzXjG76Ye5xqLNpsqI8HAAVck+vO2Vw35rKs8HRQ7HXUXWNiNhPTuyzYgHuTHBSh
 ffBa4wnvJr6/MQpF2RtIXxrHDss3qgrou5RFUTp5ucmcQO3vrbgs9vwe2DAZzKc71MIA
 KWxyYvuNGF8lVaSpMdSu6X87MeMu+fmmCYPrm5+BSGzNLHx/7hjP0L3pVS9ouDg0onn7
 ofPJktkEaW4jmvTpIsnLvo3wfK6bMk1ui9+9ovC0Jl7MVbLul5qjDL+puw/1ri/5oMnX
 +s1fmvm2qAP/p7jyilyp28lUfAIfBKbBgBFR9+thSIxV/z8iA/mNoVHMO+F1KvszjiSM
 zkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671896; x=1698276696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2oYojizKTJe59+z2rFn3jhqwAzCHsM3phmz2spMImU=;
 b=Qh+bBm6uWVjpZjN56Yo9ILVaFk/mflEl48WLbHA8R2Lim5nmQUMjMjlVNmRSRUEFmG
 wC1gGkUVEGrEsHffA0YFguyA3NwbQqXDx9G2N5IuihfGNTVTSyUdDvFVyOb8+3z1v4XT
 jHXmVddGJaTvU34fxJF7LCbwJCvnrHqYnFXojX09A9DgXt4ylLl3vacJHvF0SPwxk1mZ
 4T4k4Ppb1oAbLkdXcL08bNlD8y4nqKVya7ISlu2n7v5s0A3/VIw8KT2B99TUM4WcnaTK
 K3MqLuRBsLX/n2c0WCm647pqkUinTZ0WHjhWRbwS4ghsjGyMjDzGUjR6Q3muAHsNDxh6
 hgtA==
X-Gm-Message-State: AOJu0YxBPS7EwHLI/9RtvtnkfYcplrmFGfx7xCURStiBPMmmjAxmeweQ
 hzfyfoGrj2pb0CvgWuVuErPDqJEUv1iEMO3/YIA=
X-Google-Smtp-Source: AGHT+IHmz5DFH3zqalCZpjOJdeBVlQotWSVovSL2yng/PdcPHn63ZIcbj2ssXlVulJFWGDMMiXfAEQ==
X-Received: by 2002:a92:d650:0:b0:350:f956:91c4 with SMTP id
 x16-20020a92d650000000b00350f95691c4mr728194ilp.4.1697671896348; 
 Wed, 18 Oct 2023 16:31:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/14] linux-user: Fixes for zero_bss
Date: Wed, 18 Oct 2023 16:31:21 -0700
Message-Id: <20231018233134.1594292-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The previous change, 2d385be6152, assumed !PAGE_VALID meant that
the page would be unmapped by the elf image.  However, since we
reserved the entire image space via mmap, PAGE_VALID will always
be set.  Instead, assume PROT_NONE for the same condition.

Furthermore, assume bss is only ever present for writable segments,
and that there is no page overlap between PT_LOAD segments.
Instead of an assert, return false to indicate failure.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 53 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f21e2e0c3d..213fd3e584 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2362,31 +2362,58 @@ static abi_ulong setup_arg_pages(struct linux_binprm *bprm,
  * Map and zero the bss.  We need to explicitly zero any fractional pages
  * after the data section (i.e. bss).  Return false on mapping failure.
  */
-static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss, int prot)
+static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
+                     int prot, Error **errp)
 {
     abi_ulong align_bss;
 
+    /* We only expect writable bss; the code segment shouldn't need this. */
+    if (!(prot & PROT_WRITE)) {
+        error_setg(errp, "PT_LOAD with non-writable bss");
+        return false;
+    }
+
     align_bss = TARGET_PAGE_ALIGN(start_bss);
     end_bss = TARGET_PAGE_ALIGN(end_bss);
 
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
 
-        if (!(flags & PAGE_VALID)) {
-            /* Map the start of the bss. */
+        if (!(flags & PAGE_BITS)) {
+            /*
+             * The whole address space of the executable was reserved
+             * at the start, therefore all pages will be VALID.
+             * But assuming there are no PROT_NONE PT_LOAD segments,
+             * a PROT_NONE page means no data all bss, and we can
+             * simply extend the new anon mapping back to the start
+             * of the page of bss.
+             */
             align_bss -= TARGET_PAGE_SIZE;
-        } else if (flags & PAGE_WRITE) {
-            /* The page is already mapped writable. */
-            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         } else {
-            /* Read-only zeros? */
-            g_assert_not_reached();
+            /*
+             * The start of the bss shares a page with something.
+             * The only thing that we expect is the data section,
+             * which would already be marked writable.
+             * Overlapping the RX code segment seems malformed.
+             */
+            if (!(flags & PAGE_WRITE)) {
+                error_setg(errp, "PT_LOAD with bss overlapping "
+                           "non-writable page");
+                return false;
+            }
+
+            /* The page is already mapped and writable. */
+            memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
         }
     }
 
-    return align_bss >= end_bss ||
-           target_mmap(align_bss, end_bss - align_bss, prot,
-                       MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) != -1;
+    if (align_bss < end_bss &&
+        target_mmap(align_bss, end_bss - align_bss, prot,
+                    MAP_FIXED | MAP_PRIVATE | MAP_ANON, -1, 0) == -1) {
+        error_setg_errno(errp, errno, "Error mapping bss");
+        return false;
+    }
+    return true;
 }
 
 #if defined(TARGET_ARM)
@@ -3410,8 +3437,8 @@ static void load_elf_image(const char *image_name, int image_fd,
 
             /* If the load segment requests extra zeros (e.g. bss), map it. */
             if (vaddr_ef < vaddr_em &&
-                !zero_bss(vaddr_ef, vaddr_em, elf_prot)) {
-                goto exit_mmap;
+                !zero_bss(vaddr_ef, vaddr_em, elf_prot, &err)) {
+                goto exit_errmsg;
             }
 
             /* Find the full program boundaries.  */
-- 
2.34.1



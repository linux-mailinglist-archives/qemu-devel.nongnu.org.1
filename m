Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D839709A89
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:54:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01S0-0002dH-2g; Fri, 19 May 2023 10:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rx-0002Hw-9P
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rl-0003cA-2C
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2IiRUt7FD7TGEQRwdHh0IrJ8V8/JXfdzIWlpXzqwtg=;
 b=MqAHNW0cUUGiw5hhggHJ0xRCCGAyH68ZpOPzDDkTYxTC+UK/uMleUwrZc1DT/UKUJ83VEZ
 DFW+lM25MusrFHble7vFvpU0huQdAXL4GSM4xamxPOI+j0gE/LfLpctf3pArk3+wIwpfhZ
 d4sT2bvjSExK3gt0ubgXkbm8L71BPGI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-4GH_g_iQMAKKBjVkMYKMxQ-1; Fri, 19 May 2023 10:51:07 -0400
X-MC-Unique: 4GH_g_iQMAKKBjVkMYKMxQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ac8c5e4aafso6154621fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507865; x=1687099865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2IiRUt7FD7TGEQRwdHh0IrJ8V8/JXfdzIWlpXzqwtg=;
 b=JaT+ufHdRyl0c4nSJvtGt8nyxA2k+tuV/Wv/St+hECsJmXzriqaM739dJ2mXvqNR9j
 wUFcTduM+KTVv7vU6Ew1HKy/GXpa0yRB7WkHtQ4XtjIOLwAdL3MBulwv0koD+osxDqP+
 M6WJoyulws17WkafKOCqLl1zVxP9+OY3liijWGD+4tn6cLrRXEFQ2aNMywvArc6hW+JM
 ilMz2nIuhGL4XL5rc8DnCl3HR0/Xe3lHBaJVnT8dn+7CEWsGdLsyO/gsgo+smzdFOx6U
 78g0kZt6xnWC2ouqrYWecRGEsLox5mJ84UGq1/W6Q6rlf4ClgWtSjCmxE+8Zsz952sIH
 IuUQ==
X-Gm-Message-State: AC+VfDwClHx3em+jRQSCFbaBJ0KruexZjVNSjN+W/MWdKwH4c3r1uCgh
 mmWt5gq0ZgK0caOQUxtd5rMvrFB9ZVNOJ3Unm15U5YqAVLBja1NhOEjhWTcXfnMukx0tvTDD8dM
 +knjBjZMNXwz8ykMI7itA8XsgbpLDv08UW3uK+UYQDE/XkawkqK8Mn3vmeXFGHtOFOVCd
X-Received: by 2002:a2e:b62c:0:b0:2a9:d4f0:6 with SMTP id
 s12-20020a2eb62c000000b002a9d4f00006mr824227ljn.17.1684507865299; 
 Fri, 19 May 2023 07:51:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50eR1CGuqIQEE74Ya31XxSNmarC218WeOqygFsE/lGHoYvCI5qd4uo69vfx7rgt5LFRDvxew==
X-Received: by 2002:a2e:b62c:0:b0:2a9:d4f0:6 with SMTP id
 s12-20020a2eb62c000000b002a9d4f00006mr824215ljn.17.1684507865026; 
 Fri, 19 May 2023 07:51:05 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 18-20020a05651c041200b002adbe01cd69sm864841lja.9.2023.05.19.07.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:04 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 16/40] pci: pci_add_option_rom(): improve style
Message-ID: <4ab049c7e68919b92a5ece5ad5baa52d0a963676.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Fix over-80 lines and missing curly brackets for if-operators, which
are required by QEMU coding style.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230515125229.44836-2-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/pci/pci.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8a87ccc8b0..e26e2a7e65 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2312,10 +2312,9 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     char name[32];
     const VMStateDescription *vmsd;
 
-    if (!pdev->romfile)
-        return;
-    if (strlen(pdev->romfile) == 0)
+    if (!pdev->romfile || !strlen(pdev->romfile)) {
         return;
+    }
 
     if (!pdev->rom_bar) {
         /*
@@ -2364,7 +2363,8 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     }
     if (pdev->romsize != -1) {
         if (size > pdev->romsize) {
-            error_setg(errp, "romfile \"%s\" (%u bytes) is too large for ROM size %u",
+            error_setg(errp, "romfile \"%s\" (%u bytes) "
+                       "is too large for ROM size %u",
                        pdev->romfile, (uint32_t)size, pdev->romsize);
             g_free(path);
             return;
@@ -2374,14 +2374,13 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     }
 
     vmsd = qdev_get_vmsd(DEVICE(pdev));
+    snprintf(name, sizeof(name), "%s.rom",
+             vmsd ? vmsd->name : object_get_typename(OBJECT(pdev)));
 
-    if (vmsd) {
-        snprintf(name, sizeof(name), "%s.rom", vmsd->name);
-    } else {
-        snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
-    }
     pdev->has_rom = true;
-    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, pdev->romsize, &error_fatal);
+    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, pdev->romsize,
+                           &error_fatal);
+
     ptr = memory_region_get_ram_ptr(&pdev->rom);
     if (load_image_size(path, ptr, size) < 0) {
         error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
-- 
MST



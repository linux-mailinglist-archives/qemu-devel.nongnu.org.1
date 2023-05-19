Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F9709AB5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Ql-00071A-0V; Fri, 19 May 2023 10:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qc-000712-TD
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qb-0003Hg-69
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5VdNdbQRJpORKwXC8FXaaYafZ5Xc2CoK9u2rcDHW7X8=;
 b=APFAXQqLt4687LSQ6pNuIIglfeRGQNHLxoPNQ9ituVBQpLeT/62DWkzOaGRPo8DAca/vrX
 DKOtUtfqra+Y1xkHT4eCWy4YOE3NXMgV/083ajiCxBfsaDo3YDioLcLZnCg5LOGAq5z98A
 0meYyzKnxQSWjCycRqvXu2NrqJ+fmRQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-8qcT5AyOMMe_zQILUacFqg-1; Fri, 19 May 2023 10:49:55 -0400
X-MC-Unique: 8qcT5AyOMMe_zQILUacFqg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f0176dcc1eso603520e87.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507793; x=1687099793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VdNdbQRJpORKwXC8FXaaYafZ5Xc2CoK9u2rcDHW7X8=;
 b=VLwqTgvOGZTuFmGgf6yUyO6nJmN/zzUhPNkAIue1xM0qMLb3m4G5vOJs+MqVB0K7ny
 +ofBP61+2j+/i4lnXl7YjeKI6yHIiVSMMXe89u7QLduOLiSkDdoIGn+Ci1s3UUrQLsW8
 gN9GiHiWu1p3O3g2VWT4yieE1j083oY9X6meHKY44fnFQbybuepJDKMIIHRd33ZQQehg
 ayO+rrz5UtWvGisOv2CfyZkO3viL0k8oeWQ1IP1C9d9QDtmV8aMnAl/mS+ftr3824BTd
 +NqxwwKqjT4aVxi+/6M2qRV6Z/+AODYalUI+vCcHvzlWiMCxlsU1/yRC7cJMIwdmlLzw
 MeuA==
X-Gm-Message-State: AC+VfDxVmOndWEkqSq201o2vuQZOruDEG3YgqGi/UIs5Cz4nypqI5qWe
 Z8gsh1fT/QYdz5lb/oHpuvmdIVuRPRgmobU962noAz+n6XS2dmce92Tu9It2DhewXyouk1j6MtQ
 bUbAc2pDrGPdns4yFrWku5gnSWx7SMVXHkH+OLUDEIsvphExIAhaMRYGe84lIqsI09juD
X-Received: by 2002:a05:6512:3f1e:b0:4f3:a763:ccb7 with SMTP id
 y30-20020a0565123f1e00b004f3a763ccb7mr1154079lfa.2.1684507793340; 
 Fri, 19 May 2023 07:49:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TVlYDCbZERNbTu+/Qvfer3SJSsfdECDaHf089xi6FI7iDmeg0j7n62BQ7QdB2CXNfjyeaXQ==
X-Received: by 2002:a05:6512:3f1e:b0:4f3:a763:ccb7 with SMTP id
 y30-20020a0565123f1e00b004f3a763ccb7mr1154069lfa.2.1684507793041; 
 Fri, 19 May 2023 07:49:53 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 p3-20020a05651238c300b004f13f4ec267sm617369lft.186.2023.05.19.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:49:52 -0700 (PDT)
Date: Fri, 19 May 2023 10:49:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 03/40] hw/cxl: cdat: Fix failure to free buffer in erorr paths
Message-ID: <7b22a3218ad0b8388c8bf20d394e3220b2fc8798.1684507742.git.mst@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The failure paths in CDAT file loading did not clear up properly.
Change to using g_auto_free and a local pointer for the buffer to
ensure this function has no side effects on error.
Also drop some unnecessary checks that can not fail.

Cleanup properly after a failure to load a CDAT file.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230421132020.7408-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-cdat.c            | 33 ++++++++++++++++++---------------
 hw/mem/cxl_type3.c           |  4 ++++
 hw/pci-bridge/cxl_upstream.c |  3 +++
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
index 056711d63d..d246d6885b 100644
--- a/hw/cxl/cxl-cdat.c
+++ b/hw/cxl/cxl-cdat.c
@@ -108,6 +108,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
 static void ct3_load_cdat(CDATObject *cdat, Error **errp)
 {
     g_autofree CDATEntry *cdat_st = NULL;
+    g_autofree char *buf = NULL;
     uint8_t sum = 0;
     int num_ent;
     int i = 0, ent = 1;
@@ -116,7 +117,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
     GError *error = NULL;
 
     /* Read CDAT file and create its cache */
-    if (!g_file_get_contents(cdat->filename, (gchar **)&cdat->buf,
+    if (!g_file_get_contents(cdat->filename, (gchar **)&buf,
                              &file_size, &error)) {
         error_setg(errp, "CDAT: File read failed: %s", error->message);
         g_error_free(error);
@@ -129,9 +130,17 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
     i = sizeof(CDATTableHeader);
     num_ent = 1;
     while (i < file_size) {
-        hdr = (CDATSubHeader *)(cdat->buf + i);
+        hdr = (CDATSubHeader *)(buf + i);
+        if (i + sizeof(CDATSubHeader) > file_size) {
+            error_setg(errp, "CDAT: Truncated table");
+            return;
+        }
         cdat_len_check(hdr, errp);
         i += hdr->length;
+        if (i > file_size) {
+            error_setg(errp, "CDAT: Truncated table");
+            return;
+        }
         num_ent++;
     }
     if (i != file_size) {
@@ -139,33 +148,26 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
         return;
     }
 
-    cdat_st = g_malloc0(sizeof(*cdat_st) * num_ent);
-    if (!cdat_st) {
-        error_setg(errp, "CDAT: Failed to allocate entry array");
-        return;
-    }
+    cdat_st = g_new0(CDATEntry, num_ent);
 
     /* Set CDAT header, Entry = 0 */
-    cdat_st[0].base = cdat->buf;
+    cdat_st[0].base = buf;
     cdat_st[0].length = sizeof(CDATTableHeader);
     i = 0;
 
     while (i < cdat_st[0].length) {
-        sum += cdat->buf[i++];
+        sum += buf[i++];
     }
 
     /* Read CDAT structures */
     while (i < file_size) {
-        hdr = (CDATSubHeader *)(cdat->buf + i);
-        cdat_len_check(hdr, errp);
-
+        hdr = (CDATSubHeader *)(buf + i);
         cdat_st[ent].base = hdr;
         cdat_st[ent].length = hdr->length;
 
-        while (cdat->buf + i <
-               (uint8_t *)cdat_st[ent].base + cdat_st[ent].length) {
+        while (buf + i < (char *)cdat_st[ent].base + cdat_st[ent].length) {
             assert(i < file_size);
-            sum += cdat->buf[i++];
+            sum += buf[i++];
         }
 
         ent++;
@@ -176,6 +178,7 @@ static void ct3_load_cdat(CDATObject *cdat, Error **errp)
     }
     cdat->entry_len = num_ent;
     cdat->entry = g_steal_pointer(&cdat_st);
+    cdat->buf = g_steal_pointer(&buf);
 }
 
 void cxl_doe_cdat_init(CXLComponentState *cxl_cstate, Error **errp)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index abe60b362c..7647122cc6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -593,6 +593,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     cxl_cstate->cdat.free_cdat_table = ct3_free_cdat_table;
     cxl_cstate->cdat.private = ct3d;
     cxl_doe_cdat_init(cxl_cstate, errp);
+    if (*errp) {
+        goto err_free_special_ops;
+    }
 
     pcie_cap_deverr_init(pci_dev);
     /* Leave a bit of room for expansion */
@@ -605,6 +608,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
 
 err_release_cdat:
     cxl_doe_cdat_release(cxl_cstate);
+err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     address_space_destroy(&ct3d->hostmem_as);
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 9df436cb73..ef47e5d625 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -346,6 +346,9 @@ static void cxl_usp_realize(PCIDevice *d, Error **errp)
     cxl_cstate->cdat.free_cdat_table = free_default_cdat_table;
     cxl_cstate->cdat.private = d;
     cxl_doe_cdat_init(cxl_cstate, errp);
+    if (*errp) {
+        goto err_cap;
+    }
 
     return;
 
-- 
MST



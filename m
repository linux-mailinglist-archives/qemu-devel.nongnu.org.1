Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8EA76F5A5
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghL-0004QH-GI; Thu, 03 Aug 2023 18:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghJ-0004Q9-UP
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghI-0000W9-9W
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6g7+lXqfDr0/pfU4duCWQ/Wn2r290XtxIMj1iKGKlcg=;
 b=QVVQ92beyqGFsHBxBbrSYeAicaYWhGS3ywPCq3uGJjB5l94r5tutvbqL3Md4Voe0H7nMtF
 EN3pOVpo+PILP7lF8uU6Vr7ywzX673sKWL/3zlDHij8+7pEEsU42gQhwyYz9BtTOay5Q17
 eGefpQW2f+NSQ6ytgnW8mYw2SQ6sbEA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203--DJ4FrcENBWFm2Tel11N8g-1; Thu, 03 Aug 2023 18:21:30 -0400
X-MC-Unique: -DJ4FrcENBWFm2Tel11N8g-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51bef8bb689so3138221a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101289; x=1691706089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6g7+lXqfDr0/pfU4duCWQ/Wn2r290XtxIMj1iKGKlcg=;
 b=X5UH3jGk+Brvnju7Psdt2wdxYlAFvU+6dIKX7kwlZkKKvmHCQ0UDiRo8YAkvo9cQ6M
 Dff4yMBqxL6ZF9OsPutvhqq/jbP+H6oQAJXiueL5dznz0qtZ+TcHPDV85XNHtPAGW4d1
 OswjBDvEBswoWrNjiHXx+H+QW4bKgdVUz4DvLi+YMHmjvkEGm1APcr7niu84nm4H72w0
 CxUapE/Xc1g+V3zeaLzqCxlwxmfczV5hjgxjfIq0g47lg8nhDvsgqkd3BPbW/Db26oon
 nROjyAQMnqzIGmlmW/ss+N+jCVMGejXB2DbDZr92nk+yRhbzDGANy/2CvcQztPxP7IPc
 mxxA==
X-Gm-Message-State: AOJu0Yy3AYdurARDVILhlFg9KPWZ+EgtZoTdb7CvjT/ucQyVvmkC8Fn5
 vLtoU0VET23N5vf4s7/sxBGrA7QwfpG9Rb1mxWXJzWPuy/HkRp1lC3iMqOajV4odbkxMG8PEsMj
 QBaRyBztjhYD8ps4aXKaHIY72L1+VbJoKA5bjRNoEcpC3zAM2CUl2ySCh8n3YwK2Bcta+
X-Received: by 2002:a05:6402:42cb:b0:522:aad4:aae0 with SMTP id
 i11-20020a05640242cb00b00522aad4aae0mr52763edc.3.1691101289030; 
 Thu, 03 Aug 2023 15:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEBCb6m5wy78ttOOPndlAwBSVtcMAi2wTyHTxsrbOeyjpvvRSb1OYQn69OfdMKgzGMCEF/pA==
X-Received: by 2002:a05:6402:42cb:b0:522:aad4:aae0 with SMTP id
 i11-20020a05640242cb00b00522aad4aae0mr52753edc.3.1691101288823; 
 Thu, 03 Aug 2023 15:21:28 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 u4-20020a05640207c400b0051d9ee1c9d3sm352621edy.84.2023.08.03.15.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:28 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/22] pci: do not respond config requests after PCI device
 eject
Message-ID: <348e354417b64c484877354ee7cc66f29fa6c7df.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2224964

In migration with VF failover, Windows guest and ACPI hot
unplug we do not need to satisfy config requests, otherwise
the guest immediately detects the device and brings up its
driver. Many network VF's are stuck on the guest PCI bus after
the migration.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Message-Id: <20230728084049.191454-1-yuri.benditovich@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci_host.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 7af8afdcbe..a18aa0a8d4 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -62,6 +62,17 @@ static void pci_adjust_config_limit(PCIBus *bus, uint32_t *limit)
     }
 }
 
+static bool is_pci_dev_ejected(PCIDevice *pci_dev)
+{
+    /*
+     * device unplug was requested and the guest acked it,
+     * so we stop responding config accesses even if the
+     * device is not deleted (failover flow)
+     */
+    return pci_dev && pci_dev->partially_hotplugged &&
+           !pci_dev->qdev.pending_deleted_event;
+}
+
 void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
                                   uint32_t limit, uint32_t val, uint32_t len)
 {
@@ -75,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -100,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 
-- 
MST



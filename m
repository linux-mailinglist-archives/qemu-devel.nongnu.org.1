Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F4218944977
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Aug 2024 12:37:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAt-0005Rk-EE; Thu, 01 Aug 2024 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAb-0004WX-Iv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAa-0001d8-6H
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SekfldKxDjaLjrGHvZ8eOZLUMSLhZFBP5+JICVV9W20=;
 b=YhFqISWD+n/sVFWoNThlA9FirooqN/egm4YMVbi3jpaH0+1GhcW2lv2lXs+u50uv3Vly8z
 wQd21dFH0Xo4DOGKNAO3taVivI3lcqjmZsFaneRcUAvMSBgCbrxjhiL/n8VAYeJ96FfWz2
 baepXWl2+gkN4DdKt562Bco175XLj54=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-JxFfJVbpNByxLfGXjsk_Ug-1; Thu, 01 Aug 2024 06:36:25 -0400
X-MC-Unique: JxFfJVbpNByxLfGXjsk_Ug-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52f00bde210so7588295e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508583; x=1723113383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SekfldKxDjaLjrGHvZ8eOZLUMSLhZFBP5+JICVV9W20=;
 b=XYTJ07RYEZxWI7/5kH+vnxPvYnu2sFMBd3FtOsv7vQt3L6y6iNhDUo9lLCfDvyRTBZ
 hfHbulrp0dh4N+nVkxs4KqMk55C+Fsl2vWpUkL+E7GZFTiB/MSrRV4xdMEj+VLdQg1F+
 nuSoJQWZRoQCBpXA4Y+C6xaHFf+BivGJGhSYDi+1ZNVye7p7KgfveuO7S8H/tliXJNnC
 8tJ9Die4o51JDEciX5dFCijZArm2f7fnscqtH9YTq92lrekNpWvrGdn/fayILyrVT2qo
 d4F6n7WXZ2QaamsI8W6ODDVwdod04saPq66H1S9uruTke7ActZq7okn9LJspaeiBSmjO
 HVSQ==
X-Gm-Message-State: AOJu0Yzxh926ud1cjfd825TsbdBeagCLemNPnhVFIeROczuF2aMSiJT9
 60GI9HdUfTdEMwl5Mztf+aasp1e6BV6HMRiOlKbhftmg0xOxanNVnRtvIOIIBDRVwGZGSJJ0rwo
 MMmzWta+dtQdKlrEA+MemYcZjq9va3zaKwjuDJX3vCgq1uqdvmixx2oNFLn6L1IVPCqQQpvQZXX
 +uPsJnB3qSkMBfRevPJ3AwOXw5oMjIYw==
X-Received: by 2002:ac2:51ab:0:b0:52f:c10d:21f0 with SMTP id
 2adb3069b0e04-530b61f68b3mr1168349e87.54.1722508583183; 
 Thu, 01 Aug 2024 03:36:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwHUbeue8zsMszWxUzuuSQXlDjohDBz66f1DdkpVHCr5/zuYq5qBcZ5ZXPH4wvfoYR8iwtxA==
X-Received: by 2002:ac2:51ab:0:b0:52f:c10d:21f0 with SMTP id
 2adb3069b0e04-530b61f68b3mr1168303e87.54.1722508582280; 
 Thu, 01 Aug 2024 03:36:22 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad91eeesm889918366b.178.2024.08.01.03.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:18 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 08/19] Revert "hw/pci: Fix SR-IOV VF number calculation"
Message-ID: <558452512f068bfb3584a5a8b15530b0c53074c7.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit ca6dd3aef8a103138c99788bcba8195d4905ddc5.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cf2794879d..4c7be52951 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1437,11 +1437,7 @@ static pcibus_t pci_config_get_bar_addr(PCIDevice *d, int reg,
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
         uint16_t vf_stride =
             pci_get_word(pf->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-        uint32_t vf_num = d->devfn - (pf->devfn + vf_offset);
-
-        if (vf_num) {
-            vf_num /= vf_stride;
-        }
+        uint32_t vf_num = (d->devfn - (pf->devfn + vf_offset)) / vf_stride;
 
         if (type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
             new_addr = pci_get_quad(pf->config + bar);
-- 
MST



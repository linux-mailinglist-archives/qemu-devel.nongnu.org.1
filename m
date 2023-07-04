Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E4746FE1
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeAz-0001sv-HK; Tue, 04 Jul 2023 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAr-0001or-NH
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGeAq-0002F2-66
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Zva16AFX23AuJr9BkFuIQY+13JDh1icsCuMLWKwd7I=;
 b=R6OZGgGtePg+2gzn2Ra71ZekCJtQNQ1OzrI6ANW0gMKO8RATQPXE47SaCVc4SAn2ekMmD3
 A+XRoBVw2NfXdZcMAFvdmySUl/quukIla49orHgYtsu+lo9D8SEiAK+IBz5YAePk4Eb+2j
 BaJ2QO2ZnVVS0zKdHuLy7zC8AbJMLAA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-za4slk2jNLSgrrXU7g_JKQ-1; Tue, 04 Jul 2023 07:26:22 -0400
X-MC-Unique: za4slk2jNLSgrrXU7g_JKQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-682abcb2fdeso337817b3a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 04:26:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688469981; x=1691061981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Zva16AFX23AuJr9BkFuIQY+13JDh1icsCuMLWKwd7I=;
 b=J1G1rZ0Qw6HhxSRmf5/luWnr3lydOIf7jbg3o7Ws4bVGCuQHOqIzheevwywxAozfqs
 32q7ePEdqHuE92MThjyNurG1uZcIXsIBP83idw2ukwCvJ0Y0veP3UKFfqjKrdguQyLh4
 TqYlji5W2Q2wfr9eZrb0cf3wf314n14Uee96cw7kTNag9w0hRQToMG/XrF4xauUm3gkv
 O5VBROtHBwCEWwSU0PKMpDXHqOyZOn5NXnvbFystID8k+Fxf021MAShkovbMVqvMW1+y
 d0DQP8mosOG8yAN+3DeJ7E7G3ED03qL77EnAfLAgElm3AE8H+qmPeNn9Co47sqP33CJ1
 RaLg==
X-Gm-Message-State: ABy/qLZRS7OTg5Vdbt5fsN7vSlLA1vdyRRJlde2mj1y9jq2Ahaql6hLv
 2UuguL6DkZ6d+mSWrkFSfzjbS9zW5Ct5ZgzXqDOvVKtnfWx6zzV1TyKQRNNqhUYA7mswNU+qm/A
 EH8w1akqfrmlhEbU12nqAf93aIjhUYVrxX0BoQWb3UvHsSnoVghFdOVe1G7A8xjTj+PJb0RG7Q9
 Y=
X-Received: by 2002:a05:6a20:4327:b0:12e:6e0f:535 with SMTP id
 h39-20020a056a20432700b0012e6e0f0535mr7821752pzk.34.1688469980893; 
 Tue, 04 Jul 2023 04:26:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+zTOzrB4rE574Az2iPZjcCxKLbJO8pXN1lHUc/oQ68DAuPlFP7kmtGDk3mEP117woR1fBYw==
X-Received: by 2002:a05:6a20:4327:b0:12e:6e0f:535 with SMTP id
 h39-20020a056a20432700b0012e6e0f0535mr7821729pzk.34.1688469980527; 
 Tue, 04 Jul 2023 04:26:20 -0700 (PDT)
Received: from localhost.localdomain ([115.96.131.170])
 by smtp.googlemail.com with ESMTPSA id
 o7-20020a170902bcc700b001b8a897cd26sm780608pls.195.2023.07.04.04.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 04:26:20 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v7 6/6] hw/pci: add comment explaining the reason for checking
 function 0 in hotplug
Date: Tue,  4 Jul 2023 16:55:55 +0530
Message-Id: <20230704112555.5629-7-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230704112555.5629-1-anisinha@redhat.com>
References: <20230704112555.5629-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

This change is cosmetic. A comment is added explaining why we need to check for
the availability of function 0 when we hotplug a device.

CC: mst@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 47517ba3db..e3ff3808b6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1181,9 +1181,15 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
-    } else if (dev->hotplugged &&
-               !pci_is_vf(pci_dev) &&
-               pci_get_function_0(pci_dev)) {
+    } /*
+       * Populating function 0 triggers a scan from the guest that
+       * exposes other non-zero functions. Hence we need to ensure that
+       * function 0 wasn't added yet. With SRIOV and with or without ARI
+       * the PF must be hotplugged into function 0 for it to be detected.
+       */
+    else if (dev->hotplugged &&
+             !pci_is_vf(pci_dev) &&
+             pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
-- 
2.39.1



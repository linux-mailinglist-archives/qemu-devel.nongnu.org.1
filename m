Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4276B7483B1
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Au-0006MY-5R; Wed, 05 Jul 2023 08:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1As-0006MM-Cu
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qH1Aq-000138-Us
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688558396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXw8vJ2Z6H1k/M0qb77qhRA9FHdNbZ/XkMQEvdiJIkU=;
 b=XfOB253vSoRQ0tOrr7OMvZ0iX9iPY836HyJeCWbX88wT6IaC70kSAFhBPNWl8+gboxkf/2
 0SXI+PnJMOX+PBi69sXldbaKGZTtmrCxvmxPqc2ZpZDZ/xaVeGJM5BrfmcWP2v7HHAfHF4
 a5c95qvILd5JL5sVHfytdcxedPLDNgg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-EXaI0TePNUGT0hBfLIMonA-1; Wed, 05 Jul 2023 07:59:55 -0400
X-MC-Unique: EXaI0TePNUGT0hBfLIMonA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5578082558eso6318146a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558393; x=1691150393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXw8vJ2Z6H1k/M0qb77qhRA9FHdNbZ/XkMQEvdiJIkU=;
 b=C8IPWpSkoKztTXH9nZl/aBWy42OqbKfuRcPAithvEQCbBqCTNDEKoHw3IIHp9dePU5
 OfAyAj7bknKzSRY+IA7YNbfz+wmXpZDU+ayUNWF3Qfvqe2SNAmq9VmqWr3Bm0xW4KtbD
 C2YcOBzzmM3LarNqxVHN3jhgOsjq0TJfUR4MLqyBi5Lon6Gh+AXu70gqcF8B0h9LPHNE
 Xbw2pdBmoiDlyoIHI3ZDZF0eLkc9Sf78Tr8c7m9eN3QWbaEgMGEBjC+2h7MfV4BLQxeK
 oRQv13vyQQ+yCjAhMseXzR6fXeCeJneKqE/vKCTRPCSy1FLPDcOl+kKexyWjDsJsWfUc
 dCrA==
X-Gm-Message-State: ABy/qLZn+lztJfvzj0EM4zBxwI9EeIqw57kh++0iTLzE/oAObUPeurFj
 vGL8YcYHQ6/KiBzEOqIMp/wwItZgDqVEohgM9s7kwkIn2YllvecGyFnUaWYe7rrXvaH7X7/zzc0
 f3U3+o2S6NJkYCwIvZaMFua2XEzgcOmSXpNCZC1SaPi84YyhzMljJX8SV2pCuv6vyc+UJt0+wXP
 k=
X-Received: by 2002:a17:902:e808:b0:1b8:b46d:91b7 with SMTP id
 u8-20020a170902e80800b001b8b46d91b7mr420346plg.45.1688558393597; 
 Wed, 05 Jul 2023 04:59:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMYO/DrpoJnJ6AHxKRs8ctEPV/TxH6d0wDxQJ/4px4GAoCOVRYdn6E8D78Hvlm6vZ0j9w1qA==
X-Received: by 2002:a17:902:e808:b0:1b8:b46d:91b7 with SMTP id
 u8-20020a170902e80800b001b8b46d91b7mr420334plg.45.1688558393267; 
 Wed, 05 Jul 2023 04:59:53 -0700 (PDT)
Received: from localhost.localdomain ([115.96.119.220])
 by smtp.googlemail.com with ESMTPSA id
 v3-20020a1709028d8300b001b89c313185sm4878852plo.205.2023.07.05.04.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:59:52 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v8 6/6] hw/pci: add comment to explain checking for available
 function 0 in pci hotplug
Date: Wed,  5 Jul 2023 17:29:25 +0530
Message-Id: <20230705115925.5339-8-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230705115925.5339-1-anisinha@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
 hw/pci/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 62b393dfb7..7aee3a7f12 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1181,9 +1181,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
         return NULL;
-    } else if (dev->hotplugged &&
-               !pci_is_vf(pci_dev) &&
-               pci_get_function_0(pci_dev)) {
+    } /*
+       * Populating function 0 triggers a scan from the guest that
+       * exposes other non-zero functions. Hence we need to ensure that
+       * function 0 wasn't added yet.
+       */
+    else if (dev->hotplugged &&
+             !pci_is_vf(pci_dev) &&
+             pci_get_function_0(pci_dev)) {
         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
                    " new func %s cannot be exposed to guest.",
                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
-- 
2.39.1



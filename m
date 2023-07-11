Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F340374E7A6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7PD-0008LF-4H; Tue, 11 Jul 2023 03:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ7PB-0008Kn-UO
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ7PA-0002pw-Bx
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689059003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BHPnjyolZbfsOfUleXX+gV3drDMtAQhdvjbEBKUdP08=;
 b=FRBxges60F+HlcdIV9cuDVJMjfkwOrq6Xpi+c/9KgHytThtyqD4oc6fLHbXbYpn7bd9s6p
 Y6v/CEHTbEG2J4JlC7JHofGGEWMI66d29BvErSNwxjDw+ubh4mPnsIVZWN8FkVeJkKUVfv
 NSSQdN82Mz4sZi85f8oy9L0pGmK8qDQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-eGBYs7RdOTmyvQV6q0oTWA-1; Tue, 11 Jul 2023 03:03:21 -0400
X-MC-Unique: eGBYs7RdOTmyvQV6q0oTWA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-262e04a6f5aso5787482a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689059000; x=1691651000;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHPnjyolZbfsOfUleXX+gV3drDMtAQhdvjbEBKUdP08=;
 b=dOzkCgUCAav29T/fvfcouV398BbryeSr+Vf58aKt3ltuCd1SN+nKDL0Z6zIgyeGX4W
 XVSyb9qlvLnE/q8BaJtoBFy0Tyk6LvGB5cJEhbKvoMbiqTPdsN0wgUQTCP/Et1JuqO0W
 yH3+04K/5jsGlxBYZSKhyea3asi3Z0dGp92WsSGKefjweMiAxVV+KIwq8XqJNN3M4d7A
 UlP8aUaX++HVnTJ8XbYj8sR/HbfMTMGvLJHxbpFMGf0rQ5QyZEc16fxDCQKjbvri5TCZ
 etDpTmWt9IaMsWsND2eW5H9Es431EZ8O3HiuEWcN1QHYqG+ockonvIKHE6qvw398dyum
 NX7Q==
X-Gm-Message-State: ABy/qLY8aApwlU8yVSyZACGWLTv48t45cMqxBcFmYq6G6wI7tyYsrG0Q
 lJRtxB5gPdzCivQnPaHLv3QZyp9ZZCp8nW549VYr10Uro7W1qsgfEylBNTbuoTWDYtgQexWTbyx
 1HPOgN4sBbOovPFo=
X-Received: by 2002:a17:90b:783:b0:262:cb1c:a782 with SMTP id
 l3-20020a17090b078300b00262cb1ca782mr11697770pjz.37.1689059000681; 
 Tue, 11 Jul 2023 00:03:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHaRjM2ya5NzePjvpPv3YBqaLDChVCz65i0Takr6kf1QZgguFvyAJbFiE3EzWsYIOtHGhiyIw==
X-Received: by 2002:a17:90b:783:b0:262:cb1c:a782 with SMTP id
 l3-20020a17090b078300b00262cb1ca782mr11697750pjz.37.1689059000302; 
 Tue, 11 Jul 2023 00:03:20 -0700 (PDT)
Received: from localhost.localdomain ([116.73.134.124])
 by smtp.googlemail.com with ESMTPSA id
 l7-20020a17090aaa8700b00264044cca0fsm14339446pjq.1.2023.07.11.00.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 00:03:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	mjt@tls.msk.ru,
	qemu-devel@nongnu.org
Subject: [PATCH RESEND] hw/pci: add comment to explain checking for available
 function 0 in pci hotplug
Date: Tue, 11 Jul 2023 12:33:01 +0530
Message-Id: <20230711070301.4353-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
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
CC: mjt@tls.msk.ru
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/pci/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..6db18dfe46 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1180,9 +1180,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7176F7EC9C0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:36:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jn3-0003hj-Jf; Wed, 15 Nov 2023 12:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7e.v1-62533e98bbfc4db9867c94103d9014ee@bounce.vates.tech>)
 id 1r3Jmo-0003Zt-Bh
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:47 -0500
Received: from mail186-12.suw21.mandrillapp.com ([198.2.186.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7e.v1-62533e98bbfc4db9867c94103d9014ee@bounce.vates.tech>)
 id 1r3Jml-0000ot-P3
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 s=mandrill; t=1700068734; x=1700329234;
 i=thierry.escande@vates.tech;
 bh=i1KUIQO9g2CZuRmPbda+2Zt1MIb/whRGYxYd60ywESM=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=VazxA3WrRgG9hDWv8eZ6XbTouX+X4MpF2UURlDULyXTY1P3L/r6+0qtL/hJ0fGBTi
 NLDlz+uOzfFZkyuKT9DI+XrulWhejfPpBRxG3/SCNxE1+mwstcEu90FmwAvQR9BPKJ
 uPhkuyQeSNXP0u2d/+CG4Sp8DuA/BWsJHX1V8tIs=
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-12.suw21.mandrillapp.com (Mailchimp) with ESMTP id
 4SVqdV239Fz705lSg
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 17:18:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1700068734; h=from :
 subject : to : cc : message-id : in-reply-to : references : date :
 mime-version : content-type : content-transfer-encoding : from :
 x-mandrill-user : list-unsubscribe;
 bh=i1KUIQO9g2CZuRmPbda+2Zt1MIb/whRGYxYd60ywESM=;
 b=BzAm5UQ06P50D8CQjB8nixF+Zgw24WgGdUXxf5lIEeDFxR4TtRGuBeQ1XDIVjSbah91jt
 pl3XfVE8Pwc0KpAJ+v5+Ken10nVoe1BonCmnG6Q7PlkAWHSa1nwCQpih3hxmdR3E6cRvSK4
 5zhmvZKTmdiW16nZ863K6tQBREpHVCA=
From: Thierry Escande <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=204/4]=20ich9:=20Enable=20root=20PCI=20hotplug=20by=20default?=
Received: from [37.26.189.201] by mandrillapp.com id
 62533e98bbfc4db9867c94103d9014ee; Wed, 15 Nov 2023 17:18:54 +0000
X-Mailer: git-send-email 2.42.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: a6f8c62a-75f8-4756-90d1-92e0b788484c
X-Bm-Transport-Timestamp: 1700068732696
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Message-Id: <20231115171837.18866-5-thierry.escande@vates.tech>
In-Reply-To: <20231115171837.18866-1-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.62533e98bbfc4db9867c94103d9014ee?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20231115:md
Date: Wed, 15 Nov 2023 17:18:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.12;
 envelope-from=bounce-md_30504962.6554fd7e.v1-62533e98bbfc4db9867c94103d9014ee@bounce.vates.tech;
 helo=mail186-12.suw21.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This patch initializes use_acpi_root_pci_hotplug to true and enables
device PCI hotplug on q35 machine by default.

Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 hw/acpi/ich9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index e38c9bb998..ad2c8ad8ed 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -450,6 +450,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     pm->disable_s4 = 0;
     pm->s4_val = 2;
     pm->acpi_pci_hotplug.use_acpi_hotplug_bridge = true;
+    pm->acpi_pci_hotplug.use_acpi_root_pci_hotplug = true;
     pm->keep_pci_slot_hpc = true;
     pm->enable_tco = true;
 
-- 
2.42.0



Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


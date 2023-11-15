Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0079C7EC9BD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:35:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jmx-0003an-Bv; Wed, 15 Nov 2023 12:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7d.v1-b49b99c6e13344f598497a0b57be6331@bounce.vates.tech>)
 id 1r3Jmr-0003a6-Uf
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:51 -0500
Received: from mail186-12.suw21.mandrillapp.com ([198.2.186.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7d.v1-b49b99c6e13344f598497a0b57be6331@bounce.vates.tech>)
 id 1r3Jmq-0000pE-AY
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 s=mandrill; t=1700068733; x=1700329233;
 i=thierry.escande@vates.tech;
 bh=JOWbwFjOMTqxGzgy35q6kjO/41Rh3g/nrtq0Lyyy5/o=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=OkYe3Lr7NSDW/VURqE7OeXgTeIfYsrQhL5HSrwlphIYedmdatPRn/92yz6ruzkaVW
 DWq1QGNWjij5qOD4LVY/RNsao9+1lwjsI9RM2T7VXEvsNSb2hgRJEc+XAdTTzv05Fa
 25lFObxUrTqiPNRRjo6CZuLyqRU3pBUP8Qakid6M=
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-12.suw21.mandrillapp.com (Mailchimp) with ESMTP id
 4SVqdT3X49z705mFt
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 17:18:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1700068733; h=from :
 subject : to : cc : message-id : in-reply-to : references : date :
 mime-version : content-type : content-transfer-encoding : from :
 x-mandrill-user : list-unsubscribe;
 bh=JOWbwFjOMTqxGzgy35q6kjO/41Rh3g/nrtq0Lyyy5/o=;
 b=R/c2iAmnQrPzl0V7tvUiCiIu6OmVyK1WIHFzhg/hcp0hIkyVfzAEWyPsbW23QRrlsAkSC
 5oPs6bbBlc+sXP43/RM+9kur4IfQzdOakmC6LPGw56UNgBPhAc7a+y9C7pVHyuai3ULC42I
 ZRL1Wgi+Ai4vpbdCXO+XbikZfDWkFYk=
From: Thierry Escande <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=201/4]=20ich9:=20Remove=20unused=20hotplug=20field=20from=20ICH9LPCPMRegs=20struct?=
Received: from [37.26.189.201] by mandrillapp.com id
 b49b99c6e13344f598497a0b57be6331; Wed, 15 Nov 2023 17:18:53 +0000
X-Mailer: git-send-email 2.42.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: a6f8c62a-75f8-4756-90d1-92e0b788484c
X-Bm-Transport-Timestamp: 1700068731800
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Message-Id: <20231115171837.18866-2-thierry.escande@vates.tech>
In-Reply-To: <20231115171837.18866-1-thierry.escande@vates.tech>
References: <20231115171837.18866-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.b49b99c6e13344f598497a0b57be6331?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20231115:md
Date: Wed, 15 Nov 2023 17:18:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.12;
 envelope-from=bounce-md_30504962.6554fd7d.v1-b49b99c6e13344f598497a0b57be6331@bounce.vates.tech;
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

This patch removes the unused field use_acpi_hotplug_bridge from the
ICH9LPCPMRegs structure as it is now part of AcpiPciHpState.

Hotplug fields have been removed from piix4 state structure by commit
6536e427ce49 (pcihp: move fields enabling hotplug into AcpiPciHpState)
so do the same for ich9.

Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 include/hw/acpi/ich9.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 2faf7f0cae..4bc9aa1d11 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -57,7 +57,6 @@ typedef struct ICH9LPCPMRegs {
     CPUHotplugState cpuhp_state;
 
     bool keep_pci_slot_hpc;
-    bool use_acpi_hotplug_bridge;
     AcpiPciHpState acpi_pci_hotplug;
     MemHotplugState acpi_memory_hotplug;
 
-- 
2.42.0



Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


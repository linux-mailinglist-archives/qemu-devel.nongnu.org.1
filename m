Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 685757EC9BE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:36:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jn2-0003cp-4M; Wed, 15 Nov 2023 12:35:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7d.v1-28c2badd961c43609664e313f021bf64@bounce.vates.tech>)
 id 1r3Jmr-0003a7-VW
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:51 -0500
Received: from mail186-12.suw21.mandrillapp.com ([198.2.186.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.6554fd7d.v1-28c2badd961c43609664e313f021bf64@bounce.vates.tech>)
 id 1r3Jmq-0000pJ-Ac
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech;
 s=mandrill; t=1700068733; x=1700329233;
 i=thierry.escande@vates.tech;
 bh=BIlw9qtHLBT2nkAoU1QmxUz/qgSwVuOLgmg+AKkHgks=;
 h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
 b=BoPR9NvD8yeK03TtaAo9p/TTkOESOck9EATpj9sR516GF+qqeqpbN6iiVmhku0YIQ
 tMQdzV+EarFF9LXo1OcgMXUgxNtOU3ZJuKHlR/SPbrHqRnK+l/edN/o8femG0N2Peu
 kDf4oExbhQkARbvrlu4IuHyUosBP2z5CGUSnMozQ=
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail186-12.suw21.mandrillapp.com (Mailchimp) with ESMTP id
 4SVqdT1gLLz705mFj
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 17:18:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1700068733; h=from :
 subject : to : cc : message-id : date : mime-version : content-type :
 content-transfer-encoding : from : x-mandrill-user : list-unsubscribe;
 bh=BIlw9qtHLBT2nkAoU1QmxUz/qgSwVuOLgmg+AKkHgks=;
 b=Jna3wAJTpKqxe5HAFYsyeRQJTj8KoHwxg68NENcrTVvgMjqA2u+efZb6rGI1N+5bYbcdj
 AG4s64myD0686OkPxWP1CFOVO9NwI8w6xsyLeLAkzOG5dDxwVLiF9kdQF/OPAruW9oa/PcA
 pgu9Q2sUYvukSfRVALkwVNxWayv1Dbk=
From: Thierry Escande <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=200/4]=20ICH9=20root=20PCI=20hotplug?=
Received: from [37.26.189.201] by mandrillapp.com id
 28c2badd961c43609664e313f021bf64; Wed, 15 Nov 2023 17:18:53 +0000
X-Mailer: git-send-email 2.42.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: a6f8c62a-75f8-4756-90d1-92e0b788484c
X-Bm-Transport-Timestamp: 1700068731468
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Message-Id: <20231115171837.18866-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.28c2badd961c43609664e313f021bf64?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20231115:md
Date: Wed, 15 Nov 2023 17:18:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.186.12;
 envelope-from=bounce-md_30504962.6554fd7d.v1-28c2badd961c43609664e313f021bf64@bounce.vates.tech;
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

Hi,

This series fixes acpi_hotplug_bridge accessor names, adds new accessors
for acpi-root-pci-hotplug property, and enables root PCI hotplug by
default for Q35 machine.

Thierry Escande (4):
  ich9: Remove unused hotplug field from ICH9LPCPMRegs struct
  ich9: Renamed use_acpi_hotplug_bridge accessors
  ich9: Add accessors for acpi-root-pci-hotplug
  ich9: Enable root PCI hotplug by default

 hw/acpi/ich9.c         | 23 +++++++++++++++++++++--
 include/hw/acpi/ich9.h |  1 -
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.42.0



Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


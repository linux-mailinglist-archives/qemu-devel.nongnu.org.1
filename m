Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F4471F99D
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 07:18:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4xAU-0006as-5T; Fri, 02 Jun 2023 01:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1q4vPJ-0006Sz-99
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 23:24:53 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1q4vPE-0006Bt-4z
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 23:24:53 -0400
X-UUID: eb4761495a7845c9b6e5ee5798b5e5e5-20230602
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:db43c25c-b463-4757-9dac-d67860af78a4, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-10
X-CID-INFO: VERSION:1.1.22, REQID:db43c25c-b463-4757-9dac-d67860af78a4, IP:5,
 URL
 :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:-10
X-CID-META: VersionHash:120426c, CLOUDID:9737243d-de1e-4348-bc35-c96f92f1dcbb,
 B
 ulkID:230602111513EK6FPLAO,BulkQuantity:2,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: eb4761495a7845c9b6e5ee5798b5e5e5-20230602
X-User: zhanghao1@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <zhanghao1@kylinos.cn>) (Generic MTA)
 with ESMTP id 145393309; Fri, 02 Jun 2023 11:24:29 +0800
From: zhanghao1 <zhanghao1@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhanghao1 <zhanghao1@kylinos.cn>
Subject: [PATCH 0/1] virtio: add a new vcpu stall watchdog 
Date: Fri,  2 Jun 2023 11:22:31 +0800
Message-Id: <20230602032231.84610-1-zhanghao1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhanghao1@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 02 Jun 2023 01:17:28 -0400
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

A new virtio pci device named virtio-vcpu-stall-watchdog-pci has been
added to handle vcpu stalling

 hw/virtio/Kconfig                             |   5 +
 hw/virtio/meson.build                         |   2 +
 hw/virtio/virtio-vcpu-stall-watchdog-pci.c    |  89 +++++++
 hw/virtio/virtio-vcpu-stall-watchdog.c        | 240 ++++++++++++++++++
 .../hw/virtio/virtio-vcpu-stall-watchdog.h    |  45 ++++
 5 files changed, 381 insertions(+)
 create mode 100644 hw/virtio/virtio-vcpu-stall-watchdog-pci.c
 create mode 100644 hw/virtio/virtio-vcpu-stall-watchdog.c
 create mode 100644 include/hw/virtio/virtio-vcpu-stall-watchdog.h

-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


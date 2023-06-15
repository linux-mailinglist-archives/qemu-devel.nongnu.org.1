Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E081730F21
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 08:14:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9gEp-0008AS-BH; Thu, 15 Jun 2023 02:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1q9gEl-00089f-Ka
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 02:13:39 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhanghao1@kylinos.cn>)
 id 1q9gEg-0007ac-3Q
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 02:13:37 -0400
X-UUID: 301799cc29ba44f98eca9f613a7cf2c7-20230615
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25, REQID:d832a8fc-cf09-4a16-9682-b50b38a4045b, IP:5,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:15
X-CID-INFO: VERSION:1.1.25, REQID:d832a8fc-cf09-4a16-9682-b50b38a4045b, IP:5,
 URL
 :0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-META: VersionHash:d5b0ae3, CLOUDID:eb777f3e-de1e-4348-bc35-c96f92f1dcbb,
 B
 ulkID:23061514014654T2ZEAA,BulkQuantity:1,Recheck:0,SF:17|19|44|24|102,TC:
 nil,Content:0,EDM:5,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 301799cc29ba44f98eca9f613a7cf2c7-20230615
X-User: zhanghao1@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
 (envelope-from <zhanghao1@kylinos.cn>) (Generic MTA)
 with ESMTP id 1134153621; Thu, 15 Jun 2023 14:13:15 +0800
From: zhanghao1 <zhanghao1@kylinos.cn>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhanghao1 <zhanghao1@kylinos.cn>
Subject: [PATCH 0/1] virtio: add a new vcpu stall watchdog 
Date: Thu, 15 Jun 2023 14:13:01 +0800
Message-Id: <20230615061302.301754-1-zhanghao1@kylinos.cn>
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


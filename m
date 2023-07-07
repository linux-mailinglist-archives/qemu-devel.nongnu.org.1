Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3A74AD9C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQI-00033g-NP; Fri, 07 Jul 2023 05:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQG-000335-6u
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQD-0006Dv-97
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GEfpSJQkI+MzkAxA+FHqSVF9gVCzVoQpRE26TsKnR2E=;
 b=iE+W2DwWxZqYlHhkKeWR65wz3vsz1U83lv3h3azSO9nUjbPVzlSozrOAP93wSncIdv7giQ
 4MSZGfX6SHim2k9dq3kotSZvrc7O5voOdCj0KJRXIZOIyTM0M9usKtO3SL+MaJ/TJNyyXb
 QRx+IXi7eFCmgXkTcBpnfD30zblHSP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-h7zhVHobM46nNVhgWzcIJw-1; Fri, 07 Jul 2023 05:06:32 -0400
X-MC-Unique: h7zhVHobM46nNVhgWzcIJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79651104459C;
 Fri,  7 Jul 2023 09:06:32 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CBAE1121330;
 Fri,  7 Jul 2023 09:06:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Jason Wang <jasowang@redhat.com>
Subject: [PULL 00/15] Net patches
Date: Fri,  7 Jul 2023 05:06:13 -0400
Message-Id: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:

  Merge tag 'pull-9p-20230706' of https://github.com/cschoenebeck/qemu into staging (2023-07-06 18:19:42 +0100)

are available in the git repository at:

  https://github.com/jasowang/qemu.git tags/net-pull-request

for you to fetch changes up to da9f7f7769e8e65f6423095e978f9a375e33515c:

  igb: Remove obsolete workaround for Windows (2023-07-07 16:35:12 +0800)

----------------------------------------------------------------

----------------------------------------------------------------
Akihiko Odaki (2):
      e1000e: Add ICR clearing by corresponding IMS bit
      igb: Remove obsolete workaround for Windows

Bin Meng (9):
      hw/net: e1000: Remove the logic of padding short frames in the receive path
      hw/net: vmxnet3: Remove the logic of padding short frames in the receive path
      hw/net: i82596: Remove the logic of padding short frames in the receive path
      hw/net: ne2000: Remove the logic of padding short frames in the receive path
      hw/net: pcnet: Remove the logic of padding short frames in the receive path
      hw/net: rtl8139: Remove the logic of padding short frames in the receive path
      hw/net: sungem: Remove the logic of padding short frames in the receive path
      hw/net: sunhme: Remove the logic of padding short frames in the receive path
      hw/net: ftgmac100: Drop the small packet check in the receive path

Laurent Vivier (4):
      virtio-net: correctly report maximum tx_queue_size value
      net: socket: prepare to cleanup net_init_socket()
      net: socket: move fd type checking to its own function
      net: socket: remove net_init_socket()

 hw/net/e1000.c       | 11 +----------
 hw/net/e1000e_core.c | 38 +++++++++++++++++++++++++++++++------
 hw/net/ftgmac100.c   |  8 --------
 hw/net/i82596.c      | 18 ------------------
 hw/net/igb_core.c    |  7 +------
 hw/net/ne2000.c      | 12 ------------
 hw/net/pcnet.c       |  9 ---------
 hw/net/rtl8139.c     | 12 ------------
 hw/net/sungem.c      | 14 --------------
 hw/net/sunhme.c      | 11 -----------
 hw/net/trace-events  |  1 +
 hw/net/virtio-net.c  |  4 ++--
 hw/net/vmxnet3.c     | 10 ----------
 net/socket.c         | 53 +++++++++++++++++++++++++++-------------------------
 14 files changed, 65 insertions(+), 143 deletions(-)




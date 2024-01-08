Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A9827874
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 20:21:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMvAp-000754-PO; Mon, 08 Jan 2024 14:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMvAn-00072S-SV
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 14:20:33 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMvAm-0002si-14
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 14:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tvrLerdO/l3eBhHeqDWRFFhtTx80ILbee345/yTCM9k=; b=dg/84nCm1uoAYS3MxQ1MQ6B1ja
 jEOrRUffLMDfdPxXXiuQDtmTF3hdFFElQolXMavj0gqA9JKRSaQHjQUSpIyZI9NtFTopTBfGS6ZjY
 Radd4fUxDv9iHdPYAJAH1L5mQhaEDfapJ/rGZcWfDaf/hi85UGzdt8UHgqI4p90cqHF+e4uJyGkYy
 oRFW/JVv/p8AHnvZeDnl0tPdz+i9I9Lo+NYIVIA3R8m7BmJi46eeD3oH7HiM8aKWGqER+iuFXB+fG
 1jRAKWlAamjlEmikRrTvrf8y31Imn8d++8f1grbIL/P/wIswgiX/KPQFzRwF7vUyWHCvgw1Nf8i8x
 NAXfEVKxGNeOrjsEcEYewGEJHD/hFQjluYtmWHr1YDd0UvPXEVhvkochxMftlJ2u/efHgIaTBZv4j
 lSexTjUiMAoNDJsWk8qbE9iCznO7HnTghfHWwz0LXqJWbgRk849vnZpRKW65/p+VIavqutD4mmcE/
 3QbthbMwlhuZkvPMeqApn39mVnMTa9wZZoqSdPe7szf7+fvdYZDWI0KVMjgkGIE8eRtSLp6mWqhbe
 DWoQXTP6IFuJhOeWJb7YvJTb7aDJla3pKNXGSbRcZF6wTW+8m84/6AFpvh7wUK4F7A2JBWCUJiKMp
 Q+QYL9q+dnt6sE/TN6+/ZGuQFzR7qGLhK16900MJY=;
Received: from [2a00:23c4:8bb1:9800:102b:b374:b08c:8889]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMvA7-0000nV-V8; Mon, 08 Jan 2024 19:19:55 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Mon,  8 Jan 2024 19:20:11 +0000
Message-Id: <20240108192013.272112-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:102b:b374:b08c:8889
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 0/2] nubus: add nubus-virtio-mmio device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series introduces a new nubus-virtio-mmio device which can be plugged into
the q800 machine to enable a 68k Classic MacOS guest to access virtio devices
such as virtio-9p-device (host filesharing), virtio-gpu (extended framebuffer
support) and virtio-tablet-device (absolute positioning).

Once the nubus-virtio-mmio device has been plugged into the q800 machine, virtio
devices can be accessed by a Classic MacOS guest using the drivers from the
classicvirtio project at https://github.com/elliotnunn/classicvirtio.

The nubus-virtio-mmio device is purposefully designed to be similar to the
virtio-mmio interface used by the existing 68k virt machine, making use of a
similar memory layout and the goldfish PIC for simple interrupt management. The
main difference is that only a single goldfish PIC is used, however that still
allows up to 32 virtio devices to be connected using a single nubus card.

Patch 1 fixes an alignment bug in the existing nubus-device Declaration ROM code
whereby some ROM images could trigger an assert() in QEMU, whilst patch 2 adds
the nubus-virtio-mmio device itself.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

v2:
- Rebase onto master
- Adjust comment in patch 1 as suggested by Phil


Mark Cave-Ayland (2):
  nubus-device: round Declaration ROM memory region address to
    qemu_target_page_size()
  nubus: add nubus-virtio-mmio device

 hw/nubus/meson.build                 |   1 +
 hw/nubus/nubus-device.c              |  16 +++--
 hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
 include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
 4 files changed, 151 insertions(+), 4 deletions(-)
 create mode 100644 hw/nubus/nubus-virtio-mmio.c
 create mode 100644 include/hw/nubus/nubus-virtio-mmio.h

-- 
2.39.2



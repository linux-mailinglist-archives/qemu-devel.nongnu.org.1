Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B382AC01
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:31:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsKC-0005bd-0m; Thu, 11 Jan 2024 05:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsK9-0005a7-8B
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsK6-00042b-Ny
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xGobqxSVFZG+BinerjtA0WNZNCUtmVFFi9LFfoN9dtk=; b=RTRQ2u/+b5X71s/wHO2DRNLF43
 m+uqSwtp3VPAHl/SkMxBiIbNe9IkL2TbzyawYyOWkQhRXnSc4dlSHvPf+pH7H9aZG0rLczgHMR9JV
 C309SMeUdTxK8CbF8UmDzBUvf6oTCCgjVg2Iz9/oL2+/uw83P8csY3DvaXRgH0EoZJBEyQjCcbKLr
 zse19Qzw1QBfdD1WJjWpx3IhD5A9/5jglyJfwn0/Q50JxdpU7T7ixcnGrFljnBnwFP8PNmPEsZ4sn
 4iEqTAcT5QdFpYpbwuf3FPniHcUv01oDQhyAq3aNTB9Hz3Un/KO7ld0khLo2x46c4lOU+6H4w/M3w
 9qs81OFd2SxqK0DNTeiljJTvOc4vyUVgNh+RArVxmT4ZiKSZwcNe7YCosnL33QcubYLtwIe+OIjTg
 evDm8tShWRzT4PaGCQx4VuC51CMZqeupoHg0WzDCsvQab7g6ppBQaVrdJEXRIRktYyk1Fh+QO1R3W
 JRm7D+Enw1LQSBZgqVLIUfymoEHz4IKuQzU9jBNu9Fejp+5HIJOhqOm4s7VBc4trhXNa9xE2XEaGL
 oR+f7JQY6ZrKGbxeoh2ALOUUqKtjvubvlzsRBlx9E1jp4coDxU4ZWmPp5PmwazQjotIp5raWBrPWB
 ZAtkDv7Gd1bSTBSHNRoQtQEslUu9pJj8grBgdEKHo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsJW-000CMC-Hs; Thu, 11 Jan 2024 10:29:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Thu, 11 Jan 2024 10:29:51 +0000
Message-Id: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 0/3] nubus: add nubus-virtio-mmio device
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
whereby some ROM images could trigger an assert() in QEMU, patch 2 increases the
maximum Declaration ROM size (to aid development), whilst patch 3 adds the
nubus-virtio-mmio device itself.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[Patches still needing review: 2, 3]

v3:
- Rebase onto master
- Update patch 1 alignment calculation to use intermediatery uint8_t rom_ptr
  variable, add Phil's R-B tag
- Add patch 2 to increase maximum Declaration ROM size to 1MB

v2:
- Rebase onto master
- Adjust comment in patch 1 as suggested by Phil


Mark Cave-Ayland (3):
  nubus-device: round Declaration ROM memory region address to
    qemu_target_page_size()
  nubus.h: increase maximum Declaration ROM size from 128k to 1Mb
  nubus: add nubus-virtio-mmio device

 hw/nubus/meson.build                 |   1 +
 hw/nubus/nubus-device.c              |  18 +++--
 hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
 include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
 include/hw/nubus/nubus.h             |   2 +-
 5 files changed, 154 insertions(+), 5 deletions(-)
 create mode 100644 hw/nubus/nubus-virtio-mmio.c
 create mode 100644 include/hw/nubus/nubus-virtio-mmio.h

-- 
2.39.2



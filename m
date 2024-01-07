Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26568826619
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 22:27:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMaeY-0003Iy-6m; Sun, 07 Jan 2024 16:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMaeU-0003GZ-Q9
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 16:25:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMaeT-0004C8-3D
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 16:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jGfWioYuDfAHbjvtU02UvFqiHJgBuVsSqzxn/+7O2Bs=; b=kXMHZzmWpzHYApYcJd54491S4w
 SCzO7K1ypmgLa7isSzWr7PHWF0ntGHZye64buA3O71Vpr6A2SxPwqUIX28huh5EU0XhhhlrAE8xg6
 wWrmW6yhFB9sFF45ilf7HRsMuguIGv8x/sGHtJu+VJnSBy8foVMLbxmzAshf5dSVjpvnQRLVpLuMU
 QV4Haw3UN0PzB14KR3eFrfupn2sVVIaxw4Z3eN910SAHlObiZaWS7dfG0+wQqy/rUqeRhAm5lmWz+
 A/kWshv9OPM06oJbJ+1L4lAjynZRhbMk1Vlf+gR1a64LhKgkUZMF6vgiVlGiHCqmgW+NMCJ5Hkpbv
 r96Gt+bjiODFRur4wlwKf1IHky66h4boMYUN5YpCapypqpINtLLF9zhtvhnRWk00maOLqRKiH18Qf
 8+mTEqDVq2IB1OZzOCRax0x7RnitRlrVSsfIxIS/Nuoya2lCXYu3E7YoD2axwpKHqHEZ69on5WIBA
 RqPUxYmd8I8RRmFvXDgo7ZSai8u1AMlAmi2VXRiLH1eAopKyDtWVCwF7CmzN2SLnHAQpvqUdL1Swj
 RHBpF+WK7bPFt+NfWpTwYMEtT8eST6buSq6CTfCEePCaOLfqALNH5nHbOBjVFjYZKFrGhJPC5ZCAb
 wOzGVY+d6admzYH0kvJ6dEO6LRoFpJFgak1pWqR/Q=;
Received: from [2a00:23c4:8bb1:9800:cf84:25bc:70ee:fc26]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMads-0006OD-UV; Sun, 07 Jan 2024 21:25:16 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Sun,  7 Jan 2024 21:25:36 +0000
Message-Id: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:cf84:25bc:70ee:fc26
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/2] nubus: add nubus-virtio-mmio device
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



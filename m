Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 411939EE556
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 12:47:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLheQ-0006pw-AF; Thu, 12 Dec 2024 06:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheO-0006pc-1M
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:36 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheM-00079o-8o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=/y1eysnH4/TImEQhBUF29PF6+ZdRMhk4HruKUuZg94Q=; b=1uggGp5BIQnRH/7o5SFGI7R8Qv
 vkO3ppOTFtj4SzK2x7BN/ZEaSJTb9JZWudQ6GTG8jV70iyRvsuL6hCEK2ZU+SBjQG0R6nj3hSLC3w
 4p6ff/O9eUvT76+535dZw+voIGHCSFbMMNJggWHID/xYbaA8KHgCusIQKP+zyacbBFQf3yylhd16k
 WH0PZghIv5YrtltlXrXkEJvKoqti330Jx3QPTF5njCYtwcktETK5JbsxtqPMKXaiAjRX6sddBTOXm
 HxlydUjO5YNQ1MHWzLKzmFIUsKteSNSOiZM7wby8RoxO7UDZ1mEbpNki4aPS0N6UQDIZfag7O538l
 JwDwdtZl3s7id0c74CJB30nu728mXTIfyj1KG6nVJS/vG+jC4xbrjab5/fionYb5Z21TXW792OmcQ
 8yWA3193VO5FaxJX19hla1eiDt9Grf5cxTcvJ/eMddMgxjhr04cjBAKTpFA5AXJKHAUrSJo3UEIsx
 vkrqw9QBGh232o9LAW3KI/j9titroh2gbk1H2yJuOgYE7LRQIL8QKhMaB8RHM1nqmVLBhdx4WC3a8
 4O5wGU7tSiNlTdS+BRz1n5R9z0hPMWxsr8bTRQtjAQH0MIMxqJ8Melhj/h1HcuIycUargSqdQ35yz
 j9OuvlkzR3ZMfjcBQhkebU6eN/FvaUA1rWkBSNETI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhdi-00070a-Rq; Thu, 12 Dec 2024 11:45:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:46 +0000
Message-Id: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 00/34] next-cube: more tidy-ups and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series contains a number of tidy-ups and improvements to the NeXTCube machine
which include:

  - Bringing the code up-to-date with our latest coding standards/APIs, in particular
    related to the board configuration and IRQ wiring

  - Remove the remaining overlapping memory regions and consolidating multiple
    register implementations into a single place

  - Add a new next-scsi device containing the ESP device and its associated
    CSRs

  - Adding the empty_slot device to fill unimplemented devices and removing
    the "catch-all" next.scr memory region

  - QOMifying the next-rtc device and wiring it up with gpios as required

The next-cube machine looks in fairly good shape now, the main remaining work is to
create a separate device for the DMA controller and update the wiring of the IRQs
(including to the CPU) accordingly.

There is no change to the behaviour of the next-cube machine with this series in
that the next-cube machine with a suitable ROM image can now load the kernel from
a pre-installed NeXTStep image and start executing it.

Note that due to the device model changes this is a migration break, however since
the next-cube machine is currently unable to boot anything useful, I don't see
this as an issue.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[Patches still needing review: 3, 7, 8, 11, 17, 21, 25, 28, 29, 30, 31, 34]

v2:
- Rebase onto master
- Drop patches 1 and 4 (these have been merged separately as bugfixes)
- Add R-B tags from Thomas and Phil
- Update commit message in patch 2
- Add comments containing system register addresses as requested by Thomas in
  patch 2
- Update description for patch 7 explaining that the SCSI CSRs are also now
  modelled as standard registers (similar to Previous)
- Update description for patch 8 explaining why the previously hardcoded value
  has been dropped
- Add comments suggesting unimplemented devices in patch 14
- Remove next_rtc_vmstate from next_pc_vmstate in patch 25
- Fix cut/paste error in patch 30 headline


Mark Cave-Ayland (34):
  next-cube: remove 0x14020 dummy value from next_mmio_read()
  next-cube: remove overlap between next.dma and next.mmio memory
    regions
  next-cube: create new next.scsi container memory region
  next-cube: move next_scsi_init() to next_pc_realize()
  next-cube: introduce next_pc_init() object init function
  next-cube: introduce next-scsi device
  next-cube: move SCSI CSRs from next-pc to the next-scsi device
  next-cube: move SCSI 4020/4021 logic from next-pc device to next-scsi
    device
  next-cube: move floppy disk MMIO to separate memory region in next-pc
  next-cube: map ESCC registers as a subregion of the next.scr memory
    region
  next-cube: move ESCC to be QOM child of next-pc device
  next-cube: move timer MMIO to separate memory region on next-pc device
  next-cube: move en ethernet MMIO to separate memory region on next-pc
    device
  next-cube: add empty slots for unknown accesses to next.scr memory
    region
  next-cube: remove unused next.scr memory region
  next-cube: rearrange NeXTState declarations to improve readability
  next-cube: convert next-pc device to use Resettable interface
  next-cube: rename typedef struct NextRtc to NeXTRTC
  next-cube: use qemu_irq to drive int_status in next_scr2_rtc_update()
  next-cube: separate rtc read and write shift logic
  next-cube: always use retval to return rtc read values
  next-cube: use named gpio to set RTC data bit in scr2
  next-cube: use named gpio to read RTC data bit in scr2
  next-cube: don't use rtc phase value of -1
  next-cube: QOMify NeXTRTC
  next-cube: move reset of next-rtc fields from next-pc to next-rtc
  next-cube: move rtc-data-in gpio from next-pc to next-rtc device
  next-cube: use named gpio output for next-rtc data
  next-cube: add rtc-cmd-reset named gpio to reset the rtc state machine
  next-cube: add rtc-power-out named gpio to trigger the NEXT_PWR_I
    interrupt
  next-cube: move next_rtc_cmd_is_write() and next_rtc_data_in_irq()
    functions
  next-cube: rename old_scr2 and scr2_2 in next_scr2_rtc_update()
  next-cube: add my copyright to the top of the file
  next-cube: replace boiler-plate GPL 2.0 or later license text with
    SPDX identifier

 hw/m68k/Kconfig     |    1 +
 hw/m68k/next-cube.c | 1026 +++++++++++++++++++++++++++----------------
 2 files changed, 659 insertions(+), 368 deletions(-)

-- 
2.39.5



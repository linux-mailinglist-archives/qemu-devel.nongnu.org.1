Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 342217DE6E8
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:46:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI5x-0002cx-U7; Wed, 01 Nov 2023 16:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5n-0001yA-BI
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:35 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5i-0001R9-NQ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BCEAF756088;
 Wed,  1 Nov 2023 21:45:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8CFE3756062; Wed,  1 Nov 2023 21:45:35 +0100 (CET)
Message-Id: <cover.1698871239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/4] Misc ati-vga patches
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
    marcandre.lureau@redhat.com
Date: Wed,  1 Nov 2023 21:45:35 +0100 (CET)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Changes in v2:
- Add HOST_PATH_CNTL reg in patch 1 to match Linux vram size calculation
- Add a new patch to implement pixman fallbacks for ati-vga that
should help with the series that make pixman optional.

Some misc patches I had laying around that could be upstreamed just to
clean up my tree a bit.

BALATON Zoltan (4):
  ati-vga: Fix aperture sizes
  ati-vga: Support unaligned access to GPIO DDC registers
  ati-vga: Add 30 bit palette access register
  ati-vga: Implement fallback for pixman routines

 hw/display/ati.c      | 61 +++++++++++++++++++++++++----------
 hw/display/ati_2d.c   | 75 ++++++++++++++++++++++++++++++-------------
 hw/display/ati_dbg.c  |  2 ++
 hw/display/ati_int.h  |  2 ++
 hw/display/ati_regs.h |  2 ++
 5 files changed, 103 insertions(+), 39 deletions(-)

-- 
2.30.9



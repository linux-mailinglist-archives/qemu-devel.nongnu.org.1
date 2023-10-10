Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E07BFCB4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:03:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCOB-0007F2-0u; Tue, 10 Oct 2023 09:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqCNP-0006lk-Q8
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:02:20 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qqCNM-0006qe-7w
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:02:19 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 46658757206;
 Tue, 10 Oct 2023 15:01:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1B4367571FE; Tue, 10 Oct 2023 15:01:18 +0200 (CEST)
Message-Id: <cover.1696942148.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/3] Misc ati-vga patches
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2023 15:01:18 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Some misc patches I had laying around that could be upstreamed just to
clean up my tree a bit.

BALATON Zoltan (3):
  ati-vga: Fix aperture sizes
  ati-vga: Support unaligned access to GPIO DDC registers
  ati-vga: Add 30 bit palette access register

 hw/display/ati.c      | 50 ++++++++++++++++++++++++++++---------------
 hw/display/ati_dbg.c  |  1 +
 hw/display/ati_int.h  |  1 +
 hw/display/ati_regs.h |  1 +
 4 files changed, 36 insertions(+), 17 deletions(-)

-- 
2.30.9



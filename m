Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6D7D26DF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 00:47:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhCP-0005kO-GG; Sun, 22 Oct 2023 18:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1quhCN-0005kC-7K
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 18:45:31 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1quhCK-0007Gf-Sb
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 18:45:30 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 265A875606C;
 Mon, 23 Oct 2023 00:45:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 67C2F74705E; Mon, 23 Oct 2023 00:45:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 647087456A7;
 Mon, 23 Oct 2023 00:45:21 +0200 (CEST)
Date: Mon, 23 Oct 2023 00:45:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/3] Misc ati-vga patches
In-Reply-To: <cover.1696942148.git.balaton@eik.bme.hu>
Message-ID: <2875d8e4-e0b0-2167-7f71-f4df3588e80d@eik.bme.hu>
References: <cover.1696942148.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Tue, 10 Oct 2023, BALATON Zoltan wrote:
> Some misc patches I had laying around that could be upstreamed just to
> clean up my tree a bit.

Ping? Is Gerd still the maintainer of gfx or who else should be cc'd on 
such patches?

Regards,
BALATON Zoltan

> BALATON Zoltan (3):
>  ati-vga: Fix aperture sizes
>  ati-vga: Support unaligned access to GPIO DDC registers
>  ati-vga: Add 30 bit palette access register
>
> hw/display/ati.c      | 50 ++++++++++++++++++++++++++++---------------
> hw/display/ati_dbg.c  |  1 +
> hw/display/ati_int.h  |  1 +
> hw/display/ati_regs.h |  1 +
> 4 files changed, 36 insertions(+), 17 deletions(-)
>
>


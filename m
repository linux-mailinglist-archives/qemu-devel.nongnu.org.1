Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8457E4390
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 16:35:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0O5W-0002dw-Od; Tue, 07 Nov 2023 10:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0O5M-0002dO-Mc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 10:33:48 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0O5K-0005zO-6k
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 10:33:47 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 783E475A4B9;
 Tue,  7 Nov 2023 16:33:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6D2E075A4B8; Tue,  7 Nov 2023 16:33:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6B74775A4B7;
 Tue,  7 Nov 2023 16:33:58 +0100 (CET)
Date: Tue, 7 Nov 2023 16:33:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 1/4] ati-vga: Fix aperture sizes
In-Reply-To: <da9904df-1e3c-4e73-b614-b93665d73a05@tls.msk.ru>
Message-ID: <ad496517-ecb6-975f-7829-0773f66cd71d@eik.bme.hu>
References: <cover.1698871239.git.balaton@eik.bme.hu>
 <d077d4f90d19db731df78da6f05058db074cada1.1698871239.git.balaton@eik.bme.hu>
 <da9904df-1e3c-4e73-b614-b93665d73a05@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
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

On Tue, 7 Nov 2023, Michael Tokarev wrote:
> 01.11.2023 23:45, BALATON Zoltan:
>> Apparently these should be half the memory region sizes confirmed at
>> least by Radeon FCocde ROM while Rage 128 Pro ROMs don't seem to use
>> these. Linux r100 DRM driver also checks for a bit in HOST_PATH_CNTL
>> so we also add that even though the FCode ROM does not seem to set it.
>
> Is it stable-worthy?

Not really beacause this is only needed by RV100 drivers but that GPU is 
not emulated enough yet to work so this won't help them. However the last 
patch adding pixman fallbacks to ati_2d.c fixes graphics issues on Apple 
silicon Macs where pixman does not work that happens also with the default 
rage128p emulation so that patch may be useful in stable. It should be 
independent of the other patches in the series so should apply without the 
other patches.

Regards,
BALATON Zoltan


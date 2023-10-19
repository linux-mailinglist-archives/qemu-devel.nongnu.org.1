Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790C7D054F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 01:15:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtcDq-00015g-Pb; Thu, 19 Oct 2023 19:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtcDp-00015T-Cy; Thu, 19 Oct 2023 19:14:33 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtcDn-00036M-Lt; Thu, 19 Oct 2023 19:14:33 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 11AFF75606C;
 Fri, 20 Oct 2023 01:14:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CF3C474705E; Fri, 20 Oct 2023 01:14:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CDFFE745681;
 Fri, 20 Oct 2023 01:14:29 +0200 (CEST)
Date: Fri, 20 Oct 2023 01:14:29 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH 0/2] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
In-Reply-To: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <8c17aaed-bdd7-a360-79b4-4a04686fb7ea@eik.bme.hu>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Thu, 19 Oct 2023, Mark Cave-Ayland wrote:
> This series adds a simple implementation of legacy/native mode switching for PCI
> IDE controllers and updates the via-ide device to use it.
>
> The approach I take here is to add a new pci_ide_update_mode() function which handles
> management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
> details of the internal logic to individual PCI IDE controllers.
>
> As noted in [1] this is extracted from a local WIP branch I have which contains
> further work in this area. However for the moment I've kept it simple (and
> restricted it to the via-ide device) which is good enough for Zoltan's PPC
> images whilst paving the way for future improvements after 8.2.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Tested-by: BALATON Zoltan <balaton@eik.bme.hu>

Thank you for finishing these. I've verified that AmigaOS and MorphOS 
and Linux still boot on pegasos2 and it also works with AmigaOS on 
amigaone so I'm OK with this. I only had some small comments in patch 2. 
This can replace patch 1 in my series, the other patches should just apply 
on top of this too but I can resubmit based on this when it becomes final.

Regards,
BALATON Zoltan

>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>
> Mark Cave-Ayland (2):
>  ide/pci.c: introduce pci_ide_update_mode() function
>  hw/ide/via: implement legacy/native mode switching
>
> hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
> hw/ide/via.c         | 20 +++++++++-
> include/hw/ide/pci.h |  1 +
> 3 files changed, 109 insertions(+), 2 deletions(-)
>
>


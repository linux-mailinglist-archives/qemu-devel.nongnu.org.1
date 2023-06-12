Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E349872BE56
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 12:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8eRo-0000QB-Mz; Mon, 12 Jun 2023 06:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8eRd-0000Nw-Gh; Mon, 12 Jun 2023 06:06:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8eRb-0007B9-De; Mon, 12 Jun 2023 06:06:41 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 786E474633D;
 Mon, 12 Jun 2023 12:06:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B1540746335; Mon, 12 Jun 2023 12:06:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id ADF4B745720;
 Mon, 12 Jun 2023 12:06:30 +0200 (CEST)
Date: Mon, 12 Jun 2023 12:06:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-trivial@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] hw/char/parallel-isa: Export struct ISAParallelState
In-Reply-To: <F47D47A6-B68A-46E7-BF36-C6447AC8E4CD@gmail.com>
Message-ID: <24583ff5-542b-d645-378d-ce6a7b4affb7@eik.bme.hu>
References: <20230611110008.32638-1-shentey@gmail.com>
 <20230611110008.32638-3-shentey@gmail.com>
 <229b5f39-2a3e-e47b-5269-9ae2c43492ae@eik.bme.hu>
 <F47D47A6-B68A-46E7-BF36-C6447AC8E4CD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Probability: 9%
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

On Mon, 12 Jun 2023, Bernhard Beschow wrote:
> Am 11. Juni 2023 13:15:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sun, 11 Jun 2023, Bernhard Beschow wrote:
>>> Allows the struct to be embedded directly into device models without additional
>>> allocation.
>>>
>>> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Patches missing SoB, checkpatch should have cought this.
>
> Thanks for catching again. Fixed in v2.
>
>>
>> I don't see any of the machines or device models actually embedding 
>> ISAParallelState or ParallelState so don't know what this patch is 
>> trying to achieve. Please post the whole series with the patches that 
>> this is a preparation for so we can se where this leads.
>
> No further plans from my side.

Then IMO these patches are not needed. Keeping the struct definitions in 
parallel.c ensures they are not accessed by anything else and keeps the 
object encapsulation. I don't see a point for moving the defs to a header 
if nothing wants to use them. This is done for other devices to allow them 
to be embedded in other devices but if that's not the case here then why 
this series? (The TYPE_ISA_PARALLEL #define seems to be already in 
include/hw/chsr/parallel.h so if you only want to use that like in the 
series you've referenced in the cover letter then that can be done without 
these patches.)

Regards,
BALATON Zoltan


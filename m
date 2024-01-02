Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFBB821B29
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:45:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdD1-00070w-Tc; Tue, 02 Jan 2024 06:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rKdCq-0006z3-7d
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:45:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rKdCo-00060u-4e
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:45:11 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 777214E62E8;
 Tue,  2 Jan 2024 12:45:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 6fskiZUZaKY8; Tue,  2 Jan 2024 12:45:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 96BB04E62C2; Tue,  2 Jan 2024 12:45:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 951E574577C;
 Tue,  2 Jan 2024 12:45:02 +0100 (CET)
Date: Tue, 2 Jan 2024 12:45:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel <qemu-devel@nongnu.org>, "Hoffmann, Gerd" <kraxel@redhat.com>
Subject: Re: [PATCH 5/8] vga: optimize horizontal pel panning in 256-color
 modes
In-Reply-To: <CABgObfa3DVVzRa6v=QREyWqhRyLofiiNpp7ZJdu5nv65GrkHBQ@mail.gmail.com>
Message-ID: <2a7fb196-0882-566f-16ea-5432593bbda8@eik.bme.hu>
References: <20231231093918.239549-1-pbonzini@redhat.com>
 <20231231093918.239549-6-pbonzini@redhat.com>
 <0479f7fd-b3d5-a18c-3640-0c679cd8a834@eik.bme.hu>
 <CABgObfa3DVVzRa6v=QREyWqhRyLofiiNpp7ZJdu5nv65GrkHBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 1 Jan 2024, Paolo Bonzini wrote:
> Il dom 31 dic 2023, 17:27 BALATON Zoltan <balaton@eik.bme.hu> ha scritto:
>
>>>     palette = vga->last_palette;
>>>     hpel = (hpel >> 1) & 3;
>>> +
>>> +    /* For 256 color modes, we can adjust the source address and write
>> directly
>>> +     * to the destination, even if horizontal pel panning is active.
>> However,
>>> +     * the loop below assumes that the address does not wrap in the
>> middle of a
>>> +     * plane.  If that happens...
>>> +     */
>>> +    if (addr + (width >> 3) * 4 < VGA_VRAM_SIZE) {
>>> +        addr += hpel * 4;
>>> +        hpel = 0;
>>> +    }
>>> +
>>> +    /* ... use the panning buffer as in planar modes.  */
>>>     if (hpel) {
>>>         width += 8;
>>>         d = vga->panning_buf;
>>
>> Is it possible to do these checks once in vga.c and instead of changing
>> the return value of the draw functions pass panning_buf as d if needed?
>> Maybe that way the draw funcs could be left unchanged?
>>
>
> As of the previous patch it could, here however the logic for whether to
> use the panning_buf depends on the drawing function; 8d2 is special and
> different from the others.
>
> I can remove the optimization, it's not super Important; but it's kind of
> obvious to do it for the VGA 256-color modes, since they're the only ones
> with the same bit alignment for all pixels.

I guess that means it's not easy to do so my question is not so imprtant 
then.

Regards,
BALATON Zoltan


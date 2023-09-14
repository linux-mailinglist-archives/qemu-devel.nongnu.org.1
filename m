Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C637A03F4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:34:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglXW-0001yN-So; Thu, 14 Sep 2023 08:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qglWX-0001UW-AN
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:32:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qglWU-0007vS-Ck
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:32:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79A7621E27;
 Thu, 14 Sep 2023 15:32:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9A63E28165;
 Thu, 14 Sep 2023 15:32:35 +0300 (MSK)
Message-ID: <36b2ff6b-32c4-f8a2-ed89-fec14bf925af@tls.msk.ru>
Date: Thu, 14 Sep 2023 15:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/qxl: move check of slot_id before accessing guest_slots
Content-Language: en-US
To: Anastasia Belova <abelova@astralinux.ru>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
References: <20230914092717.7158-1-abelova@astralinux.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230914092717.7158-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

14.09.2023 12:27, Anastasia Belova wrote:
> If slot_id >= NUM_MEMSLOTS, buffer overflow is possible.
> So the check should be upper than d->guest_slots[slot_id]
> where size of d->guest_slots is NUM_MEMSLOTS.
> 
> Fixes: e954ea2873 ("qxl: qxl_add_memslot: remove guest trigerrable panics")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Good catch.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

The change is trivial enough for trivial-patches tree,
picked it up if Gerd don't mind.

/mjt

>   hw/display/qxl.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 7bb00d68f5..dc618727c0 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -1309,16 +1309,17 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
>       QXLDevMemSlot memslot;
>       int i;
>   
> -    guest_start = le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
> -    guest_end   = le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);
> -
> -    trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);
> -
>       if (slot_id >= NUM_MEMSLOTS) {
>           qxl_set_guest_bug(d, "%s: slot_id >= NUM_MEMSLOTS %d >= %d", __func__,
>                         slot_id, NUM_MEMSLOTS);
>           return 1;
>       }
> +
> +    guest_start = le64_to_cpu(d->guest_slots[slot_id].slot.mem_start);
> +    guest_end   = le64_to_cpu(d->guest_slots[slot_id].slot.mem_end);
> +
> +    trace_qxl_memslot_add_guest(d->id, slot_id, guest_start, guest_end);
> +
>       if (guest_start > guest_end) {
>           qxl_set_guest_bug(d, "%s: guest_start > guest_end 0x%" PRIx64
>                            " > 0x%" PRIx64, __func__, guest_start, guest_end);



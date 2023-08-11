Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F281E7791E3
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:30:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUT8m-0006g0-0W; Fri, 11 Aug 2023 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qUT8h-0006fi-5b
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:29:19 -0400
Received: from relay8-d.mail.gandi.net ([2001:4b98:dc4:8::228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qUT8d-0004OU-PD
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:29:18 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 231F51BF206;
 Fri, 11 Aug 2023 14:29:06 +0000 (UTC)
Message-ID: <cacf01d2-7ce3-b0c5-cdc3-b855a27872e9@ovn.org>
Date: Fri, 11 Aug 2023 16:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: don't zero out memory region cache for indirect
 descriptors
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20230807222847.2837393-1-i.maximets@ovn.org>
 <20230810155048.GI2931656@fedora>
 <3479fe54-66c5-4c17-8972-2c5d22028bdd@ovn.org>
 <CAJSP0QXi9PKShUgtVf6DVsNOEW3-AT8+rbdFU1GHgmD0J-G8MQ@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <CAJSP0QXi9PKShUgtVf6DVsNOEW3-AT8+rbdFU1GHgmD0J-G8MQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: neutral client-ip=2001:4b98:dc4:8::228;
 envelope-from=i.maximets@ovn.org; helo=relay8-d.mail.gandi.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.972,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_NEUTRAL=0.779 autolearn=ham autolearn_force=no
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

On 8/11/23 15:58, Stefan Hajnoczi wrote:
> 
> 
> On Fri, Aug 11, 2023, 08:50 Ilya Maximets <i.maximets@ovn.org <mailto:i.maximets@ovn.org>> wrote:
> 
>     On 8/10/23 17:50, Stefan Hajnoczi wrote:
>     > On Tue, Aug 08, 2023 at 12:28:47AM +0200, Ilya Maximets wrote:
>     >> Lots of virtio functions that are on a hot path in data transmission
>     >> are initializing indirect descriptor cache at the point of stack
>     >> allocation.  It's a 112 byte structure that is getting zeroed out on
>     >> each call adding unnecessary overhead.  It's going to be correctly
>     >> initialized later via special init function.  The only reason to
>     >> actually initialize right away is the ability to safely destruct it.
>     >> However, we only need to destruct it when it was used, i.e. when a
>     >> desc_cache points to it.
>     >>
>     >> Removing these unnecessary stack initializations improves throughput
>     >> of virtio-net devices in terms of 64B packets per second by 6-14 %
>     >> depending on the case.  Tested with a proposed af-xdp network backend
>     >> and a dpdk testpmd application in the guest, but should be beneficial
>     >> for other virtio devices as well.
>     >>
>     >> Signed-off-by: Ilya Maximets <i.maximets@ovn.org <mailto:i.maximets@ovn.org>>
>     >> ---
>     >>  hw/virtio/virtio.c | 42 +++++++++++++++++++++++++++---------------
>     >>  1 file changed, 27 insertions(+), 15 deletions(-)
>     >
>     > Another option is to create an address_space_cache_init_invalid()
>     > function that only assigns mrs.mr <http://mrs.mr> = NULL instead of touching all bytes
>     > of the struct like = MEMORY_REGION_CACHE_INVALID. There would be less
>     > code and the existing mrs.mr <http://mrs.mr> check in address_space_cache_destroy()
>     > would serve the same function as the desc_cache == &indirect_desc_cache
>     > check added by this patch.
> 
>     It does look simpler this way, indeed.  Though I'm not sure about
>     a function name.  We have address_space_cache_invalidate() that
>     does a completely different thing and the invalidated cache can
>     still be used, while the cache initialized with the newly proposed
>     address_space_cache_init_invalid() can not be safely used.
> 
>     I suppose, the problem is not new, since the macro was named similarly,
>     but making it a function seems to make the issue worse.
> 
>     Maybe address_space_cache_init_empty() will be a better name?
>     E.g.:
> 
>     **
>      * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
>      *
>      * @cache: The #MemoryRegionCache to operate on.
>      *
>      * Initializes #MemoryRegionCache structure without memory region attached.
>      * Cache initialized this way can only be safely destroyed, but not used.
>      */
>     static inline void address_space_cache_init_empty(MemoryRegionCache *cache)
>     {
>         cache->mrs.mr = NULL;
>     }
> 
>     What do you think?
> 
> 
> init_empty() is good.

I'll use it then.  Will send a v2 shortly.

Thanks!

> 
> Stefan
> 



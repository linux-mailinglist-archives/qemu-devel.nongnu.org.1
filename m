Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B77CD27E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 05:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qswpd-0003Sq-LL; Tue, 17 Oct 2023 23:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qswpb-0003Si-9K
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 23:02:47 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qswpY-0001V0-GG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 23:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697598164; x=1729134164;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=yEI+yEemqR/SBOd6jr/pk8cn4/9Ka28ZBbLWw2kl8uw=;
 b=DioMOlgGHd6eZbvxhWogw/L3oLFJ632+LxC23fD9zL9iVetBMb5fBSvI
 7m3CkNlQGBeL3cEi370kizUrtPjfSfAxRXjlSnaoPPbxJWamaq321nkPv
 TnU7pG85yb8v38GvemfWF9UtFlHoQCazA24IzhPoX4wlgmZYqQfTVDnTu
 ne9WSwaS7m4VCrHjqE0DWare/LmqTGH/6LDH3YWLQqmHTsK5VrtugJIVQ
 03cUNIIeQJebDpP29rfwY/fAqwFgdAmKliDjtVx1nUjbCtATQNct5AyZ9
 BCgWFrrkQeuU2FryHdRyDZ+NRBOqQRL9LtmBan1rGtWo0kM3PiKLa3Vxa g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389801248"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="389801248"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 20:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="822249380"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="822249380"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.19.128])
 ([10.93.19.128])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 20:02:36 -0700
Message-ID: <a23ee3d1-e03b-4442-bdec-341b3e52d3e0@intel.com>
Date: Wed, 18 Oct 2023 11:02:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230706075612.67404-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

David,

On 7/6/2023 3:56 PM, David Hildenbrand wrote:
> ram_block_discard_range() cannot possibly do the right thing in
> MAP_PRIVATE file mappings in the general case.
> 
> To achieve the documented semantics, we also have to punch a hole into
> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
> of such a file.
> 
> For example, using VM templating -- see commit b17fbbe55cba ("migration:
> allow private destination ram with x-ignore-shared") -- in combination with
> any mechanism that relies on discarding of RAM is problematic. This
> includes:
> * Postcopy live migration
> * virtio-balloon inflation/deflation or free-page-reporting
> * virtio-mem
> 
> So at least warn that there is something possibly dangerous is going on
> when using ram_block_discard_range() in these cases.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   softmmu/physmem.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index bda475a719..4ee157bda4 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -3456,6 +3456,24 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
>                * so a userfault will trigger.
>                */
>   #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +            /*
> +             * We'll discard data from the actual file, even though we only
> +             * have a MAP_PRIVATE mapping, possibly messing with other
> +             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
> +             * change that behavior whithout violating the promised
> +             * semantics of ram_block_discard_range().
> +             *
> +             * Only warn, because it work as long as nobody else uses that
> +             * file.
> +             */
> +            if (!qemu_ram_is_shared(rb)) {
> +                warn_report_once("ram_block_discard_range: Discarding RAM"
> +                                 " in private file mappings is possibly"
> +                                 " dangerous, because it will modify the"
> +                                 " underlying file and will affect other"
> +                                 " users of the file");
> +            }
> +

TDX has two types of memory backend for each RAM, shared memory and 
private memory. Private memory is serviced by guest memfd and shared 
memory can also be backed with a fd.

At any time, only one type needs to be valid, which means the opposite 
can be discarded. We do implement the memory discard when TDX converts 
the memory[1]. It will trigger this warning 100% because by default the 
guest memfd is not mapped as shared (MAP_SHARED).

Simply remove the warning will fail the purpose of this patch. The other 
option is to skip the warning for TDX case, which looks vary hacky. Do 
you have any idea?

[1] 
https://lore.kernel.org/all/20230914035117.3285885-18-xiaoyao.li@intel.com/

>               ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                               start, length);
>               if (ret) {



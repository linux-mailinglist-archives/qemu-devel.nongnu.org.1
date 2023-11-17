Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28B7EF922
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 22:04:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r45ze-0005Yr-6G; Fri, 17 Nov 2023 16:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r45zb-0005YH-Mx
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 16:03:11 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1r45zZ-0005At-8m
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 16:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700254989; x=1731790989;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7JF/vWM+ZZeUdd9cPjB6/JC44J5sV6hwsvD6NCm73yU=;
 b=T/4QoICg0Ve5D1vOgdYYHLXaMKLMvu+T+hbCKMl47AOEjTBJgLJK9iWq
 Sx5MqjUeu/018rQszYzkvpqOMokCy3RVGmDO4d4fgt4zJZPHvcNhWKopb
 Eo8nar2uB6oF5xLaAb0630Mq07Ia1KP1wscH2ePmyWMRBfo6Ic1kIq5s6
 EmJJAvm5UX1SjMBl4pNaDqrE7bwJWw9o6HOzNyvIWJuTGpNm8lTs0dSPg
 NDmdsnXaEn63px5KXj2YG9acSGYRKk9LK7VXrn7ENgmtobM24Du2aV1t5
 ystX/kOkfndPFBVWFbQHhKpMo/XRVXjAUu/jPKvJYABPVU/WaJEJo6/iQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="391151605"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="391151605"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 13:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1013042135"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="1013042135"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 13:03:04 -0800
Date: Fri, 17 Nov 2023 13:03:04 -0800
From: Isaku Yamahata <isaku.yamahata@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@linux.intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v3 09/70] physmem: Introduce ram_block_convert_range()
 for page conversion
Message-ID: <20231117210304.GC1645850@ls.amr.corp.intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-10-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231115071519.2864957-10-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=isaku.yamahata@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Nov 15, 2023 at 02:14:18AM -0500,
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> It's used for discarding opposite memory after memory conversion, for
> confidential guest.
> 
> When page is converted from shared to private, the original shared
> memory can be discarded via ram_block_discard_range();
> 
> When page is converted from private to shared, the original private
> memory is back'ed by guest_memfd. Introduce
> ram_block_discard_guest_memfd_range() for discarding memory in
> guest_memfd.
> 
> Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  include/exec/cpu-common.h |  2 ++
>  system/physmem.c          | 50 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 41115d891940..de728a18eef2 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -175,6 +175,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
>  
>  int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
>  int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
> +int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
> +                            bool shared_to_private);
>  
>  #endif
>  
> diff --git a/system/physmem.c b/system/physmem.c
> index ddfecddefcd6..cd6008fa09ad 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3641,6 +3641,29 @@ err:
>      return ret;
>  }
>  
> +static int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
> +                                               size_t length)
> +{
> +    int ret = -1;
> +
> +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> +    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +                    start, length);
> +
> +    if (ret) {
> +        ret = -errno;
> +        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
> +                     __func__, rb->idstr, start, length, ret);
> +    }
> +#else
> +    ret = -ENOSYS;
> +    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
> +                 __func__, rb->idstr, start, length, ret);
> +#endif
> +
> +    return ret;
> +}
> +
>  bool ramblock_is_pmem(RAMBlock *rb)
>  {
>      return rb->flags & RAM_PMEM;
> @@ -3828,3 +3851,30 @@ bool ram_block_discard_is_required(void)
>      return qatomic_read(&ram_block_discard_required_cnt) ||
>             qatomic_read(&ram_block_coordinated_discard_required_cnt);
>  }
> +
> +int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
> +                            bool shared_to_private)
> +{
> +    if (!rb || rb->guest_memfd < 0) {
> +        return -1;
> +    }
> +
> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_host_page_size) ||
> +        !QEMU_PTR_IS_ALIGNED(length, qemu_host_page_size)) {
> +        return -1;
> +    }
> +
> +    if (!length) {
> +        return -1;
> +    }
> +
> +    if (start + length > rb->max_length) {
> +        return -1;
> +    }
> +
> +    if (shared_to_private) {
> +        return ram_block_discard_range(rb, start, length);
> +    } else {
> +        return ram_block_discard_guest_memfd_range(rb, start, length);
> +    }
> +}

Originally this function issued KVM_SET_MEMORY_ATTRIBUTES, the function name
mad sense. But now it doesn't, and it issues only punch hole. We should rename
it to represent what it actually does. discard_range?
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>


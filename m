Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A178266A
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 11:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY1Mo-0008Pa-8n; Mon, 21 Aug 2023 05:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1Mm-0008PM-D2
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qY1Mj-0006TP-Qr
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 05:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692610708;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R2brJ+XSxT0BCix3/bDQpxgcg7IYxyY9nHO9hl4iHpo=;
 b=a8ij3rrgbQMyMV6tsKY9y905yhAGyNG0nWyQk1Al4msMM2bpc+2h0pmRFhwbLDAaEn0sMy
 oUVC3gCQatESZsVOd8ReS25m+kEPvPKbOmKzyiGjJmdnklUfP4kw7JXCsI/rvAUmW1LB5U
 0y8vSAkbAlYKYlNmbsfc1nA+kSuyzdA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-xPJoeZ4kMByDKf4SCIkV0A-1; Mon, 21 Aug 2023 05:38:24 -0400
X-MC-Unique: xPJoeZ4kMByDKf4SCIkV0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71A7E3815EE7;
 Mon, 21 Aug 2023 09:38:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC418492C13;
 Mon, 21 Aug 2023 09:38:20 +0000 (UTC)
Date: Mon, 21 Aug 2023 10:38:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Eduardo Habkost <eduardo@habkost.net>,
 Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v2 32/58] i386/tdx: Track RAM entries for TDX VM
Message-ID: <ZOMwin3eGaYLNNQh@redhat.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-33-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230818095041.1973309-33-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 18, 2023 at 05:50:15AM -0400, Xiaoyao Li wrote:
> The RAM of TDX VM can be classified into two types:
> 
>  - TDX_RAM_UNACCEPTED: default type of TDX memory, which needs to be
>    accepted by TDX guest before it can be used and will be all-zeros
>    after being accepted.
> 
>  - TDX_RAM_ADDED: the RAM that is ADD'ed to TD guest before running, and
>    can be used directly. E.g., TD HOB and TEMP MEM that needed by TDVF.
> 
> Maintain TdxRamEntries[] which grabs the initial RAM info from e820 table
> and mark each RAM range as default type TDX_RAM_UNACCEPTED.
> 
> Then turn the range of TD HOB and TEMP MEM to TDX_RAM_ADDED since these
> ranges will be ADD'ed before TD runs and no need to be accepted runtime.
> 
> The TdxRamEntries[] are later used to setup the memory TD resource HOB
> that passes memory info from QEMU to TDVF.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> ---
> Changes from RFC v4:
>   - simplify the algorithm of tdx_accept_ram_range() (Suggested-by: Gerd Hoffman)
>     (1) Change the existing entry to cover the accepted ram range.
>     (2) If there is room before the accepted ram range add a
> 	TDX_RAM_UNACCEPTED entry for that.
>     (3) If there is room after the accepted ram range add a
> 	TDX_RAM_UNACCEPTED entry for that.
> ---
>  target/i386/kvm/tdx.c | 110 ++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.h |  14 ++++++
>  2 files changed, 124 insertions(+)
> 
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index bb806736b4ff..ed617ebab266 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> +static int tdx_accept_ram_range(uint64_t address, uint64_t length)
> +{
> +    uint64_t head_start, tail_start, head_length, tail_length;
> +    uint64_t tmp_address, tmp_length;
> +    TdxRamEntry *e;
> +    int i;
> +
> +    for (i = 0; i < tdx_guest->nr_ram_entries; i++) {
> +        e = &tdx_guest->ram_entries[i];
> +
> +        if (address + length <= e->address ||
> +            e->address + e->length <= address) {
> +                continue;

Indented too far

> +        }
> +
> +        /*
> +         * The to-be-accepted ram range must be fully contained by one
> +         * RAM entry.
> +         */
> +        if (e->address > address ||
> +            e->address + e->length < address + length) {
> +            return -EINVAL;
> +        }
> +
> +        if (e->type == TDX_RAM_ADDED) {
> +            return -EINVAL;
> +        }
> +
> +        break;
> +    }
> +
> +    if (i == tdx_guest->nr_ram_entries) {
> +        return -1;
> +    }
> +
> +    tmp_address = e->address;
> +    tmp_length = e->length;
> +
> +    e->address = address;
> +    e->length = length;
> +    e->type = TDX_RAM_ADDED;
> +
> +    head_length = address - tmp_address;
> +    if (head_length > 0) {
> +        head_start = tmp_address;
> +        tdx_add_ram_entry(head_start, head_length, TDX_RAM_UNACCEPTED);
> +    }
> +
> +    tail_start = address + length;
> +    if (tail_start < tmp_address + tmp_length) {
> +        tail_length = tmp_address + tmp_length - tail_start;
> +        tdx_add_ram_entry(tail_start, tail_length, TDX_RAM_UNACCEPTED);
> +    }
> +
> +    return 0;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



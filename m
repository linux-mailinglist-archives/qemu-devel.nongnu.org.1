Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1E8769D2D
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQW7Y-0001GN-FI; Mon, 31 Jul 2023 12:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQW7Q-0001Ez-Bz
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQW7O-0005dK-LX
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690822297;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JvLXCcMmGv5hKdcLx3cUZEwjA2OrWpQwWaxNmIEK5uM=;
 b=VW08Inc12NKBgAY0LFEg4I0s2ZMV9Xm3nPBw8aJbvSfY5Xi9BCJsGyTbpNbm2UqBEemgyB
 VCw958mTws/pdBaGySVF/9hAnZoZWklsI7PLu8UekH0mJC+DiIcVZo+a/GM5Ke3SmUsJng
 ne+rvfO14VXZRNBPeDbDycaaKfIrZj4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-R0vH1opIM9S4G6o22AH58g-1; Mon, 31 Jul 2023 12:51:34 -0400
X-MC-Unique: R0vH1opIM9S4G6o22AH58g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64C5F894EDC;
 Mon, 31 Jul 2023 16:51:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 261BB1121325;
 Mon, 31 Jul 2023 16:51:31 +0000 (UTC)
Date: Mon, 31 Jul 2023 17:51:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 00/19] QEMU gmem implemention
Message-ID: <ZMfmkCQImgsinE6T@redhat.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jul 31, 2023 at 12:21:42PM -0400, Xiaoyao Li wrote:
> This is the first RFC version of enabling KVM gmem[1] as the backend for
> private memory of KVM_X86_PROTECTED_VM.
> 
> It adds the support to create a specific KVM_X86_PROTECTED_VM type VM,
> and introduces 'private' property for memory backend. When the vm type
> is KVM_X86_PROTECTED_VM and memory backend has private enabled as below,
> it will call KVM gmem ioctl to allocate private memory for the backend.
> 
>     $qemu -object memory-backend-ram,id=mem0,size=1G,private=on \
>           -machine q35,kvm-type=sw-protected-vm,memory-backend=mem0 \
> 	  ...
> 
> Unfortunately this patch series fails the boot of OVMF at very early
> stage due to triple fault because KVM doesn't support emulate string IO
> to private memory. We leave it as an open to be discussed.
> 
> There are following design opens that need to be discussed:
> 
> 1. how to determine the vm type?
> 
>    a. like this series, specify the vm type via machine property
>       'kvm-type'
>    b. check the memory backend, if any backend has 'private' property
>       set, the vm-type is set to KVM_X86_PROTECTED_VM.
> 
> 2. whether 'private' property is needed if we choose 1.b as design 
> 
>    with 1.b, QEMU can decide whether the memory region needs to be
>    private (allocates gmem fd for it) or not, on its own.
> 
> 3. What is KVM_X86_SW_PROTECTED_VM going to look like? What's the
>    purose of it and what's the requirement on it. I think it's the
>    questions for KVM folks than QEMU folks.
> 
> Any other idea/open/question is welcomed.
> 
> 
> Beside, TDX QEMU implemetation is based on this series to provide
> private gmem for TD private memory, which can be found at [2].
> And it can work corresponding KVM [3] to boot TDX guest. 

We already have a general purpose configuration mechanism for
confidential guests.  The -machine argument has a property
confidential-guest-support=$OBJECT-ID, for pointing to an
object that implements the TYPE_CONFIDENTIAL_GUEST_SUPPORT
interface in QEMU. This is implemented with SEV, PPC PEF
mode, and s390 protvirt.

I would expect TDX to follow this same design ie

    qemu-system-x86_64 \
      -object tdx-guest,id=tdx0,..... \
      -machine q35,confidential-guest-support=tdx0 \
      ...

and not require inventing the new 'kvm-type' attribute at least.

For the memory backend though, I'm not so sure - possibly that
might be something that still wants an extra property to identify
the type of memory to allocate, since we use memory-backend-ram
for a variety of use cases.  Or it could be an entirely new object
type such as "memory-backend-gmem"


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



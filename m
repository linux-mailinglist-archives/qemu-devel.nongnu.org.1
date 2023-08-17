Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C585C77F93D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:38:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWe7q-00065R-O3; Thu, 17 Aug 2023 10:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWe7o-0005w6-MH
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWe7h-0002ep-F9
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692283031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QBUrMoyeKjffl4+4/yBgfWxxgvb+P92Ut4EhRVLrgDY=;
 b=CgRtUIW1lGAv4ygw5bGQYqfU9jqdVq1cdl7dy3+WauuJnRH8jKHwEO1B+21ia/x5gRLtdj
 L/ApBensua733LxmKuo/S5dsH3+1YlQ43BdoaCM2V/ByfUVT6djZhc21CKNcSQwfmmJfjt
 0j8/FduJzDoXW0Ro/LU8v3KC55n6nAA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-ACzNB5ssP9Om-0nXlR9CqA-1; Thu, 17 Aug 2023 10:37:08 -0400
X-MC-Unique: ACzNB5ssP9Om-0nXlR9CqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4E953815EF3;
 Thu, 17 Aug 2023 14:37:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A2F2166B2D;
 Thu, 17 Aug 2023 14:37:06 +0000 (UTC)
Date: Thu, 17 Aug 2023 15:37:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZN4wkI679/6j6+b+@redhat.com>
References: <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <c92648e5-e974-48ac-2213-b5926a16ed4d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c92648e5-e974-48ac-2213-b5926a16ed4d@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 17, 2023 at 04:30:16PM +0200, David Hildenbrand wrote:
> 
> > @Stefan, do you have any concern when we would do 1) ?
> > 
> > As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
> > 
> > +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
> > +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
> > +   persistent writes. Linux guest drivers set the device to read-only when this
> > +   bit is present. Set unarmed to on when the memdev has readonly=on.
> > 
> > So changing the behavior would not really break the nvdimm use case.
> 
> Looking into the details, this seems to be the right thing to do.
> 
> This is what I have now as patch description, that also highlights how libvirt
> doesn't even make use of readonly=true.
> 
> 
> From 42f272ace68e0cd660a8448adb5aefb3b9dd7005 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Thu, 17 Aug 2023 12:09:07 +0200
> Subject: [PATCH v2 2/4] backends/hostmem-file: Make share=off,readonly=on
>  result in RAM instead of ROM
> 
> For now, "share=off,readonly=on" would always result in us opening the
> file R/O and mmap'ing the opened file MAP_PRIVATE R/O -- effectively
> turning it into ROM.
> 
> As documented, readonly only specifies that we want to open the file R/O:
> 
>     @readonly: if true, the backing file is opened read-only; if false,
>         it is opened read-write.  (default: false)
> 
> Especially for VM templating, "share=off" is a common use case. However,
> that use case is impossible with files that lack write permissions,
> because "share=off,readonly=off" will fail opening the file, and
> "share=off,readonly=on" will give us ROM instead of RAM.
> 
> With MAP_PRIVATE we can easily open the file R/O and mmap it R/W, to
> turn it into COW RAM: private changes don't affect the file after all and
> don't require write permissions.
> 
> This implies that we only get ROM now via "share=on,readonly=on".
> "share=off,readonly=on" will give us RAM.
> 
> The sole user of ROM via memory-backend-file are R/O NVDIMMs. They
> also require "unarmed=on" to be set for the nvdimm device.
> 
> With this change, R/O NVDIMMs will continue working even if
> "share=off,readonly=on" was specified similar to when simply
> providing ordinary RAM to the nvdimm device and setting "unarmed=on".
> 
> Note that libvirt seems to default for a "readonly" nvdimm to
> * -object memory-backend-file,share=off (implying readonly=off)
> * -device nvdimm,unarmed=on
> And never seems to even set "readonly=on" for memory-backend-file. So
> this change won't affect libvirt, they already always get COW RAM -- not
> modifying the underlying file but opening it R/O.
> 
> If someone really wants ROM, they can just use "share=on,readonly=on".
> After all, there is not relevant difference between a R/O MAP_SHARED
> file mapping and a R/O MAP_PRIVATE file mapping.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

This still leaves the patch having a warn_report() which I think is
undesirable to emit in a valid / supported use case.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



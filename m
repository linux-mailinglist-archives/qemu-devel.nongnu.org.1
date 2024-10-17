Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EDF9A2690
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Oct 2024 17:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1SPl-0003aq-3q; Thu, 17 Oct 2024 11:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1SPj-0003Zq-7X
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1SPg-0002oE-Sc
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 11:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729178862;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2hqjuI+0DE4xj9nC242F59bUCqjvPn6E1OOsFI7D9lQ=;
 b=cLYkUI+A7nqeEBehTKC+kl+maAGG3mC86UUIpsiEWGWLd0bWWZLSAZnWqoJachtIwdIvCf
 +Rcick64m5bEj0hZKtP5HcKU+b59fpQbip4Uk+vZ+FmY1kalNPoRXACn5gHMZGMSt8rIzI
 mhSsbSVbMFBWcdDIZ2yhl/JUFHQfaK0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-28IWBqzCPGeLoyD-s9Kbew-1; Thu,
 17 Oct 2024 11:27:39 -0400
X-MC-Unique: 28IWBqzCPGeLoyD-s9Kbew-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 515DB1955F41; Thu, 17 Oct 2024 15:27:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.94])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3DB31300018D; Thu, 17 Oct 2024 15:27:27 +0000 (UTC)
Date: Thu, 17 Oct 2024 16:27:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v3 6/7] i386/pc: Support cache topology in -machine for
 PC machine
Message-ID: <ZxEs3DGGgCqGT5yK@redhat.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-7-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241012104429.1048908-7-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Oct 12, 2024 at 06:44:28PM +0800, Zhao Liu wrote:
> Allow user to configure l1d, l1i, l2 and l3 cache topologies for PC
> machine.
> 
> Additionally, add the document of "-machine smp-cache" in
> qemu-options.hx.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes since Patch v2:
>  * Polished the document. (Jonathan)
> 
> Changes since Patch v1:
>  * Merged document into this patch. (Markus)
> 
> Changes since RFC v2:
>  * Used cache_supported array.
> ---
>  hw/i386/pc.c    |  4 ++++
>  qemu-options.hx | 26 +++++++++++++++++++++++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
>              -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512
> +
> +    ``smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel``
> +        Define cache properties for SMP system.
> +
> +        ``cache=cachename`` specifies the cache that the properties will be
> +        applied on. This field is the combination of cache level and cache
> +        type. It supports ``l1d`` (L1 data cache), ``l1i`` (L1 instruction
> +        cache), ``l2`` (L2 unified cache) and ``l3`` (L3 unified cache).
> +
> +        ``topology=topologylevel`` sets the cache topology level. It accepts
> +        CPU topology levels including ``thread``, ``core``, ``module``,
> +        ``cluster``, ``die``, ``socket``, ``book``, ``drawer`` and a special
> +        value ``default``. If ``default`` is set, then the cache topology will
> +        follow the architecture's default cache topology model. If another
> +        topology level is set, the cache will be shared at corresponding CPU
> +        topology level. For example, ``topology=core`` makes the cache shared
> +        by all threads within a core.
> +
> +        Example:
> +
> +        ::
> +
> +            -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core

There are 4 cache types, l1d, l1i, l2, l3.

In this example you've only set properties for l1d, l1i caches.

What does this mean for l2 / l3 caches ?

Are they reported as not existing, or are they to be reported at
some built-in default topology level. If the latter, how does the
user know what that built-in default is, and avoid nonsense like
l1d being at socket level, and l3 being at the core level ? Can
we explicitly disable a l2/l3 cache, or must it always exists ?

The QAPI has an "invalid" topology level. You've not documented
that as permitted here, but the qapi parser will happily allow
it. What semantics will that have ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



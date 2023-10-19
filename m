Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6F7CFD5B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUNy-0001T2-6q; Thu, 19 Oct 2023 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtUNt-0001Dz-RH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qtUNs-0006r2-1R
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697727143;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=30zhS09/o2RZjGX/T6liKqJmGgqeMBJz2kuNpjtRqCo=;
 b=WD28a/sQ3xzVytwsUPiKOmh3w1qxCdqaSfMvoLQCNfxqm0OY19HISQHlJzT7ZyBWvayw3v
 cA3JOcqCVeh36v2kfHP3aavXBeA7MW41g3WwapHiZ9QAe0P++R8DGckmv63l4qpQaD7ect
 dgsAdY9zy84Z6zwaKulBxrn1IvIbJdc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-1MTJXhm5M0yAzvrgYUxrLA-1; Thu, 19 Oct 2023 10:52:19 -0400
X-MC-Unique: 1MTJXhm5M0yAzvrgYUxrLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC8BC10201F0;
 Thu, 19 Oct 2023 14:52:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBF2540C6F7B;
 Thu, 19 Oct 2023 14:52:16 +0000 (UTC)
Date: Thu, 19 Oct 2023 15:52:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Yuan Liu <yuan1.liu@intel.com>, peterx@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org, nanhai.zou@intel.com
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Message-ID: <ZTFCnqbbqlmsUkRC@redhat.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cyxa6dso.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Oct 19, 2023 at 01:40:23PM +0200, Juan Quintela wrote:
> Yuan Liu <yuan1.liu@intel.com> wrote:
> > Hi,
> >
> > I am writing to submit a code change aimed at enhancing live migration
> > acceleration by leveraging the compression capability of the Intel
> > In-Memory Analytics Accelerator (IAA).
> >
> > Enabling compression functionality during the live migration process can
> > enhance performance, thereby reducing downtime and network bandwidth
> > requirements. However, this improvement comes at the cost of additional
> > CPU resources, posing a challenge for cloud service providers in terms of
> > resource allocation. To address this challenge, I have focused on offloading
> > the compression overhead to the IAA hardware, resulting in performance gains.
> >
> > The implementation of the IAA (de)compression code is based on Intel Query
> > Processing Library (QPL), an open-source software project designed for
> > IAA high-level software programming.
> >
> > Best regards,
> > Yuan Liu
> 
> After reviewing the patches:
> 
> - why are you doing this on top of old compression code, that is
>   obsolete, deprecated and buggy
> 
> - why are you not doing it on top of multifd.
> 
> You just need to add another compression method on top of multifd.
> See how it was done for zstd:

I'm not sure that is ideal approach.  IIUC, the IAA/QPL library
is not defining a new compression format. Rather it is providing
a hardware accelerator for 'deflate' format, as can be made
compatible with zlib:

  https://intel.github.io/qpl/documentation/dev_guide_docs/c_use_cases/deflate/c_deflate_zlib_gzip.html#zlib-and-gzip-compatibility-reference-link

With multifd we already have a 'zlib' compression format, and so
this IAA/QPL logic would effectively just be a providing a second
implementation of zlib.

Given the use of a standard format, I would expect to be able
to use software zlib on the src, mixed with IAA/QPL zlib on
the target, or vica-verca.

IOW, rather than defining a new compression format for this,
I think we could look at a new migration parameter for

"compression-accelerator": ["auto", "none", "qpl"]

with 'auto' the default, such that we can automatically enable
IAA/QPL when 'zlib' format is requested, if running on a suitable
host.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



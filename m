Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740AC7D2FEA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 12:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qusCV-0003sj-Ug; Mon, 23 Oct 2023 06:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qusCR-0003s4-Bl
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qusCN-0008Pi-2U
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 06:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698057012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngrzek2AH0ra100BB2zUNnm1vbQMvZi/VznuLHeTwZA=;
 b=gNv1xgrkXP8kn6h4R46M/smmQ/qsfGtxuI01j6aqse1ldFwKbfu7MF6t7iuHmTtY8UxQFF
 EJcvm1ILJRREp1GLN1bqjxqjmGh6RwzDr6N27pO+TDwQwN1U36jzmgn+b0wyBmYWT0ydT0
 I4GYKdyfr4cmwWjUn5GK/PglkBZZ6M8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-t8OHTqFCPoGx-Lt0hzwlAg-1; Mon, 23 Oct 2023 06:30:10 -0400
X-MC-Unique: t8OHTqFCPoGx-Lt0hzwlAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08F03811E94;
 Mon, 23 Oct 2023 10:30:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCE641121314;
 Mon, 23 Oct 2023 10:30:07 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:29:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "leobras@redhat.com" <leobras@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Message-ID: <ZTZLI1r+U5EbX12E@redhat.com>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
 <ZTFJ84SnSOAcU5gY@x1n> <ZTFL+N3mxESxXpfv@redhat.com>
 <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BY5PR11MB4388F9495DD42ACCFB980A6CA3D8A@BY5PR11MB4388.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

On Mon, Oct 23, 2023 at 08:33:44AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > Sent: Thursday, October 19, 2023 11:32 PM
> > To: Peter Xu <peterx@redhat.com>
> > Cc: Juan Quintela <quintela@redhat.com>; Liu, Yuan1
> > <yuan1.liu@intel.com>; farosas@suse.de; leobras@redhat.com; qemu-
> > devel@nongnu.org; Zou, Nanhai <nanhai.zou@intel.com>
> > Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
> > 
> > On Thu, Oct 19, 2023 at 11:23:31AM -0400, Peter Xu wrote:
> > > On Thu, Oct 19, 2023 at 03:52:14PM +0100, Daniel P. Berrangé wrote:
> > > > On Thu, Oct 19, 2023 at 01:40:23PM +0200, Juan Quintela wrote:
> > > > > Yuan Liu <yuan1.liu@intel.com> wrote:
> > > > > > Hi,
> > > > > >
> > > > > > I am writing to submit a code change aimed at enhancing live
> > > > > > migration acceleration by leveraging the compression capability
> > > > > > of the Intel In-Memory Analytics Accelerator (IAA).
> > > > > >
> > > > > > Enabling compression functionality during the live migration
> > > > > > process can enhance performance, thereby reducing downtime and
> > > > > > network bandwidth requirements. However, this improvement comes
> > > > > > at the cost of additional CPU resources, posing a challenge for
> > > > > > cloud service providers in terms of resource allocation. To
> > > > > > address this challenge, I have focused on offloading the compression
> > overhead to the IAA hardware, resulting in performance gains.
> > > > > >
> > > > > > The implementation of the IAA (de)compression code is based on
> > > > > > Intel Query Processing Library (QPL), an open-source software
> > > > > > project designed for IAA high-level software programming.
> > > > >
> > > > > After reviewing the patches:
> > > > >
> > > > > - why are you doing this on top of old compression code, that is
> > > > >   obsolete, deprecated and buggy
> Some users have not enabled the multifd feature yet, but they will decide whether to enable the compression feature based on the load situation. So I'm wondering if, without multifd, the compression functionality will no longer be available?
> 
> > > > > - why are you not doing it on top of multifd.
> I plan to submit the support for multifd independently because the
> multifd compression and legacy compression code are separate.

So the core question her (for migration maintainers) is whether
contributors should be spending any time at all on non-multifd
code, or if new features should be exclusively for multifd ?

I doesn't make a lot of sense over the long term to have people
spending time implementing the same features twice. IOW, should
we be directly contributors explicitly towards multifd only,
and even consider deprecating non-multifd code at some time ?

> > > > I'm not sure that is ideal approach.  IIUC, the IAA/QPL library is
> > > > not defining a new compression format. Rather it is providing a
> > > > hardware accelerator for 'deflate' format, as can be made compatible
> > > > with zlib:
> > > >
> > > >
> > > > https://intel.github.io/qpl/documentation/dev_guide_docs/c_use_cases
> > > > /deflate/c_deflate_zlib_gzip.html#zlib-and-gzip-compatibility-refere
> > > > nce-link
> > > >
> > > > With multifd we already have a 'zlib' compression format, and so
> > > > this IAA/QPL logic would effectively just be a providing a second
> > > > implementation of zlib.
> > > >
> > > > Given the use of a standard format, I would expect to be able to use
> > > > software zlib on the src, mixed with IAA/QPL zlib on the target, or
> > > > vica-verca.
> > > >
> > > > IOW, rather than defining a new compression format for this, I think
> > > > we could look at a new migration parameter for
> > > >
> > > > "compression-accelerator": ["auto", "none", "qpl"]
> > > >
> > > > with 'auto' the default, such that we can automatically enable
> > > > IAA/QPL when 'zlib' format is requested, if running on a suitable
> > > > host.
> > >
> > > I was also curious about the format of compression comparing to
> > > software ones when reading.
> > >
> > > Would there be a use case that one would prefer soft compression even
> > > if hardware accelerator existed, no matter on src/dst?
> > >
> > > I'm wondering whether we can avoid that one more parameter but always
> > > use hardware accelerations as long as possible.
>
> I want to add a new compression format(QPL or IAA-Deflate) here.
> The reasons are as follows:
>
> 1. The QPL library already supports both software and hardware paths
>    for compression. The software path uses a fast Deflate compression
>    algorithm, while the hardware path uses IAA.

That's not a reason to describe this as a new format in QEMU. It is
still deflate, and so conceptually we can model this as 'zlib' and
potentially choose to use QPL automatically.

> 2. QPL's software and hardware paths are based on the Deflate algorithm,
>    but there is a limitation: the history buffer only supports 4K. The
>    default history buffer for zlib is 32K, which means that IAA cannot
>    decompress zlib-compressed data. However, zlib can decompress IAA-
>    compressed data.

That's again not a reason to call it a new compression format in
QEMU. It would mean, however, if compression-accelerator=auto, we
would not be able to safely enable QPL on the incoming QEMU, as we
can't be sure the src used a 4k window.  We could still automatically
enable QPL on outgoing side though.

> 3. For zlib and zstd, Intel QuickAssist Technology can accelerate
>    both of them.

What's the difference between this, and the IAA/QPL ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



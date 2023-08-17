Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3D77F80E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:47:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdLg-0001ns-V8; Thu, 17 Aug 2023 09:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWdL8-0001mx-8v
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWdL3-0003Jj-8K
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692280020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uIEGijxT2vcM6takindhGvdw2ATVkiUSRO3aOsQKUIY=;
 b=N0x2tkxn60QgVaKFvt6J1cC26EPiz3Zjaqvg2GR6pRCXHNAEhcJmcnUEiSfSh56L0gcNUG
 DYWTc9OZbYTYBFJ1Pvw8GzYlR39m5DBvEsqP5Ate9UKDz778K5Vrv4k/DVHr/jon7gsoUV
 iqpm1tl4dFqxHDTDcZ+cSJLtXbAw71k=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-lGxgjeI5PuORKTf69XCK4g-1; Thu, 17 Aug 2023 09:46:59 -0400
X-MC-Unique: lGxgjeI5PuORKTf69XCK4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 047623C0DDAA;
 Thu, 17 Aug 2023 13:46:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3432026D68;
 Thu, 17 Aug 2023 13:46:57 +0000 (UTC)
Date: Thu, 17 Aug 2023 14:46:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZN4k0GzWXo+ufSMW@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Fri, Aug 11, 2023 at 09:00:54PM +0200, David Hildenbrand wrote:
> On 11.08.23 07:49, ThinerLogoer wrote:
> > At 2023-08-11 05:24:43, "Peter Xu" <peterx@redhat.com> wrote:
> > > On Fri, Aug 11, 2023 at 01:06:12AM +0800, ThinerLogoer wrote:
> > > > > I think we have the following options (there might be more)
> > > > > 
> > > > > 1) This patch.
> > > > > 
> > > > > 2) New flag for memory-backend-file. We already have "readonly" and
> > > > > "share=". I'm having a hard time coming up with a good name that really
> > > > > describes the subtle difference.
> > > > > 
> > > > > 3) Glue behavior to the QEMU machine
> > > > > 
> > > > 
> > > > 4) '-deny-private-discard' argv, or environment variable, or both
> > > 
> > > I'd personally vote for (2).  How about "fdperm"?  To describe when we want
> > > to use different rw permissions on the file (besides the access permission
> > > of the memory we already provided with "readonly"=XXX).  IIUC the only sane
> > > value will be ro/rw/default, where "default" should just use the same rw
> > > permission as the memory ("readonly"=XXX).
> > > 
> > > Would that be relatively clean and also work in this use case?
> > > 
> > > (the other thing I'd wish we don't have that fallback is, as long as we
> > > have any of that "fallback" we'll need to be compatible with it since
> > > then, and for ever...)
> > 
> > If it must be (2), I would vote (2) + (4), with (4) adjust the default behavior of said `fdperm`.
> > Mainly because (private+discard) is itself not a good practice and (4) serves
> > as a good tool to help catch existing (private+discard) problems.
> 
> Instead of fdperm, maybe we could find a better name.
> 
> The man page of "open" says: The argument flags must include one of the
> following access modes: O_RDONLY, O_WRONLY, or O_RDWR.  These request
> opening the file read-only, write-only, or read/write, respectively.
> 
> So maybe something a bit more mouthful like "file-access-mode" would be
> better.

I don't think we should directly express the config in terms
of file-access-mode, as that's a low level impl detail. The
required file access mode is an artifact of the higher level
goal, or whether the RAM should be process private vs shared,
and whether we want QEMU to be able to create the backing
file or use pre-create one.

IOW, we should express whether or not we want QEMU to try to
pre-create the file or not.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



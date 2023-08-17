Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5295177F7FA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 15:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdHA-0007UI-PA; Thu, 17 Aug 2023 09:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWdH8-0007U8-Hk
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWdH5-0002Wp-MF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 09:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692279774;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/ict9JKs5OnYOtjMIo1+sZIqkbTSafrdiLqc1ViIFgY=;
 b=BqTNY8Lai+Yp4eeHqDZvKhUMe1cKBVCXZtOCtqN8GoiUoEQQQmNC+Yum0IsnbgAyfdgvAg
 vyE5GH274HqxMnPSI868sKrj0G2XFE9yqa6C0rbkL9FlXH7CXTmgcn9Fcs448MFbuGt65k
 9ZqSbZU9UiTNLkV3+dnaqyiKURIe2ZE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-HA77_ilPNFqwKEUX6VuozA-1; Thu, 17 Aug 2023 09:42:51 -0400
X-MC-Unique: HA77_ilPNFqwKEUX6VuozA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C220B1C06EE8;
 Thu, 17 Aug 2023 13:42:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B97DB40C207A;
 Thu, 17 Aug 2023 13:42:49 +0000 (UTC)
Date: Thu, 17 Aug 2023 14:42:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZN4j1/EpXKTT99BB@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Thu, Aug 10, 2023 at 04:19:45PM +0200, David Hildenbrand wrote:
> > > Most importantly, we won't be corrupting/touching the original file in any
> > > case, because it is R/O.
> > > 
> > > If we really want to be careful, we could clue that behavior to compat
> > > machines. I'm not really sure yet if we really have to go down that path.
> > > 
> > > Any other alternatives? I'd like to avoid new flags where not really
> > > required.
> > 
> > I was just thinking of a new flag. :) So have you already discussed that
> > possibility and decided that not a good idea?
> 
> Not really. I was briefly playing with that idea but already struggled to
> come up with a reasonable name :)
> 
> Less toggles and just have it working nice, if possible.

IMHO having a new flag is desirable, because it is directly
expressing the desired deployment scenario, such tat we get
good error reporting upon deployment mistakes, while at the
same time allowing the readonly usage.

> > The root issue to me here is we actually have two resources (memory map of
> > the process, and the file) but we only have one way to describe the
> > permissions upon the two objects.  I'd think it makes a lot more sense if a
> > new flag is added, when there's a need to differentiate the two.
> > 
> > Consider if you see a bunch of qemu instances with:
> > 
> >    -mem-path $RAM_FILE
> > 
> > On the same host, which can be as weird as it could be to me.. At least
> > '-mem-path' looks still like a way to exclusively own a ram file for an
> > instance. I hesitate the new fallback can confuse people too, while that's
> > so far not the major use case.
> 
> Once I learned that this is not a MAP_SHARED mapping, I was extremely
> confused. For example, vhost-user with "-mem-path" will absolutely not work
> with "-mem-path", even though the documentation explicitly spells that out
> (I still have to send a patch to fix that).
> 
> I guess "-mem-path" was primarily only used to consume hugetlb. Even for
> tmpfs it will already result in a double memory consumption, just like when
> using -memory-backend-memfd,share=no.
> 
> I guess deprecating it was the right decision.

Regardless of whether its deprecated or not, I think its fine to just
say people need to use the more verbose memory-backend-file syntax
if they want to use an unusual deployment configuration where there is
a readonly backing file.

> > Nobody may really rely on any existing behavior of the failure, but
> > changing existing behavior is just always not wanted.  The guideline here
> > to me is: whether we want existing "-mem-path XXX" users to start using the
> > fallback in general?  If it's "no", then maybe it implies a new flag is
> > better?
> 
> I think we have the following options (there might be more)
> 
> 1) This patch.
> 
> 2) New flag for memory-backend-file. We already have "readonly" and
> "share=". I'm having a hard time coming up with a good name that really
> describes the subtle difference.
> 
> 3) Glue behavior to the QEMU machine
> 
> 
> For 3), one option would be to always open a COW file readonly (as Thiner
> originally proposed). We could leave "-mem-path" behavior alone and only
> change memory-backend-file semantics. If the COW file does *not* exist yet,
> we would refuse to create the file like patch 2+3 do. Therefore, no
> ftruncate() errors, and fallocate() errors would always happen.

I'm for (2).


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



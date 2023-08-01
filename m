Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7B76B7BC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:37:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqTl-0002cT-MJ; Tue, 01 Aug 2023 10:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQqTe-0002bf-95
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQqTc-0002wh-AE
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690900555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7OfUZ5+uQV/EyMsIEq9ndq6cUDhTf9K5PI8r2amotw=;
 b=i70cV/mvWgEd0ofY75avyfYjH5QGxAjn6n57gqtTaCPKVpYJnsNJrcSXW1FKed5Efl9QQj
 7jEcovMUnX5nKuybJakuebPUtjmxDLpe/YOaLv6wLLnTzdOrjpJFKvQDrAXTn09oC39DSx
 CjRq0+Ou6oABvUzBGUJ7WVh08bPHd9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-UIkpGWrnOlC-os_--0fIXw-1; Tue, 01 Aug 2023 10:35:50 -0400
X-MC-Unique: UIkpGWrnOlC-os_--0fIXw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D304210504B8;
 Tue,  1 Aug 2023 14:35:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8700A4A9004;
 Tue,  1 Aug 2023 14:35:48 +0000 (UTC)
Date: Tue, 1 Aug 2023 15:35:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/8] gitlab: speed up msys windows jobs with GCC
Message-ID: <ZMkYQoTh+KS9rkLW@redhat.com>
References: <20230801130403.164060-1-berrange@redhat.com>
 <87bkfqyilp.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkfqyilp.fsf@pond.sub.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 01, 2023 at 03:53:22PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This is an alternative and/or complementary to Thomas' proposal
> > to use CLang with msys:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05402.html
> >
> > First of all, the current msys installer we're using is over 12
> > months out of date. Thus after running the install, pacman then
> > replaces most of what we've just installed with new downloaded
> > content. Using the most update installer cuts 3+1/2 minutes off
> > the msys install time - 7 minutes becomes 3+1/2.
> >
> > Secondly, QEMU defaults to compiling with -O2 and this is more
> > computationally expensive for GCC. Switching to -O0 drops the
> > build time from 60 minutes down to 45 minutes.
> 
> From the fine manual[*]: "The effectiveness of some warnings depends on
> optimizations also being enabled.  For example '-Wsuggest-final-types'
> is more effective with link-time optimization and some instances of
> other warnings may not be issued at all unless optimization is enabled.
> While optimization in general improves the efficacy of control and data
> flow sensitive warnings, in some cases it may also cause false
> positives."  Do we care?

In general, yes, we do care.

In this specific case though, we're battling to figure out the lesser
of multiple evils.

Right now we configure with:

  --target-list=x86_64-softmmu --without-default-devices 

and so with optimization enabled, we'll get good warning coverage of
a small amount of code, except we don't because people started
ignoring the msys jobs as they timeout too frequently.

If we can use Thomas' clang switch or my -O0 patches, we can get
within the timeout, so people can trust the job once again. If we
can do both ideas and cut the time even more, then we can enable
more features (perhaps drop --without-default-devices).

So the warnings might not be quite as good, but we'll have the
warnings across a larger amount of code.

Alot of the warnings from the Linux/macOS builds will also apply
in the Windows builds. I think on balance I'd probably prefer us
to build a larger amount of code for Windows. This is in context
of free shared runners at least.

As a more drastic option, we might need to consider using the
Azure credits for Windows  runners too. If we could have bigger
VMs for Windows CI, we can build more and have better warnings
at the same time. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



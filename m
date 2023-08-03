Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EBB76EF7F
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRbCz-0004lB-F6; Thu, 03 Aug 2023 12:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRbCx-0004gp-La
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRbCv-0004PW-WC
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691080189;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TcbmFnILSdagiB7v8cAtN4EWcuyxcYon0uEMHzgwv/E=;
 b=L3JmITBt60gYcneabZAPGxh/pv69YgSrRnrvoNkLu7uQjlB1EyWzPa4N8L+c8yxgPh5xy6
 UmwDBvZ9C2fYmjL/cDCwgDJtool4syelNxfWibee7T/pjaMBct4GTd6K6d3bLPdQdOIJ4w
 4OShsuHb2PVOeYevVoUIcS8nNCKPxlQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-lEb0iJ_qNLOI34cv_SxdVQ-1; Thu, 03 Aug 2023 12:29:45 -0400
X-MC-Unique: lEb0iJ_qNLOI34cv_SxdVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84C65185A793;
 Thu,  3 Aug 2023 16:29:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 570BBC5796C;
 Thu,  3 Aug 2023 16:29:44 +0000 (UTC)
Date: Thu, 3 Aug 2023 17:29:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Message-ID: <ZMvV9h6AtxeuR4Kn@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <ZMd/pdT5DmPxtjYW@redhat.com>
 <925f0feb-b3c1-685e-1261-243963f232f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <925f0feb-b3c1-685e-1261-243963f232f6@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Mon, Jul 31, 2023 at 02:04:42PM +0200, Thomas Huth wrote:
> On 31/07/2023 11.32, Daniel P. Berrangé wrote:
> > On Mon, Jul 31, 2023 at 11:10:58AM +0200, Thomas Huth wrote:
> ...
> > > Or do you see another possibility how we could fix that timeout problem in
> > > the 64-bit MSYS2 job? Still switching to clang, but compiling with
> > > --extra-cflags="-Wno-unknown-attributes" maybe?
> > 
> > I was surprised to see that we're not using ccache in gitlab CI. It wouldn't
> > help the from-clean compile time, but thereafter it ought to help. I'm doing
> > some tests with that to see the impact.
> 
> I tried that two years ago, but the results were rather disappointing:
> 
>  https://lists.nongnu.org/archive/html/qemu-devel/2021-04/msg02189.html
> 
> ... but that was only with the Linux runners. Maybe it helps with the MSYS
> runners?

I've done some tests over the last few days and my results are
rather different.  The speed up is *spectacular* if the hit rate
is high.

eg, consider you are retriggering broadly the same pipeline over &
over with iterations of your patches. eg 99% of the QEMU code
probably doesn't change as you're just re-trying to fix some edge
case in 1 file, and thus you'll get near 100% hit rate.

With such a case I see:

The msys64 job can complete in 24 minutes, instead of 50-60 minutes

The build-system-fedora job can complete in 6 minutes instead of 20
minutes

The build-user-hexagon job can cmplete in 3 minutes instead of 6

Basically a 50% cut in time on all compile jobs I've looked at
so far.

NB, these are both shared runners, since the pipeline is in my
fork. I've no idea what the impact will be on the Azure private
runners for upstream.

Given the CI limitations these days, such a speedup is massively
beneficial for our contributors though.

The downside is storage for the cache. In theory gitlab has defined
a quota for storage per account. In practice they are still yet to
enforce that. If they do ever enforce it, we're likely doomed as
our container images alone will exceed it several times over, let
alone leave room for build logs, job caches, artifacts, etc. While
storage quota isn't enforced though, we might as well use ccache.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 800AA79E2DA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLkH-0003Y6-Nu; Wed, 13 Sep 2023 05:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgLkE-0003Xk-Ii
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgLk7-00014k-Mr
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694595661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syBSAHxmtbJOl+EUTI5blRbznmIrn6eKkKeoN3Js9nM=;
 b=Lu5mgEq+OSr80LHZL1NaYKnR8hhES00/+fIeDIkJAk0lut5kTPK5hhDVkgaXrkgt5UYGpX
 d256dHDL3YGhTyMDaJ0HoJcXcIzgxBaTUlMPkPchFIsGllOFSmr8ua8tcah4t4rsyYuJ3n
 AXCpB/nf9GDBpB7GYZYQRXnVK7HTQMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-PAfXDCWNNQyWqT_SExY1sQ-1; Wed, 13 Sep 2023 05:00:57 -0400
X-MC-Unique: PAfXDCWNNQyWqT_SExY1sQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03E67101FAA1;
 Wed, 13 Sep 2023 09:00:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FA54409AFC1;
 Wed, 13 Sep 2023 09:00:53 +0000 (UTC)
Date: Wed, 13 Sep 2023 10:00:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
Message-ID: <ZQF6Q3a9aMK5xSL6@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <5cbb92ab-f8b5-4d03-5698-06d0a0b7cfda@redhat.com>
 <87ledatq3s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ledatq3s.fsf@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Sep 13, 2023 at 09:48:34AM +0100, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 12/09/2023 20.41, Daniel P. Berrangé wrote:
> >> This addresses
> >>    https://gitlab.com/qemu-project/qemu/-/issues/1882
> >> Which turned out to be a genuine flaw which we missed during merge
> >> as the patch hitting master co-incided with the FreeBSD CI job
> >> having an temporary outage due to changed release image version.
> >> Daniel P. Berrangé (4):
> >>    microbit: add missing qtest_quit() call
> >>    qtest: kill orphaned qtest QEMU processes on FreeBSD
> >>    gitlab: make Cirrus CI timeout explicit
> >>    gitlab: make Cirrus CI jobs gating
> >>   .gitlab-ci.d/cirrus.yml       | 4 +++-
> >>   .gitlab-ci.d/cirrus/build.yml | 2 ++
> >>   tests/qtest/libqtest.c        | 7 +++++++
> >>   tests/qtest/microbit-test.c   | 2 ++
> >>   4 files changed, 14 insertions(+), 1 deletion(-)
> >> 
> >
> > Series
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> >
> > Alex, will you pick these up or shall I take them for my next PR?
> 
> Queued to testing/next, thanks.
> 
> Do you have a patch to disable the borked avacado tests? Or maybe I
> should just include Philippe's fix?

Not at this time. My hope was that this patch might address at least
some of the broken tests:

https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg02797.html

but I ran out of time to test that yesterday.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



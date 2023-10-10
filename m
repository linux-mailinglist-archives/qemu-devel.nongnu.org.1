Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CF67BFCB1
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCNT-0006ad-Sv; Tue, 10 Oct 2023 09:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqCMW-0006QF-HU
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqCMU-0006f0-U9
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696942882;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7E5LZqxhYAGWBXDWwkW2Y2kQIX7oZaDJ41VKMqh+xM=;
 b=aVzLgUwiFf2hk8At3P034jzGDSKjRXXu+RoynJJW8uaYJlRRZEOVJSlnhP9BQBg475ZmtY
 stNwInlNSy8aVbF71O6VEH54XUHpOSMdX7bAoTu4YfIaLQUbr4si1+oGg4s5Edw4qpgSht
 pyWduxltJ8VPQwRXdmr3QFP1YkNJbQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-XEcrS6ocNgqNO8z32eTs8w-1; Tue, 10 Oct 2023 09:01:09 -0400
X-MC-Unique: XEcrS6ocNgqNO8z32eTs8w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95F0E85829A;
 Tue, 10 Oct 2023 13:01:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46263492B04;
 Tue, 10 Oct 2023 13:01:07 +0000 (UTC)
Date: Tue, 10 Oct 2023 14:01:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 07/11] tests/avocado: Add ppc boot tests for non-free
 AIX images
Message-ID: <ZSVLEO4hAX3zJRFZ@redhat.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-8-npiggin@gmail.com>
 <87h6mypryo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6mypryo.fsf@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 10, 2023 at 01:43:16PM +0100, Alex Bennée wrote:
> 
> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > An AIX image can be provided by setting AIX_IMAGE environment
> > variable when running avocado.
> >
> > It's questionable whether we should carry these in upstream QEMU.
> > It's convenient to see how to run these things, but simple enough
> > to maintain in out of tree branch. I just wanted to see opinions
> > about it.
> 
> Yeah there is no point adding a test no one else can run. We already
> have tests that utilise dead URLs that can only run if you happen to
> have the image in the avocado cache which should arguably be removed.

I can understand the appeal of wanting to sanity check QEMU
with esentially arbitrary guest OS, whether modern, or obsolete,
whether OSS or proprietary.

The appeal of getting the test integrated into QEMU is you don't
have to worry about rebasing / merging local git changes forever
more.

I feel like this tells us we should not require users to be writing
new avocado python test code merely to get a boring old guest OS
boot up smoke test integrated into avocado.

I think we ought to have a 'guest_smoke_test.py' avocado test, that
pulls in guest OS scenarios from external YAML/JSON files. eg

  $ cat ppc_aix.yaml
  image:
    url: https:////some/path
    checksum: xxxxxx
  console:
    expect: ...some console message...
  vm:
    arch: ppc64
    machine: pseries
    ....something something extra cli args something something...

Users could then set

  export  QEMU_SMOKE_TEST_PATHS=$HOME/my-guestos-library:$HOME/shared-guestos-library
  make check-avocado

to load all the guest OS scenarios from these dirs, in addition to
any scenarios that are shipped in qemu.git by default.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



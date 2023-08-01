Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED15676B639
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQpkS-0004ja-9Z; Tue, 01 Aug 2023 09:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQpkQ-0004jN-RT
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQpkP-0001D0-5E
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690897752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Celtf0nYkunR+L7iezFpTKOgAwbLRhnPbHh7pGjoS5Q=;
 b=EVXcY7NqkVlHGASw+6KQXdjwrNZNc9Y5RiuTWZqKqGO66MTGPP3rBfA3giiu//tewGzZOm
 TuB4HELOz/vTV1y3I7OWqeFjlItVFoMtG9WhqWmJfe/ymGpAunuTYjNZHZafkavgAYK5yo
 YqvjU2v7z3osDDgYZH71HB09RyOevEU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-SgFUR4uGMPKlBXGxpcXPkQ-1; Tue, 01 Aug 2023 09:49:09 -0400
X-MC-Unique: SgFUR4uGMPKlBXGxpcXPkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF29528237C8;
 Tue,  1 Aug 2023 13:49:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED8F040C2063;
 Tue,  1 Aug 2023 13:49:07 +0000 (UTC)
Date: Tue, 1 Aug 2023 14:49:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
Message-ID: <ZMkNUWtnQzVE1wNP@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
 <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
 <6ca265d4-0dad-3725-1cd5-84da685bc63a@redhat.com>
 <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-F=6QqdjCSexG9kKsq9irjDGTv63xJNKQn+TD9-5U1pg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Mon, Jul 31, 2023 at 11:05:42AM +0100, Peter Maydell wrote:
> On Mon, 31 Jul 2023 at 10:11, Thomas Huth <thuth@redhat.com> wrote:
> > Or do you see another possibility how we could fix that timeout problem in
> > the 64-bit MSYS2 job? Still switching to clang, but compiling with
> > --extra-cflags="-Wno-unknown-attributes" maybe?
> 
> Is there any way we can separate out the "take 25 minutes to
> install a pile of packages" part from the "actually compile and
> test QEMU" part ?

I was thinking a little about what we actually aim to achieve with the
Windows MSys2 jobs.

We have long had the mingw cross compilation jobs for testing the Windows
platform compile phase. Please correct me if I'm wrong, but IIUC, the
msys2 jobs haven't identified any compilation problems that weren't already
found from the linux mingw cross compile jobs.

The definitely unique thing that the msys2 jobs *can* do though, is to
run the test suite. We can't run the test suite from the mingw cross jobs
unless we do something slightly crazy like adding Wine to the containers.
In libvirt we considered the latter until we realized that the smallest
possible wine install would still be enourmous.

In the Linux world we have the jobs split into three stages

  * Create the container images  (eg amd64-fedora-container)
  * Do the compilation work      (eg build-system-fedora)
  * Run the test suite           (eg check-system-fedora/avocado-system-fedora)

If the value of the msys2 jobs is that they let us run the test suite,
can we limit the usage of msys2 to just that part, and chain it upto
the fedora mingw cross compile jobs ie.

  win64-fedora-cross-container
    |
    +-> cross-win64-system
          |
	  +-> check-win64-msys

In the "cross-win64-system" job we would have to publish the entire QEMU
'build' directory as an artifact, to pass it over to the msys job.  If
we also published /usr/x86_64-w64-mingw32/ as an artifact, then we would
not need to install any mingw packages under msys. The basic msys installer
can be run (which takes a couple of minutes), and then then we just dump
the Fedora artifacts of /usr/x86_64-w64-mingw32/ into the right place
and run the test suite.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



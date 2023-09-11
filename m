Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3679A7DF
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffmd-0005lp-Si; Mon, 11 Sep 2023 08:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qffmZ-0005lb-Hl
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qffmT-00086g-It
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694434360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lZcjiHOjq3IF51JM+DN1lafs/aMRbVHIoDNukPD09Ac=;
 b=eVoJliFpNfsHiOzBiaaBrxZWdEq2IthWSIbiib0BgrdAqo7AneiOBAR6j85PHV+DippU9B
 6SJjs+ipiCDPBz0/Nu9fMvhoY+BkAUhNdHuSbcnpjwHEQsADB0GrCHLhebLKp6LFb8P2xr
 OIBjUTvIoL68xSYVcYi2Agis8XVLSMc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-zFfqyEdbORyUbyqOYnBggg-1; Mon, 11 Sep 2023 08:12:37 -0400
X-MC-Unique: zFfqyEdbORyUbyqOYnBggg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E914B101CA82;
 Mon, 11 Sep 2023 12:12:36 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F932156701;
 Mon, 11 Sep 2023 12:12:35 +0000 (UTC)
Date: Mon, 11 Sep 2023 14:12:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PULL 00/51] Build system, i386 changes for 2023-09-07
Message-ID: <ZP8EMs9zqz72CEfl@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907154412.GA1550739@fedora> <ZPs3UB8W4lsOFnxW@redhat.com>
 <CAJSP0QX4QgxG-3dbv6oa6_81MWJkYKTT7T05D5hCtFiG=mLi7Q@mail.gmail.com>
 <93be81d9-3f96-51e2-4b20-74ce99e56ae1@linaro.org>
 <2b5ec5d4-956e-c4c5-08c6-b5ef5fa62548@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b5ec5d4-956e-c4c5-08c6-b5ef5fa62548@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 11.09.2023 um 12:22 hat Philippe Mathieu-Daudé geschrieben:
> On 11/9/23 12:10, Philippe Mathieu-Daudé wrote:
> > On 8/9/23 17:47, Stefan Hajnoczi wrote:
> > > I wonder how it passed CI?
> > > https://gitlab.com/qemu-project/qemu/-/pipelines/996175923/
> > 
> > The conditions are:
> > - x86 host

I didn't actually try other hosts, but why do you think it depends on
the host? Is it not x86 target?

> > - both system / user emulation enabled

I did try this one while bisection because I didn't want to build the
system emulator in each step. User emulation only is enough, you don't
need to build the system emulator to get the build failure.

> > - KVM disabled

I didn't explicitly disable KVM, but I suppose it's automatically
disabled for linux-user.

> > - debug enabled
> 
> Oh, I forgot:
> 
> - clang compiler
> 
> (because this isn't an issue with GCC).
> 
> > We have jobs with 3 of the 4, but none with
> > all the 4.
> > 
> > Is it worth test it?

So it's x86, user emulation is built, debug enabled, on clang. This
doesn't feel very exotic, though of course --enable-debug will be more
common for developers while it's not the primary test case for CI.

I don't see any existing test to which it could be added without losing
another important configuration. Not sure if it's worth an additional
test when we're already hitting the CI limits too often.

On the other hand, now that I'm looking at the CI configuration, is it
correct that we have no build for clang + --enable-debug at all? Even if
you ignore the other conditions? Maybe that's basic enough that we
should have it.

Kevin



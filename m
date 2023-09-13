Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CA279E51A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNI7-00031e-98; Wed, 13 Sep 2023 06:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgNI3-000313-PV
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qgNI0-00011a-Vl
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694601606;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAQk2LZLzHQesAdge3l1Ugh4cj1lFThO5LotRTc1L54=;
 b=hhRxHpur6ar2MSS4hShMGmQEvQADb3XXqNm4e7Ifj9/J3lyW3fsiKb4XHODy0qpsC2Z33x
 TeSmTF73lrY0OaT3+zca1r97/SAhV3iAVITW8PfOK+5L9wZFJhKnRTPECTZ1YaGT5bJsRJ
 Co6wmQXhyJ5P5nT+YFs+FpCDJAtE1x8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-R3MtmYLQN5GN1lyUi2LTlw-1; Wed, 13 Sep 2023 06:40:03 -0400
X-MC-Unique: R3MtmYLQN5GN1lyUi2LTlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 488FE102F23C;
 Wed, 13 Sep 2023 10:40:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C69D200E4BC;
 Wed, 13 Sep 2023 10:40:01 +0000 (UTC)
Date: Wed, 13 Sep 2023 11:39:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] gitlab: remove unreliable avocado CI jobs
Message-ID: <ZQGRfwyKjy2FvpiY@redhat.com>
References: <20230912150611.70676-1-stefanha@redhat.com>
 <27e38912-0bad-7398-dda6-1670fc644f74@redhat.com>
 <CAFEAcA_roU-_E4P94km1RF=u6c+GRBxrGP0jS1_dXsRABCymJg@mail.gmail.com>
 <4e335f86-d075-4cc0-af5a-9dca9b3bf261@linaro.org>
 <878r9atl5s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r9atl5s.fsf@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 13, 2023 at 11:35:12AM +0100, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > On 13/9/23 11:18, Peter Maydell wrote:
> >> On Tue, 12 Sept 2023 at 21:00, Thomas Huth <thuth@redhat.com> wrote:
> >>> Please don't remove the whole job! Just disable the failing tests within the job, e.g.:
> >>>
> >>> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> >>> --- a/tests/avocado/replay_kernel.py
> >>> +++ b/tests/avocado/replay_kernel.py
> >>> @@ -503,6 +503,7 @@ def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
> >>>            console_pattern = 'Kernel command line: %s' % kernel_command_line
> >>>            self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
> >>>
> >>> +    @skipIf(os.getenv('GITLAB_CI'), 'Skipping unstable test on GitLab')
> >>>        def test_mips_malta32el_nanomips_4k(self):
> >>>            """
> >>>            :avocado: tags=arch:mipsel
> >> Please don't skip unstable tests on gitlab only. If they're
> >> unstable, then nobody wants to be running them and wondering
> >> if these are flaky tests or real issues, whether theyr'e doing
> >> it on gitlab or locally. (I know we already have a lot of these,
> >> but the effect is that instead of saying 'make check-avocado'
> >> you have to say 'GITLAB_CI=1 make check-avocado'.)
> >
> > Good point, I'll simply use:
> >
> >         @skip('Pending https://gitlab.com/qemu-project/qemu/-/issues/1884')
> >
> > Looking at other ones:
> >
> > $ git grep -w @skip tests/avocado/
> > tests/avocado/machine_sparc_leon3.py:17:    @skip("Test currently broken")
> > tests/avocado/netdev-ethtool.py:89:    @skip("Incomplete reg 0x00178
> > support")
> > tests/avocado/netdev-ethtool.py:96:    @skip("Incomplete reg 0x00178
> > support")
> > tests/avocado/replay_kernel.py:333:    @skip("Test currently broken")
> > # Console stuck as of 5.2-rc1
> > tests/avocado/replay_kernel.py:368:    @skip("nios2 emulation is buggy
> > under record/replay")
> > tests/avocado/virtio_check_params.py:119:    @skip("break multi-arch CI")
> >
> > Looking at the first one:
> >
> > commit 5baecf58ad9fb3ce24d331978526909d0beca482
> > Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > Date:   Tue Mar 31 12:50:42 2020 +0200
> >
> >     tests/acceptance/machine_sparc_leon3: Disable HelenOS test
> >
> >     This test was written/tested around beginning of 2019, but was
> >     extracted from a bigger series and posted end of June 2019 [*].
> >     Unfortunately I did not notice commit 162abf1a8 was merged by
> >     then, which implements the AHB and APB plug and play devices.
> >
> >     HelenOS 0.6 is expecting the PnP registers to be not implemented
> >     by QEMU, then forces the discovered AMBA devices (see [2]).
> >
> >     Before 162abf1a8, the console was displaying:
> >
> >       HelenOS bootloader, release 0.6.0 (Elastic Horse)
> >       Built on 2014-12-21 20:17:42 for sparc32
> >       Copyright (c) 2001-2014 HelenOS project
> >        0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
> >        0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
> >        0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
> >        0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
> >        0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
> >        0x4006d390|0x4006d390: rd image (152678/65889 bytes)
> >        0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
> >        0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
> >        0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
> >        0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
> >       ABMA devices:
> >       <1:00c> at 0x80000100 irq 3
> >       <1:00d> at 0x80000200
> >       <1:011> at 0x80000300 irq 8
> >       Memory size: 64 MB
> >
> >     As of this commit, it is now confused:
> >
> >       ABMA devices:
> >       <1:3000> at 0x00000000 irq 0
> >       <1:3000> at 0x00000000 irq 0
> >       <1:3000> at 0x00000000 irq 0
> >       <1:3000> at 0x00000000 irq 0
> >       <1:3000> at 0x00000000 irq 0
> >       <1:3000> at 0x00000000 irq 0
> >       <1:3000> at 0x00000000 irq 0
> >       ...
> >
> >     As this test is not working as expected, simply disable it (by
> >     skipping it) for now.
> >
> > More than 3 years passed already, what a disappointment.
> > Offending commit is 4 years old.
> >
> > commit 162abf1a83ddd06ce1618666f84f88ba4dbffe10
> > Author: KONRAD Frederic <frederic.konrad@adacore.com>
> > Date:   Wed May 15 14:31:32 2019 +0200
> >
> >     leon3: introduce the plug and play mechanism
> >
> >     This adds the AHB and APB plug and play devices.
> >     They are scanned during the linux boot to discover the various
> >     peripheral.
> >
> > I'm not complaining about that particular commit, I wonder about
> > usefulness of disabling tests from unmaintained areas.
> >
> > Maybe we can commit a date when disabling a test, having a disabled
> > test failing _after_ that date, so if it isn't fixed we remove it.
> > Smth like,
> >
> >   @SkipBroken(date='2023-11-15',
> >               desc='Pending
> >               https://gitlab.com/qemu-project/qemu/-/issues/1884') #
> >               Will fail if run after 2023-11-15 and this test isn't
> >              fixed
> >
> > Thoughts?
> 
> I like the:
> 
>   @skip('Pending https://gitlab.com/qemu-project/qemu/-/issues/1884')

I'd remove "Pending " too - the URL alone is sufficient info
including the record of dates, to guide us when to finally
delete a skipped test for good.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



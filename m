Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F73B765C2D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6V9-0007ff-MH; Thu, 27 Jul 2023 15:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP6V2-0007fT-Hp
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP6V0-0005Ay-N0
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690485489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqLpjDHDxbHe+j7n1j3rcU93srPQHE4fQOmeKXeEO00=;
 b=Ocj1QZnvfHslYg4A/raHWoPg1Ws2lmacU80fhhh7Rz/7OzGbhnDXyBSyfhl33wdLp2/Hnu
 Pj9J3z8Kejy4Vc4E8UkjwwyM/AJMtSoL7LT7lPELOrO7Ua6/Fqw43tf3qWIkImsqrbfcBH
 UMoubXofWhOVLEmwG8erO4UOUmCoFsg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-21nD7EgTNQ2sDKTZFybyqA-1; Thu, 27 Jul 2023 15:18:08 -0400
X-MC-Unique: 21nD7EgTNQ2sDKTZFybyqA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1bbac333f2cso8493865ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690485484; x=1691090284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqLpjDHDxbHe+j7n1j3rcU93srPQHE4fQOmeKXeEO00=;
 b=cjoda1djxaa3Bui2aTR/zr6rKcPlWPDfD4JtLX6cZY6wZNvjQi4Usgt6CkgP2j1d0N
 miYoxRLOaCrpowPLssndgPZ8HP9u/W71Xsb8ouFSyRUn6agNMKKAMBzHs1TpQzAoC1lX
 3vtgzmFu3qrEH6P4aM7ZDNNph2SvQSa9AaWxttw+EzqEBCUGy+aKm6d58PVDS/7XEiUN
 V9d3du3C613g+EhIbgDI9UUiWPDgtowm5Ba95zNc5MhKIFvgPRszYWQvHKepsXB2RxBq
 lRYEUo5sVeYF9fDLVaVNepw/D973CmadE/XHRtJDOsZ/M5+D7k5J5tojBnf2us93/nzO
 Jeyg==
X-Gm-Message-State: ABy/qLbpz/TTr3KKnTtat2fVAEagmlPsATFA1f4hKrYV0yD9bH/muluB
 XSfouFPp/CclUIB0R4NB770JVuiAPYsu6oXWJwLyoJqD4hGHUMVy05oDqUlFIja3gmpCYCxxPM9
 Jusc5QLWL1DCg196ERuDCXQsAtImO/sA=
X-Received: by 2002:a17:902:bc44:b0:1b8:b464:fa1d with SMTP id
 t4-20020a170902bc4400b001b8b464fa1dmr202696plz.69.1690485484403; 
 Thu, 27 Jul 2023 12:18:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9EXTlV2S5chSJ9TlGx8mZkjMnSQmqmPStPWCD2CzE6SIK2zfYx2HSP6DbutHqxr+uoSbPRy3nh7Q39zlhlEw=
X-Received: by 2002:a17:902:bc44:b0:1b8:b464:fa1d with SMTP id
 t4-20020a170902bc4400b001b8b464fa1dmr202680plz.69.1690485484122; Thu, 27 Jul
 2023 12:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <ad623dea-4ed8-6e06-3c70-60fcf863a79e@linaro.org>
In-Reply-To: <ad623dea-4ed8-6e06-3c70-60fcf863a79e@linaro.org>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2023 15:17:52 -0400
Message-ID: <CA+bd_6+krUvFzo6NfCdVLg5UDLXj7emS8vvX2VRnKSi0FzOUBw@mail.gmail.com>
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Jul 26, 2023 at 3:34=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 25/7/23 19:13, Peter Maydell wrote:
> > Currently this CI job is failing:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/4737819946
> >
> > because:
> >
> > (05/59) tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_e=
xynos4210_initrd:
> > INTERRUPTED: Missing asset
> > https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/l=
/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\nRunner
> > error occurred: Timeout reached\nOriginal status: CANCEL\n{'name':
> > '05-tests/avocado/boot_linux_console... (90.67 s)
> >
> > Why is a "Missing asset" causing a timeout after 90 seconds,
> > rather than being accounted as a "SKIP" ("missing requirements
> > in the test environment" sounds like what we have here) ?
>
> Maybe something to report to upstream Avocado.
>
>

Hi Philippe,

Please check my response to Peter's first message on this thread.
It's a rather long answer, but I hope this behavior is understandable.

> That said, we want CI to be reproducible. If we fetch assets from
> unreliable sources, we can't be reproducible. If we are unable to
> provide a assets cache, we'll keep hitting this problem. If we can
> not find a way to have assets stored (requiring sysadmin time setting
> up some infra, possibly only for GitLab), then I'd consider stopping
> running tests depending on external assets on CI; otherwise at some
> point we'll get tired to waste time figuring out the same problem.
>

Right, in an ideal world, we could have a master list of all the
assets that every single job will need, and require an admin to make
sure each and every one of them is cached before running a job.  The
current approach with Avocado's pre-job "fetch asset" plugin is to do
as much as possible without having duplication of the assets URLs in
such a "asset master list" and in the test code.

Also, it will not abort a job if any of these assets fail to be
fetched.  It's a convenient choice that, on the other hand, yields
lower reproducibility and reliability.

> As a maintainer I'm happy to run the avocado tests using my local
> assets cache, and I would rather keep using the framework. But then
> my cache is likely different from others (users, maintainers, CI).
> Similarly few users/maintainers end up having the same cache and
> running the same set of tests.
>
> $ du -chs ~/avocado/data/cache/
> 5.7G    /Users/philmd/avocado/data/cache/
>
> Some files are older than 3 years, and I'm happy to still run the
> tests depending on them (although they disappeared from their
> original http server).
>

This is a well maintained cache! :) Can we rsync from it? :)

Jokes aside, I'm open for ideas on how to better balance this
convenience versus reliability question.

Thanks,
- Cleber.



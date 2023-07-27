Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E061765C2E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6jh-0002hU-1X; Thu, 27 Jul 2023 15:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP6je-0002fX-PH
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP6jd-0002yX-6h
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690486395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2YVOnRFN+L8UMr6O9Z2gPvYZyRpCduNFOop3Nn4nZkU=;
 b=MlVrL7FKdQrgd6KN5FtpvavVgaWfaXNBLgCxW2A51KpF13N/+eQ15xGA0+3LMNKdw514AQ
 +XHBotZDpc1nu6xpSo1ktVsmHxWoMbXow74wIoTYElqFJgNCvlyMlF6JY9k+NMQzq1jYFU
 iAHEGZC3lTiKC5zLVt4iO6ut111/L88=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-aer7CZ18MwK1sBaXcsM64g-1; Thu, 27 Jul 2023 15:33:09 -0400
X-MC-Unique: aer7CZ18MwK1sBaXcsM64g-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-26304c2e178so1200270a91.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690486388; x=1691091188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YVOnRFN+L8UMr6O9Z2gPvYZyRpCduNFOop3Nn4nZkU=;
 b=Gqr2B4aIltyw03nnGpwhv1Ow3S8uzO4e+7NQ28axAmIkb3CPnuz9hSapRPi1D3Esk6
 a5V4ZltISvE37OFTJriHae2kbIKoZ1hLr6Eir1VoBYQZlWNHYfCnKbkcx9+AtEvt+Y8F
 ZuSFbtS/J3mnmYCvApsMzpGcXaQXCClHNUu3FfXq2eerIR1FnVPxZCuI2zExa328w3qr
 jeXtUIe+SMhSlgV88Hzt87KNSZhHKeRmsKcUphZ5byL6XCQKBXjtAEpUTkSNBTlgqJK6
 kFRrZgd0FMYZNT+twSQ/WCRTgXXgSHFg+HdbNjFsHRVG7LDIc4322us5ylMC4Q+jSDsf
 xb8g==
X-Gm-Message-State: ABy/qLaQlt7W/vClJbAPrYWfuBLHx1UG3s785t5AOUrO5+v0BOOtrBMd
 TblxO3QktOeBwF27ZC2bVS1kjKvkK1RfBRoSSxyCZGg4fsTHj+AxbO/B4DpkW0h1w7yiGtXQpiL
 Y1L4caNZxdmQi0QVc+LxOP8SLWFvVrSY=
X-Received: by 2002:a17:90a:ee81:b0:268:18e:ade5 with SMTP id
 i1-20020a17090aee8100b00268018eade5mr253049pjz.24.1690486387997; 
 Thu, 27 Jul 2023 12:33:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFpt3RsvjD7JJg4K2s7qajVziGvL4xEHmpkNecF6ODx88P4R/JHt14AW3/7nWVuctimkKqYzA5AaucA5Op4iio=
X-Received: by 2002:a17:90a:ee81:b0:268:18e:ade5 with SMTP id
 i1-20020a17090aee8100b00268018eade5mr253033pjz.24.1690486387711; Thu, 27 Jul
 2023 12:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <ad623dea-4ed8-6e06-3c70-60fcf863a79e@linaro.org>
 <92f09c35-6ccd-5f5f-2176-6bf6c49d61cf@redhat.com>
In-Reply-To: <92f09c35-6ccd-5f5f-2176-6bf6c49d61cf@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2023 15:32:56 -0400
Message-ID: <CA+bd_6+A-rgy27gKMpUixrvKPii3gHwkNEfQzxtnjBzXVEF+FQ@mail.gmail.com>
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
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

On Wed, Jul 26, 2023 at 5:07=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 26/07/2023 09.33, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 25/7/23 19:13, Peter Maydell wrote:
> >> Currently this CI job is failing:
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/4737819946
> >>
> >> because:
> >>
> >> (05/59)
> >> tests/avocado/boot_linux_console.py:BootLinuxConsole.test_arm_exynos42=
10_initrd:
> >> INTERRUPTED: Missing asset
> >> https://snapshot.debian.org/archive/debian/20190928T224601Z/pool/main/=
l/linux/linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb\nRunner
> >> error occurred: Timeout reached\nOriginal status: CANCEL\n{'name':
> >> '05-tests/avocado/boot_linux_console... (90.67 s)
> >>
> >> Why is a "Missing asset" causing a timeout after 90 seconds,
> >> rather than being accounted as a "SKIP" ("missing requirements
> >> in the test environment" sounds like what we have here) ?
> >
> > Maybe something to report to upstream Avocado.
>
> We're back to using Avocado v88.1 in QEMU. We first need someone who can
> update to the latest Avocado release and take care of the remaining
> problems... This is *very* frustrating.
>
>   Thomas
>

Hi Thomas,

As you might remember from a couple of months ago, I was (and still
am) running the Avocado QEMU tests extensively with the latest Avocado
and attempting to cover all gaps before the 103.0 LTS release.

To make it clear, Avocado is currently on sprint #103[1] which will
release 103.0, a "Long Term Stability'' release.  It may sound like a
marketing gimmick, but it's important for QEMU because we want to be
able to address all bugs that are eventually caught after its release
while still minimizing disruption.

The frustration you mentioned with the attempt to migrate from 88.1 to
101.0, and now back to 88.1 is the kind of disruption we want to
avoid.  With 103.0 LTS, like with 92.X LTS, we can and will release
minor releases with needed fixes.

So, this is also an invitation to everyone else running the
Avocado-based  QEMU tests with either Avocado 102.0, or the latest
development version and report issues.

BTW, Avocado's GitHub has a "customer:QEMU"[2] label that can be added
to issues that will certainly increase its classification and
priority.

PS: 88.1 was a minor release to address an issue with the release
process itself, so there were no differences from 88.0 that mattered
to users, nor was there the possibility of a 88.2 release with more
fixes.

Thanks,
- Cleber.

[1] - https://github.com/avocado-framework/avocado/milestone/29
[2] - https://github.com/avocado-framework/avocado/issues?q=3Dis%3Aopen+is%=
3Aissue+label%3Acustomer%3AQEMU+milestone%3A%22%23103+%28LTS+release+-+Soun=
d+of+Freedom%29%22



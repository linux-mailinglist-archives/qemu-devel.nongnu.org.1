Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFF2763B5D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfdF-0004hd-Us; Wed, 26 Jul 2023 10:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOfd6-0004XS-DH
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qOfd4-0001jI-PI
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690382201;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmTbvNI93/YugBbta5rJ/loq/GzVX9PIqMrn0tROq9M=;
 b=UbC07cx0fjrOkU9YjWunVKCEN09b8GlegRD+DR+wDNjhuGeaWcJG5BqF8YZ7BUlnDmJ1Wr
 xll/9/g/7O7BcL0SRnIguCxy4D8Vu71u750JYQlGSF36e1fLNsmVVzzqNRHE1qYeYHy5ko
 OmSGsl7i5AtCTSXKrUZtBRKhAsY8P1o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-n5QGAYwFPLicBe6-A1qWIg-1; Wed, 26 Jul 2023 10:36:36 -0400
X-MC-Unique: n5QGAYwFPLicBe6-A1qWIg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdd5d09b8so42276545e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 07:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690382194; x=1690986994;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmTbvNI93/YugBbta5rJ/loq/GzVX9PIqMrn0tROq9M=;
 b=Rl4z0uF6EoQ3msVezSQug5J0ZCzkJC5h6vnfPqJnxP8inkqJWDyL8drbiN76fY/+H4
 dJOuiwoEe1FfvqA8U/MGqfnJPTSvpXKa9NrpzlDKnnhjm2gosq7w2g4G07X4rvTiPvWY
 Afh28lmNCqH0qKIycWSz5kA3lNIowIsSXGcBKJSA6G4/ieOu+a0MC1X4cr55mfcjoeuX
 I2IA5cm6z2X147F0mZLTgAMfn9X4n9t3GoUBbTkvSDDtQx44w7LJ1Fb9cT/o5bV2753J
 +1Rver/OH4AuNccogNhKL6BqJBLOmKj/jZoJMrIEOqoxdbYVQ/2LpJH8oJ8xjnOaGixn
 HVzg==
X-Gm-Message-State: ABy/qLbXu72o5mW613OXQ8ik08GjKp1cRPjYD8k9FlZHuoq2GWq6Gdb5
 TS8kRNCRWzdGRhN9Y/zy69TCHoAT4TbmlaH0hFOR821/GIS6DRJOow2F4FIgwgSSCCk1ACSEUU8
 DZemSSOLOMdv7As8=
X-Received: by 2002:a7b:c04b:0:b0:3fd:29cf:20c5 with SMTP id
 u11-20020a7bc04b000000b003fd29cf20c5mr1541645wmc.7.1690382194144; 
 Wed, 26 Jul 2023 07:36:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE82GqDV0pRBUILUNrX+w0lHS0uILHNZLe56jFva2wfXTvBi29KM1YSBnzqqdLvncg1uHBEdg==
X-Received: by 2002:a7b:c04b:0:b0:3fd:29cf:20c5 with SMTP id
 u11-20020a7bc04b000000b003fd29cf20c5mr1541630wmc.7.1690382193818; 
 Wed, 26 Jul 2023 07:36:33 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 t23-20020a1c7717000000b003fbb9339b29sm2118064wmi.42.2023.07.26.07.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 07:36:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Subject: Re: How to tame CI?
In-Reply-To: <ZMEq3Uzl+/7ACa9v@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 26 Jul 2023 15:17:01 +0100")
References: <87fs5aho6e.fsf@secure.mitica>
 <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
 <ZMEq3Uzl+/7ACa9v@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 26 Jul 2023 16:36:32 +0200
Message-ID: <87bkfyhh8v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Wed, Jul 26, 2023 at 02:00:03PM +0100, Peter Maydell wrote:
>> On Wed, 26 Jul 2023 at 13:06, Juan Quintela <quintela@redhat.com> wrote:
>> > To make things easier, this is the part that show how it breaks (this =
is
>> > the gcov test):
>> >
>> > 357/423 qemu:block / io-qcow2-copy-before-write                       =
     ERROR           6.38s   exit status 1
>> > >>> PYTHON=3D/builds/juan.quintela/qemu/build/pyvenv/bin/python3
>> > MALLOC_PERTURB_=3D44
>> > /builds/juan.quintela/qemu/build/pyvenv/bin/python3
>> > /builds/juan.quintela/qemu/build/../tests/qemu-iotests/check -tap
>> > -qcow2 copy-before-write --source-dir
>> > /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir
>> > /builds/juan.quintela/qemu/build/tests/qemu-iotests
>> > =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
>> > stderr:
>> > --- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-wr=
ite.out
>> > +++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-wr=
ite/copy-before-write.out.bad
>> > @@ -1,5 +1,21 @@
>> > -....
>> > +...F
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
>> > +----------------------------------------------------------------------
>> > +Traceback (most recent call last):
>> > +  File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-befo=
re-write", line 210, in test_timeout_break_snapshot
>> > +    self.assertEqual(log, """\
>> > +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at
>> > offset 0\n1 MiB,[46 chars]c)\n' !=3D 'wrot[195 chars]read failed:
>> > Permission denied\n'
>> > +  wrote 524288/524288 bytes at offset 0
>> > +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> > +  wrote 524288/524288 bytes at offset 524288
>> > +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> > ++ read failed: Permission denied
>> > +- read 1048576/1048576 bytes at offset 0
>> > +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> > +
>>=20
>> This iotest failing is an intermittent that I've seen running
>> pullreqs on master. I tend to see it on the s390 host. I
>> suspect a race condition somewhere where it fails if the host
>> is heavily loaded.

What is weird to me is that I was unable to reproduce it on the previous
commit.  But with this one happened always.  No, I have no clue why, and
as said, it makes zero sense, it is for a binary that it is not used on
the block test.

Later, Juan.

>
> Since it is known flakey, we should just commit the change
>
> --- a/tests/qemu-iotests/tests/copy-before-write
> +++ b/tests/qemu-iotests/tests/copy-before-write
> @@ -1,5 +1,5 @@
>  #!/usr/bin/env python3
> -# group: auto backup
> +# group: backup
>  #
>  # Copyright (c) 2022 Virtuozzo International GmbH
>  #
>
>
> and if someone wants to re-enable it, they get the job of fixing its
> reliability first.
>
> With regards,
> Daniel



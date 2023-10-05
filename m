Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED57BA059
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPSd-0001EM-JH; Thu, 05 Oct 2023 10:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoPSc-0001ED-EB
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoPSa-0006Zv-Ld
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696516575;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5UOn5jRpuFs7zhUIbU/ju3hxTpHVT3ou0PquEBgnPU=;
 b=hDd2B/UUORVHoiaLFmFof/F0eiCoqcuwHjQ+xcECY8ZzSu2lpvoPIoyPTCOkB3t0JwMAQv
 tCFiwVlYgvMZUKEeVw8Jh8AkGB7pEuPdchWyce6kRdHGTP13l2TomkRKpK+Wo2HM2Ds0uJ
 R4uaDO+s6PLNzI8utZ2PtXJf5e6Vnjw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-mrPqFVHnO5u8Fv2urnhBsg-1; Thu, 05 Oct 2023 10:36:13 -0400
X-MC-Unique: mrPqFVHnO5u8Fv2urnhBsg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so10141485e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 07:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696516573; x=1697121373;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k5UOn5jRpuFs7zhUIbU/ju3hxTpHVT3ou0PquEBgnPU=;
 b=tGsQoVkz+LmFGU3QMIQBzS8ZH5XABtsmQv+YWSC38EmItiJnfLc2mo6pRWZV9biz+J
 ASekH9vORMHdXwy1vXrywfZuwGNSvCQsOmF+uPaDJdWruz9tYrQuj3MxSnw0lV81MZTo
 Yam0iKy5aEXh3jnavJbkEQROT7oLcruwlb08n2avJDu1/oLaWozbBJ3Ll33qV/RsS5j5
 IpR9eFcmz5cgy5Ab44ogaOYc43QgvKNSIFHjN5T/nrTEV4xgbW+C528fShXe+cGsJbzQ
 krPp8hwHE5QYIA0Ab9Ux4VwfCS7Cl/gISf4KTDIFbnRXcJ/D1A8W/zUitZsCU20OEiWE
 p5jg==
X-Gm-Message-State: AOJu0YyTo+mhTaCnZ2Cg01ewdlqZWxE7+X67yaHRdczpDQn9eZf/ER60
 22058jVyEzpiRokqZUwV0F4fUSy000z0o9QWjg1wOdCXfChb2ZSsPO+kR+59J6Vd/G0aeItxqWa
 6/omEwVTB8JGqYzI=
X-Received: by 2002:a05:600c:3795:b0:401:b92f:eec5 with SMTP id
 o21-20020a05600c379500b00401b92feec5mr1525183wmr.9.1696516572864; 
 Thu, 05 Oct 2023 07:36:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM4kBaamAxZkyfzGd/bs0LHmVkKqqk5Ms43+uCdHeZVm9RKpS+OOkyY9J94de828fBlw6drw==
X-Received: by 2002:a05:600c:3795:b0:401:b92f:eec5 with SMTP id
 o21-20020a05600c379500b00401b92feec5mr1525160wmr.9.1696516572479; 
 Thu, 05 Oct 2023 07:36:12 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 m10-20020a7bce0a000000b00405953973c3sm3886456wmc.6.2023.10.05.07.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:36:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Thomas Huth <thuth@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Kevin Wolf <kwolf@redhat.com>,
 hreitz@redhat.com,  qemu-devel@nongnu.org,  Daniel Berrange
 <berrange@redhat.com>,  richard.henderson@linaro.org,  Qemu-block
 <qemu-block@nongnu.org>
Subject: Re: How to tame CI?
In-Reply-To: <602039f4-2a22-49ed-ab19-5ca62c9f2b47@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 5 Oct 2023 15:35:15 +0300")
References: <87fs5aho6e.fsf@secure.mitica>
 <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
 <e68d2e2f-6afe-820b-fa45-44db5b6edf09@redhat.com>
 <602039f4-2a22-49ed-ab19-5ca62c9f2b47@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 16:36:10 +0200
Message-ID: <87ttr5jfvp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> On 26.07.23 16:32, Thomas Huth wrote:
>> On 26/07/2023 15.00, Peter Maydell wrote:
>>> On Wed, 26 Jul 2023 at 13:06, Juan Quintela <quintela@redhat.com> wrote:
>>>> To make things easier, this is the part that show how it breaks (this =
is
>>>> the gcov test):
>>>>
>>>> 357/423 qemu:block / io-qcow2-copy-before-write=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ERROR=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.38s=C2=A0=C2=A0=
 exit status 1
>>>>>>> PYTHON=3D/builds/juan.quintela/qemu/build/pyvenv/bin/python3
>>>> MALLOC_PERTURB_=3D44
>>>> /builds/juan.quintela/qemu/build/pyvenv/bin/python3
>>>> /builds/juan.quintela/qemu/build/../tests/qemu-iotests/check -tap
>>>> -qcow2 copy-before-write --source-dir
>>>> /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir
>>>> /builds/juan.quintela/qemu/build/tests/qemu-iotests
>>>> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80=C2=A0 =E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95
>>>> stderr:
>>>> --- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-wr=
ite.out
>>>> +++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-wr=
ite/copy-before-write.out.bad
>>>> @@ -1,5 +1,21 @@
>>>> -....
>>>> +...F
>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
>>>> +----------------------------------------------------------------------
>>>> +Traceback (most recent call last):
>>>> +=C2=A0 File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy=
-before-write", line 210, in test_timeout_break_snapshot
>>>> +=C2=A0=C2=A0=C2=A0 self.assertEqual(log, """\
>>>> +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at
>>>> offset 0\n1 MiB,[46 chars]c)\n' !=3D 'wrot[195 chars]read failed:
>>>> Permission denied\n'
>>>> +=C2=A0 wrote 524288/524288 bytes at offset 0
>>>> +=C2=A0 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> +=C2=A0 wrote 524288/524288 bytes at offset 524288
>>>> +=C2=A0 512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> ++ read failed: Permission denied
>>>> +- read 1048576/1048576 bytes at offset 0
>>>> +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> +
>>>
>>> This iotest failing is an intermittent that I've seen running
>>> pullreqs on master. I tend to see it on the s390 host. I
>>> suspect a race condition somewhere where it fails if the host
>>> is heavily loaded.
>> It's obviously a failure in an iotest, so let's CC: the
>> corresponding people (done now).
>>=20
>
> Sorry for long delay.
>
> Does it still fail?
>
> In the test we expect that copy-before-write operation fails (because
> of throttling and timeout), and therefore snapshot is broken and next
> read from snapshot should fail.
>
> But most probably the copy-before-write operation succeeded in this
> case for some reason.. I don't think that throttling and timeouts in
> block layer can guarantee some determinism.. But usually it works.
>
> we use throttling with bps-write =3D 300 * 1024, i.e. 300KB per second. a=
nd cbw-timeout is set to 1 second.
>
> Then we do write 512K,
>
> then the comment say:
> # We need second write to trigger throttling
>
> and we write another 512K.
>
> first 512K are written, and we should wait 512/300 =3D 1.7 seconds since
> _start_ of that write before issuing the second one.. But if write was
> slow we may have to wait less than a second from finish of the first
> write start the second one. Then timeout will not fire.
>
> =3D=3D=3D=3D
>
> I see two possible ways to fix that:
>
> 1. decrease bps-write a bit. For example to 200 BPS.
>
> 2. rework the test to use null-co instead of real images. This way we wil=
l not suffer from unstable IO duration.
>
>
> So, is the problem still fire sometimes?=09

For me it is random.  When it happens, it do it forever.
And then it stops, and don't happens for a while.

It is not happening for me now.

Later, Juan.



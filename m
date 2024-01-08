Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19D826BAB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:39:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMn2F-00045N-Sn; Mon, 08 Jan 2024 05:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn2D-000450-MF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn2A-000775-Qs
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704710346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31OZCjMI2QNySUtvmLVZIZhx9BGHZxlIFE4qehyMZgk=;
 b=UdM/Fn5Q2TBthPWt6UNgd9R3Tjxo09f4uyIDZHK89Kj87DfyQbzg9+9jxJV6TQRFgu9rqM
 1zaYQ9nXKtlbPiL/VFeUWzkxtQUmIEU0BlTvT5/ArJSK7ABfvLHmKeZm5Fmi41Ew6g4QNA
 j5VoYc1VNiiAtKO9XoM2omzyAi9hQ/0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-T4aU_mNMMvOhVAJXIUGVXw-1; Mon, 08 Jan 2024 05:39:03 -0500
X-MC-Unique: T4aU_mNMMvOhVAJXIUGVXw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9b09d1afaso2156687b3a.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710340; x=1705315140;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31OZCjMI2QNySUtvmLVZIZhx9BGHZxlIFE4qehyMZgk=;
 b=Dv/IIdS1hGD5UfVxK9+/HCtAt5VAXIIi9abdEkmUL3QLHEy0sl2vHrky/b9Dwg6XjD
 nwqF0XlIdrOpooTe89T8QGLrgMIwe5p67ddKw+/+OYgzQIKKGDGP4GO/MFbADHtaxHVG
 WSHL7VBJvu/Lx8Tl+WftvZ9gxx3DaHPkUBVLMhf7f5c22t+VHuqgmkd7wyQgnktnYFs4
 skZljbZ9o1UkI82ope/B+R+o48N1OBVXMXISCt5bPstC+AUZoDOA2aK8g8VI8uE3g9ud
 Dah+m6NRTsWVXo/KvGQTdwNOUaYucIyo/fTE3DwQ++W6BBAXfA2Uk+7y1aD+ZX0a+NaH
 XOiA==
X-Gm-Message-State: AOJu0Yytvl1V04MPFLpteFOOmhY89sz7NIlHbs0WZANFof1b7vm4CPWk
 6nEMm5kDtHclyGkB4qG1PumjqCG8sB1mKt+ojwUvPYgY9wD+jp46x5V0sEGul1Hh1cIevbNCZXg
 c/bNw4CPR2gyqz74Yha1WiYk=
X-Received: by 2002:a05:6a20:8e0b:b0:199:9acc:4db5 with SMTP id
 y11-20020a056a208e0b00b001999acc4db5mr2741812pzj.28.1704710340355; 
 Mon, 08 Jan 2024 02:39:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVKyZYJfPgV5ZqgkgrdkXd6xejJHdWhEOP8YBjtt2IbM6LF5rMj7uviPM8AWFtfYFW1DiMBA==
X-Received: by 2002:a05:6a20:8e0b:b0:199:9acc:4db5 with SMTP id
 y11-20020a056a208e0b00b001999acc4db5mr2741799pzj.28.1704710340079; 
 Mon, 08 Jan 2024 02:39:00 -0800 (PST)
Received: from smtpclient.apple ([116.73.134.99])
 by smtp.gmail.com with ESMTPSA id
 z125-20020a626583000000b006d9bb753d2esm5984541pfb.166.2024.01.08.02.38.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jan 2024 02:38:59 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: acpiBitsTest.test_acpi_smbios_bits test intermittently times out
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAK3XEhM5BtPtFE5fmsxf8aC+gHo4QEkyhboCcfpsQg=bJOfsjQ@mail.gmail.com>
Date: Mon, 8 Jan 2024 16:08:45 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?utf-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <663FD10C-5544-471F-87E8-8144C9115DEC@redhat.com>
References: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
 <CAK3XEhM75DW+eUFrx=73xPycKvxccdT-Tg5mfFyuW_hAMJJ3+w@mail.gmail.com>
 <CAK3XEhNe4TO4oBavsuqJwP5e1nzB6+xpdWa-D0NEq_-rqXincw@mail.gmail.com>
 <CAFEAcA-fjZw9x2RC+Czo8dQUuux1WUD6fDWCMJ-1xHdGevNWAw@mail.gmail.com>
 <CAK3XEhM5BtPtFE5fmsxf8aC+gHo4QEkyhboCcfpsQg=bJOfsjQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 07-Jan-2024, at 9:56=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> On Sat, Jan 6, 2024 at 5:39=E2=80=AFPM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>=20
>> On Sat, 6 Jan 2024 at 05:41, Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>> On Sat, Jan 6, 2024 at 10:05=E2=80=AFAM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>>=20
>>>> On Sat, Jan 6, 2024 at 12:11=E2=80=AFAM Peter Maydell =
<peter.maydell@linaro.org> wrote:
>>>>>=20
>>>>> The avocado test acpiBitsTest.test_acpi_smbios_bits seems to be
>>>>> flaky in CI -- sometimes it appears to time out.
>>>>>=20
>>>>> https://gitlab.com/qemu-project/qemu/-/issues/2077
>>>>> has the details (including links to jobs etc).
>>>>=20
>>>> Do you have more data points in terms of the jobs that failed?
>>>=20
>>> I just noticed that you attached three examples of failed tests. In
>>> all of them the test seems to be stuck at the ami latency test.
>>=20
>> OK, if you think that subtest is suspicious, could you send a
>> patch that disables just that subpart, and we'll see if it helps?
>=20
> I pushed the patches here:
> https://gitlab.com/anisinha/qemu/-/commits/disable-smilatency
> and ran the pipeline. It passed
> https://gitlab.com/anisinha/qemu/-/jobs/5878585312
>=20
> and the smilatency test was not run:
> =
https://anisinha.gitlab.io/-/qemu/-/jobs/5878585312/artifacts/build/tests/=
results/latest/test-results/01-tests_avocado_acpi-bits.py_AcpiBitsTest.tes=
t_acpi_smbios_bits/debug.log
>=20
> Not sure what we can do to have some confidence that disabling the
> test got rid of the flakiness.

I ran the avocado jobs avocado-system-centos and avocado-system-opensuse =
a few times and all times they passed. So I sent out the patches. Hope =
this settles it.


> I can send out those two patches in the
> list.




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E4B826C09
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:04:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnQl-00076F-B2; Mon, 08 Jan 2024 06:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMnQh-00075S-5Z
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMnQe-0001nY-Uv
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704711863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vfVgBroixxjt6DG4TyTA6yHZ6iXsh5UI/9ybBmKwzNo=;
 b=COTwfD612E74AgMpBRnbiB7yJgfW9JITRr9089TZLZwOFimP7IYEXqYZ8Py7XsVzTLZwYn
 Hox2+LpFex+SNSHfkjA6GPBusxpZPNDAxd3daVstNfK7wRdzLvegjVACjNrblihasKq3hj
 /cHjHzbazp3BPtgI2PiLpMcfjbnTsbo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-O4ck1MevOjGopqJK055drQ-1; Mon, 08 Jan 2024 06:04:16 -0500
X-MC-Unique: O4ck1MevOjGopqJK055drQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d4931d651aso17874145ad.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711855; x=1705316655;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfVgBroixxjt6DG4TyTA6yHZ6iXsh5UI/9ybBmKwzNo=;
 b=cpY+ZGuVhtITe7FCbiSykPxPy80b3oNDeeuIjl+rni4/6F69AdblTqRFbmt34hn5/u
 P/KP6W8UT/avEAgPWCVHmeFNORNjBEakJJdMl9k5PAr9NN6wj8she/9Bm9pCUFQvUv8m
 hbnt5PwuSJNmzf28t5cdu810Sl2N3uQX83xJiNS5e3VEYRMk7IeeiBR4WfTLZVtfLHY0
 z7nPrmipHVV+7xxfamJlE64Dq7Y9SR7yUi6UskEGzk4xU/9dNCjiw4skNzj5s6IodZzZ
 FlYXkWPPJmvObljnKl71wv2SOCGjk+l+Q2N7iwtsgShAxqUsxjirmMfz4l0z18T1rJ6+
 8h7Q==
X-Gm-Message-State: AOJu0YzXGyRRYZm5P3ZxY0esUdeqv341XswN6FN4CGogwM5KVzSgiUX9
 t3d7sOGugfyV+YsdnPqxpG2eEN2/c7v48Q0A4i+2gr/lfzNby8/YYmTXhMoMQyFfgk+zkdkBl7s
 OJ7VNTrVqti2THqdzoDwpT+c=
X-Received: by 2002:a17:903:228d:b0:1d5:4b18:17c6 with SMTP id
 b13-20020a170903228d00b001d54b1817c6mr43996plh.62.1704711855656; 
 Mon, 08 Jan 2024 03:04:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLmfjEJr0N1sjzjn+uSomoUhm+G7t0gqH4sIzd8G4KuvVfDv0qeGMm8aE1RkQ1cu0eM0Ztgw==
X-Received: by 2002:a17:903:228d:b0:1d5:4b18:17c6 with SMTP id
 b13-20020a170903228d00b001d54b1817c6mr43985plh.62.1704711855339; 
 Mon, 08 Jan 2024 03:04:15 -0800 (PST)
Received: from smtpclient.apple ([116.73.134.99])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a1709026b0c00b001d536a910fasm1509401plk.77.2024.01.08.03.04.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:04:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 1/2] acpi/tests/avocado/bits: import smilatency test from
 bits in order to disable it
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA-1Te7mGCBON_z4tyu9pewjiyjAU8g6_is_7MrRrWb0=w@mail.gmail.com>
Date: Mon, 8 Jan 2024 16:34:01 +0530
Cc: Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <57F8E018-0042-4873-A427-EF7B9EFD061E@redhat.com>
References: <20240108103439.4369-1-anisinha@redhat.com>
 <20240108103439.4369-2-anisinha@redhat.com>
 <CAFEAcA-1Te7mGCBON_z4tyu9pewjiyjAU8g6_is_7MrRrWb0=w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 08-Jan-2024, at 4:28=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 8 Jan 2024 at 10:35, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>> Add smilatency test script in the bits avocado tests from bios-bits. =
No changes
>> have been made to the original test script. The test will be disabled =
in the
>> subsequent patch.
>>=20
>> CC: peter.maydell@linaro.org
>> CC: crosa@redhat.com
>> CC: philmd@linaro.org
>> CC: bleal@redhat.com
>> CC: mst@redhat.com
>> CC: wainersm@redhat.com
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> .../acpi-bits/bits-tests/smilatency.py2       | 106 =
++++++++++++++++++
>> 1 file changed, 106 insertions(+)
>> create mode 100644 tests/avocado/acpi-bits/bits-tests/smilatency.py2
>=20
> I'm confused -- why do we need to *add* the test? This
> test already exists somewhere,

That =E2=80=9Csomewhere" is within the bios-bits image. See
https://www.qemu.org/docs/master/devel/acpi-bits.html
See "tests/avocado/acpi-bits/bits-tests=E2=80=9D section.

> because we're running it.
> So why isn't the patch "disable that existing test"?
>=20
> thanks
> -- PMM




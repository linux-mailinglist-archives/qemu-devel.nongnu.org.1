Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081677410D5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 14:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEU7R-0001h9-Ur; Wed, 28 Jun 2023 08:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEU7G-0001XR-CE
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEU7E-0007ST-JF
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 08:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687954663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ala8H6x0Ac6s7oE3CljSWLTbf6OFXx29UtDz2IsVaiE=;
 b=cvE9+1B4uFh12ta4xKKfDKvSggKJgSwkYcn/UAih37zzS13ek6W+mYnp1zpXrw9579uaQI
 P5NXTC5NudQrUsiW+G2EcwVP/t59IxRlT43M7x22mEBdanI+zBfGbt8R3bm1CYtqAmQl68
 mNl7eHF6cLK3/p/KTJL3I0GFaZHlG88=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-M27qJMQ0NuWfKGGLz1JZug-1; Wed, 28 Jun 2023 08:17:42 -0400
X-MC-Unique: M27qJMQ0NuWfKGGLz1JZug-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1b82bf26542so7335135ad.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 05:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687954661; x=1690546661;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ala8H6x0Ac6s7oE3CljSWLTbf6OFXx29UtDz2IsVaiE=;
 b=iGNFPcnGyoJ+dgwefxubacYPa4a4dcG1SBvDz4+2k3t6lheXXHhUHthvVeCYxOb4zV
 a43+rc0NMB5RW6/x1sSHei5BxnDfbw1gyzokRHm3Ad0Z6MYA4Ug31Loh/yWfFRIRe1NM
 v8AMM7NazldJYGV6mMqTxsWMrpzDEQPqphxs7Yam0P47QwPS2L6e89EL2242ffhWs3Kq
 hg3pzQo+4QJ4FkNt/UjsbE/zOLFqkNtUY8X8X/2yWYifXYTq2MqXqEoOVI7/YPOLx2Bp
 xMCKiBzpq+WeRJd3Rrw1bYFA2/FGE8wRwppzPht+3umiAR9Hp4nB9sJ/ohHvH7e7aHrx
 4naQ==
X-Gm-Message-State: AC+VfDzGrxKcPTf/a1YPehrm2Cvo4pGqpPLP3Hs8u8KZ1wS5Eka4A4HS
 voGXcglXgnrJ0rwtvGluF0VLjcoztl1H+U7P3HBt7uN3hdnvvgA/q9YS56pvghwJC3moNqI1hRN
 wgHA9wtqSSjtqTwE=
X-Received: by 2002:a17:902:f650:b0:1b3:d432:3026 with SMTP id
 m16-20020a170902f65000b001b3d4323026mr8233963plg.15.1687954661156; 
 Wed, 28 Jun 2023 05:17:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SVfhi3MYYBVJolQ90kPupjIE50lZzBN5QgFeEytcb92g+aF/gz2gzFpZZDZir+rkMFZG3tQ==
X-Received: by 2002:a17:902:f650:b0:1b3:d432:3026 with SMTP id
 m16-20020a170902f65000b001b3d4323026mr8233939plg.15.1687954660742; 
 Wed, 28 Jun 2023 05:17:40 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 jj11-20020a170903048b00b001b80e07989csm4624015plb.200.2023.06.28.05.17.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 05:17:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v3] acpi/tests/bios-tables-test: make iasl tool handling
 simpler
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230628065132-mutt-send-email-mst@kernel.org>
Date: Wed, 28 Jun 2023 17:47:35 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7866687C-C29F-4B79-82EA-CB6D0A78119F@redhat.com>
References: <20230522103039.19111-1-anisinha@redhat.com>
 <20230626084401-mutt-send-email-mst@kernel.org>
 <9B31F63A-164A-42EF-9387-1F6A56BC9BEA@redhat.com>
 <20230626091206-mutt-send-email-mst@kernel.org>
 <585996FE-8415-4ECC-BBB2-1BDA0C3D8E25@redhat.com>
 <20230628065132-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 28-Jun-2023, at 4:24 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jun 28, 2023 at 12:05:46PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 26-Jun-2023, at 6:49 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Mon, Jun 26, 2023 at 06:33:14PM +0530, Ani Sinha wrote:
>>>>=20
>>>>=20
>>>>> On 26-Jun-2023, at 6:28 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>=20
>>>>> On Mon, May 22, 2023 at 04:00:39PM +0530, Ani Sinha wrote:
>>>>>> Currently the meson based QEMU build process locates the iasl =
binary from the
>>>>>> current PATH and other locations [1] and uses that to set =
CONFIG_IASL in
>>>>>> config-host.h header.This is then used at compile time by =
bios-tables-test to
>>>>>> set iasl path.
>>>>>>=20
>>>>>> This has two disadvantages:
>>>>>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>>>>>> and rebuild QEMU in order to regenerate the header and pick up =
the found
>>>>>> iasl location. One cannot simply use the existing =
bios-tables-test binary
>>>>>> because CONFIG_IASL is only set during the QEMU build time by =
meson and
>>>>>> then bios-tables-test has to be rebuilt with CONFIG_IASL set in =
order to
>>>>>> use iasl.
>>>>>> - Sometimes, the stock iasl that comes with distributions is =
simply not good
>>>>>> enough because it does not support the latest ACPI changes - =
newly
>>>>>> introduced tables or new table attributes etc. In order to test =
ACPI code
>>>>>> in QEMU, one has to clone the latest acpica upstream repository =
and
>>>>>> rebuild iasl in order to get support for it. In those cases, one =
may want
>>>>>> the test to use the iasl binary from a non-standard location.
>>>>>>=20
>>>>>> In order to overcome the above two disadvantages, we set a =
default iasl path
>>>>>> as "/usr/bin/iasl". bios-tables-test also checks for the =
environment variable
>>>>>> IASL_PATH that can be set by the developer. IASL_PATH passed from =
the
>>>>>> environment overrides the default path. This way developers can =
point
>>>>>> IASL_PATH environment variable to a possibly a non-standard =
custom build
>>>>>> binary and quickly run bios-tables-test without rebuilding. If =
the default
>>>>>> path of iasl changes, one simply needs to update the default path =
and rebuild
>>>>>> just the test, not whole QEMU.
>>>>>>=20
>>>>>> [1] =
https://mesonbuild.com/Reference-manual_functions.html#find_program
>>>>>>=20
>>>>>> CC: alex.bennee@linaro.org
>>>>>> CC: pbonzini@redhat.com
>>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>>=20
>>>>> I don't much like environment variables since they are
>>>>> not discoverable.
>>>>=20
>>>> I do have this:
>>>>=20
>>>> +                " Set IASL_PATH environment variable to the path =
of iasl binary\n"
>>>> +                " if iasl is installed somewhere other than =
%s.\n",
>>>=20
>>> You only see this if there's a diff.
>>>=20
>>> And then people stick this in their scripts and are scratching their
>>> heads trying to figure out why is a wrong iasl running.  Or someone
>>> comes up with a different use for IASL_PATH and they conflict.
>>=20
>> OK in that case I think its ok to simply remove the environment
>> variable part. If people are going to be changing a header file,
>=20
> Not people. configure script
>=20
>> they
>> might as well change the DEFAULT_IASL_PATH in the test itself where
>> its easier to find. What additional complication meson provides is
>> that it uses find_program() to find the IASL binary in a list of
>> predefined locations. I do not think this additional tie up with =
meson
>> is worth it for the niche iasl use case.  Simple is beautiful.
>=20
> The just the below then? And we can let it be?

The original problem I had was that I had to rebuild entire QEMU just so =
that it picked up the newly installed iasl binary. This does not seem =
right and I am ok if anyone fixed this in any way they liked. I loved it =
when previously the test =E2=80=9Cjust worked=E2=80=9D when =
transitioning from no installed iasl to iasl installed in default path. =
In my opinion, currently what we do with iasl and meson is way too =
complex and is really not needed for the purpose we use the tool for.

>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
>=20
> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
> index ed1c69cf01..d0e1655d2e 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -102,6 +102,7 @@ typedef struct {
>=20
> static char disk[] =3D "tests/acpi-test-disk-XXXXXX";
> static const char *data_dir =3D "tests/data/acpi";
> +/* If you want your own path, change the below to iasl =3D =
"/home/usr/bin/iasl" */
> #ifdef CONFIG_IASL
> static const char *iasl =3D CONFIG_IASL;
> #else



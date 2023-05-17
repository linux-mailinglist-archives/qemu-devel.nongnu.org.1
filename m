Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3486F706B98
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 16:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzITB-0008Px-1T; Wed, 17 May 2023 10:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzIT8-0008Pi-2i
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzIT5-0001qX-Nd
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684334970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LKeG5hDPgsWQktVDbyJj7bzwPvdVYtcY03P2bb01++s=;
 b=do+yv82NonaSuRYUsizTp6HzWEPmb8FUpCcZDHDwuZdG6uEjZl8w4Kv+ouppb8dqfk8GEh
 5kLtakT/IzVv84nC7shS+r6nogVlsEzUL0tBng4GLTsRQ+cw3Ps1aw3MG+6FEq6soSpPvl
 pnbSwvFfUgBRNf8I7Ciz8pYaho/XO0Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-L0xGO5_fP4OjgcoJR7JgOg-1; Wed, 17 May 2023 10:49:29 -0400
X-MC-Unique: L0xGO5_fP4OjgcoJR7JgOg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2532da9e45bso46136a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 07:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684334968; x=1686926968;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LKeG5hDPgsWQktVDbyJj7bzwPvdVYtcY03P2bb01++s=;
 b=h4P1cNUiNxGot9Jvg00sgTiquog/b3yuHgUMmdpa/ZTWhLjpVORqswTCn+OQsctVZV
 uPTxr1VF9Ts2stwzmVdOPbCWjAkodE8SsQIRGKQVy4gH67scpuhQcGRSxkK7cUYfzeK/
 FuBiB9fHt6fYh6EtfRNjQ+Gqj5Al5j7axGjJTxr0hRJXPpPiQraPTMKgLvOMGjGtwNNt
 iDz6+lhsoSm2T776xBc1+Mos/kd75sk/YuzZ6sTelmHFi4h9lEb6SYADe07R0+s+FWVD
 TRQCQOY7YrIdXnuag5IphimwIwXTZL4haSsyEQS0C/bffTdcXQjBMXw+Hmo1Q3E5BsFt
 HbyA==
X-Gm-Message-State: AC+VfDz8rQW0hwJPavYtwlQyNvuRTdzU/9tFQWqPrVUxRwbp017gM99O
 kKxcEx9hc/NlvdiZ4rAG6bFJ5uoiCLNjPGtCEFqhY+e51nN/OI8yIs+5Jigma5BMcaJ1ARFsmxj
 utof1h4qpWqrKjtM=
X-Received: by 2002:a17:90a:af8c:b0:253:3975:7a37 with SMTP id
 w12-20020a17090aaf8c00b0025339757a37mr3042273pjq.9.1684334968210; 
 Wed, 17 May 2023 07:49:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5bSh/rG2KUAbTLrDywjFxk2D6o2smdBoHyIP0c/j3Jmhr1fhSRRApx3ABO8nNXMEWFvL2ONA==
X-Received: by 2002:a17:90a:af8c:b0:253:3975:7a37 with SMTP id
 w12-20020a17090aaf8c00b0025339757a37mr3042244pjq.9.1684334967764; 
 Wed, 17 May 2023 07:49:27 -0700 (PDT)
Received: from smtpclient.apple ([115.96.105.155])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a17090a950c00b0024e227828a9sm1661604pjo.24.2023.05.17.07.49.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 May 2023 07:49:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230517103522-mutt-send-email-mst@kernel.org>
Date: Wed, 17 May 2023 20:19:23 +0530
Cc: Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>>>> Currently the meson based QEMU build process locates the iasl =
binary from the
>>>> current PATH and other locations [1] and uses that to set =
CONFIG_IASL which is
>>>> then used by the test.
>>>>=20
>>>> This has two disadvantages:
>>>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>>>>  and rebuild QEMU in order to pick up the iasl location. One cannot =
simply
>>>>  use the existing bios-tables-test binary because CONFIG_IASL is =
only set
>>>>  during the QEMU build time by meson and then bios-tables-test has =
to be
>>>>  rebuilt with CONFIG_IASL set in order to use iasl.
>>>> - Sometimes, the stock iasl that comes with distributions is simply =
not good
>>>>  enough because it does not support the latest ACPI changes - newly
>>>>  introduced tables or new table attributes etc. In order to test =
ACPI code
>>>>  in QEMU, one has to clone the latest acpica upstream repository =
and
>>>>  rebuild iasl in order to get support for it. In those cases, one =
may want
>>>>  the test to use the iasl binary from a non-standard location.
>>>>=20
>>>> In order to overcome the above two disadvantages, we introduce a =
new
>>>> environment variable IASL_PATH that can be set by the tester =
pointing to an
>>>> possibly non-standard iasl binary location. Bios-tables-test then =
uses this
>>>> environment variable to set its iasl location, possibly also =
overriding the
>>>> location that was pointed to by CONFIG_IASL that was set by meson. =
This way
>>>> developers can not only use this new environment variable to set =
iasl
>>>> location to quickly run bios-tables-test but also can point the =
test to a
>>>> custom iasl if required.
>>>>=20
>>>> [1] =
https://mesonbuild.com/Reference-manual_functions.html#find_program
>>>>=20
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>=20
>>> Well I think the point was originally that meson can
>>> also test the binary in a variety of ways.
>>> Never surfaced so maybe never mind.
>>>=20
>>> Would it be easier to just look iasl up on path
>>=20
>> But that=E2=80=99s what meson is also doing, only QEMU build time.
>=20
>=20
> So you were unhappy it's build time because it is not really
> part of build and you want flexibility, right?

Hmm, maybe in that case, we might want to resurrect iasl_installed(), =
basically reverting part of cc8fa0e80836c51ba644d910c.

To me its ok if I had to set IASL_PATH=3D`which iasl` before running the =
test. I do not have strong opinions.
=20
>=20
>=20
>>> unless it was specified on command line?
>>>=20
>>>> ---
>>>> tests/qtest/bios-tables-test.c | 14 ++++++++++++++
>>>> 1 file changed, 14 insertions(+)
>>>>=20
>>>> sample runs:
>>>>=20
>>>> $ QTEST_QEMU_BINARY=3D./qemu-system-x86_64 V=3D2 =
./tests/qtest/bios-tables-test
>>>> ...
>>>> acpi-test: Warning! APIC binary file mismatch. Actual =
[aml:/tmp/aml-DLHA51], Expected [aml:tests/data/acpi/pc/APIC].
>>>> See source file tests/qtest/bios-tables-test.c for instructions on =
how to update expected files.
>>>> Using iasl: /usr/bin/iasl
>>>> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-L9GA51.dsl, =
aml:/tmp/aml-DLHA51], Expected [asl:/tmp/asl-10EA51.dsl, =
aml:tests/data/acpi/pc/APIC].
>>>>=20
>>>> $ QTEST_QEMU_BINARY=3D./qemu-system-x86_64 V=3D2 =
IASL_PATH=3D/home/anisinha/workspace/acpica/generate/unix/bin/iasl =
./tests/qtest/bios-tables-test
>>>> ...
>>>> acpi-test: Warning! APIC binary file mismatch. Actual =
[aml:/tmp/aml-5CQ341], Expected [aml:tests/data/acpi/pc/APIC].
>>>> See source file tests/qtest/bios-tables-test.c for instructions on =
how to update expected files.
>>>> User has provided an iasl path, using that: =
/home/anisinha/workspace/acpica/generate/unix/bin/iasl
>>>> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-2GQ341.dsl, =
aml:/tmp/aml-5CQ341], Expected [asl:/tmp/asl-IBR341.dsl, =
aml:tests/data/acpi/pc/APIC].
>>>>=20
>>>> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
>>>> index 7fd88b0e9c..37e8e484cb 100644
>>>> --- a/tests/qtest/bios-tables-test.c
>>>> +++ b/tests/qtest/bios-tables-test.c
>>>> @@ -440,7 +440,12 @@ static void test_acpi_asl(test_data *data)
>>>>    AcpiSdtTable *sdt, *exp_sdt;
>>>>    test_data exp_data =3D {};
>>>>    gboolean exp_err, err, all_tables_match =3D true;
>>>> +    const char *user_iasl_path =3D getenv("IASL_PATH");
>>>>=20
>>>> +    /* if user has provided a path to iasl, use that */
>>>> +    if (user_iasl_path) {
>>>> +        iasl =3D user_iasl_path;
>>>> +    }
>>>>    exp_data.tables =3D load_expected_aml(data);
>>>>    dump_aml_files(data, false);
>>>>    for (i =3D 0; i < data->tables->len; ++i) {
>>>> @@ -473,6 +478,15 @@ static void test_acpi_asl(test_data *data)
>>>>            continue;
>>>>        }
>>>>=20
>>>> +        if (verbosity_level >=3D 2) {
>>>> +            if (user_iasl_path) {
>>>> +                fprintf(stderr, "User has provided an iasl path," =
\
>>>> +                        "using that: %s\n", user_iasl_path);
>>>> +            } else {
>>>> +                fprintf(stderr, "Using iasl: %s\n", iasl);
>>>> +            }
>>>> +        }
>>>> +
>>>>        err =3D load_asl(data->tables, sdt);
>>>>        asl =3D normalize_asl(sdt->asl);
>>>>=20
>>>> --=20
>>>> 2.39.1
>=20



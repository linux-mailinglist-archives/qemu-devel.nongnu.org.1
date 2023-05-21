Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4104B70AE5D
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 16:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0kPa-0000bx-0E; Sun, 21 May 2023 10:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0kPX-0000bj-TI
 for qemu-devel@nongnu.org; Sun, 21 May 2023 10:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0kPV-0004TL-Ua
 for qemu-devel@nongnu.org; Sun, 21 May 2023 10:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684680708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c6ANHP2PVnVqXXnnIn+gnUyxJJpIpvPYTtZ/4tz5IM=;
 b=K0r4DeM0/8U5c14GCnjP6mr/4heNcHftjNAUerxJSk81v9z013HT4wNGoHXwdDnoipBELs
 NiW81eFCIC/gy+4PefNWdkh/XJ+QS235jb7un40PtSNhDNX6dokUhMeIXt56d8Zr+tll20
 8irNmQCbBxGPuiXuDNBkc+Hm5j257Gs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-g1BMrQzHMyazahyKQlVlXQ-1; Sun, 21 May 2023 10:51:46 -0400
X-MC-Unique: g1BMrQzHMyazahyKQlVlXQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-64d48b8ecd2so1239636b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 07:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684680705; x=1687272705;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8c6ANHP2PVnVqXXnnIn+gnUyxJJpIpvPYTtZ/4tz5IM=;
 b=IfINEKQM6W9oGhv5GEp/ZIjgm2TK1t26IMT3sSG9biNUHqN3rWk3ZwDk4o4NkNg53b
 qtpjruqjFa5XEDliva2O0s5xHomIguJb+xdpy/FhVWelvnEPe9YpXU01VM7eBr00FAlT
 AWgJgFqmFTU6HSsaZxTIMgojiw3waq+Tgzc2ESyt3jhVsbk8+Cq3aPtxVSRm/TYyRk8k
 56P3W+Fdu2VfUUiLFp4MSyS61CRvl95RxEnqWYgwPaoAD1MK3lzMXymQCnWpld+vnH2t
 GdwsppfWsSpWBVWCUusCCxBxKXQSTYTOpFrLfSuJbnpsfAXM+GOaZVi4amWCwfcf8iwC
 YIEQ==
X-Gm-Message-State: AC+VfDz4kgwy5h+2zQgkzVBYwQDkz4qOfE53TU6sFkd1pSw9XmNXkFSK
 8++iS4ySIN2xzYCZNEMVC3jJnxzsCiD7C4tOLJjhhjjqu4yKTHGXTbvvi9KJMsoAi71UjT6d56g
 OcCk4DcNS5T231ow=
X-Received: by 2002:a05:6a00:a21:b0:646:9232:df6 with SMTP id
 p33-20020a056a000a2100b0064692320df6mr11691125pfh.33.1684680705622; 
 Sun, 21 May 2023 07:51:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4H6dIGOWYfeX7ebCQ9pc5SbNyVw+HfjA1R6ykGkXsXTV9vmLEbX0ZLppRu855UfOfWTlc3yg==
X-Received: by 2002:a05:6a00:a21:b0:646:9232:df6 with SMTP id
 p33-20020a056a000a2100b0064692320df6mr11691106pfh.33.1684680705175; 
 Sun, 21 May 2023 07:51:45 -0700 (PDT)
Received: from smtpclient.apple ([203.212.246.201])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a62e911000000b0064d413caea6sm2670688pfh.179.2023.05.21.07.51.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 May 2023 07:51:44 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230521045204-mutt-send-email-mst@kernel.org>
Date: Sun, 21 May 2023 20:21:40 +0530
Cc: Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C57E4D4-3198-4DA4-9DCD-1D6A6F75F590@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230521045204-mutt-send-email-mst@kernel.org>
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



> On 21-May-2023, at 2:24 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>> Currently the meson based QEMU build process locates the iasl binary =
from the
>> current PATH and other locations [1] and uses that to set CONFIG_IASL =
which is
>> then used by the test.
>>=20
>> This has two disadvantages:
>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>>   and rebuild QEMU in order to pick up the iasl location. One cannot =
simply
>>   use the existing bios-tables-test binary because CONFIG_IASL is =
only set
>>   during the QEMU build time by meson and then bios-tables-test has =
to be
>>   rebuilt with CONFIG_IASL set in order to use iasl.
>> - Sometimes, the stock iasl that comes with distributions is simply =
not good
>>   enough because it does not support the latest ACPI changes - newly
>>   introduced tables or new table attributes etc. In order to test =
ACPI code
>>   in QEMU, one has to clone the latest acpica upstream repository and
>>   rebuild iasl in order to get support for it. In those cases, one =
may want
>>   the test to use the iasl binary from a non-standard location.
>>=20
>> In order to overcome the above two disadvantages, we introduce a new
>> environment variable IASL_PATH that can be set by the tester pointing =
to an
>> possibly non-standard iasl binary location. Bios-tables-test then =
uses this
>> environment variable to set its iasl location, possibly also =
overriding the
>> location that was pointed to by CONFIG_IASL that was set by meson. =
This way
>> developers can not only use this new environment variable to set iasl
>> location to quickly run bios-tables-test but also can point the test =
to a
>> custom iasl if required.
>>=20
>> [1] =
https://mesonbuild.com/Reference-manual_functions.html#find_program
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> I don't much like it that the default is now a bit harder
> to run. Case of playing with iasl is really esotetic.
> I propose a simpler idea.
> - add config-iasl.h with only CONFIG_IASL set to path
> - include from bios test
>=20
> Now if you change path only bios test is rebuilt.
>=20
> Hmm?

We can do this.=20

If an environment variable CONFIG_IASL is set or a command line is =
passed (we can do one or the other), use that. Else use a default path =
/usr/bin/iasl. This way we do not even need to rebuild the test if the =
developer wishes to use another iasl binary from a different location.=20=

I prefer env var slightly because its easier to implement from meson. =
Test specific command lines in meson.build would need more work.

>=20
>=20
>> ---
>> tests/qtest/bios-tables-test.c | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>=20
>> sample runs:
>>=20
>> $ QTEST_QEMU_BINARY=3D./qemu-system-x86_64 V=3D2 =
./tests/qtest/bios-tables-test
>> ...
>> acpi-test: Warning! APIC binary file mismatch. Actual =
[aml:/tmp/aml-DLHA51], Expected [aml:tests/data/acpi/pc/APIC].
>> See source file tests/qtest/bios-tables-test.c for instructions on =
how to update expected files.
>> Using iasl: /usr/bin/iasl
>> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-L9GA51.dsl, =
aml:/tmp/aml-DLHA51], Expected [asl:/tmp/asl-10EA51.dsl, =
aml:tests/data/acpi/pc/APIC].
>>=20
>> $ QTEST_QEMU_BINARY=3D./qemu-system-x86_64 V=3D2 =
IASL_PATH=3D/home/anisinha/workspace/acpica/generate/unix/bin/iasl =
./tests/qtest/bios-tables-test
>> ...
>> acpi-test: Warning! APIC binary file mismatch. Actual =
[aml:/tmp/aml-5CQ341], Expected [aml:tests/data/acpi/pc/APIC].
>> See source file tests/qtest/bios-tables-test.c for instructions on =
how to update expected files.
>> User has provided an iasl path, using that: =
/home/anisinha/workspace/acpica/generate/unix/bin/iasl
>> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-2GQ341.dsl, =
aml:/tmp/aml-5CQ341], Expected [asl:/tmp/asl-IBR341.dsl, =
aml:tests/data/acpi/pc/APIC].
>>=20
>> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
>> index 7fd88b0e9c..37e8e484cb 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -440,7 +440,12 @@ static void test_acpi_asl(test_data *data)
>>     AcpiSdtTable *sdt, *exp_sdt;
>>     test_data exp_data =3D {};
>>     gboolean exp_err, err, all_tables_match =3D true;
>> +    const char *user_iasl_path =3D getenv("IASL_PATH");
>>=20
>> +    /* if user has provided a path to iasl, use that */
>> +    if (user_iasl_path) {
>> +        iasl =3D user_iasl_path;
>> +    }
>>     exp_data.tables =3D load_expected_aml(data);
>>     dump_aml_files(data, false);
>>     for (i =3D 0; i < data->tables->len; ++i) {
>> @@ -473,6 +478,15 @@ static void test_acpi_asl(test_data *data)
>>             continue;
>>         }
>>=20
>> +        if (verbosity_level >=3D 2) {
>> +            if (user_iasl_path) {
>> +                fprintf(stderr, "User has provided an iasl path," \
>> +                        "using that: %s\n", user_iasl_path);
>> +            } else {
>> +                fprintf(stderr, "Using iasl: %s\n", iasl);
>> +            }
>> +        }
>> +
>>         err =3D load_asl(data->tables, sdt);
>>         asl =3D normalize_asl(sdt->asl);
>>=20
>> --=20
>> 2.39.1



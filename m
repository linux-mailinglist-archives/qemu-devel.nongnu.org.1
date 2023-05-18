Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A85F7079F3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 07:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWbb-0002p5-8r; Thu, 18 May 2023 01:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzWbZ-0002or-D7
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzWbW-0002L5-HJ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 01:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684389309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJOrTSvt7kvjrlIC7/5CxDEtPtSJdtPMzhiyIj0uErc=;
 b=FI74o2ywO5hUSnjezvBqdZPGTGbT66BqzQDuzh1rJwnWaXnrmC+XYNQO60YK6hxvDVMoJt
 +MNTH21F9QAogPifOFbCMMbipT90hlbhfveVdQ3RHIpfeCTExgXlGoSO+itxzlgbAUWN/F
 uJp3xcJkMdwGZIm3bDdjEqfkLXpi+LE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-5X_m4QPqNjuUf--glZnWKQ-1; Thu, 18 May 2023 01:55:07 -0400
X-MC-Unique: 5X_m4QPqNjuUf--glZnWKQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6435432f56bso1059111b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 22:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684389306; x=1686981306;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJOrTSvt7kvjrlIC7/5CxDEtPtSJdtPMzhiyIj0uErc=;
 b=ZexsvoZGW23HqiO0ZeXI0B0gZbhWC5W87MtITMtpjzAbs2nUxUvuFzgxzfJKdb4ETV
 7DAc0MEvP4sPL3ZcHIhl3b/r1Vkmha74tat00/WwrWfy7kyuWQqFIKeU1cZSEavzn6FL
 b69uee0qrvq83tGxV63+WZ3WBdws+NHDm+mYr7O/Gq4Bt4ADwrKPtCiO0c6fgtCoV2b1
 h+Wy7Le2vvNsIzo/Ce0hiIa2DYv5CVll3iwn59yMnWRP26QfUOwt1CBbo8Zm6TC2/Mg+
 m4S/J+s5bx7kg4NwEa9Sn/HbrJfTYdMHFBkM1Yoha9RK8kede9B+5fAtrRSMOTWisZzX
 ppZA==
X-Gm-Message-State: AC+VfDx4z/L1+mz0WjEl6klY2uEK9mz2rGw2Cb9oaCZA5ffNUsBO5H0b
 KnL+qM2MzugDo+gHmnBMkL4U+03nxzWRShmrdHreoUT/YB1vL0ZyLtY3xOwK0dYLQE8SPahAWYj
 MYdPPftQmLauuX7k=
X-Received: by 2002:a05:6a20:8414:b0:102:8f0a:5acf with SMTP id
 c20-20020a056a20841400b001028f0a5acfmr938999pzd.62.1684389306180; 
 Wed, 17 May 2023 22:55:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bRRzVMuLfrNj1BviGPLbnFNshTEkYUCNkN++XFjt+Leu4shr7ycuo8vhRS+FGCrvVoaZNrg==
X-Received: by 2002:a05:6a20:8414:b0:102:8f0a:5acf with SMTP id
 c20-20020a056a20841400b001028f0a5acfmr938981pzd.62.1684389305788; 
 Wed, 17 May 2023 22:55:05 -0700 (PDT)
Received: from smtpclient.apple ([115.96.106.170])
 by smtp.gmail.com with ESMTPSA id
 f19-20020aa782d3000000b0064928cb5f03sm495645pfn.69.2023.05.17.22.55.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 May 2023 22:55:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <B4E3F951-D046-428B-BA6D-57D5DBCDFED6@gmail.com>
Date: Thu, 18 May 2023 11:25:01 +0530
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4292575-77D7-4F05-B6E7-551F0590C224@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <B4E3F951-D046-428B-BA6D-57D5DBCDFED6@gmail.com>
To: Bernhard Beschow <shentey@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 17-May-2023, at 10:13 PM, Bernhard Beschow <shentey@gmail.com> =
wrote:
>=20
>=20
>=20
> Am 17. Mai 2023 12:07:51 UTC schrieb Ani Sinha <anisinha@redhat.com>:
>> Currently the meson based QEMU build process locates the iasl binary =
from the
>> current PATH and other locations [1] and uses that to set CONFIG_IASL =
which is
>> then used by the test.
>>=20
>> This has two disadvantages:
>> - If iasl was not previously installed in the PATH, one has to =
install iasl
>>  and rebuild QEMU in order to pick up the iasl location. One cannot =
simply
>>  use the existing bios-tables-test binary because CONFIG_IASL is only =
set
>>  during the QEMU build time by meson and then bios-tables-test has to =
be
>>  rebuilt with CONFIG_IASL set in order to use iasl.
>> - Sometimes, the stock iasl that comes with distributions is simply =
not good
>>  enough because it does not support the latest ACPI changes - newly
>>  introduced tables or new table attributes etc. In order to test ACPI =
code
>>  in QEMU, one has to clone the latest acpica upstream repository and
>>  rebuild iasl in order to get support for it. In those cases, one may =
want
>>  the test to use the iasl binary from a non-standard location.
>>=20
>> In order to overcome the above two disadvantages, we introduce a new
>> environment variable IASL_PATH that can be set by the tester pointing =
to an
>> possibly non-standard iasl binary location.
>=20
> Why not add a submodule -- l

Submodules are disliked with all fervour by the community. There is a =
long thread somewhere in the mailing list.

> ike we do with dtc -- and use that? Then we could possibly convert the =
ACPI blobs used in bios-tables-test into text files which would make AML =
patches a bit more comprehensible. We also didn't have to trust the =
commit messages to contain the actual change because one would see it =
right in the patch.
>=20
> Best regards,
> Bernhard
>=20
>> Bios-tables-test then uses this
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
>>    AcpiSdtTable *sdt, *exp_sdt;
>>    test_data exp_data =3D {};
>>    gboolean exp_err, err, all_tables_match =3D true;
>> +    const char *user_iasl_path =3D getenv("IASL_PATH");
>>=20
>> +    /* if user has provided a path to iasl, use that */
>> +    if (user_iasl_path) {
>> +        iasl =3D user_iasl_path;
>> +    }
>>    exp_data.tables =3D load_expected_aml(data);
>>    dump_aml_files(data, false);
>>    for (i =3D 0; i < data->tables->len; ++i) {
>> @@ -473,6 +478,15 @@ static void test_acpi_asl(test_data *data)
>>            continue;
>>        }
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
>>        err =3D load_asl(data->tables, sdt);
>>        asl =3D normalize_asl(sdt->asl);
>>=20
>=20



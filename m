Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69427706E72
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKG2-000386-4M; Wed, 17 May 2023 12:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzKG0-00037x-62
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:08 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzKFy-0007vn-Ae
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:44:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-50bc456cc39so1548895a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684341844; x=1686933844;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=rRaCVOy3M6DEpbNxebedlzbLZ8Qqg2jCiBcvdzDKl7A=;
 b=VajFu+HnqvBf3itHWP3MPKIOPLM8+Xq4DIb4HpMyQnCdifEkoykZsJoU2ZMOjl7qp1
 +tLUJ1xpvEuUZakFyNa5IMklz0Y2UAzYnWOBmbkblUv8Xmz8Z3Iyah/TovX/DCrLwZOP
 bw+xxmdye9Es+lvU6HgmTI+6HTQlXCBo+cJpAENYg5PB7bRrOr76uTV4xWT4l3YhK4B9
 J7yhL62Twzca1++ZwUZFx4xJULFcfydpZslrn8kv/SNrU/xwR+bmZwV1kO//ZkPS66AU
 PNU4HqHMrcaCFDVjPkf/Ak/I2ce8T7/rTYbWyvbVnQkOId4OGt7DoRYFsvpE3HCvC655
 Jl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341844; x=1686933844;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rRaCVOy3M6DEpbNxebedlzbLZ8Qqg2jCiBcvdzDKl7A=;
 b=QBQYNQQvoms6ImlpVUEqn/wdXa/3OkEXjmPNnHSqKNsT+LedXn/2Fh0KefV1PR9PiN
 IFKHqImLwDAStL8TJ3q71pfCGGQDUr22UFXlov9+ZmnKQ2pvTRbxvVq4t0m+MCEsZoDK
 tvqM0wF2hZsq/NY7dQQnxtdlk+ulOn60jC9G5W+M/GkR3ycLfETphq4s5ygKwNBduns0
 Y0d9kJ6mdIcDfz3mClVwAqpKUXL1MQMvxhAB+BqcZLz4Jbv3+XcxUp/w0k+y5o4StcNT
 D/o4t736y/idQEPIsXTWYS/cbcCXV0udX56EEEAydaMAxj0gYZ6Nr+bPbDr2eh9ZpEC2
 PTJw==
X-Gm-Message-State: AC+VfDzrqXnK1jUrnMSoJUAxJXV16HlUTNPR8w54FBnAyiNiavoMcyw0
 lVSQ2Pxc/LoWZOqJyBIsZjFm9EIV1PI=
X-Google-Smtp-Source: ACHHUZ5aF6LmgEBbA3p+b9vWYMYR4ktTZtdEaoHCeC8f+mjnJLSt2nytulytTKxr+oWDX23EUFr7tw==
X-Received: by 2002:a17:907:25c8:b0:94a:ac4b:e11b with SMTP id
 ae8-20020a17090725c800b0094aac4be11bmr32420517ejc.39.1684341844013; 
 Wed, 17 May 2023 09:44:04 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-030-242.77.191.pool.telefonica.de.
 [77.191.30.242]) by smtp.gmail.com with ESMTPSA id
 ia2-20020a170907a06200b00959c07bdbc8sm12533599ejc.100.2023.05.17.09.44.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 09:44:03 -0700 (PDT)
Date: Wed, 17 May 2023 16:43:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_acpi/tests/bios-tables-test=3A_ad?=
 =?US-ASCII?Q?d_an_environment_variable_for_iasl_location?=
In-Reply-To: <20230517120751.14679-1-anisinha@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
Message-ID: <B4E3F951-D046-428B-BA6D-57D5DBCDFED6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 17=2E Mai 2023 12:07:51 UTC schrieb Ani Sinha <anisinha@redhat=2Ecom>:
>Currently the meson based QEMU build process locates the iasl binary from=
 the
>current PATH and other locations [1] and uses that to set CONFIG_IASL whi=
ch is
>then used by the test=2E
>
>This has two disadvantages:
> - If iasl was not previously installed in the PATH, one has to install i=
asl
>   and rebuild QEMU in order to pick up the iasl location=2E One cannot s=
imply
>   use the existing bios-tables-test binary because CONFIG_IASL is only s=
et
>   during the QEMU build time by meson and then bios-tables-test has to b=
e
>   rebuilt with CONFIG_IASL set in order to use iasl=2E
> - Sometimes, the stock iasl that comes with distributions is simply not =
good
>   enough because it does not support the latest ACPI changes - newly
>   introduced tables or new table attributes etc=2E In order to test ACPI=
 code
>   in QEMU, one has to clone the latest acpica upstream repository and
>   rebuild iasl in order to get support for it=2E In those cases, one may=
 want
>   the test to use the iasl binary from a non-standard location=2E
>
>In order to overcome the above two disadvantages, we introduce a new
>environment variable IASL_PATH that can be set by the tester pointing to =
an
>possibly non-standard iasl binary location=2E

Why not add a submodule -- like we do with dtc -- and use that? Then we co=
uld possibly convert the ACPI blobs used in bios-tables-test into text file=
s which would make AML patches a bit more comprehensible=2E We also didn't =
have to trust the commit messages to contain the actual change because one =
would see it right in the patch=2E

Best regards,
Bernhard

>Bios-tables-test then uses this
>environment variable to set its iasl location, possibly also overriding t=
he
>location that was pointed to by CONFIG_IASL that was set by meson=2E This=
 way
>developers can not only use this new environment variable to set iasl
>location to quickly run bios-tables-test but also can point the test to a
>custom iasl if required=2E
>
>[1] https://mesonbuild=2Ecom/Reference-manual_functions=2Ehtml#find_progr=
am
>
>Signed-off-by: Ani Sinha <anisinha@redhat=2Ecom>
>---
> tests/qtest/bios-tables-test=2Ec | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>sample runs:
>
>$ QTEST_QEMU_BINARY=3D=2E/qemu-system-x86_64 V=3D2 =2E/tests/qtest/bios-t=
ables-test
>=2E=2E=2E
>acpi-test: Warning! APIC binary file mismatch=2E Actual [aml:/tmp/aml-DLH=
A51], Expected [aml:tests/data/acpi/pc/APIC]=2E
>See source file tests/qtest/bios-tables-test=2Ec for instructions on how =
to update expected files=2E
>Using iasl: /usr/bin/iasl
>acpi-test: Warning! APIC mismatch=2E Actual [asl:/tmp/asl-L9GA51=2Edsl, a=
ml:/tmp/aml-DLHA51], Expected [asl:/tmp/asl-10EA51=2Edsl, aml:tests/data/ac=
pi/pc/APIC]=2E
>
>$ QTEST_QEMU_BINARY=3D=2E/qemu-system-x86_64 V=3D2 IASL_PATH=3D/home/anis=
inha/workspace/acpica/generate/unix/bin/iasl =2E/tests/qtest/bios-tables-te=
st
>=2E=2E=2E
>acpi-test: Warning! APIC binary file mismatch=2E Actual [aml:/tmp/aml-5CQ=
341], Expected [aml:tests/data/acpi/pc/APIC]=2E
>See source file tests/qtest/bios-tables-test=2Ec for instructions on how =
to update expected files=2E
>User has provided an iasl path, using that: /home/anisinha/workspace/acpi=
ca/generate/unix/bin/iasl
>acpi-test: Warning! APIC mismatch=2E Actual [asl:/tmp/asl-2GQ341=2Edsl, a=
ml:/tmp/aml-5CQ341], Expected [asl:/tmp/asl-IBR341=2Edsl, aml:tests/data/ac=
pi/pc/APIC]=2E
>
>diff --git a/tests/qtest/bios-tables-test=2Ec b/tests/qtest/bios-tables-t=
est=2Ec
>index 7fd88b0e9c=2E=2E37e8e484cb 100644
>--- a/tests/qtest/bios-tables-test=2Ec
>+++ b/tests/qtest/bios-tables-test=2Ec
>@@ -440,7 +440,12 @@ static void test_acpi_asl(test_data *data)
>     AcpiSdtTable *sdt, *exp_sdt;
>     test_data exp_data =3D {};
>     gboolean exp_err, err, all_tables_match =3D true;
>+    const char *user_iasl_path =3D getenv("IASL_PATH");
>=20
>+    /* if user has provided a path to iasl, use that */
>+    if (user_iasl_path) {
>+        iasl =3D user_iasl_path;
>+    }
>     exp_data=2Etables =3D load_expected_aml(data);
>     dump_aml_files(data, false);
>     for (i =3D 0; i < data->tables->len; ++i) {
>@@ -473,6 +478,15 @@ static void test_acpi_asl(test_data *data)
>             continue;
>         }
>=20
>+        if (verbosity_level >=3D 2) {
>+            if (user_iasl_path) {
>+                fprintf(stderr, "User has provided an iasl path," \
>+                        "using that: %s\n", user_iasl_path);
>+            } else {
>+                fprintf(stderr, "Using iasl: %s\n", iasl);
>+            }
>+        }
>+
>         err =3D load_asl(data->tables, sdt);
>         asl =3D normalize_asl(sdt->asl);
>=20


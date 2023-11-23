Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D37F5C9B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:39:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r676c-00052s-JA; Thu, 23 Nov 2023 05:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r676W-000518-GW
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r676U-0005Z2-Q3
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700735917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZY5ihg166yGtmA7zInC/LOZuGduYLuzNg6wn+LLCqIU=;
 b=XHZr0eFIcxdlSMRnJ6zbvPHUN7eyoyrtEd44QmWJ7S4RGtbnJN/2CL5dRybst5j0ZD4ihD
 MkI6Nrf9B6npUapOHQT0FBkD6Qfx6G08FapObazj9ca87fZlqdigcfIzB2YYsAt4DOqGGX
 1wlaeRAbSLkXVa1dFcjTo7yc8lnSWTs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-sYIUQ__wOkeZJt8ZFM9Ehw-1; Thu, 23 Nov 2023 05:38:35 -0500
X-MC-Unique: sYIUQ__wOkeZJt8ZFM9Ehw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1ce5bad4515so9079685ad.1
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700735914; x=1701340714;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZY5ihg166yGtmA7zInC/LOZuGduYLuzNg6wn+LLCqIU=;
 b=EduQIdQYuOC2/uqGfhTJxQ70ugbD5UZYGkj4X+nhASWLh+yKB3C7AxfPWB/INDWgWq
 AtKlW9SWuGAb9PUsmkGp0oLyaLAj0q9Wgtz+OnlOlVsevtlBNAJkGpBfuVY/pUk6w8i3
 01vTVva9+/fUIDdXMVNiDCbGMdn5o5Glq0Uxz6CF/U6VnPDrUgd2nqEotfnsfekEAFr8
 b6V0g2cZUBE+n+zhVkjF+upXWnYhTS/0O89UNPMYQ6Q2mC5NQXivAnx2KSOfAAQ1N2Od
 2mkoGFGoDDyiY62BXkagECIb0mN9zyt/cqet07bSodttUPsO3VYhG9jNfRtKePCbqmV2
 gg0w==
X-Gm-Message-State: AOJu0Yzh4WZifWof7LYaFLmJUhaCw8dPbl0wMncRhGKS5WvMQ5zPDXJX
 yV0824qvdU4YA33icRDvB+6Ib4sfX/7PQTlhONMG6JWW0LOVx+VQnhQDbYKI4D+1qByjXyyx2NR
 j6Mc3to+hvoJB5hI=
X-Received: by 2002:a17:902:f68a:b0:1cf:6704:4340 with SMTP id
 l10-20020a170902f68a00b001cf67044340mr4744329plg.22.1700735914191; 
 Thu, 23 Nov 2023 02:38:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyPDDmO3JD2uERe5Ky5BYM2WWFZ8RCBlLijFll4u6IupLQhLuyFaCYq4OKgkcWxF1dWCHWZg==
X-Received: by 2002:a17:902:f68a:b0:1cf:6704:4340 with SMTP id
 l10-20020a170902f68a00b001cf67044340mr4744316plg.22.1700735913763; 
 Thu, 23 Nov 2023 02:38:33 -0800 (PST)
Received: from smtpclient.apple ([203.163.236.131])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d68b00b001ce6452a741sm943006ply.25.2023.11.23.02.38.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Nov 2023 02:38:33 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <F54768EF-9AEE-4CB4-B6C2-AC88A718922F@redhat.com>
Date: Thu, 23 Nov 2023 16:08:19 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6327B26E-FCF9-468A-9E7D-D9F4AA0D870D@redhat.com>
References: <20231107044952.5461-1-anisinha@redhat.com>
 <1D3FCCB3-FEDE-4E08-BD42-7070697913E3@redhat.com>
 <F54768EF-9AEE-4CB4-B6C2-AC88A718922F@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 21-Nov-2023, at 12:39=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 16-Nov-2023, at 11:30=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>>=20
>>=20
>>> On 07-Nov-2023, at 10:19=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>>=20
>>> When dumping table blobs using rebuild-expected-aml.sh, table blobs =
from all
>>> test variants are dumped regardless of whether there are any actual =
changes to
>>> the tables or not. This creates lot of new files for various test =
variants that
>>> are not part of the git repository. This is because we do not check =
in all table
>>> blobs for all test variants into the repository. Only those blobs =
for those
>>> variants that are different from the generic test-variant agnostic =
blob are
>>> checked in.
>>>=20
>>> This change makes the test smarter by checking if at all there are =
any changes
>>> in the tables from the checked-in gold master blobs and take actions
>>> accordingly.
>>>=20
>>> When there are no changes:
>>> - No new table blobs would be written.
>>> - Existing table blobs will be refreshed (git diff will show no =
changes).
>>> When there are changes:
>>> - New table blob files will be dumped.
>>> - Existing table blobs will be refreshed (git diff will show that =
the files
>>> changed, asl diff will show the actual changes).
>>> When new tables are introduced:
>>> - Zero byte empty file blobs for new tables as instructed in the =
header of
>>> bios-tables-test.c will be regenerated to actual table blobs.
>>>=20
>>> This would make analyzing changes to tables less confusing and there =
would
>>> be no need to clean useless untracked files when there are no table =
changes.
>>>=20
>>> CC: peter.maydell@linaro.org
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>>=20
>>> changelog:
>>> v2: commit description updated to make things a little clearer.
>>>  No actual changes.
>>=20
>> Ping ...
>=20
> Ping again ...

Ping =E2=80=A6

>=20
>>=20
>>>=20
>>> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
>>> index 9f4bc15aab..743b509e93 100644
>>> --- a/tests/qtest/bios-tables-test.c
>>> +++ b/tests/qtest/bios-tables-test.c
>>> @@ -109,6 +109,7 @@ static const char *iasl;
>>> #endif
>>>=20
>>> static int verbosity_level;
>>> +static GArray *load_expected_aml(test_data *data);
>>>=20
>>> static bool compare_signature(const AcpiSdtTable *sdt, const char =
*signature)
>>> {
>>> @@ -241,21 +242,32 @@ static void test_acpi_fadt_table(test_data =
*data)
>>>=20
>>> static void dump_aml_files(test_data *data, bool rebuild)
>>> {
>>> -    AcpiSdtTable *sdt;
>>> +    AcpiSdtTable *sdt, *exp_sdt;
>>>   GError *error =3D NULL;
>>>   gchar *aml_file =3D NULL;
>>> +    test_data exp_data =3D {};
>>>   gint fd;
>>>   ssize_t ret;
>>>   int i;
>>>=20
>>> +    exp_data.tables =3D load_expected_aml(data);
>>>   for (i =3D 0; i < data->tables->len; ++i) {
>>>       const char *ext =3D data->variant ? data->variant : "";
>>>       sdt =3D &g_array_index(data->tables, AcpiSdtTable, i);
>>> +        exp_sdt =3D &g_array_index(exp_data.tables, AcpiSdtTable, =
i);
>>>       g_assert(sdt->aml);
>>> +        g_assert(exp_sdt->aml);
>>>=20
>>>       if (rebuild) {
>>>           aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, =
data->machine,
>>>                                      sdt->aml, ext);
>>> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>>> +                sdt->aml_len =3D=3D exp_sdt->aml_len &&
>>> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
>>> +                /* identical tables, no need to write new files */
>>> +                g_free(aml_file);
>>> +                continue;
>>> +            }
>>>           fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>>>                       S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>>>           if (fd < 0) {
>>> --=20
>>> 2.42.0




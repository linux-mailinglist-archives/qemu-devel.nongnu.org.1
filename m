Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3927E2868
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01IO-0001aP-AG; Mon, 06 Nov 2023 10:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r01IL-0001a8-1e
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:13:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r01IJ-0000G7-EF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699283618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AxIvzB657al+g2Hx3OJc2tT3zy/d4AgVawfGWfwfSYA=;
 b=cKnVwLWA0O5MUegEdEYEtpaWaEKNQirCucVJ93soYw/KaNRUr6slv8HzLM9DJ1NCQt4DbO
 q82+EHlUoPFgd836ugbx0fIM/pbz/hPxnfRVC2bEoh9MxK6Erv9tWakjMtrEmfLmi01dQD
 dtYmfgSbrIlw3HgJCX2sZst4aOrpF3o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-VMkN16fhOqulbn3bpIG-4Q-1; Mon, 06 Nov 2023 10:13:21 -0500
X-MC-Unique: VMkN16fhOqulbn3bpIG-4Q-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1cc5ef7e815so30430215ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:13:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699283599; x=1699888399;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxIvzB657al+g2Hx3OJc2tT3zy/d4AgVawfGWfwfSYA=;
 b=ulRj5AB+JkP0VlZPmVnKcpxq1SkNSXWQG9wCizFFfj0zw8/i3R1FcN+bXWv1sWyKiB
 7pYMIMwdg8aTXdaD3rSpIY80HUORFaqwzgKGKvTh/QccxMKsD4RVgSYmml3xGEOuOJsd
 3rWzv2UOAyd9TkxrliclpqxdvBuzItu35e464TX2dAU7d+MnDd+OQuzLy3HZpP/9nkgq
 5/LTu0P0qAHj/ng6wajSzMCMsFJpl9sTjQ/V2dYfhiNo1LvmPGveNcZBrM//n7ABqDBz
 WFHq/TEZqh9zFg7be9e6eLbWYslIq6LgW3hQUv0Sgloe2VOacA5nNC/9xVPJTl8qyy4F
 SMzg==
X-Gm-Message-State: AOJu0YyGThaV9D9S96PsVF0vVlgEGjooU7OKM+3BoD1j5mqpbGDw2wfl
 3EpuKjotirfWZseW5mlH8hLoSUmxJ6+1brheu4wIDOFPYIgCQqh5AiOCAF9uuD/FqtXyj1rX9U2
 q48rOOKeLmwWcKuf/RwlNwUY=
X-Received: by 2002:a17:902:bcca:b0:1cc:41e1:ba38 with SMTP id
 o10-20020a170902bcca00b001cc41e1ba38mr17231410pls.66.1699283599473; 
 Mon, 06 Nov 2023 07:13:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeZZQGTVgvrKxBvFUebCKBKGa2RlPEf7haoGf8dUPO3Bn9AL+XKnGWTIa5UC1M+Cx+fpIrbw==
X-Received: by 2002:a17:902:bcca:b0:1cc:41e1:ba38 with SMTP id
 o10-20020a170902bcca00b001cc41e1ba38mr17231392pls.66.1699283599065; 
 Mon, 06 Nov 2023 07:13:19 -0800 (PST)
Received: from smtpclient.apple ([115.96.199.186])
 by smtp.gmail.com with ESMTPSA id
 io23-20020a17090312d700b001c3267ae317sm6074022plb.165.2023.11.06.07.13.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:13:18 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231106151511.57c1e397@imammedo.users.ipa.redhat.com>
Date: Mon, 6 Nov 2023 20:43:14 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6F3F2E64-DA3E-43FC-848F-3C3DCE0937EF@redhat.com>
References: <20231102081624.25229-1-anisinha@redhat.com>
 <20231106151511.57c1e397@imammedo.users.ipa.redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



> On 06-Nov-2023, at 7:45 PM, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> On Thu,  2 Nov 2023 13:46:24 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
>=20
>> When dumping table blobs using rebuild-expected-aml.sh, table blobs =
from all
>> test variants are dumped regardless of whether there are any actual =
changes to
>> the tables or not. This creates lot of new files for various test =
variants that
>> are not part of the git repository. This is because we do not check =
in all table
>> blobs for all test variants into the repository. Only those blobs for =
those
>> variants that are different from the generic test-variant agnostic =
blob are
>> checked in.
>>=20
>> This change makes the test smarter by checking if at all there are =
any changes
>> in the tables from the checked-in gold master blobs.
>=20
>> If there are no changes, no new files are written for test variants.
>> However, existing files continue to be overwritten regardless of =
whether there are changes.
>> Hence, new files will be generated only when there are actual changes =
in the tables.
>=20
> You lost me in those 3 sentences. Perhaps rephrasing and adding =
examples
> wold make it readable. (aka what's (not)writen and when)

OK I will try in v2.

>=20
>=20
>> This would make analyzing changes to tables less confusing and there =
would
>> be no need to clean useless untracked files when there are no table =
changes.
>=20
> what happens if an absolutely new table has been introduced which
> is not mentioned in tests yet (will it be dumped or not)?

When a new table is introduced, there is no existing data to compare the =
tables with. In this case, it will result in assertion in the following =
line:

>     g_assert(exp_sdt.aml_file);

I am not sure what to do in this case except to unconditionally dump all =
tables. Maybe introduce another flag? Not sure.

>=20
>>=20
>> CC: peter.maydell@linaro.org
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
>> index 9f4bc15aab..743b509e93 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -109,6 +109,7 @@ static const char *iasl;
>> #endif
>>=20
>> static int verbosity_level;
>> +static GArray *load_expected_aml(test_data *data);
>>=20
>> static bool compare_signature(const AcpiSdtTable *sdt, const char =
*signature)
>> {
>> @@ -241,21 +242,32 @@ static void test_acpi_fadt_table(test_data =
*data)
>>=20
>> static void dump_aml_files(test_data *data, bool rebuild)
>> {
>> -    AcpiSdtTable *sdt;
>> +    AcpiSdtTable *sdt, *exp_sdt;
>>     GError *error =3D NULL;
>>     gchar *aml_file =3D NULL;
>> +    test_data exp_data =3D {};
>>     gint fd;
>>     ssize_t ret;
>>     int i;
>>=20
>> +    exp_data.tables =3D load_expected_aml(data);
>>     for (i =3D 0; i < data->tables->len; ++i) {
>>         const char *ext =3D data->variant ? data->variant : "";
>>         sdt =3D &g_array_index(data->tables, AcpiSdtTable, i);
>> +        exp_sdt =3D &g_array_index(exp_data.tables, AcpiSdtTable, =
i);
>>         g_assert(sdt->aml);
>> +        g_assert(exp_sdt->aml);
>>=20
>>         if (rebuild) {
>>             aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, =
data->machine,
>>                                        sdt->aml, ext);
>> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>> +                sdt->aml_len =3D=3D exp_sdt->aml_len &&
>> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
>> +                /* identical tables, no need to write new files */
>> +                g_free(aml_file);
>> +                continue;
>> +            }
>>             fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>>                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>>             if (fd < 0) {



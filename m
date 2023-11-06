Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A01817E288E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:23:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01QC-0005RJ-OM; Mon, 06 Nov 2023 10:21:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r01QB-0005Qb-0l
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:21:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r01Q9-0002Kb-AJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699284104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8i/UXXwHaZ2UQubk7AUm81jSZIt41f90v+IPe02EN6U=;
 b=RrBgLRSvDd6yMmqjqdi1QQsxbuNYJI1Sx30HJaM+GrhFfdgGiBlhSRGbVfK1iJoHgHx8Cq
 +gnNU3kB9CAa86WLal6+E+1ZYS4pBfGUJBG4K0GDDZjk2GYYZasvrWZ3PUHGfaTQzaHu7M
 SWyzOCa6aEtGIpggHw6hpPUQBvcyycg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-yAzVcwCdMOibV8NVSk-ZNw-1; Mon, 06 Nov 2023 10:21:42 -0500
X-MC-Unique: yAzVcwCdMOibV8NVSk-ZNw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1cc281f1214so37168185ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284101; x=1699888901;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8i/UXXwHaZ2UQubk7AUm81jSZIt41f90v+IPe02EN6U=;
 b=v9thbmL6Y7ItN+02cjOvjOipB1VZC1FfutJ+rU/bdVg5i87QDzwOk7K8Jo3mSEITQh
 8EngQ6Ub7BfHV2NqIIWkhCfAFFHGfGDCN/RyuKjzJDAIKIizcEUS8DOWWyDND8LDavV+
 wnO5irz1XAqEzm7vPkwVaL8Gnh/HFXy9lLoLuzF+3BcKSD7bjcj5EY/zUAUif6kJDtX4
 wYONwrbvXuM/c4t7u3kW1FsHlUZDiyyWyZGw7hwdYs5RLI8xjoRT547uoIKiEn6YbnjH
 7AKDuxvh2iuh4aVkp17G0rHeJvOSZjzbAyCtPZ1N9PzaCkfu1eNMChfsdiwM5GfLzxnl
 ZClw==
X-Gm-Message-State: AOJu0YwuBeFAANoApe9gdOtittef/mVJJV8JGu+tpXu3CwMZ2JriWxjV
 a6SuVoXW0aAjqSneSdMrNNgvG5OHNIvBwOqRD0eG88yx7eQSXnZDRHzEHot5jPtlX+8GpdwZDUE
 ZgOuxc9Hd2tZiO00=
X-Received: by 2002:a17:902:e544:b0:1cc:5c8f:4056 with SMTP id
 n4-20020a170902e54400b001cc5c8f4056mr23414541plf.42.1699284101158; 
 Mon, 06 Nov 2023 07:21:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvX+ksW7QdWA2ucsdQH4F2sWi1Mr+Sk2XsvX3fbv96bXTHLBHen2pqs+BFqQdRwOXFKHWwpA==
X-Received: by 2002:a17:902:e544:b0:1cc:5c8f:4056 with SMTP id
 n4-20020a170902e54400b001cc5c8f4056mr23414515plf.42.1699284100824; 
 Mon, 06 Nov 2023 07:21:40 -0800 (PST)
Received: from smtpclient.apple ([115.96.199.186])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001bb0eebd90asm6013944plk.245.2023.11.06.07.21.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:21:40 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <6F3F2E64-DA3E-43FC-848F-3C3DCE0937EF@redhat.com>
Date: Mon, 6 Nov 2023 20:51:37 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BCC84EF-9559-43C1-879B-E90E6383EBC6@redhat.com>
References: <20231102081624.25229-1-anisinha@redhat.com>
 <20231106151511.57c1e397@imammedo.users.ipa.redhat.com>
 <6F3F2E64-DA3E-43FC-848F-3C3DCE0937EF@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 06-Nov-2023, at 8:43 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 06-Nov-2023, at 7:45 PM, Igor Mammedov <imammedo@redhat.com> =
wrote:
>>=20
>> On Thu,  2 Nov 2023 13:46:24 +0530
>> Ani Sinha <anisinha@redhat.com> wrote:
>>=20
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
>>> in the tables from the checked-in gold master blobs.
>>=20
>>> If there are no changes, no new files are written for test variants.
>>> However, existing files continue to be overwritten regardless of =
whether there are changes.
>>> Hence, new files will be generated only when there are actual =
changes in the tables.
>>=20
>> You lost me in those 3 sentences. Perhaps rephrasing and adding =
examples
>> wold make it readable. (aka what's (not)writen and when)
>=20
> OK I will try in v2.
>=20
>>=20
>>=20
>>> This would make analyzing changes to tables less confusing and there =
would
>>> be no need to clean useless untracked files when there are no table =
changes.
>>=20
>> what happens if an absolutely new table has been introduced which
>> is not mentioned in tests yet (will it be dumped or not)?
>=20
> When a new table is introduced, there is no existing data to compare =
the tables with. In this case, it will result in assertion in the =
following line:
>=20
>>    g_assert(exp_sdt.aml_file);
>=20
> I am not sure what to do in this case except to unconditionally dump =
all tables. Maybe introduce another flag? Not sure.

Oh wait, this patch works as is since we have said in =
bios-tables-test.c:

>  add empty files for new tables, if any, under tests/data/acpi =20

So for new tables the lengths will not match and the table should be =
dumped. I need to test this case once.=20

>=20
>>=20
>>>=20
>>> CC: peter.maydell@linaro.org
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>>> 1 file changed, 13 insertions(+), 1 deletion(-)
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
>>>    GError *error =3D NULL;
>>>    gchar *aml_file =3D NULL;
>>> +    test_data exp_data =3D {};
>>>    gint fd;
>>>    ssize_t ret;
>>>    int i;
>>>=20
>>> +    exp_data.tables =3D load_expected_aml(data);
>>>    for (i =3D 0; i < data->tables->len; ++i) {
>>>        const char *ext =3D data->variant ? data->variant : "";
>>>        sdt =3D &g_array_index(data->tables, AcpiSdtTable, i);
>>> +        exp_sdt =3D &g_array_index(exp_data.tables, AcpiSdtTable, =
i);
>>>        g_assert(sdt->aml);
>>> +        g_assert(exp_sdt->aml);
>>>=20
>>>        if (rebuild) {
>>>            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, =
data->machine,
>>>                                       sdt->aml, ext);
>>> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>>> +                sdt->aml_len =3D=3D exp_sdt->aml_len &&
>>> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
>>> +                /* identical tables, no need to write new files */
>>> +                g_free(aml_file);
>>> +                continue;
>>> +            }
>>>            fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>>>                        S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>>>            if (fd < 0) {



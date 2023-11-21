Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 198C47F262B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:10:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Kte-0003Pq-Me; Tue, 21 Nov 2023 02:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r5Ktc-0003PZ-QT
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:10:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r5Ktb-0002Jv-3y
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700550605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJE/4AoZQG7Zj38uBpReHp6i6GKolC56NcA7IE824yk=;
 b=d920unh4iAZwPeyhpigQUF7bfLeoozqsVUxmoQlAY+6uKis83OgW9ckpsZ7k/wsEMFw6a6
 ts07XgQqRgwCnniaKDnQnZ2QShga9u+E9CdcxHh06wgmIuuPxBl8bVcDJshdYHQ/WAOams
 4OCGgd7Bo1Qnzhq2PRu4WvVK5SAhieA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-BBLvcIRFNPKbWR8r5a7BJw-1; Tue, 21 Nov 2023 02:10:02 -0500
X-MC-Unique: BBLvcIRFNPKbWR8r5a7BJw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1cc9eb5b944so72842055ad.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 23:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700550602; x=1701155402;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJE/4AoZQG7Zj38uBpReHp6i6GKolC56NcA7IE824yk=;
 b=Sq9X1vFOode0eSFZKp90ss+2BCTbX9MS+vigAIAQh0tZiw47yK2BjkGqW1TsqYXfZN
 cDicN1ZyrVVQqWsgY9AkmbTV/tV/ZXthQ4KSGtlCFFPdthYyjKx6Y1wSVPneBM5R2bg3
 UPvONdfBcBWsZllx3KJD68kOVpLegbaMD2TRz12+aJloRPke6lGZce2C4Up/IEKeGVGD
 rKxvYUF+Mcu8WybwrbZ6MSJFRjkEoRHEg8h7cVCIiq/rm7z3QIrYM2FpUXY4wW8I+Z4C
 tEUwX6ypAF8Cqwpnnqmt9xtsOhOmPPJ9SK4hMgvOXqgT7YSW+qu6QbaomUP6bLQgJMHG
 o8Wg==
X-Gm-Message-State: AOJu0Yxvci8QfYYAodOQj06gzwQrV8aaB+shHarm1ZMd8zUDkY+645Ku
 UGXXhSuRso9wSa3itakhJin5WMKTSXwMzFJP8z/v5RiY7OvUHN6y4Ub6Qv/y7bJtls4ZLyKRwdf
 YdmfG7gv8FDBM9Dg=
X-Received: by 2002:a17:902:e882:b0:1cf:54c7:adc5 with SMTP id
 w2-20020a170902e88200b001cf54c7adc5mr3164776plg.4.1700550601803; 
 Mon, 20 Nov 2023 23:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHu5IpE7IgWfBEm63Xe77L4Ewnqv6Ze7TeBiGiEVWbNTf1t9rbfMP2ql+FcwkFFHbwGXCWIA==
X-Received: by 2002:a17:902:e882:b0:1cf:54c7:adc5 with SMTP id
 w2-20020a170902e88200b001cf54c7adc5mr3164757plg.4.1700550601421; 
 Mon, 20 Nov 2023 23:10:01 -0800 (PST)
Received: from smtpclient.apple ([116.72.131.174])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a1709029f9600b001c9db5e2929sm7217787plq.93.2023.11.20.23.09.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 20 Nov 2023 23:10:01 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v2] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1D3FCCB3-FEDE-4E08-BD42-7070697913E3@redhat.com>
Date: Tue, 21 Nov 2023 12:39:46 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F54768EF-9AEE-4CB4-B6C2-AC88A718922F@redhat.com>
References: <20231107044952.5461-1-anisinha@redhat.com>
 <1D3FCCB3-FEDE-4E08-BD42-7070697913E3@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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



> On 16-Nov-2023, at 11:30=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 07-Nov-2023, at 10:19=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
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
>> in the tables from the checked-in gold master blobs and take actions
>> accordingly.
>>=20
>> When there are no changes:
>> - No new table blobs would be written.
>> - Existing table blobs will be refreshed (git diff will show no =
changes).
>> When there are changes:
>> - New table blob files will be dumped.
>> - Existing table blobs will be refreshed (git diff will show that the =
files
>>  changed, asl diff will show the actual changes).
>> When new tables are introduced:
>> - Zero byte empty file blobs for new tables as instructed in the =
header of
>>  bios-tables-test.c will be regenerated to actual table blobs.
>>=20
>> This would make analyzing changes to tables less confusing and there =
would
>> be no need to clean useless untracked files when there are no table =
changes.
>>=20
>> CC: peter.maydell@linaro.org
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>> 1 file changed, 13 insertions(+), 1 deletion(-)
>>=20
>> changelog:
>> v2: commit description updated to make things a little clearer.
>>   No actual changes.
>=20
> Ping ...

Ping again ...

>=20
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
>>    GError *error =3D NULL;
>>    gchar *aml_file =3D NULL;
>> +    test_data exp_data =3D {};
>>    gint fd;
>>    ssize_t ret;
>>    int i;
>>=20
>> +    exp_data.tables =3D load_expected_aml(data);
>>    for (i =3D 0; i < data->tables->len; ++i) {
>>        const char *ext =3D data->variant ? data->variant : "";
>>        sdt =3D &g_array_index(data->tables, AcpiSdtTable, i);
>> +        exp_sdt =3D &g_array_index(exp_data.tables, AcpiSdtTable, =
i);
>>        g_assert(sdt->aml);
>> +        g_assert(exp_sdt->aml);
>>=20
>>        if (rebuild) {
>>            aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, =
data->machine,
>>                                       sdt->aml, ext);
>> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
>> +                sdt->aml_len =3D=3D exp_sdt->aml_len &&
>> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
>> +                /* identical tables, no need to write new files */
>> +                g_free(aml_file);
>> +                continue;
>> +            }
>>            fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>>                        S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>>            if (fd < 0) {
>> --=20
>> 2.42.0




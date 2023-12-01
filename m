Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67A8011AE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:28:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97IU-0005mT-CK; Fri, 01 Dec 2023 12:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r97IS-0005mF-Ev
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r97IQ-0002eU-SE
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701451641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YNZsdmlAmnzdojqWpGoWMp4jrtu25STCGS1mnmMLLA=;
 b=BJuEjG3yJm2C81I0zev56wHuowzg8iBij6XzmTcrSqmCJJsl3MlKYsT+WFdlykK9MbSgXF
 k7xs1JW+g3E7T+CipVB279Uwv8J90BhNxLJJG4Pt1pVPdq0M6Incl34/0MxdIuFPBPlbnQ
 uM1gNw5cOI2av3SXHeKME8LPNd99z3w=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-FoquT9z6OViraX2K3fVQ2A-1; Fri, 01 Dec 2023 12:27:19 -0500
X-MC-Unique: FoquT9z6OViraX2K3fVQ2A-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6c7c69e4367so3058574b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701451639; x=1702056439;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YNZsdmlAmnzdojqWpGoWMp4jrtu25STCGS1mnmMLLA=;
 b=B99XkGueRmJO6k016xfeUgZ7jElmOIh9Cl3nXxT+ZVS0kuiwQkq5nS+0d8prL9E7Er
 AXlyU4BGK+J1+JfHeEVjWcDxDcvU7bYHJdEbKYAPaeNce3idWU+uJ9AZlINt6fMuTcWJ
 Sy3foHE7qrt6kAmcOHVYsu36apAbUMNUnsXumbo2Z/4mrbzWQY2E2JFM1dRiKLKSeUyT
 c5ltkC+QqdQU4S8x8zRp6RO4DxdNeQ/kbw1vyheBpk8QJSMsDNYe7sYpoA30UUaqzZdx
 Lp+sjAD1VdNr5YCGacJV7Cgi6+cKBgkpycufcgA8//t1SEXOTh55+ba3jdxFWojfEDZ5
 foUA==
X-Gm-Message-State: AOJu0YzTZmRD6wzEEUOQ/56dCEwBOTlehczgjoTHpnCW+4vOtV798hk0
 akUJ0+QdXLznWoMhBOMTBE+xLkYMdyJwnD0yTZuH0yG7yXho0QzUNV2VtPXrtBGCIj8G5jj9v7E
 IMkTbLsLQaG3t6uA=
X-Received: by 2002:a05:6a20:a129:b0:18c:ba47:74e7 with SMTP id
 q41-20020a056a20a12900b0018cba4774e7mr17553512pzk.52.1701451638945; 
 Fri, 01 Dec 2023 09:27:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5lZOneeAxC2lyxSRfGLMm/kXqZxipEN+NdMWFcuDMENczO/oXAQAFv2lfYvjXvUIaCoRYEA==
X-Received: by 2002:a05:6a20:a129:b0:18c:ba47:74e7 with SMTP id
 q41-20020a056a20a12900b0018cba4774e7mr17553494pzk.52.1701451638618; 
 Fri, 01 Dec 2023 09:27:18 -0800 (PST)
Received: from smtpclient.apple ([116.73.132.95])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a62f20f000000b00690c52267easm3221978pfh.40.2023.12.01.09.27.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Dec 2023 09:27:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PULL 03/15] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
Date: Fri, 1 Dec 2023 22:57:04 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D04BA30-F97A-48E3-8922-1094ED42AC12@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
 <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 01-Dec-2023, at 10:45=E2=80=AFPM, Michael S. Tsirkin =
<mst@redhat.com> wrote:
>=20
> From: Ani Sinha <anisinha@redhat.com>
>=20
> When dumping table blobs using rebuild-expected-aml.sh, table blobs =
from all
> test variants are dumped regardless of whether there are any actual =
changes to
> the tables or not. This creates lot of new files for various test =
variants that
> are not part of the git repository. This is because we do not check in =
all table
> blobs for all test variants into the repository. Only those blobs for =
those
> variants that are different from the generic test-variant agnostic =
blob are
> checked in.
>=20
> This change makes the test smarter by checking if at all there are any =
changes
> in the tables from the checked-in gold master blobs and take actions
> accordingly.
>=20
> When there are no changes:
> - No new table blobs would be written.
> - Existing table blobs will be refreshed (git diff will show no =
changes).
> When there are changes:
> - New table blob files will be dumped.
> - Existing table blobs will be refreshed (git diff will show that the =
files
>   changed, asl diff will show the actual changes).
> When new tables are introduced:
> - Zero byte empty file blobs for new tables as instructed in the =
header of
>   bios-tables-test.c will be regenerated to actual table blobs.
>=20
> This would make analyzing changes to tables less confusing and there =
would
> be no need to clean useless untracked files when there are no table =
changes.
>=20
> CC: peter.maydell@linaro.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Message-Id: <20231107044952.5461-1-anisinha@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

You missed DanPB and Igor=E2=80=99s tags :(

> ---
> tests/qtest/bios-tables-test.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/qtest/bios-tables-test.c =
b/tests/qtest/bios-tables-test.c
> index 71af5cf69f..fe6a9a8563 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -112,6 +112,7 @@ static const char *iasl;
> #endif
>=20
> static int verbosity_level;
> +static GArray *load_expected_aml(test_data *data);
>=20
> static bool compare_signature(const AcpiSdtTable *sdt, const char =
*signature)
> {
> @@ -244,21 +245,32 @@ static void test_acpi_fadt_table(test_data =
*data)
>=20
> static void dump_aml_files(test_data *data, bool rebuild)
> {
> -    AcpiSdtTable *sdt;
> +    AcpiSdtTable *sdt, *exp_sdt;
>     GError *error =3D NULL;
>     gchar *aml_file =3D NULL;
> +    test_data exp_data =3D {};
>     gint fd;
>     ssize_t ret;
>     int i;
>=20
> +    exp_data.tables =3D load_expected_aml(data);
>     for (i =3D 0; i < data->tables->len; ++i) {
>         const char *ext =3D data->variant ? data->variant : "";
>         sdt =3D &g_array_index(data->tables, AcpiSdtTable, i);
> +        exp_sdt =3D &g_array_index(exp_data.tables, AcpiSdtTable, i);
>         g_assert(sdt->aml);
> +        g_assert(exp_sdt->aml);
>=20
>         if (rebuild) {
>             aml_file =3D g_strdup_printf("%s/%s/%.4s%s", data_dir, =
data->machine,
>                                        sdt->aml, ext);
> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
> +                sdt->aml_len =3D=3D exp_sdt->aml_len &&
> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> +                /* identical tables, no need to write new files */
> +                g_free(aml_file);
> +                continue;
> +            }
>             fd =3D g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>             if (fd < 0) {
> --=20
> MST
>=20



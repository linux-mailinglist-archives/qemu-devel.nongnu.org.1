Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542D7E266D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Nu-0007Si-CB; Mon, 06 Nov 2023 09:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r00Nr-0007SR-Jb
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r00Np-00049K-W9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699280117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujbeXdUIL7sE74Kv8liWhge+ZcVbN5TaUWLp5Cb9+EU=;
 b=O//yjPZcho3qt5O2esVwV4ZEnTRoH7z7PwZOnFkDvV8CjoXT7fzF7RnvPkKBO++tyICwIK
 8OprZZ5XpfibE9nLvoFXAmePXussgmVwX8tbCkcYyisZTBnB1LCilQjDQx4LdRPfDabPq7
 oyw8L779QChJYwmNXl3aAw3DWsuXP+M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-buu5JSYzPlGKJFVeECpq6w-1; Mon, 06 Nov 2023 09:15:15 -0500
X-MC-Unique: buu5JSYzPlGKJFVeECpq6w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-778a65923bdso568024285a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699280114; x=1699884914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujbeXdUIL7sE74Kv8liWhge+ZcVbN5TaUWLp5Cb9+EU=;
 b=AuV6vugwwEyi/eES6IiS7jAvgZ/tGGvfgFgmqEEq7ZpQbe2P5O4P4KiIUPP222Q8t8
 g3EM3fdfg0kUaY1QlrixrNtTA2oU9ijDjNQJQaaQCHxj98Vqr6O+NKpkubtlNigWHb6I
 DQyjZ0R9jwjje0stst6KFC6lOJkInaCtpPrFNE/vVu5p50+Z5zKH6IyNOCCWoMuDpeav
 Lyf+ORrTsURc6Y0Csh+3t5Kz1D22KcOoHpm3mLQIC8ixBTYsBOypKSSmaS/IM1mqZk2x
 VD9VvWGPcGG6gBN6f3nEywOX/TOeiehO8o4iARtDzsIzGvRxk/2/eoFSxCpXFM1ium+Q
 gXSw==
X-Gm-Message-State: AOJu0YzxAl0j961B2gvx76iSM8Wn15Dec/vvOazbkRS9inoXoSo8EFX1
 q9m6dSAxs+4RzC/BSmjHKcgyIpZ46I+llq71jYbf3Lhx182eeM06Xwuqrclef+NytVOMGWIx7/W
 1RYmHOmueN1WWYpr9tmIweEM=
X-Received: by 2002:a05:620a:3189:b0:77a:282:bfb2 with SMTP id
 bi9-20020a05620a318900b0077a0282bfb2mr34259095qkb.8.1699280114596; 
 Mon, 06 Nov 2023 06:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm66TEevY+vLd3VtmyLewSKfUORpLqbIo7rN/UQOBaEE5L9eAHuwb/Zd4iVMqgRcoaxOROAg==
X-Received: by 2002:a05:620a:3189:b0:77a:282:bfb2 with SMTP id
 bi9-20020a05620a318900b0077a0282bfb2mr34259071qkb.8.1699280114280; 
 Mon, 06 Nov 2023 06:15:14 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 k11-20020a05620a414b00b007777521dca4sm3317599qko.21.2023.11.06.06.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 06:15:13 -0800 (PST)
Date: Mon, 6 Nov 2023 15:15:11 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
Message-ID: <20231106151511.57c1e397@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231102081624.25229-1-anisinha@redhat.com>
References: <20231102081624.25229-1-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Thu,  2 Nov 2023 13:46:24 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> When dumping table blobs using rebuild-expected-aml.sh, table blobs from all
> test variants are dumped regardless of whether there are any actual changes to
> the tables or not. This creates lot of new files for various test variants that
> are not part of the git repository. This is because we do not check in all table
> blobs for all test variants into the repository. Only those blobs for those
> variants that are different from the generic test-variant agnostic blob are
> checked in.
> 
> This change makes the test smarter by checking if at all there are any changes
> in the tables from the checked-in gold master blobs.

> If there are no changes, no new files are written for test variants.
> However, existing files continue to be overwritten regardless of whether there are changes.
> Hence, new files will be generated only when there are actual changes in the tables.

You lost me in those 3 sentences. Perhaps rephrasing and adding examples
wold make it readable. (aka what's (not)writen and when)


> This would make analyzing changes to tables less confusing and there would
> be no need to clean useless untracked files when there are no table changes.

what happens if an absolutely new table has been introduced which
is not mentioned in tests yet (will it be dumped or not)?

> 
> CC: peter.maydell@linaro.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 9f4bc15aab..743b509e93 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -109,6 +109,7 @@ static const char *iasl;
>  #endif
>  
>  static int verbosity_level;
> +static GArray *load_expected_aml(test_data *data);
>  
>  static bool compare_signature(const AcpiSdtTable *sdt, const char *signature)
>  {
> @@ -241,21 +242,32 @@ static void test_acpi_fadt_table(test_data *data)
>  
>  static void dump_aml_files(test_data *data, bool rebuild)
>  {
> -    AcpiSdtTable *sdt;
> +    AcpiSdtTable *sdt, *exp_sdt;
>      GError *error = NULL;
>      gchar *aml_file = NULL;
> +    test_data exp_data = {};
>      gint fd;
>      ssize_t ret;
>      int i;
>  
> +    exp_data.tables = load_expected_aml(data);
>      for (i = 0; i < data->tables->len; ++i) {
>          const char *ext = data->variant ? data->variant : "";
>          sdt = &g_array_index(data->tables, AcpiSdtTable, i);
> +        exp_sdt = &g_array_index(exp_data.tables, AcpiSdtTable, i);
>          g_assert(sdt->aml);
> +        g_assert(exp_sdt->aml);
>  
>          if (rebuild) {
>              aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
>                                         sdt->aml, ext);
> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
> +                sdt->aml_len == exp_sdt->aml_len &&
> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> +                /* identical tables, no need to write new files */
> +                g_free(aml_file);
> +                continue;
> +            }
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>              if (fd < 0) {



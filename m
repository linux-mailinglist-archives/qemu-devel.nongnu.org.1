Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85F7F7719
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:03:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Xh2-0005xP-A9; Fri, 24 Nov 2023 10:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Xgr-0005x3-Bi
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Xgo-0006R9-I7
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700838112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8mcz3He9klenpvdrowAuW5mMGItQtiD/i00jfjDBPE=;
 b=dkeETS6mDjlIyLqgG3OQ1V98/SwGUfDslZz6w8Vs4yDQZYyMNvESJathDprC4FDg0XBbtx
 g4qJmdEOrqEnFY+O1HcBpdJsjRmZYUuprnt6u96W59zX8rjvlt7RksbyP3eLE6KSDADphp
 6e7J+HZJgFIeNOx5SHdd8a0CiFfE2Rk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ax2hsHrBOTS9_rIO9eU19g-1; Fri, 24 Nov 2023 10:01:51 -0500
X-MC-Unique: ax2hsHrBOTS9_rIO9eU19g-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50aa861dcf7so1885550e87.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700838110; x=1701442910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8mcz3He9klenpvdrowAuW5mMGItQtiD/i00jfjDBPE=;
 b=lQUVOQK4xysb5kStpGSk4Eg02k22qs2PK2bBQ8yHcKH7KLionoWgAaEbQ1mO2Jb+Iu
 HmMncRxu8zyMYCdtKmUoDwic/R2bdRxnpbcE0ENH6WBrJoiC+W5NuhZEgLLyISot7Oal
 RYsfLlfy7sqHlvjl0ZO/WXjaYRDRC1ce8gSXbITUFHp/y8e58E7S7bPFEza1bab+7Znl
 6otNtshwWOq/vw7y0cPh2UJFsv3s9CzQMV8VVH9Xxb3z65GMsPTnWnbbePnpO3W1dhGH
 6GAI/9RZGlTMqrlwPUBNq0lIPaN/OrBWWW4FXDtTYR6kEt384s7bJ89/QSQULwllligG
 znIg==
X-Gm-Message-State: AOJu0YzhNq1ZEmE+f85AFV2NTCw/+9DTWDpqbnPYv6FDWEfA9ivEDPLl
 3omOtORAEYc43MLYTZdX3xGjAX0wMVoNvjIYaM23Q5rinMPSXKxL7Qjms0207+diLERSHjMBp5t
 XxaZZAkfncqvHIwU=
X-Received: by 2002:a19:670a:0:b0:500:7c51:4684 with SMTP id
 b10-20020a19670a000000b005007c514684mr1750685lfc.56.1700838109154; 
 Fri, 24 Nov 2023 07:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUO0+90KC0YrcWtd/3LIBfsbUi2bqHPj05D/Pb5lYIx3ypqZITZActB0UO8fp0GUHXQjbuag==
X-Received: by 2002:a19:670a:0:b0:500:7c51:4684 with SMTP id
 b10-20020a19670a000000b005007c514684mr1750511lfc.56.1700838106515; 
 Fri, 24 Nov 2023 07:01:46 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 rv4-20020a17090710c400b00a047ef6f2c6sm2156193ejb.135.2023.11.24.07.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:01:46 -0800 (PST)
Date: Fri, 24 Nov 2023 16:01:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
Message-ID: <20231124160145.08f46251@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231107044952.5461-1-anisinha@redhat.com>
References: <20231107044952.5461-1-anisinha@redhat.com>
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

On Tue,  7 Nov 2023 10:19:51 +0530
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
> in the tables from the checked-in gold master blobs and take actions
> accordingly.
> 
> When there are no changes:
>  - No new table blobs would be written.
>  - Existing table blobs will be refreshed (git diff will show no changes).
> When there are changes:
>  - New table blob files will be dumped.
>  - Existing table blobs will be refreshed (git diff will show that the files
>    changed, asl diff will show the actual changes).
> When new tables are introduced:
>  - Zero byte empty file blobs for new tables as instructed in the header of
>    bios-tables-test.c will be regenerated to actual table blobs.
> 
> This would make analyzing changes to tables less confusing and there would
> be no need to clean useless untracked files when there are no table changes.
> 
> CC: peter.maydell@linaro.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> changelog:
> v2: commit description updated to make things a little clearer.
>     No actual changes.
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



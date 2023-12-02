Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE69801E8D
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 22:00:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9X5I-0008O8-59; Sat, 02 Dec 2023 15:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9X5G-0008Nq-PB
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 15:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r9X5F-0000La-5A
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 15:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701550767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xc3gDoShkgGh6wQ6v4rVConeUynScFpLkNTYAu5ELNQ=;
 b=VNqUwsC+qISMR9UseDg8fB9h1jlidxkxCghYuVZiTC4gWVD1TrHMuHDLVf2kKneNqJYOb1
 iDns3kkkvCXkAg31n8UX4yq6+tedU3ahKxCOXSsI+kBs6sFPkYUHZgHZF+himQrp191iK5
 hFauiFlDAaBJRs1RJfZ4QnHfW/T8xXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Y1Gly220NQWXHoF59OFCvA-1; Sat, 02 Dec 2023 15:59:26 -0500
X-MC-Unique: Y1Gly220NQWXHoF59OFCvA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40b3dae2285so23905665e9.2
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 12:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701550765; x=1702155565;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xc3gDoShkgGh6wQ6v4rVConeUynScFpLkNTYAu5ELNQ=;
 b=GekkO4gkzliq1+4wQONn2L0PG9JFp94TBocqCnUCwR9873F5PTAmOmUBsRAe98QThB
 9TKarH40+bd4qY11jmn68GII7FXxKZRovrndXIJQY/Z5bQI0dlGq/IthveUg3DokmKrn
 DMiebVaendtogNrFLmjMtLQ7deKUmrdelHhOkoyPJy2g2WveIG0NEEvHCP0MK4nh3oGu
 U3w1k/ummAV+/xyPkV5t8o+U0TRVSoi4jKYL1MiNhzib7rjWe/aIZOwDLZj+AJbGGjX/
 pgFKQGr7Z0OXCXY9k9hiS2aWUOL8vOv45wPViiDbkiWTJXQFr/NkbWYkMwxCraBsqKt4
 P7YQ==
X-Gm-Message-State: AOJu0Yyl4hOIWlP3Y9oBN5Ncf22MxN+oJBk//QWqm1hpDj06dyt2xFUE
 ITN6oVKBuxe0rPo3bRBRCIC/kRxvQ9pcyGVP5GDgmAjT8miYPZ3Y2FQarGXltRaUo9xDJaJ8qPp
 iGNgGBhjI1FruuW8=
X-Received: by 2002:a05:600c:20e:b0:40b:5e1e:fb97 with SMTP id
 14-20020a05600c020e00b0040b5e1efb97mr1023100wmi.76.1701550765004; 
 Sat, 02 Dec 2023 12:59:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiC/IZKov3qRLBzoqjIJGagG9wBaJdsJQqz6SM0Lv2NkPU/AQ+p4EiqK1k9U1GKPtwg3ePEQ==
X-Received: by 2002:a05:600c:20e:b0:40b:5e1e:fb97 with SMTP id
 14-20020a05600c020e00b0040b5e1efb97mr1023093wmi.76.1701550764584; 
 Sat, 02 Dec 2023 12:59:24 -0800 (PST)
Received: from redhat.com ([2.55.11.133]) by smtp.gmail.com with ESMTPSA id
 ay31-20020a05600c1e1f00b004080f0376a0sm9705351wmb.42.2023.12.02.12.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 12:59:23 -0800 (PST)
Date: Sat, 2 Dec 2023 15:59:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 03/15] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
Message-ID: <20231202155913-mutt-send-email-mst@kernel.org>
References: <cover.1701450838.git.mst@redhat.com>
 <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
 <8D04BA30-F97A-48E3-8922-1094ED42AC12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8D04BA30-F97A-48E3-8922-1094ED42AC12@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Dec 01, 2023 at 10:57:04PM +0530, Ani Sinha wrote:
> 
> 
> > On 01-Dec-2023, at 10:45 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > From: Ani Sinha <anisinha@redhat.com>
> > 
> > When dumping table blobs using rebuild-expected-aml.sh, table blobs from all
> > test variants are dumped regardless of whether there are any actual changes to
> > the tables or not. This creates lot of new files for various test variants that
> > are not part of the git repository. This is because we do not check in all table
> > blobs for all test variants into the repository. Only those blobs for those
> > variants that are different from the generic test-variant agnostic blob are
> > checked in.
> > 
> > This change makes the test smarter by checking if at all there are any changes
> > in the tables from the checked-in gold master blobs and take actions
> > accordingly.
> > 
> > When there are no changes:
> > - No new table blobs would be written.
> > - Existing table blobs will be refreshed (git diff will show no changes).
> > When there are changes:
> > - New table blob files will be dumped.
> > - Existing table blobs will be refreshed (git diff will show that the files
> >   changed, asl diff will show the actual changes).
> > When new tables are introduced:
> > - Zero byte empty file blobs for new tables as instructed in the header of
> >   bios-tables-test.c will be regenerated to actual table blobs.
> > 
> > This would make analyzing changes to tables less confusing and there would
> > be no need to clean useless untracked files when there are no table changes.
> > 
> > CC: peter.maydell@linaro.org
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > Message-Id: <20231107044952.5461-1-anisinha@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> You missed DanPB and Igor’s tags :(

fixed now, thanks!

> > ---
> > tests/qtest/bios-tables-test.c | 14 +++++++++++++-
> > 1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> > index 71af5cf69f..fe6a9a8563 100644
> > --- a/tests/qtest/bios-tables-test.c
> > +++ b/tests/qtest/bios-tables-test.c
> > @@ -112,6 +112,7 @@ static const char *iasl;
> > #endif
> > 
> > static int verbosity_level;
> > +static GArray *load_expected_aml(test_data *data);
> > 
> > static bool compare_signature(const AcpiSdtTable *sdt, const char *signature)
> > {
> > @@ -244,21 +245,32 @@ static void test_acpi_fadt_table(test_data *data)
> > 
> > static void dump_aml_files(test_data *data, bool rebuild)
> > {
> > -    AcpiSdtTable *sdt;
> > +    AcpiSdtTable *sdt, *exp_sdt;
> >     GError *error = NULL;
> >     gchar *aml_file = NULL;
> > +    test_data exp_data = {};
> >     gint fd;
> >     ssize_t ret;
> >     int i;
> > 
> > +    exp_data.tables = load_expected_aml(data);
> >     for (i = 0; i < data->tables->len; ++i) {
> >         const char *ext = data->variant ? data->variant : "";
> >         sdt = &g_array_index(data->tables, AcpiSdtTable, i);
> > +        exp_sdt = &g_array_index(exp_data.tables, AcpiSdtTable, i);
> >         g_assert(sdt->aml);
> > +        g_assert(exp_sdt->aml);
> > 
> >         if (rebuild) {
> >             aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
> >                                        sdt->aml, ext);
> > +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
> > +                sdt->aml_len == exp_sdt->aml_len &&
> > +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> > +                /* identical tables, no need to write new files */
> > +                g_free(aml_file);
> > +                continue;
> > +            }
> >             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
> >                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
> >             if (fd < 0) {
> > -- 
> > MST
> > 



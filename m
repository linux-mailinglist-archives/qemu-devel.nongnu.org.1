Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC724706AEF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 16:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHyN-0007RZ-4I; Wed, 17 May 2023 10:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzHyG-0007Qx-Dc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:17:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzHyE-0004fv-BO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684333056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WiiFx38RJAidSht/NdqiIjqau+qMtjj2oM+JqnyYH78=;
 b=aTD1s/5Rggylj7iIp2K3ceVkdVYsXqjZ1GLkBO0Ef5u9sY+DmUyyhyjwtR89qQzFMtgGLY
 kpZfNnB6C9Dckwnf/kJgsrZMpea49jdKYfUGDhKSVjuxeL7DZWN2SOHqyFXOy0bIXOhAI8
 sCnNni+F0f7vTXT2X97eu2ErLIUZKi0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-OdkNxuouPMKRMO1vpIyObA-1; Wed, 17 May 2023 10:17:35 -0400
X-MC-Unique: OdkNxuouPMKRMO1vpIyObA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-307814dd87eso386507f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 07:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684333054; x=1686925054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiiFx38RJAidSht/NdqiIjqau+qMtjj2oM+JqnyYH78=;
 b=EZKu1B3zvPXYwhmHR0wXBMvriDJ2Rv7hXIZF2U8TvwLQUaIJJ2vgxG1DwwQ/cacumX
 biEBbkxQTUn8BMTQBsNBUvZAeEm9161SUao2cliUR+0C8dVYbzkyx0N896mT4MKl19ok
 5hxNniaK75fT8A9yaFXTxr8dLnfIuiArpyIRqU5MJzUznrIkNCPDipl3bNO+Wy8wGz0N
 uLF/DUTEgFNDcHkO65jlLbPf2q9UoIZcV24E+D2V54EBOXIdNyWppe7/Dijs1sWQc0o6
 F8tr/ukxjTQ8BzwMJMWFZHxR5kg72Qt+O/ayBkp0tkM5oubRujpzhKpgNVATv8pO2k3P
 5gAw==
X-Gm-Message-State: AC+VfDzW9cqjJiqIIE+jXs5Jp1oMwlHml8qET/H6iQSRZLNST1Ybit9P
 S/4Vh6x9lo1YiB5PLYQoMixmY1yqQ9nWPBmK8yifyP5RQKOaCSk/bhho0FNsLOKUagQAi9r5Shz
 NJ9YUIxDPx6WqhXE=
X-Received: by 2002:a5d:5604:0:b0:307:979f:7373 with SMTP id
 l4-20020a5d5604000000b00307979f7373mr748345wrv.24.1684333054145; 
 Wed, 17 May 2023 07:17:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CiUy0/deYbwaJheVToB7AT85qFwcKaD+zq+sZP4UUfwxFKuvIJ3K0t358dA/eD2wcS7Tgfw==
X-Received: by 2002:a5d:5604:0:b0:307:979f:7373 with SMTP id
 l4-20020a5d5604000000b00307979f7373mr748329wrv.24.1684333053799; 
 Wed, 17 May 2023 07:17:33 -0700 (PDT)
Received: from redhat.com ([109.253.194.87]) by smtp.gmail.com with ESMTPSA id
 l6-20020a5d6746000000b003090cb7a9e6sm2946845wrw.31.2023.05.17.07.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 07:17:33 -0700 (PDT)
Date: Wed, 17 May 2023 10:17:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
Message-ID: <20230517101523-mutt-send-email-mst@kernel.org>
References: <20230517120751.14679-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517120751.14679-1-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
> Currently the meson based QEMU build process locates the iasl binary from the
> current PATH and other locations [1] and uses that to set CONFIG_IASL which is
> then used by the test.
> 
> This has two disadvantages:
>  - If iasl was not previously installed in the PATH, one has to install iasl
>    and rebuild QEMU in order to pick up the iasl location. One cannot simply
>    use the existing bios-tables-test binary because CONFIG_IASL is only set
>    during the QEMU build time by meson and then bios-tables-test has to be
>    rebuilt with CONFIG_IASL set in order to use iasl.
>  - Sometimes, the stock iasl that comes with distributions is simply not good
>    enough because it does not support the latest ACPI changes - newly
>    introduced tables or new table attributes etc. In order to test ACPI code
>    in QEMU, one has to clone the latest acpica upstream repository and
>    rebuild iasl in order to get support for it. In those cases, one may want
>    the test to use the iasl binary from a non-standard location.
> 
> In order to overcome the above two disadvantages, we introduce a new
> environment variable IASL_PATH that can be set by the tester pointing to an
> possibly non-standard iasl binary location. Bios-tables-test then uses this
> environment variable to set its iasl location, possibly also overriding the
> location that was pointed to by CONFIG_IASL that was set by meson. This way
> developers can not only use this new environment variable to set iasl
> location to quickly run bios-tables-test but also can point the test to a
> custom iasl if required.
> 
> [1] https://mesonbuild.com/Reference-manual_functions.html#find_program
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Well I think the point was originally that meson can
also test the binary in a variety of ways.
Never surfaced so maybe never mind.

Would it be easier to just look iasl up on path
unless it was specified on command line?

> ---
>  tests/qtest/bios-tables-test.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> sample runs:
> 
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 V=2 ./tests/qtest/bios-tables-test
> ...
> acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-DLHA51], Expected [aml:tests/data/acpi/pc/APIC].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> Using iasl: /usr/bin/iasl
> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-L9GA51.dsl, aml:/tmp/aml-DLHA51], Expected [asl:/tmp/asl-10EA51.dsl, aml:tests/data/acpi/pc/APIC].
> 
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 V=2 IASL_PATH=/home/anisinha/workspace/acpica/generate/unix/bin/iasl ./tests/qtest/bios-tables-test
> ...
> acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-5CQ341], Expected [aml:tests/data/acpi/pc/APIC].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> User has provided an iasl path, using that: /home/anisinha/workspace/acpica/generate/unix/bin/iasl
> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-2GQ341.dsl, aml:/tmp/aml-5CQ341], Expected [asl:/tmp/asl-IBR341.dsl, aml:tests/data/acpi/pc/APIC].
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 7fd88b0e9c..37e8e484cb 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -440,7 +440,12 @@ static void test_acpi_asl(test_data *data)
>      AcpiSdtTable *sdt, *exp_sdt;
>      test_data exp_data = {};
>      gboolean exp_err, err, all_tables_match = true;
> +    const char *user_iasl_path = getenv("IASL_PATH");
>  
> +    /* if user has provided a path to iasl, use that */
> +    if (user_iasl_path) {
> +        iasl = user_iasl_path;
> +    }
>      exp_data.tables = load_expected_aml(data);
>      dump_aml_files(data, false);
>      for (i = 0; i < data->tables->len; ++i) {
> @@ -473,6 +478,15 @@ static void test_acpi_asl(test_data *data)
>              continue;
>          }
>  
> +        if (verbosity_level >= 2) {
> +            if (user_iasl_path) {
> +                fprintf(stderr, "User has provided an iasl path," \
> +                        "using that: %s\n", user_iasl_path);
> +            } else {
> +                fprintf(stderr, "Using iasl: %s\n", iasl);
> +            }
> +        }
> +
>          err = load_asl(data->tables, sdt);
>          asl = normalize_asl(sdt->asl);
>  
> -- 
> 2.39.1



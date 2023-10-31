Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F57DC4EE
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 04:41:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfcr-0007Xh-9X; Mon, 30 Oct 2023 23:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfcp-0007XX-O6
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 23:41:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfcn-0001wM-QA
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 23:41:07 -0400
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-6cd09f51fe0so3048543a34.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 20:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698723664; x=1699328464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H7bNfWtbhF2rnqjmBgMq9Uh1ug3ZiGMN18l/Q5Ti2Nc=;
 b=tKkNjzGCtsHC7fkfMwLSF71E1CJ2yDPs183+gAKApsEJE5sthy6z/z70PAOgEsCP+N
 jva0sAkoxxK3Eol0Z57cKyXkB6r6KW9Q1D2hwYqYuATN8ej06VmksUtXUDmGiL/KrdL0
 8PptTPapAaR6WHgo74XLW2xBXzQ6ceYpoOSt/Nkr7AnCrcSV3uuD4ngNKAUZ3i1jzV8o
 7YOqHd/GvPZ2/4wjBDXLyGnAeAUehCHTyn0a8xOtVmVgOHvbM3IEuZtDOMEv337EhKL0
 JF8h6jhI+DnKDyQ0UwwoUwpNVA8oV8Ho78/Rzrf60PqfDr+xjs3h2e6o1sb+cr3b3iKd
 hZxQ==
X-Gm-Message-State: AOJu0Yww4DvXCfJw0lHgvrQmPOk06vQek8rEkhALq7QqRWXcAn94LfeW
 L8T9vUUiiSJA2t6GdrHgMUEx6vvVH/M=
X-Google-Smtp-Source: AGHT+IG1265AHc2oJoonFx7YCAaQOZ3Zjb5EgDgEchpr3xgGX6zeImgVpt6Prhr/I27qLB+pl8Pbnw==
X-Received: by 2002:a05:6830:120b:b0:6bd:be5:daa2 with SMTP id
 r11-20020a056830120b00b006bd0be5daa2mr13128177otp.33.1698723664260; 
 Mon, 30 Oct 2023 20:41:04 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com.
 [209.85.216.54]) by smtp.gmail.com with ESMTPSA id
 s9-20020a056a00194900b006bd9422b279sm243957pfk.54.2023.10.30.20.41.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 20:41:04 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2800bb246ceso2723232a91.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 20:41:04 -0700 (PDT)
X-Received: by 2002:a17:90a:1c2:b0:280:52a3:711e with SMTP id
 2-20020a17090a01c200b0028052a3711emr3816958pjd.47.1698723663812; Mon, 30 Oct
 2023 20:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231029060404.71196-1-j@getutm.app>
 <20231029060404.71196-14-j@getutm.app>
 <b2828199-610a-4b2e-8964-92513e1872e0@linux.ibm.com>
 <8497cf62-a360-4883-abc0-f6023b1c99b0@linux.ibm.com>
In-Reply-To: <8497cf62-a360-4883-abc0-f6023b1c99b0@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 30 Oct 2023 20:40:53 -0700
X-Gmail-Original-Message-ID: <CA+E+eSDqOxNU8na909dPZVUyosbtm8MMW+dqBXGs6Vkek1VHXg@mail.gmail.com>
Message-ID: <CA+E+eSDqOxNU8na909dPZVUyosbtm8MMW+dqBXGs6Vkek1VHXg@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] tests: acpi: updated expected blobs for TPM CRB
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.41; envelope-from=osy86dev@gmail.com;
 helo=mail-ot1-f41.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I think I actually messed up and committed an older version of the
expected blobs. Since these are newly added for the new tests, they
should be passing without any additional work.

On Mon, Oct 30, 2023 at 5:35=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
> On 10/30/23 18:42, Stefan Berger wrote:
> >
> > On 10/29/23 02:03, Joelle van Dyne wrote:
> >> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >
> > I see this error here with the test cases:
> >
> >
> > | 364/377 ERROR:../tests/qtest/bios-tables-test.c:535:test_acpi_asl:
> > assertion failed: (all_tables_match) ERROR
> > 364/377 qemu:qtest+qtest-x86_64 /
> > qtest-x86_64/bios-tables-test                     ERROR 34.83s killed
> > by signal 6 SIGABRT
> > >>> QTEST_QEMU_BINARY=3D./qemu-system-x86_64 MALLOC_PERTURB_=3D200
> > QTEST_QEMU_IMG=3D./qemu-img
> > G_TEST_DBUS_DAEMON=3D/home/stefanb/qemu-tpm/tests/dbus-vmstate-daemon.s=
h
> > QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
> > PYTHON=3D/home/stefanb/qemu-tpm/build/pyvenv/bin/python3
> > /home/stefanb/qemu-tpm/build/tests/qtest/bios-tables-test --tap -k
> > --------------------------------------------------------------- 8<
> > ---------------------------------------------------------------
> >
> > $ diff tests/data/acpi/virt/TPM2.crb-device.dsl /tmp/aml-98C6D2.dsl
> > 6c6
> > <  * Disassembly of tests/data/acpi/virt/TPM2.crb-device.tpm2, Mon Oct
> > 30 18:30:00 2023
> > ---
> > >  * Disassembly of /tmp/aml-98C6D2, Mon Oct 30 18:29:29 2023
> > 16c16
> > < [009h 0009   1]                     Checksum : BA
> > ---
> > > [009h 0009   1]                     Checksum : C2
> > 30c30
> > < [044h 0068   8]                  Log Address : 0000000043D10000
> > ---
> > > [044h 0068   8]                  Log Address : 0000000043C90000
> >
> > The diff is in the address of the TPM log ... Not good. I don't know
> > how we could have it ignore the address or not build the TPM2 table
> > with an address for a log. It would be good to have test cases.
> >
> >    Stefan
>
>
> The log that the TPM2 ACPI table points to is needed for a BIOS, UEFI
> does not need it (but we don't typically know whether BIOS or UEFI will
> run). So we could introduce a property no-acpi-log and have the test
> cases set this to 'on' and get a NULL pointer for the 'Log Address'. You
> could use the following in a patch:
>
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index acc654382e..2b2de34201 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2224,6 +2224,7 @@ void build_tpm2(GArray *table_data, BIOSLinker
> *linker, GArray *tcpalog,
>       uint32_t start_method;
>       AcpiTable table =3D { .sig =3D "TPM2", .rev =3D 4,
>                           .oem_id =3D oem_id, .oem_table_id =3D oem_table=
_id };
> +    bool acpi_log =3D true;
>
>       acpi_table_begin(&table, table_data);
>
> @@ -2238,6 +2239,7 @@ void build_tpm2(GArray *table_data, BIOSLinker
> *linker, GArray *tcpalog,
>           control_area_start_address =3D TPM_CRB_ADDR_CTRL;
>           start_method =3D TPM2_START_METHOD_CRB;
>       } else if (TPM_IS_CRB_SYSBUS(tpmif)) {
> +        acpi_log =3D !object_property_get_bool(OBJECT(tpmif),
> "no-acpi-log", NULL);
>           baseaddr =3D object_property_get_uint(OBJECT(tpmif),
> "x-baseaddr", NULL);
>           control_area_start_address =3D baseaddr + A_CRB_CTRL_REQ;
>           start_method =3D TPM2_START_METHOD_CRB;
> @@ -2253,20 +2255,25 @@ void build_tpm2(GArray *table_data, BIOSLinker
> *linker, GArray *tcpalog,
>       g_array_append_vals(table_data, &start_method_params,
>                           ARRAY_SIZE(start_method_params));
>
> -    /* Log Area Minimum Length */
> -    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
> +    if (acpi_log) {
> +        /* Log Area Minimum Length */
> +        build_append_int_noprefix(table_data,
> TPM_LOG_AREA_MINIMUM_SIZE, 4);
>
> -    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> -    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
> -                             false);
> +        acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> +        bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE,
> tcpalog, 1,
> +                                 false);
>
> -    log_addr_offset =3D table_data->len;
> +        log_addr_offset =3D table_data->len;
>
> -    /* Log Area Start Address to be filled by Guest linker */
> -    build_append_int_noprefix(table_data, 0, 8);
> -    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -                                   log_addr_offset, 8,
> -                                   ACPI_BUILD_TPMLOG_FILE, 0);
> +        /* Log Area Start Address to be filled by Guest linker */
> +        build_append_int_noprefix(table_data, 0, 8);
> +        bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +                                       log_addr_offset, 8,
> +                                       ACPI_BUILD_TPMLOG_FILE, 0);
> +    } else {
> +        build_append_int_noprefix(table_data, 0, 4);
> +        build_append_int_noprefix(table_data, 0, 8);
> +    }
>       acpi_table_end(linker, &table);
>   }
>   #endif
> diff --git a/hw/tpm/tpm_crb_sysbus.c b/hw/tpm/tpm_crb_sysbus.c
> index c10a8b5639..aeeaba512b 100644
> --- a/hw/tpm/tpm_crb_sysbus.c
> +++ b/hw/tpm/tpm_crb_sysbus.c
> @@ -35,6 +35,7 @@ struct TPMCRBStateSysBus {
>       TPMCRBState state;
>       uint64_t baseaddr;
>       uint64_t size;
> +    bool no_acpi_log;
>   };
>
>   OBJECT_DECLARE_SIMPLE_TYPE(TPMCRBStateSysBus, TPM_CRB_SYSBUS)
> @@ -74,6 +75,8 @@ static Property tpm_crb_sysbus_properties[] =3D {
>                          baseaddr, TPM_CRB_ADDR_BASE),
>       DEFINE_PROP_UINT64("x-size", TPMCRBStateSysBus,
>                          size, TPM_CRB_ADDR_SIZE),
> +    DEFINE_PROP_BOOL("no-acpi-log", TPMCRBStateSysBus,
> +                     no_acpi_log, FALSE),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index dea2a18158..9e8a02f924 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1400,7 +1400,7 @@ static void test_acpi_tcg_tpm(const char *machine,
> const char *tpm_if,
>           " %s"
>           " -chardev socket,id=3Dchr,path=3D%s"
>           " -tpmdev emulator,id=3Ddev,chardev=3Dchr"
> -        " -device tpm-%s,tpmdev=3Ddev",
> +        " -device tpm-%s,tpmdev=3Ddev,no-acpi-log=3Don",
>           g_strcmp0(machine, "virt") =3D=3D 0 ? "-cpu cortex-a57" : "",
>           test.addr->u.q_unix.path, tpm_if);
>
>


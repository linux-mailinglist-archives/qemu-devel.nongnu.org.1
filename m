Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA417EB6E3
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:30:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2z6z-0006SI-EU; Tue, 14 Nov 2023 14:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2z6i-0006Rj-1p
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:29:56 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2z6f-0007Rv-Mj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:29:55 -0500
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so4777498b3a.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699990192; x=1700594992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrLqgioGt8kHV4+YjMy74wH8Dz5G6o5dCJXDxxEdl3Q=;
 b=XiTzuUT7ZFM9tJt3Cyda8FveLvWkXNGKCjKrVlKxoS0svYJutbttl3k2mELRVGRgQ0
 Udvbmccimncp+7IargpXWeYkmU+w6BxgJfYPWSzjwXIU9zXdozjE1I+T9yjX75Qu7x3Q
 QGEMeKGDPgpF+fAhBY0362WiWXCeK4fPRaKNbnkB90iJ/WC/F2iaObTwDBGUHDIyrzNj
 WRJ0OrSrL9io4Mg3dGx+7leMu1dIOZnpUaF+A7g1YGa3s4oFvjNIwTOHbPrMvvyiHi1Y
 sXjk6Msj62zztedRJ+7PglyQ7dkgk3CaKB2SKwQC2/t8sC7ClQcCqLZVzXPpym+DIxfd
 KH2g==
X-Gm-Message-State: AOJu0YzqCjdU5+aIkCxl4nhuQnvJIc5h6tIa1L2vDVBjysA0zgCugnj5
 xlU8QNHT5WyYIDbfR8IDdA1wgH7udPc=
X-Google-Smtp-Source: AGHT+IE6Ot9GOrbY1/Y4nGxuK5rxB4ZzFBmXB15wfjQtVR7OZB25tKj8PU/YWjoI/5mQovU7I8P+fQ==
X-Received: by 2002:a05:6a20:42a4:b0:174:2361:b4a3 with SMTP id
 o36-20020a056a2042a400b001742361b4a3mr9205462pzj.59.1699990191650; 
 Tue, 14 Nov 2023 11:29:51 -0800 (PST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com.
 [209.85.215.171]) by smtp.gmail.com with ESMTPSA id
 a18-20020a656412000000b0059d219cb359sm5088999pgv.9.2023.11.14.11.29.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 11:29:51 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-5b980391d7cso3745516a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:29:51 -0800 (PST)
X-Received: by 2002:a17:90b:1c02:b0:27d:c36:e12d with SMTP id
 oc2-20020a17090b1c0200b0027d0c36e12dmr8753495pjb.6.1699990190930; Tue, 14 Nov
 2023 11:29:50 -0800 (PST)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-6-j@getutm.app>
 <865e5b38-0e83-4522-8d3e-410ba2394173@linux.ibm.com>
 <20340277-648c-4ebd-825b-20199ceafe64@linux.ibm.com>
In-Reply-To: <20340277-648c-4ebd-825b-20199ceafe64@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 14 Nov 2023 11:29:40 -0800
X-Gmail-Original-Message-ID: <CA+E+eSACVT1=iYSfqDGhhM2KZt7Sjy2jReZfOuXnLSxX=MMHAQ@mail.gmail.com>
Message-ID: <CA+E+eSACVT1=iYSfqDGhhM2KZt7Sjy2jReZfOuXnLSxX=MMHAQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] tpm_crb: move ACPI table building to device
 interface
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.170; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f170.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Nov 14, 2023 at 8:44=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 11/14/23 11:37, Stefan Berger wrote:
> >
> >
> > On 11/13/23 21:09, Joelle van Dyne wrote:
> >> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> >> support TPM 2.0 backends, we check for this in realize.
> >>
> >> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >> ---
> >>   hw/tpm/tpm_crb.h        |  2 ++
> >>   hw/i386/acpi-build.c    | 16 +---------------
> >>   hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
> >>   hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
> >>   4 files changed, 38 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> >> index 36863e1664..e6a86e3fd1 100644
> >> --- a/hw/tpm/tpm_crb.h
> >> +++ b/hw/tpm/tpm_crb.h
> >> @@ -73,5 +73,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState
> >> *s, Error **errp);
> >>   void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void
> >> *saved_cmdmem);
> >>   void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
> >>                         const void *saved_cmdmem);
> >> +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr,
> >> uint32_t size,
> >> +                       bool build_ppi);
> >>
> >>   #endif /* TPM_TPM_CRB_H */
> >> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >> index 80db183b78..7491cee2af 100644
> >> --- a/hw/i386/acpi-build.c
> >> +++ b/hw/i386/acpi-build.c
> >> @@ -1792,21 +1792,7 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
> >>
> >>   #ifdef CONFIG_TPM
> >>       if (TPM_IS_CRB(tpm)) {
> >> -        dev =3D aml_device("TPM");
> >> -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101"))=
);
> >> -        aml_append(dev, aml_name_decl("_STR",
> >> -                                      aml_string("TPM 2.0 Device")));
> >> -        crs =3D aml_resource_template();
> >> -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> >> -                                           TPM_CRB_ADDR_SIZE,
> >> AML_READ_WRITE));
> >> -        aml_append(dev, aml_name_decl("_CRS", crs));
> >> -
> >> -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> >> -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> >> -
> >> -        tpm_build_ppi_acpi(tpm, dev);
> >> -
> >> -        aml_append(sb_scope, dev);
> >> +        call_dev_aml_func(DEVICE(tpm), scope);
> >
> > For an x86_64 VM we have to call it directly otherwise the ACPI table
> > won't be there.
> >
> >          tpm_crb_build_aml(tpm, sb_scope, TPM_CRB_ADDR_BASE,
> > TPM_CRB_ADDR_SIZE, true);
> >
> >
> I looks like a good place for the moved code would be in hw/acpi/tpm.c

The change in v5 is that we call "call_dev_aml_func" which calls
"tpm_crb_build_aml" from tpm_crb.c (later moved to tpm_crb_common.c).
I think it's a better place for it because TPM TIS has a different
ACPI table and both can be handled correctly by call_dev_aml_func. In
the previous versions when we moved TPM CRB to ISA there was no need
to manually call "call_dev_aml_func" because the function for building
the ISA bus called it. However, I think this is still better in case
it is decided in the future to move the CRB device on ISA or another
bus and it makes the code more manageable with more TPM types.


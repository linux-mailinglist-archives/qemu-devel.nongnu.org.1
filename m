Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED987B755E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnp1c-0008Ne-F0; Tue, 03 Oct 2023 19:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnp1U-0008DT-G2
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:41:55 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qnp1S-0001J1-BE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:41:52 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9936b3d0286so273225766b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696376509; x=1696981309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2kKssY1K4Voz5YS0eLOYx2ENbJBdfnUhIYUd/TkOAM=;
 b=KjTZMQc3dK6bAEY3pomxpz11OwEzuav4KmAzMzAp7gyDVCV8zoGpOeFj/7qUV1a/pP
 jgD4+8hU33ZfCu2Hpc/RR1YkATVh2ySA2LPBS3uyLlnws27zThLUD+cAbGoQfWTMYP/c
 VmLQLI9cSd1mNgpUmFII6d1jFMbSZxY7+FaGIUddXt3SRiuDnemGxNDL6BOEpNYXff3g
 ryKIar4ReZ+T0VzCgwR4crfE9m2Wwm1PKMB3FPlz8Va8ROolJ4XoTdteMdhOcmmyzEy8
 cODPD7jOF3EBUNAP5S0LQMK1H+/UmZFG4xAVHmuSJuHerMVxsWQmJg+0MWN5GWFVvqww
 taLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376509; x=1696981309;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2kKssY1K4Voz5YS0eLOYx2ENbJBdfnUhIYUd/TkOAM=;
 b=OG1ze0c3iDpP5GalknnXv8+a2L/gbdE6LJlgikQ+eqGRgyCnSVehiNCdYCgB6QKhU+
 EKtDvYMsRx/0TrBJz4AuKbYV0vEr4TSetESw7/dRmUveDXj6JVz6DZpogNCjifM95oQ1
 TGsFz6psgi/EU5DQcxKwn+sE8ew1GDcUk9yZHPblL2Z00mdUggE8aa2fwr6XMNiSaDnD
 e8nsukZTUiEixFQmNY3m8Yxm3Rm0L1wrVIFtDOfuc1T2iW+BRyey8fghIwXF9/pKlHFE
 pu1pze5ULAp//TMZaXfBroVOvbdQDVTosvmFrX4Wtvt8kfssPd4Rk6XYG3MmB3beD3d6
 d8wA==
X-Gm-Message-State: AOJu0Yxerj7uT4G7wMInuZk8Aie17bsdIUYZb98l9tSlKEutvUwCNiu9
 OEQaKyx4tJp31hPRQvoR4Mc=
X-Google-Smtp-Source: AGHT+IHlmWknz+zqY0gl9Hvs0x5hm0g0VsonMm7uGI4mPXmvv2uWfWsgs+3Zs8N8BYwkAogY1rF6yQ==
X-Received: by 2002:a17:907:7614:b0:9ae:2438:d6d with SMTP id
 jx20-20020a170907761400b009ae24380d6dmr582049ejc.51.1696376508641; 
 Tue, 03 Oct 2023 16:41:48 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf2af200c1d1cd88f0d7c31c.dip0.t-ipconnect.de.
 [2003:fa:af2a:f200:c1d1:cd88:f0d7:c31c])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a1709064a5200b009932337747esm1776349ejv.86.2023.10.03.16.41.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 16:41:48 -0700 (PDT)
Date: Tue, 03 Oct 2023 23:41:39 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/5] hw/i386/apic: Simplify apic_get_class()
In-Reply-To: <20231003082728.83496-4-philmd@linaro.org>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-4-philmd@linaro.org>
Message-ID: <2D436D7B-D6AA-4825-B2B4-0F9639CA2665@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 3=2E Oktober 2023 08:27:26 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <p=
hilmd@linaro=2Eorg>:
>Now than apic_get_class() can not fail, remove its

s/than/that/
s/can not/can't/ (which is stylistically consistent with "neither" below)

Best regards,
Bernhard

>Error** parameter=2E It can't return NULL neither, so
>simplify x86_cpu_apic_create()=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>---
> include/hw/i386/apic_internal=2Eh | 2 +-
> hw/i386/amd_iommu=2Ec             | 2 +-
> hw/i386/intel_iommu=2Ec           | 4 ++--
> target/i386/cpu-sysemu=2Ec        | 4 ++--
> 4 files changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/include/hw/i386/apic_internal=2Eh b/include/hw/i386/apic_int=
ernal=2Eh
>index 5f2ba24bfc=2E=2Ee61ad04769 100644
>--- a/include/hw/i386/apic_internal=2Eh
>+++ b/include/hw/i386/apic_internal=2Eh
>@@ -225,6 +225,6 @@ static inline int apic_get_bit(uint32_t *tab, int ind=
ex)
>     return !!(tab[i] & mask);
> }
>=20
>-APICCommonClass *apic_get_class(Error **errp);
>+APICCommonClass *apic_get_class(void);
>=20
> #endif /* QEMU_APIC_INTERNAL_H */
>diff --git a/hw/i386/amd_iommu=2Ec b/hw/i386/amd_iommu=2Ec
>index c98a3c6e11=2E=2E0a95025ab7 100644
>--- a/hw/i386/amd_iommu=2Ec
>+++ b/hw/i386/amd_iommu=2Ec
>@@ -1368,7 +1368,7 @@ static MemTxResult amdvi_mem_ir_write(void *opaque,=
 hwaddr addr,
>         return MEMTX_ERROR;
>     }
>=20
>-    apic_get_class(NULL)->send_msi(&to);
>+    apic_get_class()->send_msi(&to);
>=20
>     trace_amdvi_mem_ir_write(to=2Eaddress, to=2Edata);
>     return MEMTX_OK;
>diff --git a/hw/i386/intel_iommu=2Ec b/hw/i386/intel_iommu=2Ec
>index 2c832ab68b=2E=2Edffe3583bd 100644
>--- a/hw/i386/intel_iommu=2Ec
>+++ b/hw/i386/intel_iommu=2Ec
>@@ -397,7 +397,7 @@ static void vtd_generate_interrupt(IntelIOMMUState *s=
, hwaddr mesg_addr_reg,
>=20
>     trace_vtd_irq_generate(msi=2Eaddress, msi=2Edata);
>=20
>-    apic_get_class(NULL)->send_msi(&msi);
>+    apic_get_class()->send_msi(&msi);
> }
>=20
> /* Generate a fault event to software via MSI if conditions are met=2E
>@@ -3554,7 +3554,7 @@ static MemTxResult vtd_mem_ir_write(void *opaque, h=
waddr addr,
>         return MEMTX_ERROR;
>     }
>=20
>-    apic_get_class(NULL)->send_msi(&to);
>+    apic_get_class()->send_msi(&to);
>=20
>     return MEMTX_OK;
> }
>diff --git a/target/i386/cpu-sysemu=2Ec b/target/i386/cpu-sysemu=2Ec
>index 6a228c9178=2E=2E9038c65267 100644
>--- a/target/i386/cpu-sysemu=2Ec
>+++ b/target/i386/cpu-sysemu=2Ec
>@@ -247,7 +247,7 @@ void x86_cpu_machine_reset_cb(void *opaque)
>     cpu_reset(CPU(cpu));
> }
>=20
>-APICCommonClass *apic_get_class(Error **errp)
>+APICCommonClass *apic_get_class(void)
> {
>     const char *apic_type =3D "apic";
>=20
>@@ -266,7 +266,7 @@ APICCommonClass *apic_get_class(Error **errp)
> void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
> {
>     APICCommonState *apic;
>-    APICCommonClass *apic_class =3D apic_get_class(errp);
>+    APICCommonClass *apic_class =3D apic_get_class();
>=20
>     cpu->apic_state =3D DEVICE(object_new_with_class(OBJECT_CLASS(apic_c=
lass)));
>     object_property_add_child(OBJECT(cpu), "lapic",


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDFB70464B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp4N-0002Ne-Jt; Tue, 16 May 2023 03:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyp4K-0002Kx-KN
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:26:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyp4I-0007dU-Tv
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:26:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f42c86543bso54846735e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20221208.gappssmtp.com; s=20221208; t=1684221957; x=1686813957; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezlM8Es+XSXRFIHZdp4OqyXuLK6zFFQqlNU9vq/9klA=;
 b=BbI5Hrdn53lZMZT8u4v+LqXfsi3mdPP3WEKdYO9WMD9Ra8fY0ccupCisGG5kROL9ew
 HVDZ8laKeOFBwrXMvyLvqy1uqPa2/7/kX+2WdNlxgg6Q8UBPzBzSEeTff0UcH4bmslTR
 EgcIxJknyN/V8QkFEoXGpOFIu11pdBmylbzUzX4W+brfQ1Clmzk66UxOIcUFjaKvBD6I
 TErZ0vNeH9WrwEoYeFXTzlXQIFdTtZnpdmd02JyN+sljIe+KuzNFGOJDkQ82o/G+xPKx
 nDEMP1H4PSgl7MUsNB7re1tw3qSO+Kc49nviVQH9bjwvD1zICWGUiPuxWcXLeGhzK5Mi
 giHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684221957; x=1686813957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ezlM8Es+XSXRFIHZdp4OqyXuLK6zFFQqlNU9vq/9klA=;
 b=HLmb51FCuhI+3/yP1QPieTXyBIofR5tA8iwNRbkDovvitas9DgfIo1+oJt2QiTF1CE
 rZJJ6Z6WFOkB1/HLRtXd+OGWGkdS6x05Rxo8HhI0Fux+S3/qlscr+/MXiGspUZplvhWc
 ogSanNfIAYXnWlctbkO8WBF1GXE0O6pNk+FnhnvgpmbPZMo7d4EKpNWVHAUzoFlS1qsF
 1DBEctB5jjmq7kEq8QPBfVgNux6j81HHELrqZ12wd1xKxYkYEt1/xHDG0/MMVmjE7s/e
 n5DojsOEDigkqyPPzAEfGgkRKlJuRMny4ek05IwfLbjDhBtkFNXh8WvEMaBDxxMZw2hd
 Hd/A==
X-Gm-Message-State: AC+VfDwlJhmC6IUbl6bDNO8qGRqwKMYiX1IjUz6PXZI6KpwV7HQspB4F
 JHLoR+TF25o7HD8zit/X/E+JtkBYGQryEw7XaODysQ==
X-Google-Smtp-Source: ACHHUZ47r/RrDjjVOitJKG/pu/Ul3CKaNuZqlYIKhfPl9bVcXJTpTvCzxaYXyuZaEBrzRNQEfITvdkKsRuVICK06frA=
X-Received: by 2002:adf:dc04:0:b0:307:a33d:d054 with SMTP id
 t4-20020adfdc04000000b00307a33dd054mr17502713wri.49.1684221957408; Tue, 16
 May 2023 00:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-3-eric.devolder@oracle.com>
In-Reply-To: <20230515203311.2139-3-eric.devolder@oracle.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 16 May 2023 12:55:46 +0530
Message-ID: <CAARzgwyNkKh_2PWe+ca1FKgtUKy22d3n7TMKRFpQcZkcaAnhQA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: i386: bump to MADT to revision 3
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com, 
 imammedo@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::332;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 16, 2023 at 2:04=E2=80=AFAM Eric DeVolder <eric.devolder@oracle=
.com> wrote:
>
> Currently i386 QEMU generates MADT revision 3, and reports
> MADT revision 1. Set .revision to 3 to match reality.
>
> Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devol=
der@ora
> cle.com/T/#t
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/i386/acpi-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 52e5c1439a..8a0932fe84 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *=
linker,
>      MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
>      const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHINE(=
x86ms));
>      AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(adev);
> -    AcpiTable table =3D { .sig =3D "APIC", .rev =3D 1, .oem_id =3D oem_i=
d,
> +    AcpiTable table =3D { .sig =3D "APIC", .rev =3D 3, .oem_id =3D oem_i=
d,
>                          .oem_table_id =3D oem_table_id };
>
>      acpi_table_begin(&table, table_data);
> --
> 2.31.1
>


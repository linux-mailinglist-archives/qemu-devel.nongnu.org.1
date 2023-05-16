Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F30CC704E23
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 14:52:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyuA4-0002WB-2V; Tue, 16 May 2023 08:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyu9t-00026j-ET
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:52:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pyu9r-0007hM-93
 for qemu-devel@nongnu.org; Tue, 16 May 2023 08:52:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-307664010fdso13369644f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 05:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20221208.gappssmtp.com; s=20221208; t=1684241521; x=1686833521; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9KLrUPpyXtxjGP2a6+NY4iggSmqVWW4xYF9D43kaPh0=;
 b=NbGrrGKiZoQMyf6m+MqhYthXtBZGsYM8u2W/kjC4JNx89fw/1/K3KiAPeuyhcRVC1k
 0nx7BC0TuHA4R2WX981moMBN9YVFzcEywQ2YIhHxs93ZRXOfrbob/m0BGdf6LjhUZ77T
 siLDHCUjJVunvDwyOjINjJb1eixT/7UrGCtIvgMTmPW+0U4vvMGZvlOLsaxs/yE7qYvL
 449DvC9fyS9vEr/q7mR5AZ0ik87av0NvhuZhEQ1Oldefdgm7+8s3iXxYLjKFMCYo8ZZH
 rYtE5shWvpBziWhXE0iIvcmZv0Nl3yobn58k1tptsrCs8qBIUNb4yd4cE9OHtvTYCIP7
 nyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684241521; x=1686833521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KLrUPpyXtxjGP2a6+NY4iggSmqVWW4xYF9D43kaPh0=;
 b=GUtjrApu1Trm2LSl3KovG2WIg5Gq3WNP+08Y4+Pr8nR9BtVns48h6nlZfmUfIj4MJs
 QYSpQzBJhRYq3VRrQ8YnD50SnxsTgsPTO9DcMcTlPtgOoemhSj6NLm47r9Ho2OXlbYvX
 WTfIR8r6g/NA8YnQ8qo7seUKYE/kyywsHth/Pgy9i6BFSrRdz4va06vep3iGka1sEdTr
 wPcLZsiKf+LP9f5Tq4vaKL3BG7kqELlLKcWlinoVFL79gE+Z8XwMTI+dxED6eLr6AyGN
 TebMwp/lwuQzfj29AM7ISwYgPucUHoM2bt/S7kTOhnu/Wouv+862lNq21gDfUxWtxsp0
 7bkg==
X-Gm-Message-State: AC+VfDxg+4fIJQExDpnJ/dGXcNwkiTB1+pFnA1pbfCxTuhk197RXsImh
 pL5rl5cCjkt8oUdn0bxQzCjYISgXwIOgGQnTbmlNXw==
X-Google-Smtp-Source: ACHHUZ6UNIUTEP9hf8FEPSU2klaDPSpHeeFp7Fx2EMng4sATOdW8AW6n4+T3ieblQhaspZ8IoFcejKBThYvnBA0wyvA=
X-Received: by 2002:adf:fc8c:0:b0:306:3204:3633 with SMTP id
 g12-20020adffc8c000000b0030632043633mr25252275wrr.22.1684241520819; Tue, 16
 May 2023 05:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-3-eric.devolder@oracle.com>
 <20230516143149.42ad6810@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230516143149.42ad6810@imammedo.users.ipa.redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 16 May 2023 18:21:49 +0530
Message-ID: <CAARzgww1zX5Ss9gpredzt9X83df5yd3Y_P7kVzauw58yXTryZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ACPI: i386: bump to MADT to revision 3
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>, qemu-devel@nongnu.org, 
 shannon.zhaosl@gmail.com, mst@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, boris.ostrovsky@oracle.com, 
 miguel.luis@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::429;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 16, 2023 at 6:01=E2=80=AFPM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> On Mon, 15 May 2023 16:33:10 -0400
> Eric DeVolder <eric.devolder@oracle.com> wrote:
>
> > Currently i386 QEMU generates MADT revision 3, and reports
> > MADT revision 1. Set .revision to 3 to match reality.
> >
> > Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.dev=
older@ora
> > cle.com/T/#t
> > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > ---
> >  hw/i386/acpi-common.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> > index 52e5c1439a..8a0932fe84 100644
> > --- a/hw/i386/acpi-common.c
> > +++ b/hw/i386/acpi-common.c
> > @@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker=
 *linker,
> >      MachineClass *mc =3D MACHINE_GET_CLASS(x86ms);
> >      const CPUArchIdList *apic_ids =3D mc->possible_cpu_arch_ids(MACHIN=
E(x86ms));
> >      AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(adev);
> > -    AcpiTable table =3D { .sig =3D "APIC", .rev =3D 1, .oem_id =3D oem=
_id,
> > +    AcpiTable table =3D { .sig =3D "APIC", .rev =3D 3, .oem_id =3D oem=
_id,
> >                          .oem_table_id =3D oem_table_id };
> >
> >      acpi_table_begin(&table, table_data);
>
> make check fails for me at this point
> (my guess is that not all APIC tables are whitelisted)

I think the patchset needs to be rebased and the blobs regenerated.


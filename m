Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E04705978
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 23:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz2DY-0007YE-9m; Tue, 16 May 2023 17:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pz2DT-0007XN-R0
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pz2DQ-0002tT-KA
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684272494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TFAUgf29GjbYcm/qm0sOT4i4fQMO8RQaCqw25hYYDHs=;
 b=IcJHaQL+/tY/1xPdaP4Ao0DQVTGvRAKQCBGHpEpgZsEn4+zXRd6LLZPuda7IZc1fnWkL95
 1mg55pbWd3Pyt4IudSuSfs1o7SaJhrYjLUhp+BDth996E2Oiz8+8CQ2qmpYPLEMbVjpchm
 XXk/XJYfVfUx+MmBOXKxk5pIie5CH4w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-Kn4owqYdO_u1xX7GHfO00Q-1; Tue, 16 May 2023 17:28:12 -0400
X-MC-Unique: Kn4owqYdO_u1xX7GHfO00Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so7331773f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 14:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684272492; x=1686864492;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TFAUgf29GjbYcm/qm0sOT4i4fQMO8RQaCqw25hYYDHs=;
 b=flWX5PGhwGxJDfzkLU+2DOpMsCzQL6D1KDNzBeGeJ3pDtDVuDCV+HBpTQMHuwONfth
 3+KH6GlkRDKxQ7s/OJQTdidYLOeUBJ4U6LIaREAZTqRvtjh2XGJFASOraq4EwvHDikof
 jfGqK5R+sbK9ugC0r8KAjb9+Bn2DV0bZuQhdS68DSWbPAjWHa1O3r6GxC8Kil1lsK6ME
 w49HtEYgczf5RFzbE+UktD31hNZek9fkpVgO4v3mP1f7ARDDCMyvG6iAv/nc8s4tC6I2
 veDSqUYpcIabbP9tREU3+SG+U2I948KaKd3++jA4IEIqIUeNyl8PR/jKUdt70L0AegVZ
 oS+Q==
X-Gm-Message-State: AC+VfDyO2RHP89jpivYtPvJwH6/W0i0st1zSAp6/u20XiM5XNM1yh0Ps
 VtBA7cyu/DpzU3Ki/nBtvfvlXklWA4BjamRkCjGKcDKjVSTinoNEEJqD7/RHhBWi4TiBV3GQjIU
 9J6OmGDXvWfvkd84=
X-Received: by 2002:adf:f30b:0:b0:2f8:f775:c885 with SMTP id
 i11-20020adff30b000000b002f8f775c885mr27372341wro.6.1684272491801; 
 Tue, 16 May 2023 14:28:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Uvj3Y6jQAtgS1hM2ueTXLyoY/bp8055p2OIRgB6qbOjoSjd0EbjocU+azY6okyKpmWYcXDA==
X-Received: by 2002:adf:f30b:0:b0:2f8:f775:c885 with SMTP id
 i11-20020adff30b000000b002f8f775c885mr27372325wro.6.1684272491484; 
 Tue, 16 May 2023 14:28:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:3448:6dd9:9d1c:f4ae:94f0])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a5d4e01000000b002c70ce264bfsm526176wrt.76.2023.05.16.14.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 14:28:10 -0700 (PDT)
Date: Tue, 16 May 2023 17:28:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Ani Sinha <ani@anisinha.ca>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 peter.maydell@linaro.org, qemu-arm@nongnu.org,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Subject: Re: [PATCH 2/3] ACPI: i386: bump to MADT to revision 3
Message-ID: <20230516172635-mutt-send-email-mst@kernel.org>
References: <20230515203311.2139-1-eric.devolder@oracle.com>
 <20230515203311.2139-3-eric.devolder@oracle.com>
 <20230516143149.42ad6810@imammedo.users.ipa.redhat.com>
 <CAARzgww1zX5Ss9gpredzt9X83df5yd3Y_P7kVzauw58yXTryZA@mail.gmail.com>
 <72a526b6-420e-6a85-8cbd-dc589c220c58@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72a526b6-420e-6a85-8cbd-dc589c220c58@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 16, 2023 at 04:22:58PM -0500, Eric DeVolder wrote:
> 
> 
> On 5/16/23 07:51, Ani Sinha wrote:
> > On Tue, May 16, 2023 at 6:01 PM Igor Mammedov <imammedo@redhat.com> wrote:
> > > 
> > > On Mon, 15 May 2023 16:33:10 -0400
> > > Eric DeVolder <eric.devolder@oracle.com> wrote:
> > > 
> > > > Currently i386 QEMU generates MADT revision 3, and reports
> > > > MADT revision 1. Set .revision to 3 to match reality.
> > > > 
> > > > Link: https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@ora
> > > > cle.com/T/#t
> > > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > > ---
> > > >   hw/i386/acpi-common.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> > > > index 52e5c1439a..8a0932fe84 100644
> > > > --- a/hw/i386/acpi-common.c
> > > > +++ b/hw/i386/acpi-common.c
> > > > @@ -102,7 +102,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
> > > >       MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> > > >       const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
> > > >       AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
> > > > -    AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = oem_id,
> > > > +    AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
> > > >                           .oem_table_id = oem_table_id };
> > > > 
> > > >       acpi_table_begin(&table, table_data);
> > > 
> > > make check fails for me at this point
> > > (my guess is that not all APIC tables are whitelisted)
> > 
> > I think the patchset needs to be rebased and the blobs regenerated.
> 
> So I've been trying to overcome this today and not having much luck.
> 
> When I run "make check V=2", I see at the end:
> 
> Summary of Failures:
> 
>  45/786 qemu:qtest+qtest-i386 / qtest-i386/bios-tables-test
>  68/786 qemu:qtest+qtest-x86_64 / qtest-x86_64/bios-tables-test
> 
> If I go look at 45/786, for example, I see:
> 
> Looking for expected file 'tests/data/acpi/pc/FACP'
> Using expected file 'tests/data/acpi/pc/FACP'
> Looking for expected file 'tests/data/acpi/pc/APIC'
> Using expected file 'tests/data/acpi/pc/APIC'
> Looking for expected file 'tests/data/acpi/pc/HPET'
> Using expected file 'tests/data/acpi/pc/HPET'
> Looking for expected file 'tests/data/acpi/pc/WAET'
> Using expected file 'tests/data/acpi/pc/WAET'
> Looking for expected file 'tests/data/acpi/pc/FACS'
> Using expected file 'tests/data/acpi/pc/FACS'
> Looking for expected file 'tests/data/acpi/pc/DSDT'
> Using expected file 'tests/data/acpi/pc/DSDT'
> acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-R4D741],
> Expected [aml:tests/data/acpi/pc/APIC].
> See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
> acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-GVD741.dsl,
> aml:/tmp/aml-R4D741], Expected [asl:/tmp/asl-1F9641.dsl,
> aml:tests/data/acpi/pc/APIC].
> --- /tmp/asl-1F9641.dsl 2023-05-16 15:18:31.292579156 -0400
> +++ /tmp/asl-GVD741.dsl 2023-05-16 15:18:31.291579149 -0400
> @@ -1,32 +1,32 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20230331 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/pc/APIC, Tue May 16 15:18:31 2023
> + * Disassembly of /tmp/aml-R4D741, Tue May 16 15:18:31 2023
>   *
>   * ACPI Data Table [APIC]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>   */
> 
>  [000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
>  [004h 0004 004h]                Table Length : 00000078
> -[008h 0008 001h]                    Revision : 01
> -[009h 0009 001h]                    Checksum : 8A
> +[008h 0008 001h]                    Revision : 03
> +[009h 0009 001h]                    Checksum : 88
>  [00Ah 0010 006h]                      Oem ID : "BOCHS "
>  [010h 0016 008h]                Oem Table ID : "BXPC    "
>  [018h 0024 004h]                Oem Revision : 00000001
>  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>  [020h 0032 004h]       Asl Compiler Revision : 00000001
> [...]
> 
> And the q35 looks very very similar.
> 
> It suggests that I need to list tests/data/acpi/pc/APIC, which I have done
> in bios-tables-test-allowed-diff.h:
> 
> /* List of comma-separated changed AML files to ignore */
> "tests/data/acpi/pc/APIC",
> "tests/data/acpi/q35/APIC",
> "tests/data/acpi/microvm/APIC",
> "tests/data/acpi/virt/APIC",
> 
> But as I looked closer at the files that changed in the last step
> of the previous post, there are a bunch of them:
> 
>  tests/data/acpi/microvm/APIC                  | Bin 70 -> 70 bytes
>  tests/data/acpi/microvm/APIC.ioapic2          | Bin 82 -> 82 bytes
>  tests/data/acpi/microvm/APIC.pcie             | Bin 110 -> 110 bytes
>  tests/data/acpi/pc/APIC                       | Bin 120 -> 120 bytes
>  tests/data/acpi/pc/APIC.acpihmat              | Bin 128 -> 128 bytes
>  tests/data/acpi/pc/APIC.cphp                  | Bin 160 -> 160 bytes
>  tests/data/acpi/pc/APIC.dimmpxm               | Bin 144 -> 144 bytes
>  tests/data/acpi/q35/APIC                      | Bin 120 -> 120 bytes
>  tests/data/acpi/q35/APIC.acpihmat             | Bin 128 -> 128 bytes
>  tests/data/acpi/q35/APIC.acpihmat-noinitiator | Bin 144 -> 144 bytes
>  tests/data/acpi/q35/APIC.core-count2          | Bin 2478 -> 2478 bytes
>  tests/data/acpi/q35/APIC.cphp                 | Bin 160 -> 160 bytes
>  tests/data/acpi/q35/APIC.dimmpxm              | Bin 144 -> 144 bytes
>  tests/data/acpi/q35/APIC.xapic                | Bin 2686 -> 2686 bytes
> 
> Should all of these files be listed in allowed-diff.h?

unfortunately, yes.

> And I would also need to provide the diff for each in the patch
> containing this last step, correct?
> 
> Thanks,
> eric

if you mean commit log, if the diff is the same it is
enough to list it once and mention it is the same.

-- 
MST



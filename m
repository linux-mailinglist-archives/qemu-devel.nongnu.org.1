Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB1A7046A8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pypHN-0004iw-Q3; Tue, 16 May 2023 03:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pypHK-0004dH-P2
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:39:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1pypHI-0001vn-ED
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:39:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-307c040797bso4458997f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20221208.gappssmtp.com; s=20221208; t=1684222762; x=1686814762; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1UfqrNCKG7o7XwwcY0l9H9T2D5WfH2yjo8z8z7kn8qI=;
 b=iQ72D+R0hkbJ5kGn+NQSlrVpMpXLMXXdv7QRuVGlp9nxbYsOBWoheRAtr4oEQ9rd1Z
 eToZ9hYUdf5b5d29PE7Fg9QOuFLZH+PTc9jLlXerHARcllM7GyHpvDx8c2hVLPnr14Xn
 bYcOMHQS+WjpkRsJCAp1Q2tukSo8N2b15e6m++ngGOGnTmLuVaG4aCPIo4P5H4T9GapQ
 48OUSTQo1sxTBhXOEUyBNiRH4ms8NEDfobrqbIncWzSfC5OiNGqP2KRSXRW6mJI3TH/h
 wTet0tl8AYZqtPCIc/5HsG9sKXVgzp7qj9fNCLXyFlGf91Dx+ntn/8mP+7LmMwk86qFZ
 sUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222762; x=1686814762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1UfqrNCKG7o7XwwcY0l9H9T2D5WfH2yjo8z8z7kn8qI=;
 b=Tmheh7O0Xl6rzKTW+WJ+WE9G1I06qXkoqboLvpw+leTeTL6U0Q4V76NO/W9EenukWl
 BZ0Ppw68+d3OBZzVBFyobDWjpc5go4lzbZrFlYSdlJmHrkbWfLBo+js7WXoCJbdqGZlR
 zxnV6aiBexcdRsi9dqo6SP04X9uN37lmCI52ZoravAMp8zM51et5A5NHqMdewXLqiiJW
 wNgYBfM96OcGY5w8mThYuu+LpoYEbq4s3TAEanVyYzlZMKGjIRwyX/mraqzhAu0mmgn3
 AXzDZEeMg3FM/MBq0wPwslknTTYpxiA1BADHZsBjWVehX6JIRi+b/WPWqscrUcznm7Bh
 7ncg==
X-Gm-Message-State: AC+VfDwb9GmIHkqOGi9/7eMnSolU3W0YKedB2FkGqdaHOUB6PXc+JZCq
 t/vT3Nzv6scLu0T4EdcuG0UmKRyFSGrehRY3OiYjyQ==
X-Google-Smtp-Source: ACHHUZ5Q6XYh6y9jRNDthfhOuinqB5dGEdulvAy0okcgkeQcEqmtQhssAqTyl1aJvEbh/Z6LsMm2mY592wX4cpM237A=
X-Received: by 2002:adf:f28a:0:b0:309:732:86df with SMTP id
 k10-20020adff28a000000b00309073286dfmr7214961wro.58.1684222761483; Tue, 16
 May 2023 00:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230515203311.2139-1-eric.devolder@oracle.com>
In-Reply-To: <20230515203311.2139-1-eric.devolder@oracle.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 16 May 2023 13:09:10 +0530
Message-ID: <CAARzgwwT1n-hyDRbbwk+i50KSgRDoP9ivSwwJU18p8C1xUMyaw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: i386: bump MADT to revision 3
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, mst@redhat.com, 
 imammedo@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, 
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::42f;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x42f.google.com
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

On Tue, May 16, 2023 at 2:03=E2=80=AFAM Eric DeVolder <eric.devolder@oracle=
.com> wrote:
>
> The following Linux kernel change broke CPU hotplug for MADT revision
> less than 5.
>
>  e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be =
onlined for x2APIC")
>
> Discussion on this topic can be located here:
>
>  https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@o=
racle.com/T/#t
>
> which resulted in the following fixes in Linux 6.3-rc5:
>
>  a74fabfbd1b7: ("x86/ACPI/boot: Use FADT version to check support for onl=
ine capable")
>  fed8d8773b8e: ("x86/acpi/boot: Correct acpi_is_processor_usable() check"=
)
>
> However, as part of the investigation into resolving this breakage, I
> learned that i386 QEMU reports revision 1, while technically it
> generates revision 3.

Since this series was sent to my personal email and not my redhat
email, I suspect you have not rebased your patchset. Maybe you should
do that in case it generates any conflicts etc.

>
> Below is a table summarizing the changes to the MADT. This information
> gleamed from the ACPI specs on uefi.org.
>
> ACPI    MADT    What
> Version Version
> 1.0             MADT not present
> 2.0     1       Section 5.2.10.4
> 3.0     2       Section 5.2.11.4
>                  5.2.11.13 Local SAPIC Structure added two new fields:
>                   ACPI Processor UID Value
>                   ACPI Processor UID String
>                  5.2.10.14 Platform Interrupt Sources Structure:
>                   Reserved changed to Platform Interrupt Sources Flags
> 3.0b    2       Section 5.2.11.4
>                  Added a section describing guidelines for the ordering o=
f
>                  processors in the MADT to support proper boot processor
>                  and multi-threaded logical processor operation.
> 4.0     3       Section 5.2.12
>                  Adds Processor Local x2APIC structure type 9
>                  Adds Local x2APIC NMI structure type 0xA
> 5.0     3       Section 5.2.12
> 6.0     3       Section 5.2.12
> 6.0a    4       Section 5.2.12
>                  Adds ARM GIC structure types 0xB-0xF
> 6.2a    45      Section 5.2.12   <--- version 45, is indeed accurate!
> 6.2b    5       Section 5.2.12
>                  GIC ITS last Reserved offset changed to 16 from 20 (typo=
)
> 6.3     5       Section 5.2.12
>                  Adds Local APIC Flags Online Capable!
>                  Adds GICC SPE Overflow Interrupt field
> 6.4     5       Section 5.2.12
>                  Adds Multiprocessor Wakeup Structure type 0x10
>                  (change notes says structure previously misplaced?)
> 6.5     5       Section 5.2.12
>
> For the MADT revision change 1 -> 2, the spec has a change to the
> SAPIC structure. In general, QEMU does not generate/support SAPIC.
> So the QEMU i386 MADT revision can safely be moved to 2.
>
> For the MADT revision change 2 -> 3, the spec adds Local x2APIC
> structures. QEMU has long supported x2apic ACPI structures.
> So the QEMU i386 MADT revision can safely be moved to 3.
>
> So, set the MADT revision to 3.
>
> Regards,
> Eric
> ---
> Eric DeVolder (3):
>   ACPI: bios-tables-test.c step 2 (allowed-diff entries)
>   ACPI: i386: bump to MADT to revision 3
>   ACPI: bios-tables-test.c step 5 (update expected table binaries)
>
>  hw/i386/acpi-common.c                         |   2 +-
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
>  15 files changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.31.1
>


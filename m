Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5AD70854B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfrC-0004df-NL; Thu, 18 May 2023 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pzfpx-00043O-SP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1pzfpu-0007Wb-Q5
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684424779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+ohhMLdD6oMt7wQsCjH5gTw3CSm0NjJslp4cmuIvf4=;
 b=UySCh6TMjmKaMonKzJG/T5VKQhAMdrU3zse44xbs/d5AcAmKZBsuJHBlim/pEcuNK/tDy8
 KjwVzNUIPHatmSqbFFjcqMh8djJ7jTUcaIv/6Vf2s+Ho7FtMrjUWDcv1501aVB+LEZdZEp
 zVWZQWl12NDPBHovXFmzPWD9h2gvQNM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ydRITNlUPPa_n9F2hFpBLA-1; Thu, 18 May 2023 11:46:08 -0400
X-MC-Unique: ydRITNlUPPa_n9F2hFpBLA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9698409b9bfso205734366b.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684424766; x=1687016766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+ohhMLdD6oMt7wQsCjH5gTw3CSm0NjJslp4cmuIvf4=;
 b=d3ew7q8F3yvwvW5VnIanSS0h95a/AtSfrhbgsUiF1WLmxKg4aFqYVhDkBLS/Xkeksy
 vbA38v5NkzyrVCax3kyl/T9zZTDR4ITiuBtamktisfBEAzs4wvvTrimmTL53XDucHiWr
 9tPfciwOxvRtKXQdN7UTy6Z0UtQaoiqmo1HcAp6pCz1KcInTq/dY1aL5UX+phEniydeo
 hqzTwtDgF5E1SHHMc2u8rLkLaj+2boXdzbbU7R4IwhxzuMb88UA6p87EGlY7slrGAp3z
 iY+SoiI9Gu7u/BP7CYyVbcSESjyY7S+LmrtGPebR/cTi8hB6UsKrNhcenOou59V77XXz
 UYRQ==
X-Gm-Message-State: AC+VfDy/bqqROcBOiFG+3ldpezZ/E6KzZB3E4oTRlC7Zqci25AM0a4gO
 BfNFKgmzIsJ5cjq7i+gx0cVBaUgfijGCRFucXBmrhVfRmrhLADE4WjFU4G69XrBSHpB2stuqb1c
 JnjyNpRlxBYWdqvY=
X-Received: by 2002:a17:907:3fa5:b0:96a:eb4e:e310 with SMTP id
 hr37-20020a1709073fa500b0096aeb4ee310mr5898367ejc.23.1684424766079; 
 Thu, 18 May 2023 08:46:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sf9YmNoXpiEPn32z1lF2B1E+6UGSRKwmLLSxLFa+sXqXSHEVQQg3jhjCvbIFaU8/a/7OvMw==
X-Received: by 2002:a17:907:3fa5:b0:96a:eb4e:e310 with SMTP id
 hr37-20020a1709073fa500b0096aeb4ee310mr5898341ejc.23.1684424765706; 
 Thu, 18 May 2023 08:46:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 qx16-20020a170906fcd000b009545230e682sm1131739ejb.91.2023.05.18.08.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:46:05 -0700 (PDT)
Date: Thu, 18 May 2023 17:46:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com, miguel.luis@oracle.com
Subject: Re: [PATCH v2 0/3] ACPI: i386: bump MADT to revision 3
Message-ID: <20230518174604.2c43cd70@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230517162545.2191-1-eric.devolder@oracle.com>
References: <20230517162545.2191-1-eric.devolder@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
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

On Wed, 17 May 2023 12:25:42 -0400
Eric DeVolder <eric.devolder@oracle.com> wrote:

> The following Linux kernel change broke CPU hotplug for MADT revision
> less than 5.
> 
>  e2869bd7af60 ("x86/acpi/boot: Do not register processors that cannot be onlined for x2APIC")
> 
> Discussion on this topic can be located here:
> 
>  https://lore.kernel.org/linux-acpi/20230327191026.3454-1-eric.devolder@oracle.com/T/#t
> 
> which resulted in the following fixes in Linux 6.3-rc5:
> 
>  a74fabfbd1b7: ("x86/ACPI/boot: Use FADT version to check support for online capable")
>  fed8d8773b8e: ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
> 
> However, as part of the investigation into resolving this breakage, I
> learned that i386 QEMU reports revision 1, while technically it
> generates revision 3.
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
>                  Added a section describing guidelines for the ordering of
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
>                  GIC ITS last Reserved offset changed to 16 from 20 (typo)
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
> v2: 17may2023
>  - Fix problems with the binary tables for the bios-tables-test.c
>    and make check.
> 
> v1: 15may2023
>  - initial
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>



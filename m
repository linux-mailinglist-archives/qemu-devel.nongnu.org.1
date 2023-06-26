Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387873DCF2
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDk6Q-0008QX-HE; Mon, 26 Jun 2023 07:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDk6J-0008J3-Sp
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qDk6F-0007sB-VP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKuhqAmMw6XWgOV+7nhL8FIO0+61ioUAYYMq6X8IhSI=;
 b=bnJbfhJtoK759A0dmm3ZWQajqMlZ41DqQe5hMq1Pvkv/aDabW/EcBpKvpJU3KpxryAOqne
 5YcCTzrMX2E6vVvXmdYOG15W+vu1b8rzTNvMiD4005JaC0nbf8X19qXiZsnc+PRLc3JO8r
 87LNwuA3ndg9GBdAwcTYD0b+ydDIL4I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-pScWug87Om2DqBEdHR4bLg-1; Mon, 26 Jun 2023 07:09:37 -0400
X-MC-Unique: pScWug87Om2DqBEdHR4bLg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51a38fb9dc8so1918534a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777776; x=1690369776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKuhqAmMw6XWgOV+7nhL8FIO0+61ioUAYYMq6X8IhSI=;
 b=EOpNuXn9kDvIbVBi8fvjOtZUHF91BDEMDiDKI4WCMbANzqWLqxoz7ZkK93IQbr9Epf
 jEt9wiKIPEHpCyLvYYrFgkG/UMqLaobBV5NiLw7x4RFT7K9i+UPFKKWre5IlnoEKAiN7
 zWqIH60h/mwT9l5jPBcwvod0ylnXFNoDmBf17u43NNPouzmIZN+RRDg+1yqquJCID45K
 UPCNh4aoTUhPyMqZFi4qDawAqPL2PeLZBL1TG1gp26L0nGn3k2OoF/orz3ZQlVhJOyem
 NH9X/YVRVKO+qOrzUf5mqIaqmcQdJFqLVN0ayg6QZShePsuhyH2I5Rq5kcIPDI2gQFdS
 bBpg==
X-Gm-Message-State: AC+VfDwCnBXyE9MMtCbx1kqXaSi7EkbNwMZWX0q7IEBZriZ3pJt3fzm2
 vLf1q/Uy1k6ogB9ye/u3Mtp6nCAKy6HCs3Mzobqp1GXQ3a3mLlCXG0HQEWp2i1rcOjbckiFUfTX
 yOLiraaQYF/nZqQ8=
X-Received: by 2002:a50:ec8c:0:b0:51b:d567:cfed with SMTP id
 e12-20020a50ec8c000000b0051bd567cfedmr11211602edr.5.1687777776394; 
 Mon, 26 Jun 2023 04:09:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43cStQmApYyLzV8n8NFw0haPNxIcoYQk6n2EyuEyXr5NgpLi8NpaHfGYH4C30H16/k+rdFiQ==
X-Received: by 2002:a50:ec8c:0:b0:51b:d567:cfed with SMTP id
 e12-20020a50ec8c000000b0051bd567cfedmr11211591edr.5.1687777776140; 
 Mon, 26 Jun 2023 04:09:36 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 bc23-20020a056402205700b0051d9dbf5edfsm647252edb.55.2023.06.26.04.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:09:35 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:09:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/acpi/bios-tables-test: update acpi blob
 q35/DSDT.noacpihp
Message-ID: <20230626130934.356f4c27@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230621140723.462220-4-anisinha@redhat.com>
References: <20230621140723.462220-1-anisinha@redhat.com>
 <20230621140723.462220-4-anisinha@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 21 Jun 2023 19:37:23 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> Some fixes were committed in bios-tables-test in the previous commit. Update
> the acpi blob and clear bios-tables-test-allowed-diff.h so that the test
> continues to pass with the changes in the bios-tables-test.
> 
> Following is the asl diff between the old and the newly updated blob:
> 
> @@ -1,30 +1,30 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20210604 (64-bit version)
>   * Copyright (c) 2000 - 2021 Intel Corporation
>   *
>   * Disassembling to symbolic ASL+ operators
>   *
> - * Disassembly of tests/data/acpi/q35/DSDT.noacpihp, Wed Jun 21 18:26:52 2023
> + * Disassembly of /tmp/aml-O8SU61, Wed Jun 21 18:26:52 2023
>   *
>   * Original Table Header:
>   *     Signature        "DSDT"
> - *     Length           0x00002038 (8248)
> + *     Length           0x00002031 (8241)
>   *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
> - *     Checksum         0x4A
> + *     Checksum         0x89
>   *     OEM ID           "BOCHS "
>   *     OEM Table ID     "BXPC    "
>   *     OEM Revision     0x00000001 (1)
>   *     Compiler ID      "BXPC"
>   *     Compiler Version 0x00000001 (1)
>   */
>  DefinitionBlock ("", "DSDT", 1, "BOCHS ", "BXPC    ", 0x00000001)
>  {
>      Scope (\)
>      {
>          OperationRegion (DBG, SystemIO, 0x0402, One)
>          Field (DBG, ByteAcc, NoLock, Preserve)
>          {
>              DBGB,   8
>          }
> 
> @@ -3148,48 +3148,48 @@
>                  {
>                      Name (_ADR, Zero)  // _ADR: Address
>                      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>                      {
>                          Local0 = Package (0x01)
>                              {
>                                  0x01F5
>                              }
>                          Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
>                      }
>                  }
>              }
> 
>              Device (S40)
>              {
>                  Name (_ADR, 0x00080000)  // _ADR: Address
> -                Device (S41)
> +                Device (S01)
>                  {
> -                    Name (_ADR, 0x00080001)  // _ADR: Address
> +                    Name (_ADR, One)  // _ADR: Address
>                      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>                      {
>                          Local0 = Package (0x01)
>                              {
>                                  0x0259
>                              }
>                          Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
>                      }
>                  }
> 
> -                Device (S48)
> +                Device (S02)
>                  {
> -                    Name (_ADR, 0x00090000)  // _ADR: Address
> +                    Name (_ADR, 0x02)  // _ADR: Address
>                      Device (S00)
>                      {
>                          Name (_ADR, Zero)  // _ADR: Address
>                      }
>                  }
>              }
> 
>              Device (SF8)
>              {
>                  Name (_ADR, 0x001F0000)  // _ADR: Address
>                  OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
>                  Scope (\_SB)
>                  {
>                      Field (PCI0.SF8.PIRQ, ByteAcc, NoLock, Preserve)
>                      {
>                          PRQA,   8,
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/q35/DSDT.noacpihp           | Bin 8248 -> 8241 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
> 
> diff --git a/tests/data/acpi/q35/DSDT.noacpihp b/tests/data/acpi/q35/DSDT.noacpihp
> index 6ab1f0e52543fcb7f84a7fd1327fe5aa42010565..8cab2f8eb9ae94e0165f3f17857ec7d080fb0e13 100644
> GIT binary patch
> delta 109
> zcmdntu+f3bCD<jzP=SGgv2!Dri!7J3UQB$jQ@nt;?&b(tDMlAZ)?gEZc#e2SmmnSn
> z1`dYkCY4|VLx=#Qh(x?gurE)65Gx~hBvZl?S0FDVGb=kGx=AwFzzCv>i)r&-xoSoL  
> DyqFtK
> 
> delta 94
> zcmdn!u)~4NCD<jzLV<yS(Q6}@i!7IyUQB$jQ@nta-sT8dDMm#P)?gEZc#e2SmmnSn
> k1`dYkCXHYdL#O~FP+)SuoHV~ou!#j+5huguZF1F&02bsG6#xJL
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index 31df9c6187..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.noacpihp",



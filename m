Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463EA47EA2
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 14:12:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndfE-0003m1-Rx; Thu, 27 Feb 2025 08:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndf6-0003li-Hf
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndf4-0007rV-1X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740661843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C47eEjmJaVqu/3uObrRrcqjFV5Gh0jdIcLpUBogWc8g=;
 b=frmhIy+R6q2EsjPkQLB5PB8Fr1STaWlbKdGw/aL9Gt/M0XxvnHI5NS2npHR+jPCDEFebAH
 4tmSWiaYGqEj2whRuplUCTUG7585zEghHw3STXmoVeE78eGyynEWDn0ShuccIYiBUVLCzw
 t6v3yLSn4yjGwVzUTPPzHZKKjP8OCGU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57--tocEk2TOh6KcVIYRNBgBw-1; Thu, 27 Feb 2025 08:10:42 -0500
X-MC-Unique: -tocEk2TOh6KcVIYRNBgBw-1
X-Mimecast-MFC-AGG-ID: -tocEk2TOh6KcVIYRNBgBw_1740661841
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so777512f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740661841; x=1741266641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C47eEjmJaVqu/3uObrRrcqjFV5Gh0jdIcLpUBogWc8g=;
 b=RV/AcMSphXxhmz9Z4VT99zRgf5TYkS4eSkFCjT1rulxueQ1pipL7E3d03Hhb4cpu1y
 9q54+sp87levTRAgkb7dNmQrI09yOPyPrsxeuRQipZ9F6ZcY7FDNq8oxMsHUH4fzBaZ1
 EaEzhBWaVt9RwRzC9+1JDVB7Km/8aro5S/S4vSg39v3aoGzbnC3oYLnqH4A3tElwMBbd
 v8geDy3vRiz9w4oy9GLnvjH0YkoII3Z9JXaQcSEoxENpifg5uhTWM8JCPuOn0MYdB552
 Zx6u/U4A6ot0dftE/ULAWD8B0t9liAjXjkboXD4Ob1UumlJb1JRoM5/G7CkZxqOoys2f
 reCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtf1qSINhdjljEPYWvL6PfaV55DxOl5urST8XtwQ3mg7ur6JVNmF9XiiIbVMSot0I9aNucClnnzqbP@nongnu.org
X-Gm-Message-State: AOJu0Yx+eSPwHsojqTWYsoAaPl5oAwaYSyI/7Zex8EgEnpGQW0TaNu/n
 XnwOQo+rXzz93OIWSmdGSyd95W6ctCqT8bPvm6qgrunRlzFySgMUturKoX4v5Les4GxduONHAlk
 ROKDRx66IHcx6KgKo10nquL9rR/DvZ7/oC4TyWKZhlebLdgB7elbU
X-Gm-Gg: ASbGncs6kvyC+UHHid+Gay9Pq7kr7xZhxL7bp65knBw8TLOBzUzLpVeLulLIRPOauSI
 Z7iLceS8RXto6xTwmcS+DX3LJ1yU0Sk+oKhFm+3cdEslxi7PekBHIttIbQRz9xKl5WY2oVWYZM+
 HoSGQur1sp8TnUP5veE/OhykpnxzJXmOurp2aPAJ2st/WlPBeIG7PtGwu6PlBfByOht7H0MFRXU
 axejStzjJJIMlOr1OJ6cpTcFBf820zdGI+EzMbyKSaBvz8H2nkB3dl8RwTpH5ovlces/uEq9qt1
 sb+YNs9G2LkhrIF1SgVk3fFm7ySJW6hhgl4eMYtd9b9PedChMqkfJKr9yybbSoM=
X-Received: by 2002:a5d:5987:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-390d4f430dcmr6272411f8f.27.1740661841183; 
 Thu, 27 Feb 2025 05:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDM58xBg8L1fBcECTjAJuyfgFDnIEg62q1hABBLjJQKBwyuRk5iz9ImLnvJUiHBBAh8lWRDA==
X-Received: by 2002:a5d:5987:0:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-390d4f430dcmr6272388f8f.27.1740661840791; 
 Thu, 27 Feb 2025 05:10:40 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485df5asm2016418f8f.96.2025.02.27.05.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:10:39 -0800 (PST)
Date: Thu, 27 Feb 2025 14:10:38 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept
 two sources
Message-ID: <20250227141038.28501d73@imammedo.users.ipa.redhat.com>
In-Reply-To: <9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Feb 2025 12:03:47 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

squash this patch into the next one

Also at this point there is no visible HEST changes yet, so a soon as you remove
white-list without enabling new HEST, the tests should start failing.

I suggest to move 20/21 before this patch,
as result one would see dsdt and hest diffs when running tests
and then you can use rebuild-expected-aml.sh to generate updated
tables and update them in one patch (that's what we typically do,
we don't split updates in increments).


> --- /tmp/asl-38PE22.dsl	2025-02-26 16:25:32.362148388 +0100
> +++ /tmp/asl-HSPE22.dsl	2025-02-26 16:25:32.361148402 +0100
> @@ -1,39 +1,39 @@
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20240322 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/aarch64/virt/HEST
> + * Disassembly of /tmp/aml-DMPE22
>   *
>   * ACPI Data Table [HEST]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>   */
> 
>  [000h 0000 004h]                   Signature : "HEST"    [Hardware Error Source Table]
> -[004h 0004 004h]                Table Length : 00000084
> +[004h 0004 004h]                Table Length : 000000E0
>  [008h 0008 001h]                    Revision : 01
> -[009h 0009 001h]                    Checksum : E2
> +[009h 0009 001h]                    Checksum : 6C
>  [00Ah 0010 006h]                      Oem ID : "BOCHS "
>  [010h 0016 008h]                Oem Table ID : "BXPC    "
>  [018h 0024 004h]                Oem Revision : 00000001
>  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>  [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
> -[024h 0036 004h]          Error Source Count : 00000001
> +[024h 0036 004h]          Error Source Count : 00000002
> 
>  [028h 0040 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
>  [02Ah 0042 002h]                   Source Id : 0000
>  [02Ch 0044 002h]           Related Source Id : FFFF
>  [02Eh 0046 001h]                    Reserved : 00
>  [02Fh 0047 001h]                     Enabled : 01
>  [030h 0048 004h]      Records To Preallocate : 00000001
>  [034h 0052 004h]     Max Sections Per Record : 00000001
>  [038h 0056 004h]         Max Raw Data Length : 00000400
> 
>  [03Ch 0060 00Ch]        Error Status Address : [Generic Address Structure]
>  [03Ch 0060 001h]                    Space ID : 00 [SystemMemory]
>  [03Dh 0061 001h]                   Bit Width : 40
>  [03Eh 0062 001h]                  Bit Offset : 00
>  [03Fh 0063 001h]        Encoded Access Width : 04 [QWord Access:64]
>  [040h 0064 008h]                     Address : 0000000043DA0000
> @@ -42,32 +42,75 @@
>  [048h 0072 001h]                 Notify Type : 08 [SEA]
>  [049h 0073 001h]               Notify Length : 1C
>  [04Ah 0074 002h]  Configuration Write Enable : 0000
>  [04Ch 0076 004h]                PollInterval : 00000000
>  [050h 0080 004h]                      Vector : 00000000
>  [054h 0084 004h]     Polling Threshold Value : 00000000
>  [058h 0088 004h]    Polling Threshold Window : 00000000
>  [05Ch 0092 004h]       Error Threshold Value : 00000000
>  [060h 0096 004h]      Error Threshold Window : 00000000
> 
>  [064h 0100 004h]   Error Status Block Length : 00000400
>  [068h 0104 00Ch]           Read Ack Register : [Generic Address Structure]
>  [068h 0104 001h]                    Space ID : 00 [SystemMemory]
>  [069h 0105 001h]                   Bit Width : 40
>  [06Ah 0106 001h]                  Bit Offset : 00
>  [06Bh 0107 001h]        Encoded Access Width : 04 [QWord Access:64]
> -[06Ch 0108 008h]                     Address : 0000000043DA0008
> +[06Ch 0108 008h]                     Address : 0000000043DA0010
> 
>  [074h 0116 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
>  [07Ch 0124 008h]              Read Ack Write : 0000000000000001
> 
> -Raw Table Data: Length 132 (0x84)
> +[084h 0132 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
> +[086h 0134 002h]                   Source Id : 0001
> +[088h 0136 002h]           Related Source Id : FFFF
> +[08Ah 0138 001h]                    Reserved : 00
> +[08Bh 0139 001h]                     Enabled : 01
> +[08Ch 0140 004h]      Records To Preallocate : 00000001
> +[090h 0144 004h]     Max Sections Per Record : 00000001
> +[094h 0148 004h]         Max Raw Data Length : 00000400
> +
> +[098h 0152 00Ch]        Error Status Address : [Generic Address Structure]
> +[098h 0152 001h]                    Space ID : 00 [SystemMemory]
> +[099h 0153 001h]                   Bit Width : 40
> +[09Ah 0154 001h]                  Bit Offset : 00
> +[09Bh 0155 001h]        Encoded Access Width : 04 [QWord Access:64]
> +[09Ch 0156 008h]                     Address : 0000000043DA0008
> +
> +[0A4h 0164 01Ch]                      Notify : [Hardware Error Notification Structure]
> +[0A4h 0164 001h]                 Notify Type : 07 [GPIO]
> +[0A5h 0165 001h]               Notify Length : 1C
> +[0A6h 0166 002h]  Configuration Write Enable : 0000
> +[0A8h 0168 004h]                PollInterval : 00000000
> +[0ACh 0172 004h]                      Vector : 00000000
> +[0B0h 0176 004h]     Polling Threshold Value : 00000000
> +[0B4h 0180 004h]    Polling Threshold Window : 00000000
> +[0B8h 0184 004h]       Error Threshold Value : 00000000
> +[0BCh 0188 004h]      Error Threshold Window : 00000000
> +
> +[0C0h 0192 004h]   Error Status Block Length : 00000400
> +[0C4h 0196 00Ch]           Read Ack Register : [Generic Address Structure]
> +[0C4h 0196 001h]                    Space ID : 00 [SystemMemory]
> +[0C5h 0197 001h]                   Bit Width : 40
> +[0C6h 0198 001h]                  Bit Offset : 00
> +[0C7h 0199 001h]        Encoded Access Width : 04 [QWord Access:64]
> +[0C8h 0200 008h]                     Address : 0000000043DA0018
> 
> -    0000: 48 45 53 54 84 00 00 00 01 E2 42 4F 43 48 53 20  // HEST......BOCHS
> +[0D0h 0208 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
> +[0D8h 0216 008h]              Read Ack Write : 0000000000000001
> +
> +Raw Table Data: Length 224 (0xE0)
> +
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  tests/data/acpi/aarch64/virt/HEST | Bin 132 -> 224 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
> 
> diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> index 4c5d8c5b5da5b3241f93cd0839e94272bf6b1486..674272922db7d48f7821aa7c83ec76bb3b556d2a 100644
> GIT binary patch
> delta 68
> zcmZo+e89-%;TjzBfPsO5F=rx|6eH6_Rd+^#iMisuTnvm1|Nk>EGJ@nLCJHmL%S;Ru
> WnV7)J#lXPAz`)?Zz#=g*R~!HcF%5eF
> 
> delta 29
> lcmaFB*uu!=;Tjy$!oa}5_-G=R6eHtARriT=I3|_|004Ge2nqlI
> 



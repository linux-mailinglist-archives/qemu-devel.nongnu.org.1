Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7150573FAD2
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6bZ-0000RI-31; Tue, 27 Jun 2023 07:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qE6bX-0000R3-2U
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:11:27 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qE6bV-00040Z-9h
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:11:26 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so4089201e87.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687864283; x=1690456283;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuduRVloJOVw7jW4g3I3eFfyX2ilk9akjT9KLl191qk=;
 b=TDoACJzckX9CCQtr3x+2iKY1Wpf9JPbZr9Tmac61Yrls/8jq1PEuy/0e16W9lYfBKt
 CX5uC1mt/uFzHpuLVDMX+61rxme4sPuE0PAaqkupSSyHq8aB9MClZQozkwR7L5EGQWEy
 Lbcr+F6YnU2wYx59+jPuZ3eXVie2PXbUGFqCRhU/xSPmq1lSAOpAlAgnVtE/DeH70WAU
 /xZGKCB9ZoLyyTdaKN/r8RwdrnBXuWjsXO1E0D5MHjNGYFjz1E4MIzxHi7PLFTd+tnQ8
 iiHhNj44gPCUuQhFqEMr6iuOnpfzFDMq+/BRXnNnHFXgYCWTOxhKQrl9Haq8lcEdTA6s
 hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687864283; x=1690456283;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CuduRVloJOVw7jW4g3I3eFfyX2ilk9akjT9KLl191qk=;
 b=iY8tc1Om8m2HxWdQN9zgXyOQ5VMF+nddry+Wxbv8iiKwzUnEPtKDv1Q9/RhFd1n++Y
 vEzIblUcz04E+b+ZVKlTyXCYTwUeztnpn0CCO//GX5AXSAzi7MGqRfs9dNRUOAajSsj6
 a0Diy9oVzs7WtWWWiqPh2PYvFGoktiL1NyhjobNdoJE7/dxaE02sq4ShYRw4rACz/Pxb
 FnJlhbtWlKDkiIWhw34z3zveon8+xPO9VCV15VCMvas9q7AW7c8H6QJTkEkvap97/6oy
 GmoHatjTWtfKZmABgCWqXsyAzgkNWzh+Ozd3DJKRT9fqYS6cgymAxpqjTZ+FMzrTU+bj
 41ow==
X-Gm-Message-State: AC+VfDzDyA7iFaQAThIl9K6A/aon8+nc28RnxyFVogAFpxhzEjp5Ygt9
 U8AtBvz/tkWp0WixnnMkZqz2i1CaJcg=
X-Google-Smtp-Source: ACHHUZ7J5RrJuR4cS5VYw9/2DPvrBv3doY3V0OY17oqYQcbyWh46th0VA2CJ3pt7g/atF7ipiMo3Fg==
X-Received: by 2002:a05:6512:2090:b0:4fb:893a:d322 with SMTP id
 t16-20020a056512209000b004fb893ad322mr428099lfr.68.1687864282417; 
 Tue, 27 Jun 2023 04:11:22 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 m21-20020a7bcb95000000b003faabd8fcb8sm4411668wmi.46.2023.06.27.04.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 04:11:21 -0700 (PDT)
Date: Tue, 27 Jun 2023 10:12:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Olaf Hering <olaf@aepfle.de>, John Snow <jsnow@redhat.com>
CC: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
In-Reply-To: <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
Message-ID: <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 27=2E Juni 2023 07:11:33 UTC schrieb Paolo Bonzini <pbonzini@redhat=2Ec=
om>:
>On 6/26/23 23:19, Olaf Hering wrote:
>> I need advice on how to debug this=2E
>>=20
>> One thing that stands out is uhci_irq()=2E
>> It reads a u16 from the USBSTS register=2E
>>=20
>> On the qemu side, this read is served from bmdma_read=2E Since the read
>> size is 2, the result is ~0, and uhci_irq() turns the controller off=2E
>> In other words, memory_region_ops_read from addr=3D0xc102 is served fro=
m "piix-bmdma"
>>=20
>> If the pci_set_word calls in piix_ide_reset are skipped, the read is
>> served from uhci_port_write=2E This is the expected behavior=2E
>> In other words, memory_region_ops_read from addr=3D0xc102 is served fro=
m "uhci"=2E
>
>I think what's happening is that
>
>    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
>
>is setting the BAR to 0xC100, therefore overlapping the UHCI device's reg=
ion=2E  In principle this line shouldn't be necessary at all though; it's e=
nough to clear the COMMAND register=2E

Interesting=2E The BAR is a 32 bit register whose default value is 0x00000=
001=2E I think what's supposed to happen here is a pci_set_long() rather th=
an a pci_set_byte()=2E

Bits 4=2E=2E15 represent the BAR address, and pci_set_byte() only clears b=
its 4=2E=2E7, leaving bits 8=2E=2E15 unchanged=2E Perhaps this causes the B=
AR to be moved into the UHCI region? Does changing the call to pci_set_long=
() fix the problem?

Best regards,
Bernhard

>
>Can you check the value of the COMMAND register (pci_conf + 0x04, 16 bits=
, little endian)?  Something might be causing the register to be set back t=
o a nonzero value, therefore re-enabling the I/O at the address that overla=
ps the UHCI device=2E
>
>Paolo
>
>


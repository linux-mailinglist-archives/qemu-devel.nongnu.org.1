Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B847E058B
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:27:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyw4G-0000Ea-Ex; Fri, 03 Nov 2023 11:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyw4D-0000E9-Uk
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:26:37 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyw4C-0003XC-6e
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:26:37 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso3607531a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025193; x=1699629993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SQOgokHngI/6nscwBaVE2kyd2lmfKIKWbi+1iG7xL8s=;
 b=avrDAzVFb6ajvMAosX1syeSM4mgs6I+NQfaFM+39CTBnE8PHK8m54MMFXYkMNR04pO
 WWfHYFSprjc4V9/wt9WrXcwUbqTqUi+QsIpUCiX+Q+D9zVSZ7sipzsI7U2AcYlyBTgvY
 BS5SsZgpJn5UwphUOuOsyC/VCPrZxSznKSq3H+HpQZ55YjV4sKk2jEBSeaZLT4gGjuKN
 Zn/82IPehhn4umP4kcrmtiUHX7Rpirs5PZdpJuXvoKEoYeDO74US40YbqKJAQ6xytOSv
 0hJO0kXs+m0VdAuZv+Nq5UXg5SQLKc9qPbmP3R4Gtr0uvqTFx1ZxdT/MPk+aZEPv0vZT
 Nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025193; x=1699629993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQOgokHngI/6nscwBaVE2kyd2lmfKIKWbi+1iG7xL8s=;
 b=vUU3lWPV0OzAtGTjUlZ/2eVMpqbr7e/tJTq0evuo6OQxD44MjuwRkWjB60urZslZcQ
 ZOEAab6zEjhWU8dOOzZ/O2AUI8yjyo+lp474yfrf1yvorW85QQ1WzAJubslYqQ+dy1ni
 q7e0a1SBMZyON8U3JXBr4EhV6BjyjeLp+XSQ9XcUUpnZT2hh4o6ei+csceiaBC5IWEuI
 3Hpq41wmNvC3gMn3BMPNBfr21SORJ8rbq5meRCsu4HiX5uzeA4Yznt8pFcj9oUYWLezh
 Ev274F1wTYDUmr+ewWptYHx1SXuHsVPvIeG9gsUDuzrUFv7SH/IhV6insKnMEGXZSIx6
 t35w==
X-Gm-Message-State: AOJu0Yzq48UAz3S9NC3ePdFj9x7a5cloMoXn+0D5zwBBUCOb5rN88Mqc
 pIsLH9GI0YQkWJ8APizZhz+MwL5Fxr+UbDgfZT3NFpneUCP3sa/E
X-Google-Smtp-Source: AGHT+IES+qxVy3SJIm0RKG6vK7OT4YxTttoVewOjeZWAKufkLYOIGY7sb9mVElG0Bs5mqRuNlPqQGBNDT9td/566OrU=
X-Received: by 2002:aa7:d1c9:0:b0:53e:5dad:dce0 with SMTP id
 g9-20020aa7d1c9000000b0053e5daddce0mr18247368edp.3.1699025193626; Fri, 03 Nov
 2023 08:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231103152120.829962-1-peter.maydell@linaro.org>
 <20231103152120.829962-3-peter.maydell@linaro.org>
In-Reply-To: <20231103152120.829962-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 15:26:22 +0000
Message-ID: <CAFEAcA-iSvg0r7-pRbv07p80Fy4ZEii0Md2DnuGs_=djdBe-HA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/arm/virt: Report correct register sizes in ACPI
 DBG2/SPCR tables.
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 3 Nov 2023 at 15:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Udo Steinberg <udo@hypervisor.org>
>
> Documentation for using the GAS in ACPI tables to report debug UART addresses at
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
> states the following:
>
> - The Register Bit Width field contains the register stride and must be a
>   power of 2 that is at least as large as the access size.  On 32-bit
>   platforms this value cannot exceed 32.  On 64-bit platforms this value
>   cannot exceed 64.
> - The Access Size field is used to determine whether byte, WORD, DWORD, or
>   QWORD accesses are to be used.  QWORD accesses are only valid on 64-bit
>   architectures.
>
> Documentation for the ARM PL011 at
> https://developer.arm.com/documentation/ddi0183/latest/
> states that the registers are:
>
> - spaced 4 bytes apart (see Table 3-2), so register stride must be 32.
> - 16 bits in size in some cases (see individual registers), so access
>   size must be at least 2.
>
> Linux doesn't seem to care about this error in the table, but it does
> affect at least the NOVA microhypervisor.
>
> In theory we therefore have a choice between reporting the access
> size as 2 (16 bit accesses) or 3 (32-bit accesses).  In practice,
> Linux does not correctly handle the case where the table reports the
> access size as 2: as of kernel commit 750b95887e5678, the code in
> acpi_parse_spcr() tries to tell the serial driver to use 16 bit
> accesses by passing "mmio16" in the option string, but the PL011
> driver code in pl011_console_match() only recognizes "mmio" or
> "mmio32". The result is that unless the user has enabled 'earlycon'
>
Oops, a line seems to have got deleted here -- should continue

"there is no console output from the guest kernel."

> We therefore choose to report the access size as 32 bits; this works
> for NOVA and also for Linux.  It is also what the UEFI firmware on a
> Raspberry Pi 4 reports, so we're in line with existing real-world
> practice.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1938
> Signed-off-by: Udo Steinberg <udo@hypervisor.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> [PMM: minor commit message tweaks; use 32 bit accesses]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> --

thanks
-- PMM


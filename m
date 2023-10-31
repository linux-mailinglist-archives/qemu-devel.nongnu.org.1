Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED37DCC20
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:49:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxnER-0003fK-Ha; Tue, 31 Oct 2023 07:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxnE0-0003cl-Av
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:48:01 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxnDx-0006am-0H
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:47:59 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so9027243a12.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698752874; x=1699357674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VwIR2nG8TxbMHJkdIhgeLgz6ORkHRY3DmTxwbW8TJq8=;
 b=xcwTihD168HdKCqdZnRYmb5uUHyCadwrDuX0bxlTFD1hQew5GDVeqLwbZTAP8pEyul
 0kGFS8LiSA911rSjDpOroDMlEb/M2cu1HyyunBU4atLbjHsZ+G+ucZYZETdfrvW/Azxf
 HyPl7QgfRQpcxGQGUVExn25gAkjCM+IOtVmrLNOibkQWFhrV4BEBd8YR8nijE+PZ0TG0
 tObRL4rZF7RO8RbmmzocvpaVnfDe2E0FPHJQOhlRcpV5l97KtKFmnJM5WrcBi9aA3TAH
 JFVsNPOCJLww3hcAbjmKAMP96zXa5yHb/n+s7CG3t0ZvookOgRnZBge5blYSdSvM0pIJ
 xO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698752874; x=1699357674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VwIR2nG8TxbMHJkdIhgeLgz6ORkHRY3DmTxwbW8TJq8=;
 b=Z/BQqBOnCU9mTyp3yOPK/aAUyBIWe3Y3JzYSIq/d+olqeIdf189Vqj5JERCCVNoAxG
 voAV10xJAUDJRCzPN5H+v5ul1Ak+JhyGvIzFNrEAjlJfdh3kYb/CIaw7VtW6LhH/YT9x
 /IqslceDButz8MtIgH1U+8o78Vfn7gNhwBnOacoq85hscnDIgQxRBO5RqyX1/EIhhnJq
 3fbp1+CMpyXIcDu0ls1u2huBHseDqWerCAvQZjpHKzs+Ho/igbYagVtV3r1jBt9RGObm
 GxkXJcJ6W2WvjRwPYEASyVIik98rvVLNac4ctTMRI4UkR58XAVVEByzMlWWlDpg/AcA+
 /zrA==
X-Gm-Message-State: AOJu0YzQjcoGxL0uF1YOc44mMN7nBb/MZrVbQpC7D2obcFfwZtkXxNaF
 KDMTujaDtCQmdBpS3pYix0rCwABmID02JFxqmqI4k81ZTKoWlypG
X-Google-Smtp-Source: AGHT+IEnCPC8QbDEddEtQK/HXDozwarBlm+zt0S7ElJKzHbh7/Mx1/LsS0nUM9ZWbgh9MaMJbGCy7CUt/ey79GRK9Uk=
X-Received: by 2002:a50:cc8e:0:b0:542:e844:5c9b with SMTP id
 q14-20020a50cc8e000000b00542e8445c9bmr7034119edi.13.1698752873943; Tue, 31
 Oct 2023 04:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231021143308.04f1a6fe@darkstar.speedport.ip>
In-Reply-To: <20231021143308.04f1a6fe@darkstar.speedport.ip>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 11:47:42 +0000
Message-ID: <CAFEAcA-UcGSujyYNpE=RNY9d7pkM73iy=ciQtiZfu3ZTRHmxSg@mail.gmail.com>
Subject: Re: PATCH: #1938: [ARM/PL011] Wrong UART register spacing reported in
 DBG2/SPCR
To: Udo Steinberg <udo@hypervisor.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sat, 21 Oct 2023 at 13:33, Udo Steinberg <udo@hypervisor.org> wrote:
>
>
> From: Udo Steinberg <udo@hypervisor.org>
> Date: Sat, 21 Oct 2023 14:10:30 +0200
> Subject: [PATCH] hw/arm/virt: Report correct register sizes in ACPI DBG2/SPCR
>  tables.
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
> - 16 bits in size (see individual registers), so access size must be 2.
>
> The PL011 documentation does not mention whether 8-bit accesses or 32-bit
> accesses to the registers are also allowed. Because a standard PL011 (not
> the SBSA version) is connected via a 16-bit bus using PWDATA[15:0] and
> PRDATA[15:0] (see Figure 2-1), using 16-bit access is the safest choice.

For the hardware, Linux kernel commit 84c3e03bdd1146 does suggest
that 16-bit is the traditional access size (the 32-bit access support
added in that commit is for a not-very-pl011-like UART which has the
registers in a different order, incidentally). As far as the PL011
itself is concerned, it doesn't implement the APB bus PSTRB signal, so
it reads/writes all bits of its data bus every time. The interconnect/
bus fabric gets a say in what happens but it would be pretty unlikely
for it to go out of its way to deny 32 bit accesses I think (it
would have to hardcode that this particular APB peripheral had a
16 bit width and then deny accesses based on access width on
its upstream bus).

Anyway, 16-bit access should be OK. (In practice I see the Linux
driver doing both 8-bit and 32-bit accesses, depending on the
register: our impl handles all sizes, converting anything that's
not 32-bit to 32-bit in the memory subsystem code.)

> For SBSA-compatible UARTs the DBG2/SPCR table should report a different
> subtype (0xd or 0xe) instead of 0x3.

There is an annoying dance that has to be done with the test suite
when we do ACPI table updates, because otherwise "make check" fails
because the new ACPI table doesn't match its golden reference file.
I had to figure that out recently so I'll do that for you (will
involve me resending this patch with some extras before/after that
update the test suite).

> Fixes #1938.

We generally note this with the syntax:
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1938

but I'll fix that up when I take this patch upstream (and add
a note about what guest software ran into the bug).

> Signed-off-by: Udo Steinberg <udo@hypervisor.org>
> ---
>  hw/arm/virt-acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 9ce136cd88..91ed7fc94a 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -482,7 +482,7 @@ build_spcr(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 3, 1); /* ARM PL011 UART */
>      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
>      /* Base Address */
> -    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 2,
>                       vms->memmap[VIRT_UART].base);
>      /* Interrupt Type */
>      build_append_int_noprefix(table_data,
> @@ -673,7 +673,7 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      build_append_int_noprefix(table_data, 34, 2);
>
>      /* BaseAddressRegister[] */
> -    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 8, 0, 1,
> +    build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 32, 0, 2,
>                       vms->memmap[VIRT_UART].base);
>
>      /* AddressSize[] */

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


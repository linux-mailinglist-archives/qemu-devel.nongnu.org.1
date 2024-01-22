Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7568835D87
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 10:03:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRqC9-0006EP-Js; Mon, 22 Jan 2024 04:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRqC7-0006ED-JI
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:02:15 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRqC5-0001jc-R8
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 04:02:15 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-559f92bf7b6so5087051a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705914132; x=1706518932; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KKM+mW1KsZFNjx/YizAUxUWauBOWUyr4CgK27vzdg/w=;
 b=g8fThI7PxPoPS2msAnwb9VGGu7JUFH6eqBMccLDvIpxcmNyZvhY5Je84pS8dok5zOe
 0BvaVPTZEbKqKaqJ0S3ueD2xv0b0o+obrS8vqdEJoTRMLKGU1wclo7EpEVDxwjtNeQfe
 F3+rbmwy4k5HHvUAvbSmlEleEYEYlffQAAbHDIspeXLALDqJeqxLykP8zB8ay690YXUE
 r0EHNQ7jeM5uJgWKUKYr5b+qB7eE1aM4C+qr7YrwJ96UCJHroC8I8cjYvzOPPRipkUF8
 CYVUNv4z5RP9aHFNXBYkQgl/6Im6GqpmJue/JbqX2Hpz5Uyw8hCcT55yVen+yOzvMLzK
 6Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705914132; x=1706518932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KKM+mW1KsZFNjx/YizAUxUWauBOWUyr4CgK27vzdg/w=;
 b=A5GV1t0lfZPpm74A9EAsts2gtk+Tw19GiNJ8Sr4iO7yC5EkNBUPEfpgneGAqsvkbm7
 AhwdAyUbbvX1sgNUu/1kPHG5MhkKDZyjBHb0eUNH7ygQS0m4qzFx8riO6Xo7pfr0YWWq
 wG3tTeEMl8/Z23ESIipTeHn6xxYbbA0/NSZN3/cu98S+cVYN9FPBJc4zPNWTFIxhmSIb
 3T4ROmK7q1CDutYQhRYDoG78GQtGEDaN/WTPll3IxGQY/VpyI6F+8COr/FV9cco0POrE
 ei3NjWQssU2+GGKvVoUN26f88VV/73HxEqyj1J4Mi8B8n2V+QsGDEPz7Ebrqxv6BdI5t
 SLvg==
X-Gm-Message-State: AOJu0YwFy71bCVj3MfZiys45BLvd47REWUYlJYlI6lcnezl1LD83W3F8
 Ws11spwy6Dj5PwWhLnjjEEDtNyW9GSNC9ZrrhyFFSYOSDJkVYvC9I3MX49RleFc4oPYMFuXhwnd
 WPOsttP5S8jxxinU2zbOdYuElHRC3oCfETDRnDA==
X-Google-Smtp-Source: AGHT+IGMmokiHGDAwfTWxeW7JJBUS+sdY3p1VdqD1wOzb6/Sj7oalj6BVRZZg6vPup/6XI+GJMrlmX5EQnDXtiJQ6+g=
X-Received: by 2002:a05:6402:b18:b0:559:c3de:76f with SMTP id
 bm24-20020a0564020b1800b00559c3de076fmr4857174edb.18.1705914132208; Mon, 22
 Jan 2024 01:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20240121164754.47367-1-shlomop@pliops.com>
In-Reply-To: <20240121164754.47367-1-shlomop@pliops.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 09:01:40 +0000
Message-ID: <CAFEAcA918jHyb0D9hAQ0XdH+Lp8191OaSVqu6URVh_73jh+t0Q@mail.gmail.com>
Subject: Re: [PATCH v3] Handle wrap around in limit calculation
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: qemu-devel@nongnu.org, andrew.sminov@gmail.com, peter.maydell@linaro.com, 
 shlomop@pliops.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 21 Jan 2024 at 16:48, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:
>
> From: Shlomo Pongratz <shlomopongratz@gmail.com>
>
>     Hanlde wrap around when calculating the viewport size
>     caused by the fact that perior to version 460A the limit variable
>     was 32bit quantity and not 64 bits quantity.
>     In the i.MX 6Dual/6Quad Applications Processor Reference Manual
>     document on which the original code was based upon in the
>     description of the iATU Region Upper Base Address Register it is
>     written:
>     Forms bits [63:32] of the start (and end) address of the address region to be
>     translated.
>     That is in this register is the upper of both base and the limit.
>     In the current implementation this value was ignored for the limit
>     which caused a wrap around of the size calculaiton.
>     Using the documnet example:
>     Base HI: 0x80000000 Base LO: 0xd0000000 Limit LO: 0xd000ffff
>     The correct size is 0x80000000d000ffff - 0x80000000d0000000 + 1 =
> 0x010000
>     The wrong result is 0xd000ffff - 0x80000000d0000000 + 1 = 0x8000000000010000
>
>     Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>
>     ----
>
>     Changes since v2:
>      * Don't try to fix the calculation.
>      * Change the limit variable from 32bit to 64 bit
>      * Set the limit bits [63:32] same as the base according to
>        the specification on which the original code was base upon.
>
>     Changes since v1:
>      * Seperate subject and description
> ---
>  hw/pci-host/designware.c         | 19 ++++++++++++++-----
>  include/hw/pci-host/designware.h |  2 +-
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index dd9e389c07..43cba9432f 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -269,7 +269,7 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
>  {
>      const uint64_t target = viewport->target;
>      const uint64_t base   = viewport->base;
> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
> +    const uint64_t size   = viewport->limit - base + 1;
>      const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
>
>      MemoryRegion *current, *other;
> @@ -351,6 +351,14 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>      case DESIGNWARE_PCIE_ATU_UPPER_BASE:
>          viewport->base &= 0x00000000FFFFFFFFULL;
>          viewport->base |= (uint64_t)val << 32;

> +        /* The documentatoin states that the value of this register

"documentation".

Multiline comments should have the /* on a line of its own.

> +         * "Forms bits [63:32] of the start (and end) address
> +         * of the address region to be translated.
> +         * Note that from version 406A there is a sperate
> +         * register fot the upper end address
> +         */
> +        viewport->limit &= 0x00000000FFFFFFFFULL;
> +        viewport->limit |= (uint64_t)val << 32;
>          break;

Better to calculate the effective limit address when we need it,
rather than when the register is written. It's not a very
expensive calculation.

> diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
> index 908f3d946b..51052683b7 100644
> --- a/include/hw/pci-host/designware.h
> +++ b/include/hw/pci-host/designware.h
> @@ -41,7 +41,7 @@ typedef struct DesignwarePCIEViewport {
>
>      uint64_t base;
>      uint64_t target;
> -    uint32_t limit;
> +    uint64_t limit;
>      uint32_t cr[2];

Making this field 64 bits makes the code to read and write
the register more complicated, and introduces a migration
compat break that we need to deal with. Why bother?
You can fix the problem that you're trying to solve in
the way that I suggested to you without introducing this
extra complication to this patch.

thanks
-- PMM


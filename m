Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 285FA823C28
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 07:17:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLH1o-0000P1-AC; Thu, 04 Jan 2024 01:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLH1k-0000N4-I7
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 01:16:25 -0500
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rLH1i-0007ne-IR
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 01:16:24 -0500
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-466eb8576e0so27916137.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 22:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704348981; x=1704953781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lG+z0mxHKCLTcaKOhef2Ndjn4DJI9rtSfsJUnJdMCNo=;
 b=iv6r0139BSvk0UICW6XheDkTBqPYQp8oNlwg6ReESgeOAhB+Z7hdhXGr5sg1Grckdg
 i3EI06UxUXIFROpA2ndnUynuWtKCd2oGU8w/ZmNOce+EAXEfuA7KmuTmES5Cfh2Dpzhg
 aUzh7ltKx2V8jwNkOawriXVPRrn5I+jRCKkL8wkfxj3g1ayj2SBRaXxi2HaRDgH8uxgu
 wnfIdBFJK25C5aSIWNqryrvWCr9T2OJmvXtzh81G7QOpF/7yJGSpSsm81osKGsbKWp6p
 jJSbYTw+AaGbo5t2dwDo3AD8dr9QU0M0N4pX67JqtmTralGoq8weIMfSnOoX/pgMG/F1
 5MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704348981; x=1704953781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lG+z0mxHKCLTcaKOhef2Ndjn4DJI9rtSfsJUnJdMCNo=;
 b=MD8OucCoZllzuZHiTli9P9SPJYEFNXMGDW27CqUu83bLKCewcyK+Z8TRC+p+9gCm/+
 DMLNzOgLPBugrZ7zpblEHwCCHhBURSgUEBm12m3LgXYJTxyVzBNljrOs5LF2aTlL5Y+d
 YkvhEwQR+muNSkgFv43PcdOj9e4c3iGyWjiFYbUcAaEhbQYApNJJq3dLLqoKfEjQImr8
 Ur0E88MN6LbW+avbXuS88Igw6EdjiNx3iE4c9WoGrrcA+a6mg3RT07FOrBzC3c/8NiBg
 wtF3wv8Qjtl/HWW97VUbDMJJjA4rca7w9B/9CowkcpMRQ6oOxPSageb7CIEF/egOGYxe
 3nyA==
X-Gm-Message-State: AOJu0YwcY/IDTxTqcbuYQhNKb1ZQjiYrOHRKa03GEy8/H3Ai+rbp4n5T
 vKs3yEBhTsvhvjK+Tv7JLXVYggq0x3dhN0UlRQs=
X-Google-Smtp-Source: AGHT+IGTFWH/57EkM02eZEHWM+XxTGQvb9JzWlCak7gijzxLV1srMUFyzO3xOORAtQ6eMNd1YCf2UlxEaiRpx0LJ6co=
X-Received: by 2002:a05:6102:dd3:b0:467:4ee9:fd71 with SMTP id
 e19-20020a0561020dd300b004674ee9fd71mr37166vst.16.1704348981485; Wed, 03 Jan
 2024 22:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231220193436.25909-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 4 Jan 2024 16:15:55 +1000
Message-ID: <CAKmqyKOLd0o_QXdOUF-67BuPW8xWxx=Yzy-qgz4FA3sffnX7gw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs/system/riscv: document acpi parameter of virt
 machine
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Dec 21, 2023 at 6:03=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Since QEMU v8.0.0 the RISC-V virt machine has a switch to disable ACPI
> table generation. Add it to the documentation.
>
> Fixes: 168b8c29cedb ("hw/riscv/virt: Add a switch to disable ACPI")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> v2:
>         mention that acpi=3Don is the default
> ---
>  docs/system/riscv/virt.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index f5fa7b8b29..9a06f95a34 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -95,6 +95,11 @@ The following machine-specific options are supported:
>    SiFive CLINT. When not specified, this option is assumed to be "off".
>    This option is restricted to the TCG accelerator.
>
> +- acpi=3D[on|off|auto]
> +
> +  When this option is "on" (which is the default), ACPI tables are gener=
ated and
> +  exposed as firmware tables etc/acpi/rsdp and etc/acpi/tables.
> +
>  - aia=3D[none|aplic|aplic-imsic]
>
>    This option allows selecting interrupt controller defined by the AIA
> --
> 2.40.1
>
>


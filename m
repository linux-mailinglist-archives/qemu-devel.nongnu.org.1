Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A507E7D7E43
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvWN-0005n9-LP; Thu, 26 Oct 2023 04:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvvWE-0005lj-Om
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:15:06 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qvvWC-0003DD-N7
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:15:06 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso879113a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698308101; x=1698912901; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ql5Vy4pWQNjDcXY9mDI9mWkXrxMH6KemWvgXgYc24PY=;
 b=b3jdnbWx4/2EgT625N5lzFuuCBdB1Q6Zw1OY5CxR4gbnXXyDMu3wyhk+cCXvJYquDp
 f2aHbi1FenlPzx4leY6waVEZcl5Dv8GBQEzdvC8ZaigOQWvTE/6hAKArqJCG0yRRCcNz
 Y0LtdaNOQUt+38QKb+OBkciTVcsmUh90u6cp7sx/Ua4otVtlJdzqn6CLeoahjyOIDQgV
 8bzOY2i0g+Bng65aBSAfna/gNAwJ0fRke8b2YsdJGZ15BlQc/hjU7uCeDZJti7VCHaVZ
 tth5lJubUXikH6SO6u1rC9RWQmoGXNB3vd78a2RVNTuXGcqTBMPEJseXDpu+/N9Kogv7
 93Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698308101; x=1698912901;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql5Vy4pWQNjDcXY9mDI9mWkXrxMH6KemWvgXgYc24PY=;
 b=A1IXklO1h9eEOCjUhzrfRxlpHlv84jNEs0ccFR7BA8An1ksUemIbNTBhTDTfLG6cJh
 bd9m4cgzCeWNULuOvy1caO2Gc8Mt/CoPC8yq9MNaue+Ssw1dD2ae/6vXKpD39CoXh2hL
 ateTy8bzcYtGEyodVOFipPQKqUythR2CvCzMSjLVjQpSQGUcHYbcAqMqW1czW+TYOeP8
 Z+VlHNvaRGMrb/kg7E3Fln3UAzt2kfqvNS0EX1O9zUNsvW/8cX2ZCgedyND3xhH2qb4S
 KxTuzn/3Mbp+qGR6yVFnMMqDGIhNMHZtdzWaaHQLUHQ+EsDUjt4OBS7kQRO5cjBM3ybT
 oImw==
X-Gm-Message-State: AOJu0YzSxXfzyKbyYVAkGAkxWSOuSTtYeJmdv8xbDVbapMp2EBlf3rhY
 zuRMQ05aJ9jfRXMDZDbSXfJbpg==
X-Google-Smtp-Source: AGHT+IEeTLwsDxjdkFHpFKi4ZMLMdr0xFhgD4ScRFxrMambRF0ZbA4M3nqgjmLa+zghciBK9sWAe0A==
X-Received: by 2002:a50:8e19:0:b0:53e:98c6:5100 with SMTP id
 25-20020a508e19000000b0053e98c65100mr11789231edw.30.1698308101376; 
 Thu, 26 Oct 2023 01:15:01 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a056402033400b0053dd8898f75sm10706781edw.81.2023.10.26.01.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 01:15:00 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:15:00 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v4 01/13] hw/arm/virt-acpi-build.c: Migrate fw_cfg
 creation to common location
Message-ID: <20231026-6b31593481fe2476e49197e5@orel>
References: <20231025200713.580814-1-sunilvl@ventanamicro.com>
 <20231025200713.580814-2-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025200713.580814-2-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 26, 2023 at 01:37:01AM +0530, Sunil V L wrote:
...
> diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
> new file mode 100644
> index 0000000000..eddaffc09b
> --- /dev/null
> +++ b/hw/nvram/fw_cfg-acpi.c
> @@ -0,0 +1,44 @@
> +/*
> + * Add fw_cfg device in DSDT
> + *
> + * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
> + * Copyright (C) 2006 Fabrice Bellard
> + * Copyright (C) 2013 Red Hat Inc
> + *
> + * Author: Michael S. Tsirkin <mst@redhat.com>
> + *
> + * Copyright (c) 2015 HUAWEI TECHNOLOGIES CO.,LTD.
> + *
> + * Author: Shannon Zhao <zhaoshenglong@huawei.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.

I don't recommend creating new files with the long form GPL instead of an
SPDX. I can't find a QEMU SPDX policy to point at, but pretty much every
project I work on has been moving towards SPDX, and usually with a format
policy. I presume QEMU will either slowly work its way there too or
someday do a mass change. New files can participate in an unofficial slow
transition now, rather than have to be touched again in a mass change.

...
> diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
> new file mode 100644
> index 0000000000..1c863df329
> --- /dev/null
> +++ b/include/hw/nvram/fw_cfg_acpi.h
> @@ -0,0 +1,15 @@
> +/*
> + * ACPI support for fw_cfg
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

While QEMU doesn't appear to have an SPDX policy with formatting rules,
I would format this as

/* SPDX-License-Identifier: GPL-2.0-or-later */
/*
 * ACPI support for fw_cfg
 */

And the source file above as

// SPDX-License-Identifier: GPL-2.0-or-later
/*
 * Add fw_cfg device in DSDT
 *
 * ...
 */

as that is the recommended format for many projects (I think starting
with Linux which documents[1] it) and tools have already learned that
formatting. QEMU's checkpatch will accept the C99 comment style[2].

[1] https://www.kernel.org/doc/html/latest/process/license-rules.html#license-identifier-syntax
[2] commit 8d061278d385 ("checkpatch: allow SPDX-License-Identifier")

Thanks,
drew


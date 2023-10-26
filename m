Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D73BF7D82B2
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 14:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvzW7-0004zs-9t; Thu, 26 Oct 2023 08:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qvzW4-0004zO-LI
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 08:31:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qvzW2-0006Xr-J9
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 08:31:12 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9b95943beso7124285ad.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 05:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698323469; x=1698928269; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qT2vp+gxewl4eJFh380Hgn2+Gi/7MoBdgjxJhKQ4Q9k=;
 b=brBdChKh+h2GDmqPjlCFbNZX3rJaeaH0kPoZFBY6+jSEE8BQZdctKNaxV0BGcviMyD
 jqrlUPcfzrfdfM3r5pQNlAacWdY2yVF34RC8rT+S2DJUdQHDglxAbhQP9KQoK8IwMYAZ
 3gYBGu6LsJpzczhXYq+H43GUSV9kLNHaw9NJTdBl+bq8T1eOseFc3EO3VkGtcw076fDv
 2POXsdDaO1ztadae+zrVsueKTZsFm2vIYPXd2A/Xe2pDawYv302xvLPEC7uZMqbZ9lnx
 sLyIQUMEjDuNGL+I8nIqhlA2CqyHVthwqG+d2t1nLCcVUvkdT4ms++WS+SIuHOdHohfQ
 5OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698323469; x=1698928269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qT2vp+gxewl4eJFh380Hgn2+Gi/7MoBdgjxJhKQ4Q9k=;
 b=gMW943gMqQw3XbOzuYSvlxDsrxqWuN+gAPqSB8FHrd+nYPpBKWuJnXWxt60Q5cz+N5
 k7n61XAIlKDbBshZZFbKmjO1HpeEMEHyZUDmRMTuegnRWqJud6lUkv/Jup07xykeDqIb
 8MkYKS4eF6kON0xCni9KqE5DiTtHIUjnOSL2GBAdFAK3U6RSoXnUOY+nIEH7rjB/D6J1
 pk4Goj0D/G1Oo259/mEv504LQHJN+B6JQJjEr1fPvMdzdxNFIIN6yN9EpHySocCxELDK
 H67dP2VCXJKUU0j2Z+yVmnkPnJLeLGKps6U69v6stQAaduMTlM+ebG6wuEq2i0L6eIB/
 u7rw==
X-Gm-Message-State: AOJu0YyE7KmNtCucI7TJtgKNuI/nTmdCnCaRNI6nlfChtGROKTxNFPaz
 5Hya8MzdWdwVkm1T1RTxlkq0FQ==
X-Google-Smtp-Source: AGHT+IFXVFn85bJ4Q2KdCStqxw1KdlbLwY9OM9fqXfmfwk0mQSbPjydFWZ9XPTmnigM3Nl2ZzTliuQ==
X-Received: by 2002:a17:902:d506:b0:1c2:1068:1f4f with SMTP id
 b6-20020a170902d50600b001c210681f4fmr19948403plg.17.1698323469022; 
 Thu, 26 Oct 2023 05:31:09 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78]) by smtp.gmail.com with ESMTPSA id
 q9-20020a170902dac900b001b9c960ffeasm10871782plx.47.2023.10.26.05.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 05:31:08 -0700 (PDT)
Date: Thu, 26 Oct 2023 18:00:57 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [PATCH v4 01/13] hw/arm/virt-acpi-build.c: Migrate fw_cfg
 creation to common location
Message-ID: <ZTpcAXO3GCGYjhNB@sunil-laptop>
References: <20231025200713.580814-1-sunilvl@ventanamicro.com>
 <20231025200713.580814-2-sunilvl@ventanamicro.com>
 <20231026-6b31593481fe2476e49197e5@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-6b31593481fe2476e49197e5@orel>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 26, 2023 at 10:15:00AM +0200, Andrew Jones wrote:
> On Thu, Oct 26, 2023 at 01:37:01AM +0530, Sunil V L wrote:
> ...
> > diff --git a/hw/nvram/fw_cfg-acpi.c b/hw/nvram/fw_cfg-acpi.c
> > new file mode 100644
> > index 0000000000..eddaffc09b
> > --- /dev/null
> > +++ b/hw/nvram/fw_cfg-acpi.c
> > @@ -0,0 +1,44 @@
> > +/*
> > + * Add fw_cfg device in DSDT
> > + *
> > + * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
> > + * Copyright (C) 2006 Fabrice Bellard
> > + * Copyright (C) 2013 Red Hat Inc
> > + *
> > + * Author: Michael S. Tsirkin <mst@redhat.com>
> > + *
> > + * Copyright (c) 2015 HUAWEI TECHNOLOGIES CO.,LTD.
> > + *
> > + * Author: Shannon Zhao <zhaoshenglong@huawei.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > +
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > +
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> 
> I don't recommend creating new files with the long form GPL instead of an
> SPDX. I can't find a QEMU SPDX policy to point at, but pretty much every
> project I work on has been moving towards SPDX, and usually with a format
> policy. I presume QEMU will either slowly work its way there too or
> someday do a mass change. New files can participate in an unofficial slow
> transition now, rather than have to be touched again in a mass change.
> 
Sure. Let me update this in the next revision.

> ...
> > diff --git a/include/hw/nvram/fw_cfg_acpi.h b/include/hw/nvram/fw_cfg_acpi.h
> > new file mode 100644
> > index 0000000000..1c863df329
> > --- /dev/null
> > +++ b/include/hw/nvram/fw_cfg_acpi.h
> > @@ -0,0 +1,15 @@
> > +/*
> > + * ACPI support for fw_cfg
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> 
> While QEMU doesn't appear to have an SPDX policy with formatting rules,
> I would format this as
> 
> /* SPDX-License-Identifier: GPL-2.0-or-later */
> /*
>  * ACPI support for fw_cfg
>  */
> 
> And the source file above as
> 
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>  * Add fw_cfg device in DSDT
>  *
>  * ...
>  */
> 
> as that is the recommended format for many projects (I think starting
> with Linux which documents[1] it) and tools have already learned that
> formatting. QEMU's checkpatch will accept the C99 comment style[2].
> 
> [1] https://www.kernel.org/doc/html/latest/process/license-rules.html#license-identifier-syntax
> [2] commit 8d061278d385 ("checkpatch: allow SPDX-License-Identifier")
> 
Thanks for the pointers. Let me update according to this.

Thanks,
Sunil


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC77F747F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 14:03:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Vot-0002oY-AH; Fri, 24 Nov 2023 08:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Vor-0002o1-JK; Fri, 24 Nov 2023 08:02:05 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6Vop-0001xV-Kp; Fri, 24 Nov 2023 08:02:05 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cf7a1546c0so15835715ad.0; 
 Fri, 24 Nov 2023 05:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700830921; x=1701435721; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2RG3JxlO92KFMhYb9iaxy4huQnUDhgbuXxQWntRXS0=;
 b=K2uwcVTcGRRCcTHXFkzkrUuQQeMQlPubbE4ZfV9+tB6P3SiCaHU8CuzzOXxTEcMQ2W
 /uTW4a9IEBcnJ04cxpxGjnS1cLHAOz+gGfJnMKvtQoRdBU46pDnxaduhvYnZhBOhDmUG
 DYZrHy20SVvTBBWBRyAI8Uc2/Z9Hs/Io30pWga3LqBK5hQLw8MBVaSWS9vt3Ke8J5L1p
 CHll1BZMrqisA9YI1arU6tBri+4IiKMN4jmYR9AdQ4Egdi0tgEoKQi3r62ukbp3azXD1
 JwCRVXXVdv4p0xQM0mTvXKcGY2uno1Rc0zYpJohDutd0Pz+mwVaDUKilmZaFJfADi6bb
 ryqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700830921; x=1701435721;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q2RG3JxlO92KFMhYb9iaxy4huQnUDhgbuXxQWntRXS0=;
 b=SD6hjwH4JorEvr/kKPvXsepHo7KW+zWNfC7/dgXl8PYDOzf9xwgGUfZ19+P92krUrg
 xBRm2UVPMJf617He/70qUKjH/znO/j/2UVyZyjJ/8yjyQKAX5xXwCR3uNrg2FYuwxnVC
 nRvVOT5xltZXoLPoluZJu0EyJhhgOdQbUdtE24gspWUyC2BJax91sYrScSI0zH53+AVs
 0aOVFfZiKPBlGcfH+w1b8NHOX6zM5HZDgmakwSfvxfC0r1hF5dcDabjv1RhWcVoMT+tr
 54Op/iao4FOP+ShagxogYUEso1sSFHqIBoH4hllSNu5CNC8mggOHk00lbRY1IX+oOPXF
 yEyg==
X-Gm-Message-State: AOJu0YzvgNYpoReBCWioCfum9RQcEyl8qmQBrKifYIH5/sGIm+QLS5jx
 8gXQxzrCyasCfnAOjQr+FiA=
X-Google-Smtp-Source: AGHT+IGS8Rzu40sU4WPXH42cbOSe5FmCeLeQZ2DvcfLobWVWazINgdU5abDBaFTO726+THQUR+bTpQ==
X-Received: by 2002:a17:902:ec84:b0:1cf:532e:9a77 with SMTP id
 x4-20020a170902ec8400b001cf532e9a77mr3510472plg.58.1700830921548; 
 Fri, 24 Nov 2023 05:02:01 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 jj14-20020a170903048e00b001b9da42cd7dsm3126665plb.279.2023.11.24.05.01.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 05:02:00 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 23:01:54 +1000
Message-Id: <CX728N8AEA4N.1WTXYOBNMBOF3@wheely>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <calebs@us.ibm.com>,
 <chalapathi.v@ibm.com>, <saif.abrar@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 2/3] hw/ppc: Add nest1 chiplet model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Chalapathi V"
 <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
 <20231124101534.19454-3-chalapathi.v@linux.ibm.com>
 <CX707LTEH9J0.3UF28GS7L10P7@wheely>
 <236fe044-7adb-43c2-8887-0303ee33d6c6@kaod.org>
In-Reply-To: <236fe044-7adb-43c2-8887-0303ee33d6c6@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Fri Nov 24, 2023 at 10:19 PM AEST, C=C3=A9dric Le Goater wrote:
> On 11/24/23 12:26, Nicholas Piggin wrote:
> > For this and actually the last patch too, it would be good to mention
> > (possibly in a header comment in the file too) what actual functionalit=
y
> > is being provided/modeled. It looks like it's just modeling behaviour o=
f
> > reads and writes for some registers.
> >=20
> > Oh, and sorry I didn't follow development and comments on this too
> > closely, so forgive me if I've missed things already said. I'll go
> > back and read through the series.
> >=20
> > On Fri Nov 24, 2023 at 8:15 PM AEST, Chalapathi V wrote:
> >> The nest1 chiplet handle the high speed i/o traffic over PCIe and othe=
rs.
> >> The nest1 chiplet consists of PowerBus Fabric controller,
> >> nest Memory Management Unit, chiplet control unit and more.
> >>
> >> This commit creates a nest1 chiplet model and initialize and realize t=
he
> >> pervasive chiplet model where chiplet control registers are implemente=
d.
> >>
> >> This commit also implement the read/write method for the powerbus scom
> >> registers
> >=20
> > The powerbus scom registers, are those specifically for the PowerBus
> > Fabric controller mentioned in the first paragraph, or is it a more
> > general set of registers for the chiplet?
> >=20
> >>
> >> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> >> ---
> >>   include/hw/ppc/pnv_nest_chiplet.h |  36 ++++++
> >>   include/hw/ppc/pnv_xscom.h        |   6 +
> >>   hw/ppc/pnv_nest1_chiplet.c        | 197 ++++++++++++++++++++++++++++=
++
> >>   hw/ppc/meson.build                |   1 +
> >>   4 files changed, 240 insertions(+)
> >>   create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
> >>   create mode 100644 hw/ppc/pnv_nest1_chiplet.c
> >>
> >> diff --git a/include/hw/ppc/pnv_nest_chiplet.h b/include/hw/ppc/pnv_ne=
st_chiplet.h
> >> new file mode 100644
> >> index 0000000000..845030fb1a
> >> --- /dev/null
> >> +++ b/include/hw/ppc/pnv_nest_chiplet.h
> >> @@ -0,0 +1,36 @@
> >> +/*
> >> + * QEMU PowerPC nest chiplet model
> >> + *
> >> + * Copyright (c) 2023, IBM Corporation.
> >> + *
> >> + * SPDX-License-Identifier: GPL-2.0-or-later
> >> + *
> >> + * This code is licensed under the GPL version 2 or later. See the
> >> + * COPYING file in the top-level directory.
> >> + *
> >> + */
> >> +
> >> +#ifndef PPC_PNV_NEST1_CHIPLET_H
> >> +#define PPC_PNV_NEST1_CHIPLET_H
> >> +
> >> +#include "hw/ppc/pnv_pervasive.h"
> >> +
> >> +#define TYPE_PNV_NEST1 "pnv-nest1-chiplet"
> >> +#define PNV_NEST1(obj) OBJECT_CHECK(PnvNest1, (obj), TYPE_PNV_NEST1)
> >> +
> >> +typedef struct pb_scom {
> >> +    uint64_t mode;
> >> +    uint64_t hp_mode2_curr;
> >> +} pb_scom;
> >> +
> >> +typedef struct PnvNest1 {
> >=20
> > Naming nitpicking again...
> >=20
> > The main ifndef guard for header files should match the file name, so
> > the file should be called pnv_nest1_chiplet.h (and that matches the .c
> > file too).
> >=20
> > I think this struct should be called Nest1Chiplet too.
>
> I asked Chalapathi to do the exact opposit :)

Oops :)

> I don't mind really, my argument was that most models represent HW logic
> units or subunits of a bigger unit. I don't see the point in adding a
> chip/chiplet suffix apart from PnvChip since it represents a socket or
> processor.
>
> You choose. I will keep quiet :)

Ah. I can see that side of it. And for many of the nest chiplets (MC,
PAU, PCI) that makes sense. For Nest0 and Nest1... it's a bit
overloaded. First of all, all the nest chiplets are "nest". Then
there is also some nest units inside the processor chiplets (L2, L3,
NCU are considered to be nest). And then the nest also has a Pervasive
Chiplet itself, and we also have these pervasive registers in each
chiplet, etc., etc.

So my worry is we'll run into confusion if we shorten names too much.

We can always rename things, so it won't be the end of the world, but
thinking about the pervasive chiplet, I think we can already see that
"PnvPervasive" would not be a good name for it.

The chiplets have short names actually if that would help. Nest 1 is
called N1, so we could call it PnvN1Chiplet. That seems the usual
way to refer to them in docs, so I think a better name.

Thanks,
Nick


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1C721B47
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 02:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5yDM-00043y-GP; Sun, 04 Jun 2023 20:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q5yDK-00043b-KV
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 20:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q5yDI-0007Ke-9l
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 20:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685925406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdTtX1ZLLI9wKhF2how4UKm5Dy+vvtgrXhRJ/+WvhI4=;
 b=gXgV5JSYX8jOdw+GK14J/KH1kpKK4MEoW8x5mF/QWEgN5mWPh9+qKfV7mQAvi7HjIBwv+2
 BKPH94fSlcLLf11In22ktkHIE9gXC41TMrZC1tWVcIzMQd65VqHh/xzzY2RwJJt8dZE2YK
 ZXyGo+bkE2ETMtzqmAe+a6CFSNmZ674=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-uYwu1zWpP3G7udglIy5FnA-1; Sun, 04 Jun 2023 20:36:45 -0400
X-MC-Unique: uYwu1zWpP3G7udglIy5FnA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b1b630bb2bso12455701fa.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 17:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685925404; x=1688517404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdTtX1ZLLI9wKhF2how4UKm5Dy+vvtgrXhRJ/+WvhI4=;
 b=YIot8xtsHLhS15i+Rm1vhMOINZUqvwpwAofdFh5jIUh5VEl+zVs0l8oVFdNkcFEm50
 OYJ5n771jZROfxXUghFcsK4AIEzpM+MpXkQALJvWfpFsVr8tpFQABv44+uLkO+TAnZWr
 vIOESGvMBbuNEAlmK4z3hAUkEGYPYFxxM8a94ZKvXCtPSdhF3wJm3IRj7n3aYqgSrFPZ
 Li5gFsbIR8m+4DWnx16zsmqeGqgRKVseg1WiwCkswX/EnkpSDp2StQ++WUZyL1XE/AIz
 /99JfBeT9bejuIuZmU0OxYB627ee3ITY3ySDeO4UDjHgz7DPFwQ0H/i9xlSrLdt7zQAn
 V7ng==
X-Gm-Message-State: AC+VfDwOKz7u0wWhEqPtWc3G6BAiapgm6VbmH6UMg48HFF7lhJpWPoR2
 GcvF9wRJJWj129G3B7Bj6iggUspi0saIwBFEFuwInASkgbG6snlZWxmsPpdy35h/Qv6Olhn5iJw
 /8gBNwUve6TayMDTwQA8uBhG30HPxj1g=
X-Received: by 2002:a2e:9cc1:0:b0:2a7:adf7:1781 with SMTP id
 g1-20020a2e9cc1000000b002a7adf71781mr3124793ljj.2.1685925403830; 
 Sun, 04 Jun 2023 17:36:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54c3do9y9FapCVbL+gNk+RxLHc9lonNVICtVWCnMVBC7M2UXkb66xRTuB+tEqXun714U2BBOJtyirUnsgByrM=
X-Received: by 2002:a2e:9cc1:0:b0:2a7:adf7:1781 with SMTP id
 g1-20020a2e9cc1000000b002a7adf71781mr3124785ljj.2.1685925403439; Sun, 04 Jun
 2023 17:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-14-mark.cave-ayland@ilande.co.uk>
 <ada65226-f41c-7bc2-eec9-d880efef9455@vivier.eu>
In-Reply-To: <ada65226-f41c-7bc2-eec9-d880efef9455@vivier.eu>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 5 Jun 2023 08:36:32 +0800
Message-ID: <CACGkMEvx4N_=GA8P5sg91ugJCFTuNAsv4viRfKtBvQa=oUDg6w@mail.gmail.com>
Subject: Re: [PATCH v3 13/23] hw/net/dp8393x.c: move TYPE_DP8393X and
 dp8393xState into dp8393x.h
To: Laurent Vivier <laurent@vivier.eu>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jun 5, 2023 at 12:18=E2=80=AFAM Laurent Vivier <laurent@vivier.eu> =
wrote:
>
> Jason,
>
> if you agree with the changes I will merge them via the m68k branch.

Yes.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
> Laurent
>
> Le 04/06/2023 =C3=A0 15:14, Mark Cave-Ayland a =C3=A9crit :
> > This is to enable them to be used outside of dp8393x.c.
> >
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > CC: Jason Wang <jasowang@redhat.com>
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> >   hw/net/dp8393x.c         | 32 +--------------------
> >   include/hw/net/dp8393x.h | 60 +++++++++++++++++++++++++++++++++++++++=
+
> >   2 files changed, 61 insertions(+), 31 deletions(-)
> >   create mode 100644 include/hw/net/dp8393x.h
> >
> > diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> > index 45b954e46c..a596f7fbc6 100644
> > --- a/hw/net/dp8393x.c
> > +++ b/hw/net/dp8393x.c
> > @@ -20,6 +20,7 @@
> >   #include "qemu/osdep.h"
> >   #include "hw/irq.h"
> >   #include "hw/qdev-properties.h"
> > +#include "hw/net/dp8393x.h"
> >   #include "hw/sysbus.h"
> >   #include "migration/vmstate.h"
> >   #include "net/net.h"
> > @@ -85,7 +86,6 @@ static const char *reg_names[] =3D {
> >   #define SONIC_MPT    0x2e
> >   #define SONIC_MDT    0x2f
> >   #define SONIC_DCR2   0x3f
> > -#define SONIC_REG_COUNT  0x40
> >
> >   #define SONIC_CR_HTX     0x0001
> >   #define SONIC_CR_TXP     0x0002
> > @@ -139,36 +139,6 @@ static const char *reg_names[] =3D {
> >   #define SONIC_DESC_EOL   0x0001
> >   #define SONIC_DESC_ADDR  0xFFFE
> >
> > -#define TYPE_DP8393X "dp8393x"
> > -OBJECT_DECLARE_SIMPLE_TYPE(dp8393xState, DP8393X)
> > -
> > -struct dp8393xState {
> > -    SysBusDevice parent_obj;
> > -
> > -    /* Hardware */
> > -    uint8_t it_shift;
> > -    bool big_endian;
> > -    bool last_rba_is_full;
> > -    qemu_irq irq;
> > -    int irq_level;
> > -    QEMUTimer *watchdog;
> > -    int64_t wt_last_update;
> > -    NICConf conf;
> > -    NICState *nic;
> > -    MemoryRegion mmio;
> > -
> > -    /* Registers */
> > -    uint16_t cam[16][3];
> > -    uint16_t regs[SONIC_REG_COUNT];
> > -
> > -    /* Temporaries */
> > -    uint8_t tx_buffer[0x10000];
> > -    int loopback_packet;
> > -
> > -    /* Memory access */
> > -    MemoryRegion *dma_mr;
> > -    AddressSpace as;
> > -};
> >
> >   /*
> >    * Accessor functions for values which are formed by
> > diff --git a/include/hw/net/dp8393x.h b/include/hw/net/dp8393x.h
> > new file mode 100644
> > index 0000000000..4a3f7478be
> > --- /dev/null
> > +++ b/include/hw/net/dp8393x.h
> > @@ -0,0 +1,60 @@
> > +/*
> > + * QEMU NS SONIC DP8393x netcard
> > + *
> > + * Copyright (c) 2008-2009 Herve Poussineau
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation; either version 2 of
> > + * the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License a=
long
> > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_NET_DP8393X_H
> > +#define HW_NET_DP8393X_H
> > +
> > +#include "hw/sysbus.h"
> > +#include "net/net.h"
> > +#include "exec/memory.h"
> > +
> > +#define SONIC_REG_COUNT  0x40
> > +
> > +#define TYPE_DP8393X "dp8393x"
> > +OBJECT_DECLARE_SIMPLE_TYPE(dp8393xState, DP8393X)
> > +
> > +struct dp8393xState {
> > +    SysBusDevice parent_obj;
> > +
> > +    /* Hardware */
> > +    uint8_t it_shift;
> > +    bool big_endian;
> > +    bool last_rba_is_full;
> > +    qemu_irq irq;
> > +    int irq_level;
> > +    QEMUTimer *watchdog;
> > +    int64_t wt_last_update;
> > +    NICConf conf;
> > +    NICState *nic;
> > +    MemoryRegion mmio;
> > +
> > +    /* Registers */
> > +    uint16_t cam[16][3];
> > +    uint16_t regs[SONIC_REG_COUNT];
> > +
> > +    /* Temporaries */
> > +    uint8_t tx_buffer[0x10000];
> > +    int loopback_packet;
> > +
> > +    /* Memory access */
> > +    MemoryRegion *dma_mr;
> > +    AddressSpace as;
> > +};
> > +
> > +#endif
>
>



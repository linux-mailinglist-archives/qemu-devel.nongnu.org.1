Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8587434B3
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7G8-00052i-KQ; Fri, 30 Jun 2023 02:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF7G6-00052K-HY
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:05:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF7G4-0007q5-KX
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688105127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6gcXZuwuD1fZ0mmERxs6VyNXFpMBOOo6AC1eTKAahlA=;
 b=dqlxQLBaxUTIysDPnUex6qHPnxWFBvb8VO2sSzEO+DkSWatCMurEfvYygIdn8xvIMmi4W3
 6tSD7YZQ5yWBMdzZV7pChxhR1UVhwx4vbJNtFd+DHdwjaZ7nYRtDXQWZTFh8qzW+fuMVCR
 C33S3CdjOCtUmg1dbPVmD1Pz+Ljgzms=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-fztX4OjuOX2c8L1FZxUaFg-1; Fri, 30 Jun 2023 02:05:25 -0400
X-MC-Unique: fztX4OjuOX2c8L1FZxUaFg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b66c262bd9so13928921fa.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 23:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688105124; x=1690697124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6gcXZuwuD1fZ0mmERxs6VyNXFpMBOOo6AC1eTKAahlA=;
 b=ey/6jSXzfjnq2AqHZrWX9DjM3BsPkz7Hd4DmxJ2Wne9n5o9/xHvm28YWZVDsaF01Tq
 RZ3yzp8qKFNDWNdkUNNRirBiexbFujjf4I+XM5JQ9PP3GJRfEA5u31AWNkw/C1fLPIsR
 CH6lQFyA/AJRv8GFmcUZ8JInVYdVDAvFbSAvNRGGZPy+BXIrc+1LiM/SuFsoy/RmxOBU
 yz2Zj9/jBzKFxl+KkwQjmeg3yfCf/aGio8g1moBJflXRBN9aCnZVI8vXCTclmuF2FImx
 2urH4NIzgf0DsmtmOlMZseYkJqYOjmCPWMMv7qGLOrZOiXqqW+oWa6CKtv4eKcPbfiRg
 /h1Q==
X-Gm-Message-State: ABy/qLZqWE+GRyvlpwCRSasSkhOMndRVVo/kEx/d15xBL0g5omIBtCHz
 USzWTZgDPSJwEzhlSC0MwS4YeEwAGlFyz0YzlVt9ZuQKyC5rkU2zC9+hu6b+ShihvRsORfK8RLu
 z/zYmoHyXTR8sT+QvTpz1PLtZKQiXE9A=
X-Received: by 2002:a2e:9bd6:0:b0:2b4:45bc:7bd with SMTP id
 w22-20020a2e9bd6000000b002b445bc07bdmr1350697ljj.4.1688105124511; 
 Thu, 29 Jun 2023 23:05:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwiODeQ2YTsvPEJ/OohVRTOj251FmobQgLcipeUC+pKd7X3G2StS2nZfoB7t3TjpAoecPmej0tcBkUzTUNH8g=
X-Received: by 2002:a2e:9bd6:0:b0:2b4:45bc:7bd with SMTP id
 w22-20020a2e9bd6000000b002b445bc07bdmr1350683ljj.4.1688105124183; Thu, 29 Jun
 2023 23:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230602072516.42502-1-akihiko.odaki@daynix.com>
 <c3c571aa-d882-09ea-15d8-4cb119feae4e@daynix.com>
In-Reply-To: <c3c571aa-d882-09ea-15d8-4cb119feae4e@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 14:05:13 +0800
Message-ID: <CACGkMEu6gRKC3aGKNMOCyKq8AJ8xrjkYxPFzsWQezSrbBqRh9Q@mail.gmail.com>
Subject: Re: [PATCH] e1000e: Add ICR clearing by corresponding IMS bit
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: intel-wired-lan@lists.osuosl.org, qemu-devel@nongnu.org, 
 alexander.duyck@gmail.com, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 29, 2023 at 4:53=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/06/02 16:25, Akihiko Odaki wrote:
> > The datasheet does not say what happens when interrupt was asserted
> > (ICR.INT_ASSERT=3D1) and auto mask is *not* active.
> > However, section of 13.3.27 the PCIe* GbE Controllers Open Source
> > Software Developer=E2=80=99s Manual, which were written for older devic=
es,
> > namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
> > 82573E/82573V/82573L, does say:
> >> If IMS =3D 0b, then the ICR register is always clear-on-read. If IMS i=
s
> >> not 0b, but some ICR bit is set where the corresponding IMS bit is not
> >> set, then a read does not clear the ICR register. For example, if
> >> IMS =3D 10101010b and ICR =3D 01010101b, then a read to the ICR regist=
er
> >> does not clear it. If IMS =3D 10101010b and ICR =3D 0101011b, then a r=
ead
> >> to the ICR register clears it entirely (ICR.INT_ASSERTED =3D 1b).
> >
> > Linux does no longer activate auto mask since commit
> > 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware clears
> > ICR even in such a case so we also should do so.
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1707441
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > Supersedes: <20201203133236.222207-1-andrew@daynix.com>
> > ("[PATCH v2] e1000e: Added ICR clearing by corresponding IMS bit.")
> >
> >   hw/net/e1000e_core.c | 38 ++++++++++++++++++++++++++++++++------
> >   hw/net/trace-events  |  1 +
> >   2 files changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> > index 9785ef279c..338bbbf4f4 100644
> > --- a/hw/net/e1000e_core.c
> > +++ b/hw/net/e1000e_core.c
> > @@ -2607,12 +2607,38 @@ e1000e_mac_icr_read(E1000ECore *core, int index=
)
> >           e1000e_lower_interrupts(core, ICR, 0xffffffff);
> >       }
> >
> > -    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
> > -        (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
> > -        trace_e1000e_irq_icr_clear_iame();
> > -        e1000e_lower_interrupts(core, ICR, 0xffffffff);
> > -        trace_e1000e_irq_icr_process_iame();
> > -        e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
> > +    if (core->mac[ICR] & E1000_ICR_ASSERTED) {
> > +        if (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME) {
> > +            trace_e1000e_irq_icr_clear_iame();
> > +            e1000e_lower_interrupts(core, ICR, 0xffffffff);
> > +            trace_e1000e_irq_icr_process_iame();
> > +            e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
> > +        }
> > +
> > +        /*
> > +         * The datasheet does not say what happens when interrupt was =
asserted
> > +         * (ICR.INT_ASSERT=3D1) and auto mask is *not* active.
> > +         * However, section of 13.3.27 the PCIe* GbE Controllers Open =
Source
> > +         * Software Developer=E2=80=99s Manual, which were written for=
 older devices,
> > +         * namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
> > +         * 82573E/82573V/82573L, does say:
> > +         * > If IMS =3D 0b, then the ICR register is always clear-on-r=
ead. If IMS
> > +         * > is not 0b, but some ICR bit is set where the correspondin=
g IMS bit
> > +         * > is not set, then a read does not clear the ICR register. =
For
> > +         * > example, if IMS =3D 10101010b and ICR =3D 01010101b, then=
 a read to the
> > +         * > ICR register does not clear it. If IMS =3D 10101010b and
> > +         * > ICR =3D 0101011b, then a read to the ICR register clears =
it entirely
> > +         * > (ICR.INT_ASSERTED =3D 1b).
> > +         *
> > +         * Linux does no longer activate auto mask since commit
> > +         * 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardw=
are
> > +         * clears ICR even in such a case so we also should do so.
> > +         */
> > +        if (core->mac[ICR] & core->mac[IMS]) {
> > +            trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
> > +                                                   core->mac[IMS]);
> > +            e1000e_lower_interrupts(core, ICR, 0xffffffff);
> > +        }
> >       }
> >
> >       return ret;
> > diff --git a/hw/net/trace-events b/hw/net/trace-events
> > index e97e9dc17b..9103488e17 100644
> > --- a/hw/net/trace-events
> > +++ b/hw/net/trace-events
> > @@ -217,6 +217,7 @@ e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%=
x"
> >   e1000e_irq_icr_clear_nonmsix_icr_read(void) "Clearing ICR on read due=
 to non MSI-X int"
> >   e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero=
 IMS"
> >   e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
> > +e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing=
 ICR on read due corresponding IMS bit: 0x%x & 0x%x"
> >   e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IM=
S due to EIAME, IAM: 0x%X, cause: 0x%X"
> >   e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR =
bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
> >   e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to =
IMC write 0x%x"
>
> Hi Jason,
>
> Can you have a look at this patch and
> "[PATCH] igb: Remove obsolete workaround for Windows":
> https://patchew.org/QEMU/20230529023704.9387-1-akihiko.odaki@daynix.com/
>
> Regards,
> Akihiko Odaki

I've queued both of the patches.

Thanks

>



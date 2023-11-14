Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F707EA848
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 02:39:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2iNK-0002re-Fw; Mon, 13 Nov 2023 20:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2iNF-0002rK-By
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 20:37:54 -0500
Received: from mail-oa1-f42.google.com ([209.85.160.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2iN7-0002Ff-OB
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 20:37:52 -0500
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-1eb39505ba4so3331028fac.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 17:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699925861; x=1700530661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Pzj3VImTrzR+e81oZM92kHfHpbTRcefjMYJ3M0Y3LI=;
 b=tEWt/55NKlIgU2w9uY21fsgM8OvwzlAkkq59dVPz/UpysrMxR/xUzJ8GEn9lsryEt7
 r9743tllnlAIWAWVVmwgrWLkOIrF/ydS7jE+iOW2K30ouTuAIdYxRDiw1WLBpjCnigRE
 lIy/Hw/5DUZUllbzzpHjFgBz1xpqQoc2rungTysvVporkFU1LAZNGPwwgGEU3BaULwfX
 Xm7QleUINFVK9ViVscbwTRHXqmC823aHxXHeNHXEIfuH+fK9OhEH6mvWLRPgkMj+Qdo8
 CL/nSyvHAnc6fSa0RBw7sWb7qI588RgdNYZ1Md/D+YSsiyuyB3CL9SExWlak6IpWgqrs
 KArw==
X-Gm-Message-State: AOJu0YymZ/Cmqw4MAParIBItjelMLMkp/7vMXos6UWNlmJsIG4cYovuo
 S2EM15uB8rJbYeEqB5JwCsMCGUj83jw=
X-Google-Smtp-Source: AGHT+IGT+k4TihuvB0gKRpWJ9BzdQJ45ZTH1JIPxE5n7lLNz13HJt2X32PsB9s09h+MhKE4lNCTHyA==
X-Received: by 2002:a05:6870:fb88:b0:1f0:d96:8d9c with SMTP id
 kv8-20020a056870fb8800b001f00d968d9cmr10724031oab.9.1699925860898; 
 Mon, 13 Nov 2023 17:37:40 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com.
 [209.85.216.45]) by smtp.gmail.com with ESMTPSA id
 p1-20020a62ab01000000b006c0316485f9sm214101pff.64.2023.11.13.17.37.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 17:37:40 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-280260db156so4593366a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 17:37:40 -0800 (PST)
X-Received: by 2002:a17:90b:4f8b:b0:263:f630:228f with SMTP id
 qe11-20020a17090b4f8b00b00263f630228fmr9433897pjb.23.1699925860068; Mon, 13
 Nov 2023 17:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20231031040021.65582-1-j@getutm.app>
 <20231031040021.65582-5-j@getutm.app>
 <e7a4c833-3e61-4a7f-ab9e-3921eb581613@linux.ibm.com>
In-Reply-To: <e7a4c833-3e61-4a7f-ab9e-3921eb581613@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 13 Nov 2023 17:37:28 -0800
X-Gmail-Original-Message-ID: <CA+E+eSA27LvGBY4TyZg5zWLZ6J=d=deiaM9-FjpQCNy=m+dHog@mail.gmail.com>
Message-ID: <CA+E+eSA27LvGBY4TyZg5zWLZ6J=d=deiaM9-FjpQCNy=m+dHog@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.160.42; envelope-from=osy86dev@gmail.com;
 helo=mail-oa1-f42.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Nov 1, 2023 at 2:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
>
>
> On 10/31/23 00:00, Joelle van Dyne wrote:
> > On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
> > the exception is not decoded by hardware and we cannot trap the MMIO
> > read. This led to the idea from @agraf to use the same mapping type as
> > ROM devices: namely that reads should be seen as memory type and
> > writes should trap as MMIO.
> >
> > Once that was done, the second memory mapping of the command buffer
> > region was redundent and was removed.
> >
> > A note about the removal of the read trap for `CRB_LOC_STATE`:
> > The only usage was to return the most up-to-date value for
> > `tpmEstablished`. However, `tpmEstablished` is only cleared when a
> > TPM2_HashStart operation is called which only exists for locality 4.
> > We do not handle locality 4. Indeed, the comment for the write handler
> > of `CRB_LOC_CTRL` makes the same argument for why it is not calling
> > the backend to reset the `tpmEstablished` bit (to 1).
> > As this bit is unused, we do not need to worry about updating it for
> > reads.
> >
> > In order to maintain migration compatibility with older versions of
> > QEMU, we store a copy of the register data and command data which is
> > used only during save/restore.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
>
> > diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> > index bee0b71fee..605e8576e9 100644
> > --- a/hw/tpm/tpm_crb_common.c
> > +++ b/hw/tpm/tpm_crb_common.c
> > @@ -31,31 +31,12 @@
> >   #include "qom/object.h"
> >   #include "tpm_crb.h"
> >
> > -static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
> > -                                  unsigned size)
> > +static uint8_t tpm_crb_get_active_locty(TPMCRBState *s, uint32_t *regs=
)
> >   {
> > -    TPMCRBState *s =3D opaque;
> > -    void *regs =3D (void *)&s->regs + (addr & ~3);
> > -    unsigned offset =3D addr & 3;
> > -    uint32_t val =3D *(uint32_t *)regs >> (8 * offset);
> > -
> > -    switch (addr) {
> > -    case A_CRB_LOC_STATE:
> > -        val |=3D !tpm_backend_get_tpm_established_flag(s->tpmbe);
> > -        break;
> > -    }
> > -
> > -    trace_tpm_crb_mmio_read(addr, size, val);
> > -
> > -    return val;
> > -}
> > -
> > -static uint8_t tpm_crb_get_active_locty(TPMCRBState *s)
> > -{
> > -    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
> > +    if (!ARRAY_FIELD_EX32(regs, CRB_LOC_STATE, locAssigned)) {
> >           return TPM_CRB_NO_LOCALITY;
> >       }
> > -    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
> > +    return ARRAY_FIELD_EX32(regs, CRB_LOC_STATE, activeLocality);
> >   }
> >
> >   static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> > @@ -63,35 +44,47 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr=
 addr,
> >   {
> >       TPMCRBState *s =3D opaque;
> >       uint8_t locty =3D  addr >> 12;
> > +    uint32_t *regs;
> > +    void *mem;
> >
> >       trace_tpm_crb_mmio_write(addr, size, val);
> > +    regs =3D memory_region_get_ram_ptr(&s->mmio);
> > +    mem =3D &regs[R_CRB_DATA_BUFFER];
> > +    assert(regs);
> > +
> > +    if (addr >=3D A_CRB_DATA_BUFFER) {
>
>
> Can you write here /* receive TPM command bytes */ ?
Will do.

>
>
> > +        assert(addr + size <=3D TPM_CRB_ADDR_SIZE);
> > +        assert(size <=3D sizeof(val));
> > +        memcpy(mem + addr - A_CRB_DATA_BUFFER, &val, size);
>
> > +        memory_region_set_dirty(&s->mmio, addr, size);
> > +        return;
> > +    }
> >
> >       switch (addr) {
> >       case A_CRB_CTRL_REQ:
> >           switch (val) {
> >           case CRB_CTRL_REQ_CMD_READY:
> > -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> > +            ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
> >                                tpmIdle, 0);
> >               break;
> >           case CRB_CTRL_REQ_GO_IDLE:
> > -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> > +            ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
> >                                tpmIdle, 1);
> >               break;
> >           }
> >           break;
> >       case A_CRB_CTRL_CANCEL:
> >           if (val =3D=3D CRB_CANCEL_INVOKE &&
> > -            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> > +            regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> >               tpm_backend_cancel_cmd(s->tpmbe);
> >           }
> >           break;
> >       case A_CRB_CTRL_START:
> >           if (val =3D=3D CRB_START_INVOKE &&
> > -            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> > -            tpm_crb_get_active_locty(s) =3D=3D locty) {
> > -            void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
> > +            !(regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> > +            tpm_crb_get_active_locty(s, regs) =3D=3D locty) {
> >
> > -            s->regs[R_CRB_CTRL_START] |=3D CRB_START_INVOKE;
> > +            regs[R_CRB_CTRL_START] |=3D CRB_START_INVOKE;
> >               s->cmd =3D (TPMBackendCmd) {
> >                   .in =3D mem,
> >                   .in_len =3D MIN(tpm_cmd_get_size(mem), s->be_buffer_s=
ize),
> > @@ -108,26 +101,27 @@ static void tpm_crb_mmio_write(void *opaque, hwad=
dr addr,
> >               /* not loc 3 or 4 */
> >               break;
> >           case CRB_LOC_CTRL_RELINQUISH:
> > -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> > +            ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
> >                                locAssigned, 0);
> > -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> > +            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
> >                                Granted, 0);
> >               break;
> >           case CRB_LOC_CTRL_REQUEST_ACCESS:
> > -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> > +            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
> >                                Granted, 1);
> > -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> > +            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
> >                                beenSeized, 0);
> > -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> > +            ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
> >                                locAssigned, 1);
> >               break;
> >           }
> >           break;
> >       }
> > +
> > +    memory_region_set_dirty(&s->mmio, 0, A_CRB_DATA_BUFFER);
> >   }
> >
> >   const MemoryRegionOps tpm_crb_memory_ops =3D {
> > -    .read =3D tpm_crb_mmio_read,
> >       .write =3D tpm_crb_mmio_write,
> >       .endianness =3D DEVICE_LITTLE_ENDIAN,
> >       .valid =3D {
> > @@ -138,12 +132,16 @@ const MemoryRegionOps tpm_crb_memory_ops =3D {
> >
> >   void tpm_crb_request_completed(TPMCRBState *s, int ret)
> >   {
> > -    s->regs[R_CRB_CTRL_START] &=3D ~CRB_START_INVOKE;
> > +    uint32_t *regs =3D memory_region_get_ram_ptr(&s->mmio);
> > +
> > +    assert(regs);
> > +    regs[R_CRB_CTRL_START] &=3D ~CRB_START_INVOKE;
> >       if (ret !=3D 0) {
> > -        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> > +        ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
> >                            tpmSts, 1); /* fatal error */
> >       }
> > -    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> > +
> > +    memory_region_set_dirty(&s->mmio, 0, TPM_CRB_ADDR_SIZE);
> >   }
> >
> >   enum TPMVersion tpm_crb_get_version(TPMCRBState *s)
> > @@ -160,45 +158,50 @@ int tpm_crb_pre_save(TPMCRBState *s)
> >
> >   void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
> >   {
> > +    uint32_t *regs =3D memory_region_get_ram_ptr(&s->mmio);
> > +
> > +    assert(regs);
> >       if (s->ppi_enabled) {
> >           tpm_ppi_reset(&s->ppi);
> >       }
> >       tpm_backend_reset(s->tpmbe);
> >
> > -    memset(s->regs, 0, sizeof(s->regs));
> > +    memset(regs, 0, TPM_CRB_ADDR_SIZE);
> >
> > -    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> > +    ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
> >                        tpmRegValidSts, 1);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> > +    ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
> > +                     tpmEstablished, 1);
> > +    ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
> >                        tpmIdle, 1);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        InterfaceVersion, CRB_INTF_VERSION_CRB);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_6=
4);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
> >                        RID, 0b0000);
> > -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> > +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID2,
> >                        VID, PCI_VENDOR_ID_IBM);
> >
> >       baseaddr +=3D A_CRB_DATA_BUFFER;
> > -    s->regs[R_CRB_CTRL_CMD_SIZE] =3D CRB_CTRL_CMD_SIZE;
> > -    s->regs[R_CRB_CTRL_CMD_LADDR] =3D (uint32_t)baseaddr;
> > -    s->regs[R_CRB_CTRL_CMD_HADDR] =3D (uint32_t)(baseaddr >> 32);
> > -    s->regs[R_CRB_CTRL_RSP_SIZE] =3D CRB_CTRL_CMD_SIZE;
> > -    s->regs[R_CRB_CTRL_RSP_LADDR] =3D (uint32_t)baseaddr;
> > -    s->regs[R_CRB_CTRL_RSP_HADDR] =3D (uint32_t)(baseaddr >> 32);
> > +    regs[R_CRB_CTRL_CMD_SIZE] =3D CRB_CTRL_CMD_SIZE;
> > +    regs[R_CRB_CTRL_CMD_LADDR] =3D (uint32_t)baseaddr;
> > +    regs[R_CRB_CTRL_CMD_HADDR] =3D (uint32_t)(baseaddr >> 32);
> > +    regs[R_CRB_CTRL_RSP_SIZE] =3D CRB_CTRL_CMD_SIZE;
> > +    regs[R_CRB_CTRL_RSP_LADDR] =3D (uint32_t)baseaddr;
> > +    regs[R_CRB_CTRL_RSP_HADDR] =3D (uint32_t)(baseaddr >> 32);
> >
> >       s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
> >                               CRB_CTRL_CMD_SIZE);
> > @@ -206,15 +209,33 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t basea=
ddr)
> >       if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
> >           exit(1);
> >       }
> > +
> > +    memory_region_rom_device_set_romd(&s->mmio, true);
> > +    memory_region_set_dirty(&s->mmio, 0, TPM_CRB_ADDR_SIZE);
> >   }
> >
> >   void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
> >   {
> > -    memory_region_init_io(&s->mmio, obj, &tpm_crb_memory_ops, s,
> > -        "tpm-crb-mmio", sizeof(s->regs));
> > -    memory_region_init_ram(&s->cmdmem, obj,
> > -        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> > +    memory_region_init_rom_device_nomigrate(&s->mmio, obj, &tpm_crb_me=
mory_ops,
> > +        s, "tpm-crb-mem", TPM_CRB_ADDR_SIZE, errp);
> >       if (s->ppi_enabled) {
> >           tpm_ppi_init_memory(&s->ppi, obj);
> >       }
> >   }
> > +
> > +void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *save=
d_cmdmem)
> > +{
> > +    uint32_t *regs =3D memory_region_get_ram_ptr(&s->mmio);
> > +
> > +    memcpy(saved_regs, regs, TPM_CRB_R_MAX);
> > +    memcpy(saved_cmdmem, &regs[R_CRB_DATA_BUFFER], A_CRB_DATA_BUFFER);
>
> I find it confusing that this function is here rather than in
> tpm_crb_non_pre_save().
I factored it that way to be consistent with the other callbacks in
-common. The idea is that the -common code has no visibility into the
instance specific data structure and therefore needs to get that info
(saved_regs, saved_cmdmem) from the concrete instance.

>
> The size should be CRB_CTRL_CMD_SIZE.
Good catch, will fix.

>
> > +}
> > +
> > +void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
> > +                      const void *saved_cmdmem)
> > +{
> > +    uint32_t *regs =3D memory_region_get_ram_ptr(&s->mmio);
> > +
> > +    memcpy(regs, saved_regs, TPM_CRB_R_MAX);
> > +    memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, A_CRB_DATA_BUFFER);
> > +}
>
> Same comments; size seems wrong.


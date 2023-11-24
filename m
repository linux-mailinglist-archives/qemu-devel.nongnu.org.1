Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7A7F6C57
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 07:35:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Plb-00081O-Vw; Fri, 24 Nov 2023 01:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PlZ-0007uy-Lh; Fri, 24 Nov 2023 01:34:17 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6PlX-0003lw-RK; Fri, 24 Nov 2023 01:34:17 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6cbd24d9557so1140850b3a.1; 
 Thu, 23 Nov 2023 22:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700807654; x=1701412454; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnymXk14LFM4E6VC/UKBowo1YuDcSmFI23zUursKreU=;
 b=ZKZWsmDXt0weyLdoJXcVk1zdciyQvLGYErcABODFZkorq4WiO+ZUqSMcObEVad1gy3
 WI5cFX9legmssk8SprdKc/JF0NR9DR+FPtzSPkdeO7MT+wEvVWI+ZhiWK2IraRZ+lQXK
 Rq9n1LUMn5SN164y+bYdGmzmolUtNPz8gf+N7hAEhdaXOcvyi2Kfr67MM6nDVBGgl1yl
 Ri/4s3kCtGreCSTfoYxexWMOuJnzbPi7tJyHodz65ayWq6AupDRe+lR0Ar6cxeIjZvNs
 vlqrEUqnLG/PcduGTWxuhOhzGwYUynfywnMya8ZPgWKJWDiyZ0vQNMfpID1s6qOwZqb9
 8l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700807654; x=1701412454;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QnymXk14LFM4E6VC/UKBowo1YuDcSmFI23zUursKreU=;
 b=VOUibu7Kxn0HTogW9WuOv9LK/uSF4d6rndlOaZw14mbzOgmHAs8wumPvY/FthU2eFv
 CAk9l6P2+83RX8CNDKQqHSfZr2EOdr2tcI0H9+8e/Lu9RDi7xzSG+XLjrlEpAA5JxgC8
 0YBfR+7d11BzP8oknV4S88OODhdxYxtezgbKHFqt6QVRpLwMURezrzs6I6/cQUW8kdgS
 0/0twfDaXTxyBHmvDaclb7HDHQc8zOSotwe2ybx4Z8NvRU42FbDRz27WG90J0Ioma+/X
 YrlMFzzcyx/2ydk0AygBnktM4VAXi15PxwS9K3jR1EflhKHwlB5ApUYpGzQAud63WeMi
 393w==
X-Gm-Message-State: AOJu0YzrPSLS/7cMUG6JcOupxcgVx25opeCc9AL8bq+h1crME+ovzTRb
 LD4h7cjJ+hd4jbxq5+kUtm8=
X-Google-Smtp-Source: AGHT+IHzzhIBtRxTc7qTLjKpcvlxue3ZqSjNrlqPaEA33elTTFM8h4uw9vjj3lX4J4hBdafox/vbtQ==
X-Received: by 2002:a05:6a20:8e1f:b0:13f:13cb:bc50 with SMTP id
 y31-20020a056a208e1f00b0013f13cbbc50mr2319718pzj.25.1700807653882; 
 Thu, 23 Nov 2023 22:34:13 -0800 (PST)
Received: from localhost ([1.145.239.154]) by smtp.gmail.com with ESMTPSA id
 g8-20020a056a00078800b006cb574445efsm2200923pfu.88.2023.11.23.22.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 22:34:13 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 16:33:52 +1000
Message-Id: <CX6TZJPI3XFZ.2HMPTJ2OTV4N@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 5/7] pnv/chiptod: Implement the ChipTOD to Core transfer
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231123103018.172383-1-npiggin@gmail.com>
 <20231123103018.172383-6-npiggin@gmail.com>
 <3d3e74bc-d19a-4c45-a23d-de9a3bdc81bf@kaod.org>
In-Reply-To: <3d3e74bc-d19a-4c45-a23d-de9a3bdc81bf@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

On Fri Nov 24, 2023 at 4:34 AM AEST, C=C3=A9dric Le Goater wrote:
> On 11/23/23 11:30, Nicholas Piggin wrote:
> > One of the functions of the ChipTOD is to transfer TOD to the Core
> > (aka PC - Pervasive Core) timebase facility.
> >=20
> > The ChipTOD can be programmed with a target address to send the TOD
> > value to. The hardware implementation seems to perform this by
> > sending the TOD value to a SCOM addres.
>
> address
>
> >=20
> > This implementation grabs the core directly and manipulates the
> > timebase facility state in the core. This is a hack, but it works
> > enough for now. A better implementation would implement the transfer
> > to the PnvCore xscom register and drive the timebase state machine
> > from there.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   include/hw/ppc/pnv_chiptod.h |  3 ++
> >   include/hw/ppc/pnv_core.h    |  4 ++
> >   target/ppc/cpu.h             |  7 +++
> >   hw/ppc/pnv.c                 | 33 +++++++++++++
> >   hw/ppc/pnv_chiptod.c         | 92 +++++++++++++++++++++++++++++++++++=
+
> >   5 files changed, 139 insertions(+)
> >=20
> > diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.=
h
> > index e2765c3bfc..ffcc376e80 100644
> > --- a/include/hw/ppc/pnv_chiptod.h
> > +++ b/include/hw/ppc/pnv_chiptod.h
> > @@ -29,6 +29,8 @@ enum tod_state {
> >       tod_stopped =3D 1,
> >   };
> >  =20
> > +typedef struct PnvCore PnvCore;
> > +
> >   struct PnvChipTOD {
> >       DeviceState xd;
> >  =20
> > @@ -40,6 +42,7 @@ struct PnvChipTOD {
> >       enum tod_state tod_state;
> >       uint64_t tod_error;
> >       uint64_t pss_mss_ctrl_reg;
> > +    PnvCore *slave_pc_target;
> >   };
> >  =20
> >   struct PnvChipTODClass {
> > diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > index 4db21229a6..5f52ae7dbf 100644
> > --- a/include/hw/ppc/pnv_core.h
> > +++ b/include/hw/ppc/pnv_core.h
> > @@ -85,4 +85,8 @@ struct PnvQuad {
> >       MemoryRegion xscom_regs;
> >       MemoryRegion xscom_qme_regs;
> >   };
> > +
> > +PnvCore *pnv_get_core_by_xscom_base(PnvChip *chip, uint32_t xscom_base=
);
> > +PnvCore *pnv_get_core_by_id(PnvChip *chip, uint32_t core_id);
> > +
> >   #endif /* PPC_PNV_CORE_H */
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 848e583c2d..8df5626939 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1258,6 +1258,13 @@ struct CPUArchState {
> >       uint32_t tlb_need_flush; /* Delayed flush needed */
> >   #define TLB_NEED_LOCAL_FLUSH   0x1
> >   #define TLB_NEED_GLOBAL_FLUSH  0x2
> > +
> > +#if defined(TARGET_PPC64)
> > +    /* Would be nice to put these into PnvCore */
>
> This is going to be complex to do from the insn implementation.
>
>
> > +    /* PowerNV chiptod / timebase facility state. */
> > +    int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod=
 */
> > +    int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
> > +#endif
> >   #endif
> >  =20
> >       /* Other registers */
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 546266ae3d..fa0dc26732 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -2032,6 +2032,39 @@ static void pnv_chip_core_realize(PnvChip *chip,=
 Error **errp)
> >       }
> >   }
> >  =20
> > +PnvCore *pnv_get_core_by_xscom_base(PnvChip *chip, uint32_t xscom_base=
)
>
> please use a pnv_chip_ prefix and move this routine definition in file
> pnv_chiptod.c if possible. We don't want this routine to be used too
> widely ... if not possible, please add a comment saying this is a
> shortcut to avoid complex modeling of HW which is not exposed to the
> software. In any case, add the comment.

Done.

> > +{
> > +    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
> > +    int i;
> > +
> > +    for (i =3D 0; i < chip->nr_cores; i++) {
> > +        PnvCore *pc =3D chip->cores[i];
> > +        CPUCore *cc =3D CPU_CORE(pc);
> > +        int core_hwid =3D cc->core_id;
> > +
> > +        if (pcc->xscom_core_base(chip, core_hwid) =3D=3D xscom_base) {
> > +            return pc;
> > +        }
> > +    }
> > +    return NULL;
> > +}
> > +
> > +PnvCore *pnv_get_core_by_id(PnvChip *chip, uint32_t core_id)
>
> please use a pnv_chip_ prefix and move this routine definition close
> to pnv_chip_find_cpu()

Done.

> > @@ -201,6 +201,62 @@ static void pnv_chiptod_xscom_write(void *opaque, =
hwaddr addr,
> >           chiptod->pss_mss_ctrl_reg =3D val & PPC_BITMASK(0, 31);
> >           break;
> >  =20
> > +    case TOD_TX_TTYPE_CTRL_REG:
> > +        /*
> > +         * This register sets the target of the TOD value transfer ini=
tiated
> > +         * by TOD_MOVE_TOD_TO_TB. The TOD is able to send the address =
to
> > +         * any target register, though in practice only the PC TOD reg=
ister
> > +         * should be used. ChipTOD has a "SCOM addressing" mode which =
fully
> > +         * specifies the SCOM address, and a core-ID mode which uses t=
he
> > +         * core ID to target the PC TOD for a given core.
> > +         *
> > +         * skiboot uses SCOM for P10 and ID for P9, possibly due to ha=
rdware
> > +         * weirdness. For this reason, that is all we implement here.
> > +         */
> > +        if (val & PPC_BIT(35)) { /* SCOM addressing */
> > +            uint32_t addr2 =3D val >> 32;
> > +            uint32_t reg =3D addr2 & 0xfff;
> > +
> > +            if (reg !=3D PC_TOD) {
> > +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addr=
essing: "
> > +                              "unimplemented slave register 0x%" PRIx3=
2 "\n",
> > +                              reg);
> > +                return;
> > +            }
> > +
> > +            /*
> > +             * This may not deal with P10 big-core addressing at the m=
oment.
> > +             * The big-core code in skiboot syncs small cores, but it =
targets
> > +             * the even PIR (first small-core) when syncing second sma=
ll-core.
> > +             */
> > +            chiptod->slave_pc_target =3D
> > +                    pnv_get_core_by_xscom_base(chiptod->chip, addr2 & =
~0xfff);
> > +            if (!chiptod->slave_pc_target) {
> > +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom wri=
te reg"
> > +                              " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
> > +                              " invalid slave XSCOM address\n", val);
> > +            }
> So this is preparing the chiptod to initiate a SCOM memop on the
> targetted core.

Yes.

>
> > +        } else { /* PIR addressing */
> > +            uint32_t core_id;
>
> I suppose "PIR addressing" is the previous way of doing the same.

Yes, I should have written "core ID addresing", and it seems to do the
same thing, but just gives you a shortcut to find the PC_TOD scom
address for that core. The WB basically says they are equivalent AFAIKS.

>
> > +
> > +            if (!is_power9) {
>
> Please transform 'is_power9' into a class attribute
>
>     bool PnvChipTODClass::pir_addressing

I made the entire transmit operation a class function, which works
okay. There's possibly more than one quirk in HW (based on my trouble
making skiboot work on real HW) so it could be useful to model various
other things too.

> > +        } else if (chiptod->slave_pc_target =3D=3D NULL) {
> > +            qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: xscom write r=
eg"
> > +                          " TOD_MOVE_TOD_TO_TB_REG with no slave targe=
t\n");
> > +        } else {
> > +            PowerPCCPU *cpu =3D chiptod->slave_pc_target->threads[0];
> > +            CPUPPCState *env =3D &cpu->env;
> > +
> > +            /*
> > +             * Moving TOD to TB will set the TB of all threads in a
> > +             * core, so skiboot only does this once per thread0, so
> > +             * that is where we keep the timebase state machine.
> > +             *
> > +             * It is likely possible for TBST to be driven from other
> > +             * threads in the core, but for now we only implement it f=
or
> > +             * thread 0.
> > +             */
>
>
> and here, the memop is done and the status of the transaction should be
> read in SPR_TFMR. This is not a friendly HW interface !

Yes, workbook says to poll TFMR[18] on the target core after this scom.

It is a bit weird, I guess there's a lot of history (and features I
don't understand) behind it. TFMR can be read via SCOM in the core PC
unit I think, so it could be programmed more naturally that way. Not
that we model SCOM access to PC registers AFAIK...

All other formatting, naming, wording comments I snipped, I agree with
and havechanged.

Thanks,
Nick


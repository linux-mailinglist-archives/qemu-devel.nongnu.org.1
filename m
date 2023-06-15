Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7667317E7
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 13:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9lVp-0000eB-4B; Thu, 15 Jun 2023 07:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9lVj-0000do-4s; Thu, 15 Jun 2023 07:51:31 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9lVg-0005Cg-QH; Thu, 15 Jun 2023 07:51:30 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b517ee9157so3754595ad.3; 
 Thu, 15 Jun 2023 04:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686829887; x=1689421887;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1GHgzy4IWX9es1qN0dtNrwQcCDfIYR64eOUc+xUVas=;
 b=FIJ824DBlXWgjIGay0K/4YoORbQ51Ef8c1XDLwWb8wAaCQSaNE9+EGCRffBbB1oM3k
 WubQi/FnM0wINeNPQPdLNWOpuuVxfKP4zLlq37AHP1NOTLE5t3tRDBzIMBfirLGUfdmd
 Ainvtlj7mvKtowWcAPzWyKn7/A4P7sWMeLSXJ6NlYsoxV8pRA4RUoGmP88WwqUS5sW+k
 qjmArx2a10g//uui89vOzuDXWS6bPAbwC1XLTgGQZ/9v8Jwo8xMEq1rz1a7/j6fYkJV9
 66Zk6A0g53mHEfSp8TRU8qLvFDQ/D41fEIEVFNNS8KLEIDGLrxV+j156bdmKextunuZs
 XK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686829887; x=1689421887;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G1GHgzy4IWX9es1qN0dtNrwQcCDfIYR64eOUc+xUVas=;
 b=VB5RjDQJc2TqhxpKdGWPHegsM3824yk1xCuGRxvt1eM1nPdPr9CRWsqmr0PAhcN1cN
 EUydCZ/4AYfscS4hpYE+AeKw/7Mwza9sXfFqLf3kxA+wHWsF11eo33xX6sUHQA1lkkNp
 HjmBGAobwl5brZDImHfy/7fZQVmLRfBz86capQ97h0f2IptTdkAZxACdmWNONabvo2z/
 gVJ8o0ILTjBNgFnxWIJExoYiTxTvuCJLSxhZ3Lk1YJt9mKq7Fc4+dC4YzfS7fO3GvelE
 IYlW5iPdo3hQyO77Ctct9FZ6BPabXrdPOX1jogFbdpOnxS18idWKwMbCG1mSXxAQJBGc
 aXpw==
X-Gm-Message-State: AC+VfDzMGMTSx0g1Zwc7xSE5G5MDv6ZH5b3jeB6k0+MMLFv17iRYVo2H
 YUuqPanW3jlu6NM+Mni0ZMx4Vhst/4E=
X-Google-Smtp-Source: ACHHUZ5XJrtTTZiHOJEftl7pwG9t/wSLAOo28lH8VDTkQO+2CY+0O+1z8Cak1b7YnrVVvxInitTECA==
X-Received: by 2002:a17:902:f68e:b0:1b5:1e24:8a6e with SMTP id
 l14-20020a170902f68e00b001b51e248a6emr768805plg.60.1686829886819; 
 Thu, 15 Jun 2023 04:51:26 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a170902b20c00b001ac741dfd29sm13827524plr.295.2023.06.15.04.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 04:51:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 21:51:22 +1000
Message-Id: <CTD7AE00VYIP.2IPHRORV44U1P@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
Subject: Re: [PATCH 4/4] ppc/spapr: Move spapr nested HV to a new file
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-5-npiggin@gmail.com>
 <497ec7c7-2f8e-fb79-92dd-077fa12957af@linux.ibm.com>
In-Reply-To: <497ec7c7-2f8e-fb79-92dd-077fa12957af@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

On Thu Jun 15, 2023 at 4:30 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/8/23 14:43, Nicholas Piggin wrote:
> > Create spapr_nested.c for most of the nested HV implementation.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/meson.build     |   1 +
> >   hw/ppc/spapr_hcall.c   | 415 +---------------------------------
> >   hw/ppc/spapr_nested.c  | 496 ++++++++++++++++++++++++++++++++++++++++=
+
> >   include/hw/ppc/spapr.h |  61 +----
> >   4 files changed, 499 insertions(+), 474 deletions(-)
> >   create mode 100644 hw/ppc/spapr_nested.c

[snip]

> > diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> > new file mode 100644
> > index 0000000000..c06dd8903c
> > --- /dev/null
> > +++ b/hw/ppc/spapr_nested.c
> > @@ -0,0 +1,496 @@
> > +#include "qemu/osdep.h"
> > +#include "qemu/cutils.h"
> > +#include "exec/exec-all.h"
> > +#include "helper_regs.h"
> > +#include "hw/ppc/ppc.h"
> > +#include "hw/ppc/spapr.h"
> > +#include "hw/ppc/spapr_cpu_core.h"
> > +
> > +/*
> > + * Register state for entering a nested guest with H_ENTER_NESTED.
> > + * New member must be added at the end.
> > + */
> > +struct kvmppc_hv_guest_state {
> > +    uint64_t version;      /* version of this structure layout, must b=
e first */
> > +    uint32_t lpid;
> > +    uint32_t vcpu_token;
> > +    /* These registers are hypervisor privileged (at least for writing=
) */
> > +    uint64_t lpcr;
> > +    uint64_t pcr;
> > +    uint64_t amor;
> > +    uint64_t dpdes;
> > +    uint64_t hfscr;
> > +    int64_t tb_offset;
> > +    uint64_t dawr0;
> > +    uint64_t dawrx0;
> > +    uint64_t ciabr;
> > +    uint64_t hdec_expiry;
> > +    uint64_t purr;
> > +    uint64_t spurr;
> > +    uint64_t ic;
> > +    uint64_t vtb;
> > +    uint64_t hdar;
> > +    uint64_t hdsisr;
> > +    uint64_t heir;
> > +    uint64_t asdr;
> > +    /* These are OS privileged but need to be set late in guest entry =
*/
> > +    uint64_t srr0;
> > +    uint64_t srr1;
> > +    uint64_t sprg[4];
> > +    uint64_t pidr;
> > +    uint64_t cfar;
> > +    uint64_t ppr;
> > +    /* Version 1 ends here */
> > +    uint64_t dawr1;
> > +    uint64_t dawrx1;
> > +    /* Version 2 ends here */
> > +};
> > +
> > +/* Latest version of hv_guest_state structure */
> > +#define HV_GUEST_STATE_VERSION  2
> > +
> > +/* Linux 64-bit powerpc pt_regs struct, used by nested HV */
> > +struct kvmppc_pt_regs {
> > +    uint64_t gpr[32];
> > +    uint64_t nip;
> > +    uint64_t msr;
> > +    uint64_t orig_gpr3;    /* Used for restarting system calls */
> > +    uint64_t ctr;
> > +    uint64_t link;
> > +    uint64_t xer;
> > +    uint64_t ccr;
> > +    uint64_t softe;        /* Soft enabled/disabled */
> > +    uint64_t trap;         /* Reason for being here */
> > +    uint64_t dar;          /* Fault registers */
> > +    uint64_t dsisr;        /* on 4xx/Book-E used for ESR */
> > +    uint64_t result;       /* Result of a system call */
> > +};
>
> Now that we have a separated spapr_nested.c for nested related code,
> Can above definitions and other nested related defines (like struct=20
> nested_ppc_state below) be moved to a new spapr_nested.h as well?
> Otherwise, looks good to me.

They're private to this file, so do we need to? I'm on the fence about
it, maybe because they're hcall ABI. I don't object to adding a new
spapr_nested.h for nested related things in general though.

Thanks,
Nick


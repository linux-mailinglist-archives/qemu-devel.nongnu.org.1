Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF327917CF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9Kw-0000dO-5O; Mon, 04 Sep 2023 09:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qd9Kp-0000cU-IG; Mon, 04 Sep 2023 09:09:44 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qd9Km-00058W-Gh; Mon, 04 Sep 2023 09:09:42 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34e12396f6fso5103115ab.1; 
 Mon, 04 Sep 2023 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693832979; x=1694437779; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aXdCSkQUnks4joj4Q9Xj2ogjlfuFzQJroeoQkDZyopg=;
 b=GyH4//TmaOIceE3dkdaPF75RSXVzz7Qi74GQ57RUNJZ7eS23iOOIB+UyJZuDm6EFYL
 XLKaC5r64J1x03yQloSUCUZ5NmIhZlvjQPIg6l6Jj39DcgbNUi3NZFy/K5QwHNFHlG6J
 Rq2rRF2TAZBerr0FBnERW+9GLGOqaKxl14Mxn6wfu+BZW2cenX2l+ycPjZmHdR3fN48R
 5OafiN39j5ey9CN0QRvUkvPamMugj1wOr9GzMwhev/hBOIzm2WMBBUl3n1AdOxuLGyd0
 doIaOxT+MYAT1LqBnVlf6arRo80uWq19RFdlV5ZKHhv1hv5byaGW46Tj+l9VWykRc+dW
 Wa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693832979; x=1694437779;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aXdCSkQUnks4joj4Q9Xj2ogjlfuFzQJroeoQkDZyopg=;
 b=hgLklw34ZS4ruU/ZywPDpUKPEDwTqeFInrjpYzB9kax9l1hKcC5VYNW/TKuEfkxSJq
 NIqJdXziR+sfiN/M0GMR33YuZv2iGC8P0Yv2Gn8/+1VXw6erlsPETqShGnYh49Ay0G6/
 CKp4vRN3VBJKDavz7BuBjsOI8JiorphzbkVzjYHs+oL/PqCvQZ+jqoEqIbN5QWPA9+xL
 7QaRqB/cbtx46pw6TRrEnfnbjHiOT/5BqRaAckl+qFek02spBPUOojF0lcLpVKV01Wn4
 swXJlhYzbl00YIQZVPZ9SW4ClDEr/wkxBP2XuuKs3Zo4QQuANhgT6CwXajGeK04Mm79s
 caZw==
X-Gm-Message-State: AOJu0YywO8gCTMTQOw8OFPDJZfDyYZfGZQB6FU0x2/giwX+Ph6un08lr
 Av16JNQ1px9j61/d4cPQ+Wk=
X-Google-Smtp-Source: AGHT+IHEdx4vDy+OPE6M4w6z7xojWKWMJCcXlzvVVvF4Wrfd9lwP9R0DAGUTYMprLPQwru0ZDBRaqA==
X-Received: by 2002:a92:c144:0:b0:34c:cc37:3064 with SMTP id
 b4-20020a92c144000000b0034ccc373064mr11469619ilh.15.1693832978817; 
 Mon, 04 Sep 2023 06:09:38 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a63b207000000b00563df2ba23bsm7703080pge.50.2023.09.04.06.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:09:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Sep 2023 23:09:33 +1000
Message-Id: <CVA5ODL1631K.3IGDZE9PWNRL3@wheely>
Cc: "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 08/19] target/ppc: Sign-extend large decrementer to
 64-bits
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-9-npiggin@gmail.com>
 <59203654-9490-0b2c-af6d-3d52577c41ff@kaod.org>
In-Reply-To: <59203654-9490-0b2c-af6d-3d52577c41ff@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=npiggin@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Sep 1, 2023 at 10:25 PM AEST, C=C3=A9dric Le Goater wrote:
> Nick,
>
> On 8/8/23 06:19, Nicholas Piggin wrote:
> > When storing a large decrementer value with the most significant
> > implemented bit set, it is to be treated as a negative and sign
> > extended.
> >=20
> > This isn't hit for book3s DEC because of another bug, fixing it
> > in the next patch exposes this one and can cause additional
> > problems, so fix this first. It can be hit with HDECR and other
> > edge triggered types.
> >=20
> > Fixes: a8dafa52518 ("target/ppc: Implement large decrementer support fo=
r TCG")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/ppc.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index a397820d9c..fb4784793c 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -743,7 +743,9 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
> >        * to 64 bits, otherwise it is a 32 bit value.
> >        */
> >       if (env->spr[SPR_LPCR] & LPCR_LD) {
> > -        return decr;
> > +        PowerPCCPU *cpu =3D env_archcpu(env);
> > +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > +        return sextract64(decr, 0, pcc->lrg_decr_bits);
> >       }
> >       return (uint32_t) decr;
> >   }
> > @@ -762,7 +764,9 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
> >        * extended to 64 bits, otherwise it is 32 bits.
> >        */
> >       if (pcc->lrg_decr_bits > 32) {
> > -        return hdecr;
> > +        PowerPCCPU *cpu =3D env_archcpu(env);
> > +        PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
>
> Why are 'cpu' and 'ppc' duplicated ?

Hmm.. cut and paste bug maybe, good catch.

I'll send an increment to tidy it if needed.

Thanks,
Nick


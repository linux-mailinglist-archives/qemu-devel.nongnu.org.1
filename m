Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340A73EF18
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 01:16:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDvQV-0002uC-Dq; Mon, 26 Jun 2023 19:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDvQT-0002ty-9e; Mon, 26 Jun 2023 19:15:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDvQR-00078e-GZ; Mon, 26 Jun 2023 19:15:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b7e1875cc1so11078465ad.1; 
 Mon, 26 Jun 2023 16:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687821313; x=1690413313;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/jsPJ+XUXjceBl6ow61h+SxSjDUMKs9dHFQhCR15cA=;
 b=HbFETgKRAfgDziLWoduwULsmsKOwNgeG7kjBrDpwaTn9jUXlYeHfRsiTf+3Wc+7VSR
 B1pYYEkZW+ZNlQzMDJucG93sQzqvT08PMtX0htUbfCpIslkN//4SLsTJvTwxMIHgEDkq
 ooyzjrxX/GC9f+UYYh+oRXw5I46xIfUZWKXlCes2gydPRlr1zvk4Ea8MrBegS5TN26g8
 X0mQ2tqhZWOeB48h5NP8eFvbooFp28oOFYB7dWc59xS8WaNFtvF1LmMla1iyHZLuR8Zy
 owiydECQDF6EVxQfodnikb6AQgtAjNVVnoNF1PKp+3H5M2sluelWPcDh4pxNSlbkwgpI
 pdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687821313; x=1690413313;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q/jsPJ+XUXjceBl6ow61h+SxSjDUMKs9dHFQhCR15cA=;
 b=BdoTVrz6LMliCg0hT5O2m4DfzoApYsKWoDkDzmAe/DUkOTQUXtR7ZvHQ7EPx6dEGh1
 stOQez1wTN14yAYD3T3MPaF9C/vhLf7HlYYjfeTjET0uWRgbWO8/E41hNwMxjV1MmnH1
 PTfJwFTdKrPQKux1flFaTEMpmQfIwvgMxsSOKEAMTe8c9slm8/OlkoJjmYG3eMP5j0SK
 uNpsRgHwycBKRlswJNLfG4KBD1gwic5tye/OLfus1CiRPhLN9xOhYVVKbyqM9uOa3Spw
 +YjlYjXTU2AJ6P54yRqGzCr8qF80OuA1GvTHMts2r1Ve6wvYlEkwjxMkYoRe+vhbjdgg
 /+zA==
X-Gm-Message-State: AC+VfDxC0CM91e7KKlfK7/rEaO+INSbtT9YDd/26M8LqdBNIf4+3uuJt
 AG6VTOKi7SVv6szcipR8Evg=
X-Google-Smtp-Source: ACHHUZ4v1PLf+8MzNKQ2OIHrzLOWyXcV8Pcj/FM02ofZq/AjVL8ynOjeGhuZnkKJo0WwarVL03oyuQ==
X-Received: by 2002:a17:902:a414:b0:1b8:e2a:9ef0 with SMTP id
 p20-20020a170902a41400b001b80e2a9ef0mr2100423plq.32.1687821313145; 
 Mon, 26 Jun 2023 16:15:13 -0700 (PDT)
Received: from localhost (14-200-238-131.tpgi.com.au. [14.200.238.131])
 by smtp.gmail.com with ESMTPSA id
 jl23-20020a170903135700b001aafa2e212esm4665463plb.52.2023.06.26.16.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 16:15:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jun 2023 09:15:06 +1000
Message-Id: <CTMYPVXCDUD5.3RP8ZKFAIJ3ZV@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Michael Tokarev"
 <mjt@tls.msk.ru>, "Richard Henderson" <richard.henderson@linaro.org>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>
Subject: Re: [PULL 10/30] ppc/spapr: H_ENTER_NESTED should restore host XER
 ca field
X-Mailer: aerc 0.15.2
References: <20230626055647.1147743-1-clg@kaod.org>
 <20230626055647.1147743-11-clg@kaod.org>
 <eb1c3b7c-5f50-7e25-ec99-3f84013e76c4@tls.msk.ru>
 <ecca1867-4308-5218-a5f6-9b0a93756f72@kaod.org>
In-Reply-To: <ecca1867-4308-5218-a5f6-9b0a93756f72@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Tue Jun 27, 2023 at 7:45 AM AEST, C=C3=A9dric Le Goater wrote:
> On 6/26/23 14:26, Michael Tokarev wrote:
> > 26.06.2023 08:56, C=C3=A9dric Le Goater wrote:
> >> From: Nicholas Piggin <npiggin@gmail.com>
> >>
> >> Fix missing env->ca restore when going from L2 back to the host.
> >>
> >> Fixes: 120f738a467 ("spapr: implement nested-hv capability for the vir=
tual hypervisor")
> >> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >> =C2=A0 hw/ppc/spapr_hcall.c | 1 +
> >> =C2=A0 1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index b9047555757f..0582b524d108 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1773,6 +1773,7 @@ out_restore_l1:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->cfar =3D spapr_cpu->nested_host_st=
ate->cfar;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->xer =3D spapr_cpu->nested_host_sta=
te->xer;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->so =3D spapr_cpu->nested_host_stat=
e->so;
> >> +=C2=A0=C2=A0=C2=A0 env->ca =3D spapr_cpu->nested_host_state->ca;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->ov =3D spapr_cpu->nested_host_stat=
e->ov;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->ov32 =3D spapr_cpu->nested_host_st=
ate->ov32;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->ca32 =3D spapr_cpu->nested_host_st=
ate->ca32;
> >=20
> > Is it -stable material too, or don't bother?
> > 120f738a467 is 7.0.
>
> I would say so. The CPU is missing state (Carry bit) when restoring conte=
xt,
> it could be important for some instructions.
>
> Nick, did you have specific test case ?

No I just found it when doing the conversion to the new host save
structure. Now I think about it again, XER is volatile across hcalls
in general so I think the patch is not fixing any practical bug.

Thanks,
Nick


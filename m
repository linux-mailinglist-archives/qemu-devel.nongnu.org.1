Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E10730CD7
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 03:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9c5T-0001FO-7H; Wed, 14 Jun 2023 21:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9c5R-0001Ek-26; Wed, 14 Jun 2023 21:47:45 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9c5O-0004xw-I4; Wed, 14 Jun 2023 21:47:44 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-3f9e1ebbf31so25213991cf.2; 
 Wed, 14 Jun 2023 18:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686793660; x=1689385660;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+gmWFa0mvQLFRncR/7RONdq8Dh8MN5XbGQdFLjHzOU=;
 b=l2Mvr+2q13QiumXwG9teFl95GgAxaKLOh0wx8IKDW/i73ROko+FWkMExlJ1DJVcV4r
 t0MlpOUF0FoGXEabJNEhheW3dlZ/4QLjLzeXDr5QJFq9xLc7wdI1AaqzpLrwzC5lIMUw
 2RDooKubOLuipLZ2FwVcNeKYu08Kw2m4AdfVAmmgnUAj97QytzUCYDG3QZTSjKm0NrhZ
 RyQPnDhDFuf59yAPAD8I44teFvPYuah+1865rf8JO7CEvpE+658S55HGu7Sc3u19GSFH
 bXI9d/V+FCEtzmeZrxKqwm5TstoRNHAR89tZHNzjplyCUlOtUXtJkCtN/lWPy3XP9sTM
 tSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686793660; x=1689385660;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x+gmWFa0mvQLFRncR/7RONdq8Dh8MN5XbGQdFLjHzOU=;
 b=Rc9MT1g06nw92m5MjXTz+ADMqE2rz2NKzQz1baL2PJ7s2inlFofwc7ChFIl10Bn1x+
 R72m//xwbdLsZD/IxfTiXcZ2d9fB7ROnqGhI0Dc9TdzY7XOQkQN0D8Z3CMprYS8Av9vB
 QqQiuz9hlMm47P6jBCiFv48S4DYgimfjBFOOkOwV5dX6Emv4ZBtWB0juY1a/Z8MQUEza
 d/zmEmxHBzniNNrJyw5pVVp4hRAm/5xrYCD7JAFrh22FusyrVfoyGyh8ddDcF8iHtV14
 BuOu4J44mjobupvN90a9nBfdCBY+sOJNzBHZSMTBvBtLdu2nU9CwJJiLqoA9Aus3v0de
 FFEw==
X-Gm-Message-State: AC+VfDwei+ie+3oAYIca12HB8lgZA9Ur1MZzZZNGe29UksvZio/QHbJU
 z9aTsAhUhFordCnnVRNtfds46TjQUGY=
X-Google-Smtp-Source: ACHHUZ5R3y+/hxujKAXNmia/dyqlbZJs7ervQ6iksY5560L/ZikGllfu0bH9CtxJcGZT92X2ei8QXA==
X-Received: by 2002:a05:622a:3ce:b0:3f9:a771:eb55 with SMTP id
 k14-20020a05622a03ce00b003f9a771eb55mr4626718qtx.52.1686793660276; 
 Wed, 14 Jun 2023 18:47:40 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 s1-20020aa78d41000000b0064fa2fdfa9esm10872586pfe.81.2023.06.14.18.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 18:47:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 11:47:34 +1000
Message-Id: <CTCUG3ECHDWH.2SLS9N3N1XRNA@wheely>
Subject: Re: [PATCH 09/10] target/ppc: Simplify syscall exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <ddb1379de4b3c20e543b37fb18fde5581191af49.1686522199.git.balaton@eik.bme.hu>
 <CTC3156BMOHL.1CSJOLOF48ZK5@wheely>
 <0c1ccff0-ae1c-8dd2-2c23-c3670296469b@eik.bme.hu>
In-Reply-To: <0c1ccff0-ae1c-8dd2-2c23-c3670296469b@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=npiggin@gmail.com; helo=mail-qt1-x829.google.com
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

On Thu Jun 15, 2023 at 7:33 AM AEST, BALATON Zoltan wrote:
> On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> > On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> >> After previous changes the hypercall handling in 7xx and 74xx
> >> exception handlers can be folded into one if statement to simpilfy
> >> this code.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/excp_helper.c | 26 ++++++++++----------------
> >>  1 file changed, 10 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> >> index 4f6a6dfb19..089417894e 100644
> >> --- a/target/ppc/excp_helper.c
> >> +++ b/target/ppc/excp_helper.c
> >> @@ -738,26 +738,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, in=
t excp)
> >>          break;
> >>      case POWERPC_EXCP_SYSCALL:   /* System call exception            =
        */
> >>      {
> >> -        int lev =3D env->error_code;
> >> +        PowerPCCPU *cpu =3D env_archcpu(env);
> >
> > I prefer to keep lev. Makes sense to combine the tests though
> > I suppose. Although with powernv it's not really clear that we
> > want to dump_syscall. dump_hcall is probably better (powernv
> > could support a non-PAPR hypervisor with different hcall
> > semantics, but also it could support an OS with different
> > syscall semantics too). I guess that could be changed back
> > when necessary though.
>
> What do you mean changed back? This is not supposed to change when=20
> dump_hcall and dump_syscall is called. However I've only changed the=20
> powerpc_excp_7xx() and powerpc_excp_74xx() functions where this is only=
=20
> present as a hack for VOF. I've left powerpc_excp_books() where hypercall=
s=20
> really exist unchanged because that takes other bits into accound so=20
> probably we can't combine the tests rhere.

Oh sorry I didn't notice it wasn't books.

Thanks,
Nick


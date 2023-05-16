Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AC1704A38
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:15:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrhf-0000Rt-Ed; Tue, 16 May 2023 06:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrhc-0000RD-Ds; Tue, 16 May 2023 06:14:44 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrha-0005tT-Nq; Tue, 16 May 2023 06:14:44 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-25332b3915bso73188a91.2; 
 Tue, 16 May 2023 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684232081; x=1686824081;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B2O71G+3wFJq8EGAQZeNZo4z3AOHv0LcC55tHjFjOt8=;
 b=MFThNy6iqPJFOGMH7/oiEsZhPY4cizXHTFscnyZxzHrFyFcmIHq4dGUHTBYk+Wj0Qx
 CA0Msvyniq07BTH/BKcZvHW3IIK8L82y88+/QHVOHIp3TBht0L8nLyrNpabxCDvtdQA1
 Cn5t/ndz38o7wRYiyrUfdldMDVlaAxeDe1AvYnYO6Sn0uj2sxfp6izoe3FTXy0eP3sWC
 r8HrIXaaQgQayFkLL/d0HfQ22NJxyKgYOMIwwt+ZRZJow5lJbl1PxHPedD5d2WbEFbrv
 H4wr+eqag8QW8bOBmjvJLq9xYM0vQy1ZJTzEu4XvOwahsNwh7yIrD/sCmgALVEuzU5a4
 9eoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684232081; x=1686824081;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=B2O71G+3wFJq8EGAQZeNZo4z3AOHv0LcC55tHjFjOt8=;
 b=UZrAtav6LybguoycM5ZYElIUGh4t8WbVkgnhT2S9zjUJKHv6i9rPXsNvS9/Mx+fpuw
 43x6GDKrt65E4CjcrQz6GhFfSKiKyLSs78+e1FcbTVkyfRMFFdGmmesr9PpB4nctZee+
 Gur+hUUoPqGSBQEd5TouCBgRZZUtJrmqQRyCveokVgJLVpjfM2lm9nEOCawqqrOh9+tT
 H1r8DMbXDIcN37TpFAjTkSMlXIomXUh7s6x6MZVtyzt+e/89XNhwfqduJcQpGgYRzm8S
 FNVhJfp5N/Tk6c7W/ob+opK+CmZHKJV2U6r5ZQa50xmBr4ALf6jFNXx13nMtGbOW7MY7
 0A5w==
X-Gm-Message-State: AC+VfDwYy2hfCOqzsm+E+SogPGRXUkRonQUCzLiLMdkAFiQCYEPROmGf
 MpC4QEk4qjjQDkgzUWSe1mk=
X-Google-Smtp-Source: ACHHUZ4OmFiASZ7lj6dJxTICUfQBh+27UUt7Uo+tuCquSBWRPK86yZxtJRLYhGHLbT+QbuQQ//yROg==
X-Received: by 2002:a17:90a:cb87:b0:250:c758:13a0 with SMTP id
 a7-20020a17090acb8700b00250c75813a0mr22804887pju.41.1684232080830; 
 Tue, 16 May 2023 03:14:40 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a170902e84200b001a19196af48sm15151811plg.64.2023.05.16.03.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 03:14:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 20:14:35 +1000
Message-Id: <CSNMFY6UV3G8.2V3AWPITZT1BM@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
X-Mailer: aerc 0.14.0
References: <20230515160201.394587-1-npiggin@gmail.com>
 <f9167007-ca18-eef6-5973-64da0ff4fedc@linux.ibm.com>
In-Reply-To: <f9167007-ca18-eef6-5973-64da0ff4fedc@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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

On Tue May 16, 2023 at 7:23 PM AEST, Harsh Prateek Bora wrote:
> <correcting my email in CC>
>
> On 5/15/23 21:32, Nicholas Piggin wrote:
> > POWER9 DD2.1 and earlier had significant limitations when running KVM,
> > including lack of "mixed mode" MMU support (ability to run HPT and RPT
> > mode on threads of the same core), and a translation prefetch issue
> > which is worked around by disabling "AIL" mode for the guest.
> >=20
> > These processors are not widely available, and it's difficult to deal
> > with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> > and make it the default POWER9 CPU.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This is unchanged since v3, just reposting.
> >=20
> > Thanks,
> > Nick
> >=20
> >   hw/ppc/pnv.c                   |  2 +-
> >   hw/ppc/pnv_core.c              |  2 +-
> >   hw/ppc/spapr.c                 |  2 +-
> >   hw/ppc/spapr_cpu_core.c        |  1 +
> >   include/hw/ppc/pnv.h           |  2 +-
> >   target/ppc/cpu-models.c        |  4 +++-
> >   target/ppc/cpu-models.h        |  1 +
> >   target/ppc/cpu_init.c          | 21 +++++++++++++++++++--
> >   tests/qtest/device-plug-test.c |  4 ++--
> >   9 files changed, 30 insertions(+), 9 deletions(-)
> >=20
>
> <snip>
>
>
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index a77e036b3a..572b5e553a 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -350,6 +350,7 @@ enum {
> >       CPU_POWERPC_POWER9_BASE        =3D 0x004E0000,
> >       CPU_POWERPC_POWER9_DD1         =3D 0x004E1100,
> >       CPU_POWERPC_POWER9_DD20        =3D 0x004E1200,
> > +    CPU_POWERPC_POWER9_DD22        =3D 0x004E1202,
> >       CPU_POWERPC_POWER10_BASE       =3D 0x00800000,
> >       CPU_POWERPC_POWER10_DD1        =3D 0x00801100,
> >       CPU_POWERPC_POWER10_DD20       =3D 0x00801200,
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 0ce2e3c91d..6775828dfc 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -6284,9 +6284,26 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass=
 *pcc, uint32_t pvr, bool best)
> >           return false;
> >       }
> >  =20
> > -    if ((pvr & 0x0f00) =3D=3D (pcc->pvr & 0x0f00)) {
> > -        /* Major DD version matches to power9_v1.0 and power9_v2.0 */
> > +    if ((pvr & 0x0f00) !=3D (pcc->pvr & 0x0f00)) {
> > +        /* Major DD version does not match */
> > +        return false;
> > +    }
> > +
> > +    if ((pvr & 0x0f00) =3D=3D 0x100) {
> > +        /* DD1.x always matches power9_v1.0 */
> >           return true;
> > +    } else if ((pvr & 0x0f00) =3D=3D 0x200) {
> > +        if ((pvr & 0xf) < 2) {
> > +            /* DD2.0, DD2.1 match power9_v2.0 */
> > +            if ((pcc->pvr & 0xf) =3D=3D 0) {
> > +                return true;
> > +            }
> > +        } else {
> > +            /* DD2.2, DD2.3 match power9_v2.2 */
> > +            if ((pcc->pvr & 0xf) =3D=3D 2) {
> The comment is futuristic about DD2.3 although the condition checks only=
=20
> for DD2.2, may be update comment for now and another patch later along=20
> with other changes needed to support 2.3?

In the case of KVM, PVR matching code matches 'pvr' from the host to
the best pcc. So the comment matches the code. It's just a bit clunky.

But as Cedric said we might want a 2.3 type as well if we want to
account for the nuances in better detail. No objection to adding it.

Thanks,
Nick


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8009721C0B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 04:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q602g-0004xD-2V; Sun, 04 Jun 2023 22:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q602c-0004wY-M6; Sun, 04 Jun 2023 22:33:54 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q602b-0007hY-2K; Sun, 04 Jun 2023 22:33:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-650352b89f6so2050883b3a.0; 
 Sun, 04 Jun 2023 19:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685932430; x=1688524430;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACDfDDrvbSgwiTMyt5QAOS9AFjWfq5+cab8/zWQwEEs=;
 b=GeDrDOld0p58rqe9P3GRXYptXKYjsBrGGB9bMSZMIINEj2zluQGxIdPhXZny4iWKGN
 bfM+1pToMklGIoYSrgr7oYp3xYOcNtgVaZEv4sQB9X5NiD6hAfyuj7ou3S+s908vH4l8
 2jtu/pdDIWXUZGpJYwr9/TVrrPvI60RC0o/Z2F5y9kLRMz4EVVL8HWJIRds9ffUcNZKW
 yYdoedNW8aTWwOXOntEcDNomo77O12O2AAle5mFIEduXWVcRp66s+DQxeFFj3LY8x7As
 MRPeEaAIQyHfeLp3RAb1OJP7MvixiTbRYz/4NUGoDqdvsZmUg4J7sYo4uyp/bMn8mAua
 D1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685932430; x=1688524430;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ACDfDDrvbSgwiTMyt5QAOS9AFjWfq5+cab8/zWQwEEs=;
 b=Km3yiu8DB1re6QLwSy2EwfCEGH3ZDhkfWFYKbFVRwXtzOjsCU9pj9GPvw6f6S7rS9I
 vNK7IikUGwRKxPdM/ycxgs6dUwrSzWZUpJx3kBmozPZEZZpWweMIN0OiozbdJfCdL3HU
 XYeiIGEMwyw7D/YeTCpqEcz6fea4+rBicp8kemVp3BtMaazvIM3SE9rldqI98ffj3E2B
 AcE6lWWUWJiO29a1uIUJ20FSsyvYGXiF9AFtNBAdLo9rXCCZxCXyrWaaCgNcjuT6NYHN
 xwMA78MFrx9bjxVOCTB+sAn/q2zFoDvITnhQg4Ao6whfojFh1LY6jGVbkYORCb57zF59
 SVmg==
X-Gm-Message-State: AC+VfDw3anCKMy6UEsfoxH9nAq3apxarE9P5ST2jgwYcTL6C38EPAsr4
 cnwzxwQ2aXdFxXxXZnAH4TE=
X-Google-Smtp-Source: ACHHUZ4tO70odMDvQWo3wwQ833mis/1MetRtPD4KntkJUeQbSOgiTEYn7ZJECunExYtd8wcZhqKKqQ==
X-Received: by 2002:a05:6a20:3d8b:b0:10e:457f:254c with SMTP id
 s11-20020a056a203d8b00b0010e457f254cmr1623579pzi.2.1685932430400; 
 Sun, 04 Jun 2023 19:33:50 -0700 (PDT)
Received: from localhost ([203.221.142.9]) by smtp.gmail.com with ESMTPSA id
 t1-20020a170902e84100b001b04949e0acsm5269454plg.232.2023.06.04.19.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 19:33:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jun 2023 12:33:44 +1000
Message-Id: <CT4D5ZIWEEXB.195JSP061UCUD@wheely>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>
Subject: Re: [PATCH 1/4] target/ppc: Fix lqarx to set cpu_reserve
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230604102858.148584-1-npiggin@gmail.com>
 <a9cfd044-6c20-e84a-b6ef-0f16c43765e3@linaro.org>
In-Reply-To: <a9cfd044-6c20-e84a-b6ef-0f16c43765e3@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

On Mon Jun 5, 2023 at 2:05 AM AEST, Richard Henderson wrote:
> On 6/4/23 03:28, Nicholas Piggin wrote:
> > lqarx does not set cpu_reserve, which causes stqcx. to never succeed.
> > Fix this and slightly rearrange gen_load_locked so the two functions
> > match more closely.
> >=20
> > Cc: qemu-stable@nongnu.org
> > Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
> > Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQAR=
X, LQ, STQ")
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > cpu_reserve got lost in the parallel part with the first patch, then
> > from serial part when it was merged with the parallel by the second
> > patch.
>
> Oops, sorry about that.

No problem, I really appreciate your work on ppc, ppc just should have
more unit tests particularly for non-trivial instructions like lqarx
which would have caught it. That's the real problem.

>
> >=20
> > Thanks,
> > Nick
> >=20
> >   target/ppc/translate.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 3650d2985d..e129cdcb8f 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -3583,8 +3583,8 @@ static void gen_load_locked(DisasContext *ctx, Me=
mOp memop)
> >  =20
> >       gen_set_access_type(ctx, ACCESS_RES);
> >       gen_addr_reg_index(ctx, t0);
> > -    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
> >       tcg_gen_mov_tl(cpu_reserve, t0);
> > +    tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
> >       tcg_gen_mov_tl(cpu_reserve_val, gpr);
>
> This change is wrong.  Reserve should not be set if the load faults.

Oh yeah, good catch.

Thanks
Nick


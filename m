Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAD72FD81
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 13:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9P4C-0008HI-Hd; Wed, 14 Jun 2023 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9P46-0008Gh-41; Wed, 14 Jun 2023 07:53:30 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9P42-0008Jw-3z; Wed, 14 Jun 2023 07:53:29 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-652a6cf1918so5030644b3a.1; 
 Wed, 14 Jun 2023 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686743601; x=1689335601;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1yjuFvJX0Rl7bVQ9koPLCHmaf913q9n4XLmVw1Go0E=;
 b=OL8S3rhZuAM0LSW8s2Jar+KeramBtbLbap7lq3xVFDKX6tGiJog1PasScFi3phLh5R
 zbcZHAY1E5oq3OA/Zz4n0++NRmrVp56+IAVgBEL6tM7qaZkerrVIxbBoRO8Oc+eUfb+f
 fp9bZMFtAJFxiRM0Abl+ZM5Kfopb9ypQ5S2VDFbEzef4mQmon7je0MWiLmzCHvdiJK5u
 eX9/xpPcSBL6HYUBfzgAEfwDl9WQorUXzQBcmApzPaQWJlU3MIkp1ddCk/CkEwqrrkmC
 5RpxnNZ+P+tQ+9Gq1LzwAf4lKvaLnwcLbzG9P1IY6wTscNJ4Jz0TKUjQZHloZRB3VhI7
 RqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686743601; x=1689335601;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T1yjuFvJX0Rl7bVQ9koPLCHmaf913q9n4XLmVw1Go0E=;
 b=ByRdROyjtMIFPgfviGqx3NXMo4miUnUDZGYW/3iNE2n8BGNRBtcZ3D21XHKBXDQUpw
 ZEq1aTMsdaWGriFsnbidjPUCsz/6k4UA7UU2F+BFsZto2x+J+CRpm6+bqHrvdhFb7RnM
 jU4burkQQCzgxfGvN/hQDoUu775YQ7ax3rfxj5om+cjctgP2lOffVf7UuX7XvHmsVfsO
 6zkVWuNiZTYctY2Abp7rTU3ACAn4QUUUpqd6SbGS3F+Sni86PCRsj6LaSZvJ1WqfMd5f
 b0lIsyG3TcnHLt7w1OjzmUrw3IfuyBY6WL135Zj2W9yrE9e+NzSVzBuylyAQmbC1V6AO
 jqPQ==
X-Gm-Message-State: AC+VfDzvmfBOl07Pjs+ufHWyjBkyxyABzL+LBYTTyMf/Twa4+e3kL9eX
 MBKTPoiuH4ECiYCUIBGAXLg=
X-Google-Smtp-Source: ACHHUZ6Z2KKp9fFa2UoqIlfNFtpbbbd3vmqjnw9P95LFZixusVdXkExiTUKx9AWCEYhEJgW25H3zuA==
X-Received: by 2002:a05:6a20:12ca:b0:111:d03c:2bf9 with SMTP id
 v10-20020a056a2012ca00b00111d03c2bf9mr1471946pzg.12.1686743600966; 
 Wed, 14 Jun 2023 04:53:20 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001b3fb1002besm1881491plo.141.2023.06.14.04.53.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 04:53:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 21:53:16 +1000
Message-Id: <CTCCPAUHAJSP.Y23Q0I4PBNWV@wheely>
Subject: Re: [PATCH 1/4] ppc/spapr: H_ENTER_NESTED should restore host XER
 ca field
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>
X-Mailer: aerc 0.14.0
References: <20230608091344.88685-1-npiggin@gmail.com>
 <20230608091344.88685-2-npiggin@gmail.com>
 <33465d2b-3c2b-8a29-d6c3-c379e742e259@linux.ibm.com>
In-Reply-To: <33465d2b-3c2b-8a29-d6c3-c379e742e259@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Fri Jun 9, 2023 at 5:05 PM AEST, Harsh Prateek Bora wrote:
> Since we have the spapr_exit_nested routine that gets executed during=20
> return path which contains the below change, I think mentioning=20
> spapr_exit_nested in the title may be more specific/appropriate.

It's the H_ENTER_NESTED call from the host though. I think that's
the right subject, changelog then says the bug is when returning
back to the host.

Thanks,
Nick



>
> On 6/8/23 14:43, Nicholas Piggin wrote:
> > Fix missing env->ca restore when going from L2 back to the host.
> >=20
> > Fixes: 120f738a467 ("spapr: implement nested-hv capability for the virt=
ual hypervisor")
> > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr_hcall.c | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index b904755575..0582b524d1 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1773,6 +1773,7 @@ out_restore_l1:
> >       env->cfar =3D spapr_cpu->nested_host_state->cfar;
> >       env->xer =3D spapr_cpu->nested_host_state->xer;
> >       env->so =3D spapr_cpu->nested_host_state->so;
> > +    env->ca =3D spapr_cpu->nested_host_state->ca;
> >       env->ov =3D spapr_cpu->nested_host_state->ov;
> >       env->ov32 =3D spapr_cpu->nested_host_state->ov32;
> >       env->ca32 =3D spapr_cpu->nested_host_state->ca32;



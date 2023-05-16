Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 614D1704994
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:43:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrCp-00014k-A7; Tue, 16 May 2023 05:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrCm-00013x-G9; Tue, 16 May 2023 05:42:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrCk-00078z-EW; Tue, 16 May 2023 05:42:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ab0c697c2bso128158055ad.1; 
 Tue, 16 May 2023 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684230168; x=1686822168;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMMCWj0JpAwWKvsJb6kd9BsTeIAwK1j1iLbHKFhmZBU=;
 b=L5qCpC8/KlWj1+RqBtmQ+vTG9a4pLavpgoiCxQ3bsJStiWbxGQu5XPp3hO3D15eXPC
 qXgQP/g3EO7Tjh3E6oWgzHN3gPRU2pO6Z3cOq0VZEQHyL/IOGtmddj9mWb7UVIqi+QRl
 AhnnRt5Ho46jGREM8cDHkSSLiyH0bKBrw9aFtd0yxAjM+QfNSYeN0wLv9gSZmSpIsWZU
 flo58OziBeGTCe9pLJUgDYtb4V6dyDfRfxep7tmwmScDqNrASc8cJil0JuBG1DrrzOCl
 7teXNcFZ35YfrORKEr6ZIyKy4rp7lZBiDCgjT3+uJ89fd48Lh6wHka6e2AmXXY2x1jQc
 CW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684230168; x=1686822168;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KMMCWj0JpAwWKvsJb6kd9BsTeIAwK1j1iLbHKFhmZBU=;
 b=ZFrbywQK9re8H/E3IbAC6nAkZ+G6VdDNcBQOnI+feeoItV4fBOwLfDTtn32aMm0huD
 fKwe8yGeCZGQCwodRKqeXAbh+2Dsaxask3+W2KtEOf22mMDRRw1vKOSjwQ/jWmiLHPjr
 KNXdXXlyDoBwSl//ibE4l1D2MGC0aRd2rET0VvgRm5UzTNrYqXb8Q8qyMjzzxo4cmXl0
 45kjD2dP9uz3oy6HVcs/kbyB/oYx4v13tYAbok36g1vhUj36MY7Oi42CkGj4Ktl8KMGf
 6BptU3dd6eRIX7OaEyHl8IbcMqC/3UlXziDI7P8i+Zrho99PUWs3Xtc7iDBwcUScrgf6
 Qmyw==
X-Gm-Message-State: AC+VfDzSz+LvPnW0yQawk56D3iEYnuLJfMClYoucW9nJEGE0tJboxicF
 +u6e9Rqi+qFujT+auz9z34f+6IJgJks=
X-Google-Smtp-Source: ACHHUZ6NHFo4WfCktKP8hGknWIKLgN+wCzw3Bb/qWK7snFVCUmPaQxHY3zJv+JbpJiUQhlNQMMly0A==
X-Received: by 2002:a17:903:244d:b0:1a5:2540:729 with SMTP id
 l13-20020a170903244d00b001a525400729mr46947383pls.56.1684230168564; 
 Tue, 16 May 2023 02:42:48 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a17090264cf00b001ab01b909c9sm15147839pli.120.2023.05.16.02.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 02:42:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 19:42:43 +1000
Message-Id: <CSNLRJWUDMA7.3OIG531AGZGVR@wheely>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/ppc: Use SMT4 small core chip type in POWER9/10
 PVRs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230515160131.394562-1-npiggin@gmail.com>
 <4b1147e0-498d-e3ae-d97a-4063055099b1@linux.ibm.com>
In-Reply-To: <4b1147e0-498d-e3ae-d97a-4063055099b1@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Tue May 16, 2023 at 6:43 PM AEST, Harsh Prateek Bora wrote:
> <correcting my email id in CC>
>
> On 5/15/23 21:31, Nicholas Piggin wrote:
> > QEMU's PVR value for POWER9 DD2.0 has chip type 1, which is the SMT4
> > "small core" type that OpenPOWER processors use. QEMU's PVR for all
> > other POWER9/10 have chip type 0, which "enterprise" systems use.
> >=20
> > The difference does not really matter to QEMU (because it does not care
> > about SMT mode in the target), but for consistency all PVRs should use
> > the same chip type. We'll go with the SMT4 OpenPOWER type.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This is a replacement for
> >=20
> > https://lists.gnu.org/archive/html/qemu-ppc/2022-03/msg00227.html
> >=20
> > But the chip type is changed to 1 instead of 0, because that's the
> > more familiar SM4 / small core CPU.
> >=20
> > Thanks,
> > Nick
> >=20
> >   target/ppc/cpu-models.h | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> > index 1326493a9a..a77e036b3a 100644
> > --- a/target/ppc/cpu-models.h
> > +++ b/target/ppc/cpu-models.h
> > @@ -348,11 +348,11 @@ enum {
> >       CPU_POWERPC_POWER8NVL_BASE     =3D 0x004C0000,
> >       CPU_POWERPC_POWER8NVL_v10      =3D 0x004C0100,
> >       CPU_POWERPC_POWER9_BASE        =3D 0x004E0000,
> > -    CPU_POWERPC_POWER9_DD1         =3D 0x004E0100,
> > +    CPU_POWERPC_POWER9_DD1         =3D 0x004E1100,
>
> Could you please point me to the doc location you are referring here?
> The P9 UM document that I have access to mentions this bit (0/1) for=20
> 12/24 cores. Not sure if this change is intended here.

Yes that's the one, OpenPOWER POWER9 User Manual lists it in PVR.
POWER10 is the same.

Thanks,
Nick


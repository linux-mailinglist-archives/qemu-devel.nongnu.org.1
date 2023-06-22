Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D1739F30
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 13:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCI3n-0003N2-9g; Thu, 22 Jun 2023 07:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCI3k-0003MD-6r; Thu, 22 Jun 2023 07:01:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCI3i-00072K-Ji; Thu, 22 Jun 2023 07:01:03 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b4f95833c7so37115155ad.1; 
 Thu, 22 Jun 2023 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687431660; x=1690023660;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Suf8xcjr94twkMdtMq86GZspr4L+OaQC3ip8khX+UCI=;
 b=eOjsx/7zKe58OyxcpnI//TWxssnvvVCpTO8c7LuSR3rfiggVEByGDW9vyVp4heyPjy
 NPH/mmCbo1Qt0R3AjcFabnIUU5lM2BhOvSe8i/gD/VDB8UYVY9ny8mC/f73hqvQP3y6Z
 BDU4brfDm1EIgrpmnuSON/fmS+KAP8TGiYMsb837vjS+wl9QXkrhUBZfRj/tKqdyGvnP
 TtsF0bC+7xRAbSQoob3/SYI5R9ijKryoAgD76ewofWe9e4qAD5tA4SOfmY56XC+YWmEN
 gupyi+bK/nADxBTWK+TI1KAexZwpLNibOuQxS767vxpzdNNGk69paAO6GuSevXOYsr3r
 MC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687431660; x=1690023660;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Suf8xcjr94twkMdtMq86GZspr4L+OaQC3ip8khX+UCI=;
 b=MNqmxYaNbQb0+GOKIijFse3J/SA6W6WD4auwcT1snYr9qJb8TYYdeF+V/WXOD+SYKY
 zUt913guMA1tnjGK8pxSKx8I9VhOATPR9fDWH3um61Q680gIAAFg0BRAwywbhg7jvDlO
 oUSDIaXwbCnuEp9o1T7wsWDHbH0xMGraXkQ/dL4pBxQxJXi+qTXev3x42R4vrNukxMtq
 prvKGUJDDKrvMAGqyeH4+Es3nEbarQ4IcodHdy/Z9jWI2qX6flR3oAgTNjpHm7LiYPxU
 UtqojztCS6EQcjypuA941GMC6gB17F7G42y65XrB9cuC9KD5YHTKTJlluFrSDgSD38Iv
 /nhQ==
X-Gm-Message-State: AC+VfDzfhXQwYL+zHyVkyq2qUgK9q/mI/ETO2QZqH2DYpndGpX700BEH
 GtfZ6mDdXGShJRDT1bRBkg5bghKz9ik=
X-Google-Smtp-Source: ACHHUZ6uBFue6I9AQ/bjF9KeTPWc3i3ZSFwwUnQBJP2NdfbBTCYXuxMNkoE6vYuVD7ErhRKD1afRpw==
X-Received: by 2002:a17:902:d702:b0:1b3:9d13:34b3 with SMTP id
 w2-20020a170902d70200b001b39d1334b3mr13732435ply.37.1687431660241; 
 Thu, 22 Jun 2023 04:01:00 -0700 (PDT)
Received: from localhost (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 jh5-20020a170903328500b001ac7c725c1asm1384523plb.6.2023.06.22.04.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 04:00:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jun 2023 21:00:55 +1000
Message-Id: <CTJ4LKZXRDU5.3J10AK6I35GNF@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH] target/ppc: Fix sc instruction handling of LEV field
X-Mailer: aerc 0.14.0
References: <20230621110938.239066-1-npiggin@gmail.com>
 <ceed7522-ac70-02fd-14b5-e97fad5e52a3@linux.ibm.com>
In-Reply-To: <ceed7522-ac70-02fd-14b5-e97fad5e52a3@linux.ibm.com>
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

On Thu Jun 22, 2023 at 6:00 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/21/23 16:39, Nicholas Piggin wrote:
> > The top bits of the LEV field of the sc instruction are to be treated a=
s
> > as a reserved field rather than a reserved value, meaning LEV is
> > effectively the bottom bit. LEV=3D0xF should be treated as LEV=3D1 and =
be
> > a hypercall, for example.
> >=20
> > This changes the instruction execution to just set lev from the low bit
> > of the field. Processors which don't support the LEV field will continu=
e
> > to ignore it.
> >=20
> > ISA v3.1 defines LEV to be 2 bits, in order to add the 'sc 2' ultracall
> > instruction. TCG does not support Ultravisor, so don't worry about
> > that bit.
> >=20
> > Suggested-by: "Harsh Prateek Bora" <harshpb@linux.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This should probably go ahead of the ISA 3.1 LEV in SRR1 patch. I
> > don't think they need to be backported to stable though, have not
> > caused any real problems.
> >=20
> > Thanks to Harsh for spotting it.
> >=20
> > Thanks,
> > Nick
> >=20
> >   target/ppc/translate.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index 15a00bd4fa..3c62f9188a 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -4424,7 +4424,12 @@ static void gen_sc(DisasContext *ctx)
> >   {
> >       uint32_t lev;
> >  =20
> > -    lev =3D (ctx->opcode >> 5) & 0x7F;
> > +    /*
> > +     * LEV is a 7-bit field, but the top 6 bits are treated as a reser=
ved
> > +     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but tha=
t is
> > +     * for Ultravisor which TCG does not support, so just ignore the t=
op 6.
> > +     */
> > +    lev =3D (ctx->opcode >> 5) & 0x1;
>
> should this change be applied to gen_scv() defined next to it as well ?

No. scv uses all LEV bits.

Thanks,
Nick

>
> Otherwise,
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> >       gen_exception_err(ctx, POWERPC_SYSCALL, lev);
> >   }
> >  =20



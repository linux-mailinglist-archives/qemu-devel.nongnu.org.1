Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A87D6226
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvY1r-0006sb-Ta; Wed, 25 Oct 2023 03:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qvY1m-0006rG-IL; Wed, 25 Oct 2023 03:10:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qvY1k-0001Jo-OD; Wed, 25 Oct 2023 03:10:06 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso4260525ad.1; 
 Wed, 25 Oct 2023 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698217802; x=1698822602; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QEHIme7JyEIrmSSVHKta4oCyhy8pOhWsd3pOrcrgBss=;
 b=U9Lepn6ueDN54y5LTOmr4sFehnqZtZxkbrXBZ35GKR7gxQ8mmZdZU2lvH7/JKEYpa9
 m/kjfhw+SaCdBTz5d+pUu8hAIu0p8gB50v/yBD6JnjPVUiwZVEV0GU4P7aThQRqFInZ6
 dEbav8yexOEzBXyZbNfDx+P+Em6bPGMPfqKpSmDUj4/W3Wq0K9e6HMnoRqKpp9+e2lHk
 MaOuQfkV3CFCo2rm2cpfc9HYRJewrrFAM9mStGbzQTXB32TPiGBZVOyyw288ZQMEZJ43
 gUA2b1xxBrM1l2pdY2p+NcZiKrydWUAKMEtxlRADR93DqlLIe1DwuPDsmwNOI8f74gzj
 jZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698217802; x=1698822602;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QEHIme7JyEIrmSSVHKta4oCyhy8pOhWsd3pOrcrgBss=;
 b=RhNDlH9XaItXMqRq+KfvWo+5jNG9E2mgXUXDOcsUGTmpBsKYdD2apYbNjm8UVJ5it9
 qzU3N0vvsnUhLDA+Mx3J53SjQpf/HhrWVr4zKsPPJFoCwbP3UtumqUxKiHbXHxL9b0FC
 ySFEnTxbb+u2USgZyi7mMWeULvxhmQS3JdpjdFv5VQ3xqfVbPpc4k8rtEcv/hxQgAHaG
 29xkAdeA2BwLnH6/s5NNEKKQlLEKB6Vd2lPcP+52gIB1M7Z7WcVz25SHjV8oepOQVF6b
 OwCcyfcsHvb5MS4BTEUkjhZn7sJiKOSM7A1uG5kLzdwcolUnOCxmzEs9hcp9fc3s1T+2
 JE4w==
X-Gm-Message-State: AOJu0YyHji8SiFAsi8sRPZH2mOmB7dBTMN+WHmovVj7FN6t0Bz9Fk3Xr
 Fjj4lKHMuJ9SaeFRFScsvFM=
X-Google-Smtp-Source: AGHT+IHZSF+b3+KWregwD7t0jvR2aSoxsvZgLkBtx4ICsGVko0lYdZYmf0ojFJshKpjaOKKrsc5FWg==
X-Received: by 2002:a17:902:ea07:b0:1c9:f6df:8a88 with SMTP id
 s7-20020a170902ea0700b001c9f6df8a88mr27929036plg.26.1698217802554; 
 Wed, 25 Oct 2023 00:10:02 -0700 (PDT)
Received: from localhost (193-116-88-234.tpgi.com.au. [193.116.88.234])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a63e40d000000b0059d219cb359sm8263799pgi.9.2023.10.25.00.09.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 00:10:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Oct 2023 17:09:55 +1000
Message-Id: <CWHBYSZE3X91.1YCI4JXJ3H2SE@wheely>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [RFC PATCH 9/9] target/ppc: Use tcg_gen_sextract_tl
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-10-philmd@linaro.org>
 <b9d9c1a0-5b20-4d33-aaf2-f12097122004@linaro.org>
In-Reply-To: <b9d9c1a0-5b20-4d33-aaf2-f12097122004@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Tue Oct 24, 2023 at 11:04 AM AEST, Richard Henderson wrote:
> On 10/23/23 09:09, Philippe Mathieu-Daud=C3=A9 wrote:
> > Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> > RFC: Please double-check 32/64 & bits
> > ---
> >   target/ppc/translate.c | 22 ++++------------------
> >   1 file changed, 4 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > index c6e1f7c2ca..1370db9bd5 100644
> > --- a/target/ppc/translate.c
> > +++ b/target/ppc/translate.c
> > @@ -2892,13 +2892,7 @@ static void gen_slw(DisasContext *ctx)
> >  =20
> >       t0 =3D tcg_temp_new();
> >       /* AND rS with a mask that is 0 when rB >=3D 0x20 */
> > -#if defined(TARGET_PPC64)
> > -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x3a);
> > -    tcg_gen_sari_tl(t0, t0, 0x3f);
> > -#else
> > -    tcg_gen_shli_tl(t0, cpu_gpr[rB(ctx->opcode)], 0x1a);
> > -    tcg_gen_sari_tl(t0, t0, 0x1f);
> > -#endif
> > +    tcg_gen_sextract_tl(t0, cpu_gpr[rB(ctx->opcode)], 5, 1);
> >       tcg_gen_andc_tl(t0, cpu_gpr[rS(ctx->opcode)], t0);
>
> Patch looks correct as is, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
>
> However:
> I'd be tempted to use and+movcond instead of sext+andc.

That would be simpler / more mechnical following of specification
in the ISA. Might be better to save that for a later patch though.
Any downsides for backend generation? On host without cmov?

> Also there is a special case of 32-bit shifts with 64-bit shift count on =
ppc64.
>
> #ifdef TARGET_PPC64
>      tcg_gen_andi_tl(t0, rb, 0x3f);
> #else
>      tcg_gen_andi_tl(t0, rb, 0x1f);
>      tcg_gen_andi_tl(t1, rb, 0x20);
>      tcg_gen_movcond_tl(TCG_COND_NE, t1, t1, zero, zero, rs);
>      rs =3D t1;
> #endif
>      tcg_gen_shl_tl(ra, rs, t0);
>      tcg_gen_ext32u_tl(ra, ra);
>
>
> It also makes me wonder about adding some TCGCond for bit-test so that th=
is could be
>
>      tcg_gen_movcond_tl(TCG_COND_TSTNE, t1, rb, 0x20, 0, 0, rs);
>
> and make use of the "test" vs "cmp" instructions on most hosts, but espec=
ially x86.

Might be useful.

Thanks,
Nick



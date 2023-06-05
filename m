Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236E7228C9
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BBV-0008A7-Hg; Mon, 05 Jun 2023 10:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q6BBT-00089p-Bd
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:27:47 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rehn@rivosinc.com>) id 1q6BBR-0001fY-Q3
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:27:47 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f61b45ee0dso2563274e87.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1685975264; x=1688567264; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uQt4JqGqmnfDbu4GCu3cignamVALqm0l4BFap+YQLOE=;
 b=GjVN0GSh0wPAsS13nit/hoqp8TmbEAhG++q0JvFg4QOkwy52nN342m3bh7z6HC2sXY
 3XLyym/YI1ps3Wm/r9CMZEkYxttACdX9N6WCqS05Gc1D1rSWK0cGvNPhPvPlOtZ5CBKe
 OWdVLfNquA9nUkWvGx+FSJV0AY5zxkcX+Uh5VbXlhOLvkBFTGRMMWolxN2MvczU5fVZD
 T0P/d9XFaLb+itFlgZs4Cg+rltT0PH0uJtMGb5XAB+voRBGJPgDyRQlOvFpc6NPPzNR5
 6+d78GCnYA2iKAeNhUibirpUYvANsmIA1QYH373jQPom+CrR/Gv1HMLdytqcUzHsTzfG
 GfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685975264; x=1688567264;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uQt4JqGqmnfDbu4GCu3cignamVALqm0l4BFap+YQLOE=;
 b=DorMgH+OdKXP9u6ZzAoqYw2O0tgUSW1TXgtn+HZ85D3jDVyRWB2WGe9OY1k0T0PIbi
 yjJhL5ea8qty0SEAItdFtQVoJE1aVAZTKM+jdr5BM4+FlwNP+dO/QwDj/dir7Lgq3AXY
 Kl59dEpOazCKDhudUSHHJJSHdyl5ToCo3vm9u8cDEnNkEEazWM45TAw9uVbj+Yca3pxo
 BP9swMxzKKosVpuE3bo7Yw7C3WImQFhuAYo9zM5roVeNKFl97pyADhrRUyVJLpinrht3
 MfzJ69O2U9M8wbc5VJZ/a3Rv3tytg8Fu/ep74KlxfpnuqhR3k8RLW8xlL8B8hhKHXpxU
 XoUQ==
X-Gm-Message-State: AC+VfDzNekynmlwCmOo8jeNlmG2OeTfFS/X7GX10v02lXBx25dRQ5v6Z
 6v+quhJt/CD9I3VJ5d42cXWXcsdIZNICCm2j52moOA==
X-Google-Smtp-Source: ACHHUZ4jVBszXwYZxRpqmW8jDtcFr7EE+qioytQnR/40Oshtt05V7vdJitExm25u2cDxXu+MH/bGcw==
X-Received: by 2002:ac2:596f:0:b0:4f1:47be:8db6 with SMTP id
 h15-20020ac2596f000000b004f147be8db6mr4919846lfp.56.1685975264158; 
 Mon, 05 Jun 2023 07:27:44 -0700 (PDT)
Received: from [192.168.50.45] (h-155-4-92-80.A980.priv.bahnhof.se.
 [155.4.92.80]) by smtp.gmail.com with ESMTPSA id
 b30-20020ac25e9e000000b004f6150e089dsm1087279lfq.289.2023.06.05.07.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 07:27:43 -0700 (PDT)
Message-ID: <9d8f020964f8b8481ee3c54efd9e1316734b030a.camel@rivosinc.com>
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
From: Robbin Ehn <rehn@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, Andrew Jones
 <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-riscv@nongnu.org
Date: Mon, 05 Jun 2023 16:27:42 +0200
In-Reply-To: <42a13e2c-7fef-a2a4-3ef6-d0ca0c0bdd6e@linaro.org>
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
 <20230602-86a3d8d9fad1fb3464d28702@orel>
 <024ee92f725f4ffd2952f472861ba9b415f4cde3.camel@rivosinc.com>
 <20230602-6e13ca96e3e8064c96abf9bf@orel>
 <42a13e2c-7fef-a2a4-3ef6-d0ca0c0bdd6e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=rehn@rivosinc.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 2023-06-02 at 20:00 -0700, Richard Henderson wrote:
> On 6/2/23 08:07, Andrew Jones wrote:
> > On Fri, Jun 02, 2023 at 04:39:20PM +0200, Robbin Ehn wrote:
> > > On Fri, 2023-06-02 at 16:02 +0200, Andrew Jones wrote:
> > > > On Fri, Jun 02, 2023 at 11:41:11AM +0200, Robbin Ehn wrote:
> > ...
> > > > > +#if defined(TARGET_RISCV)
> > > > > +    case TARGET_NR_riscv_hwprobe:
> > > > > +        {
> > > >=20
> > > > The { goes under the c of case, which will shift all the below four=
 spaces
> > > > left as well.
> > >=20
> > > This was an attempt to blend in, i.e. same style as the preceding cas=
e.
> > > I'll change, thanks.
> >=20
> > Hmm, I see. This function does have many cases with the indented format=
,
> > but not all of them, and the rest of the code base doesn't indent. I wo=
n't
> > insist on changing this, as long as checkpatch isn't complaining.
>=20
> Splitting the entire thing out to a helper function is even cleaner.
> We have lots of those, but certainly not universal.

This was my initial reaction, even move something out of this file.
Yes I'll put it in a helper.

Thank you!

/Robbin

>=20
> I have, from time to time, tried to clean all of this up, but no one want=
ed to look at a=20
> 100+ RFC patch set which only scratched the surface.
>=20
>=20
> r~
>=20



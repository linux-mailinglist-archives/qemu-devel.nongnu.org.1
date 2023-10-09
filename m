Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938067BEA38
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 21:00:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvUB-0007RM-BT; Mon, 09 Oct 2023 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qpvU5-0007R7-9w
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 15:00:05 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qpvU3-0003fg-3E
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 15:00:05 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3528bc102adso18708795ab.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696877997; x=1697482797; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=V9rfMQWcblwUB1eURUHn2a43Owaw14w8a2AufeEwUhY=;
 b=Zpu8VoMJpVhC2r4zoqhVokyF87wGHcXA5izBGH6weHututiAJo7N31OaGxZQgXRw7J
 4K+ODt1ldovK5rzrhrI/s76JXnHkLpFcxjLvVVwXOE5X6m+ISfrshPw6xeQc+4PaYaTR
 7pHsmGfFR4szD/9o2PWoh0E6Mo9yWhvR69ARpxEoLs4gkBhenWicf+T8/RleKUVv+Nny
 CsA5SUeETzln4oV8LZGV+Ek0ADnaqQdkSK+c5kVFT4i0QQn2ZiI+gNphGvBGCHbVhRJK
 yTbnnmQWLiFufbmXXI0hANgMeN2IMnG/BbILEP3p3oxxIdvwFAvSAQ5fRqBS8FbPdAE8
 p2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696877997; x=1697482797;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V9rfMQWcblwUB1eURUHn2a43Owaw14w8a2AufeEwUhY=;
 b=IVOlZnsjmEeoXw9v6sffJgoGyvHf2e3wE2rQzq9LCt/3F0/KFJBC52nfX7Jx+QfvSA
 vwImol7xWvToxLtQ5AIjhZR+E3Z/cFf13XowAMrztHVy9lh4NKt+0LvDi7msbXye5vdA
 mSG0ocGuT8mHHqbItElmsxEUw/xRQ6nWJBmdbzyhqjfDi5C7BT4lYGjCoiPBXsLpL79h
 4jlDsV7rOUBkM2WajYA3EfNZsXTs7+6aIeIp0pGdNbCN/OXqcjmtCGRa7tZrmMsnrid7
 tIPLv80MJTi7+Ho1I/X8aWgU3lwKBSzu2QJqBELp+XFVAlAcGCXctIvvDS4XSjBRB2OD
 Qtrw==
X-Gm-Message-State: AOJu0YxeAMU/x+6e27iquZ2pftsaDr2PwrwbIDt8eEp6+rLds30DfMwB
 BbhCijUhBpLWE0hDNCYLNkQ=
X-Google-Smtp-Source: AGHT+IEkSx4hcLia5GPL5Jcxlq9aSYNgVThWq7TvgT0+F+xq5PeMh3BBgXRmg97yhxb6cOUyohUk5w==
X-Received: by 2002:a05:6e02:e0c:b0:351:1d53:c789 with SMTP id
 a12-20020a056e020e0c00b003511d53c789mr15863863ilk.8.1696877997448; 
 Mon, 09 Oct 2023 11:59:57 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:582b:6312:c6b:a6f0])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a028816000000b004301f422fbdsm2239411jai.178.2023.10.09.11.59.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Oct 2023 11:59:55 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <armbru@redhat.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <peter.maydell@linaro.org>,
 "'Matheus Bernardino \(QUIC\)'" <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>, <ale@rev.ng>, <anjo@rev.ng>,
 "'Marco Liebel \(QUIC\)'" <quic_mliebel@quicinc.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <316e01d9f86e$401f62b0$c05e2810$@gmail.com>
 <SN6PR02MB42059CEC773018D164164A86B8CFA@SN6PR02MB4205.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB42059CEC773018D164164A86B8CFA@SN6PR02MB4205.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Date: Mon, 9 Oct 2023 12:59:53 -0600
Message-ID: <05d501d9fae2$ca7553e0$5f5ffba0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJv0F5Exw0TPnXaZfUwlO9P/EDe8gDs17xJAQAzRToBfYS0vq76z8dA
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::135;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x135.google.com
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Sunday, October 8, 2023 7:50 AM
> To: ltaylorsimpson@gmail.com; qemu-devel@nongnu.org
> Cc: armbru@redhat.com; richard.henderson@linaro.org; =
philmd@linaro.org;
> peter.maydell@linaro.org; Matheus Bernardino (QUIC)
> <quic_mathbern@quicinc.com>; stefanha@redhat.com; ale@rev.ng;
> anjo@rev.ng; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
>=20
>=20
>=20
> > -----Original Message-----
> > From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> > Sent: Friday, October 6, 2023 11:01 AM
> > To: Brian Cain <bcain@quicinc.com>; qemu-devel@nongnu.org
> > Cc: armbru@redhat.com; richard.henderson@linaro.org;
> > philmd@linaro.org; peter.maydell@linaro.org; Matheus Bernardino =
(QUIC)
> > <quic_mathbern@quicinc.com>; stefanha@redhat.com; ale@rev.ng;
> > anjo@rev.ng; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>
> > Subject: RE: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
> >
> > WARNING: This email originated from outside of Qualcomm. Please be
> > wary of any links or attachments, and do not enable macros.
> >
> > > -----Original Message-----
> > > From: Brian Cain <bcain@quicinc.com>
> > > Sent: Thursday, October 5, 2023 4:22 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: bcain@quicinc.com; armbru@redhat.com;
> > > richard.henderson@linaro.org; philmd@linaro.org;
> > > peter.maydell@linaro.org; quic_mathbern@quicinc.com;
> > > stefanha@redhat.com; ale@rev.ng; anjo@rev.ng;
> > > quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com
> > > Subject: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
> > >
> > > The typedef `vaddr` is shadowed by `vaddr` identifiers, so we =
rename
> > > the identifiers to avoid shadowing the type name.
> > >
> > > The global `cpu_env` is shadowed by local `cpu_env` arguments, so =
we
> > > rename the function arguments to avoid shadowing the global.
> > >
> > > Signed-off-by: Brian Cain <bcain@quicinc.com>
> > > ---
> > >  target/hexagon/genptr.c                 | 56 =
++++++++++++-------------
> > >  target/hexagon/genptr.h                 | 18 ++++----
> > >  target/hexagon/mmvec/system_ext_mmvec.c |  4 +-
> > > target/hexagon/mmvec/system_ext_mmvec.h |  2 +-
> > >  target/hexagon/op_helper.c              |  4 +-
> > >  5 files changed, 42 insertions(+), 42 deletions(-)
> > >
> > > diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c =
index
> > > 217bc7bb5a..11377ac92b 100644
> > > --- a/target/hexagon/genptr.c
> > > +++ b/target/hexagon/genptr.c
> > > @@ -334,28 +334,28 @@ void gen_set_byte_i64(int N, TCGv_i64 =
result,
> > TCGv
> > > src)
> > >      tcg_gen_deposit_i64(result, result, src64, N * 8, 8);  }
> > >
> > > -static inline void gen_load_locked4u(TCGv dest, TCGv vaddr, int
> > > mem_index)
> > > +static inline void gen_load_locked4u(TCGv dest, TCGv v_addr, int
> > > +mem_index)
> >
> > I'd recommend moving both the type and the arg name to the new line,
> > also indent the new line.
> > static inline void gen_load_locked4u(TCGv dest, TCGv v_addr,
> >                                                                   =
int
> > mem_index)
> >
> >
> I could be mistaken but AFAICT none of these lines are wrapped in the =
way
> they're quoted above  in my patch (nor the baseline).  I don't think =
any of
> these lines exceed 80 columns, so they shouldn't need wrapping, =
either.
>=20
> I double checked how it's displayed at the archive
> https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01667.html to
> make sure that it wasn't a misconfiguration of my mailer.  For another
> perspective - refer to the commit used to create this patch:
> https://github.com/quic/qemu/commit/7f20565d403d16337ab6d69ee663121
> a3eef71e6
>=20
> Is your review comment that "these lines should be wrapped and when =
you
> do, make sure you do it like this"?  Or "if you are going to wrap =
them, wrap
> them like this"?  Or something else?

Yes.  It looked like some adding the v_ would sometimes put the line =
over the 80 character size.
If so, wrap them as described.  If not, no wrapping is needed.


>=20
> > Otherwise,
> > Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> >




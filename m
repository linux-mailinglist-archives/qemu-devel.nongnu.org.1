Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7687917C8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9JF-0008B1-K0; Mon, 04 Sep 2023 09:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qd9JD-0008AX-P3; Mon, 04 Sep 2023 09:08:03 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qd9JB-0004vz-A5; Mon, 04 Sep 2023 09:08:03 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso564602a12.3; 
 Mon, 04 Sep 2023 06:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693832879; x=1694437679; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DS4WjEmTOj6qfK8KWbdFHoAuX3YHHp1qmmf1Ie6+ojw=;
 b=Zrw8Y3jFzcd9uCSLbEsflNV0Ugq1QtAmTS2EZOI0odTzthumW0jCwldp03PxHcPuEb
 gp8xVpEAnF1kBfmu9cfqq6RhoxYw6OcA4E8/zy2bzmLRwlpkzebt7FznHyk256Buial0
 +XaoqsNcOpMrHsUa8x8ZDFvFuLHIKZ8mU6t5XFVM+7rLe8DG3aKs3kQGpcWeguD0DBCK
 bEnueod7hzabDPCQIue6CKlarx2isaf7GhgPKe3tJjXbdWEgVhk93FPgFDgSZXE2Afs7
 7/t+4tCKIzn6m+yEZRHMl3FqX1ZRgsGySYbjw+VuoUBgdysdxl2sQtwLPaoh3UWMO2+C
 A1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693832879; x=1694437679;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DS4WjEmTOj6qfK8KWbdFHoAuX3YHHp1qmmf1Ie6+ojw=;
 b=RbhrO8C3cvpx+Puu56uIkpsq8hcttoTdij2XWAO1IQ5ByM34AkgmRz7FrYKoETTloq
 Y9y1GyG2hCC3S11KogcuiW2W6ZXhORfe6FtBW3ARkuXd+6e/Xn9INsEh9Vl160HaiOlN
 oTqS3tGB6aSZ2hglbonw5VrWOvi+bqfiNthddHPfwzI436Vl3SlvwXLtpOKPmeqJfjQy
 r7CO9VyDJ5chiMVIADydgEwN3LR/pVdfZ7JUv6Nd8Yo/sPsH5nvV1SeD/P0a8niKbMeE
 U/wxjMQwQFCbJbGpNSQ8/d4zkV9+p4is/zDfZaHZhoBkefw8u1GKiMxyFsDy++22FGHD
 wv6g==
X-Gm-Message-State: AOJu0YwYHoSujiP9n43Z8eZWWvH2rtQSL62k8C29j/1/71ag1eVlKDTJ
 FUqy5ldlEjybF/E3xhGMXLw=
X-Google-Smtp-Source: AGHT+IGkYhqLfY8XmGpjNjBbcjcoZs5V0e92FPIqs/j0Me/DCdpTvKBC3S+RWPNP254STivwl7CdPQ==
X-Received: by 2002:a05:6a20:9786:b0:14d:e075:fc5d with SMTP id
 hx6-20020a056a20978600b0014de075fc5dmr7471272pzc.40.1693832878926; 
 Mon, 04 Sep 2023 06:07:58 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 15-20020aa7914f000000b0068bc2432ee2sm7294443pfi.51.2023.09.04.06.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 06:07:58 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Sep 2023 23:07:51 +1000
Message-Id: <CVA5N2UCW62Q.1XROBBZ9RWCER@wheely>
Cc: "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: Re: [PATCH v2 05/19] host-utils: Add muldiv64_round_up
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-6-npiggin@gmail.com>
 <ef43cbed-ac93-4be1-2a0a-54ffb608871a@kaod.org>
 <52695ffb-9294-f6ad-85e2-da4c3841682b@linaro.org>
In-Reply-To: <52695ffb-9294-f6ad-85e2-da4c3841682b@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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

On Sat Sep 2, 2023 at 3:02 AM AEST, Richard Henderson wrote:
> On 9/1/23 04:51, C=C3=A9dric Le Goater wrote:
> > Adding more reviewers since this patch is modifying a common service.
> >=20
> > Thanks,
> >=20
> > C.
> >=20
> >=20
> > On 8/8/23 06:19, Nicholas Piggin wrote:
> >> This will be used for converting time intervals in different base unit=
s
> >> to host units, for the purpose of scheduling timers to emulate target
> >> timers. Timers typically must not fire before their requested expiry
> >> time but may fire some time afterward, so rounding up is the right way
> >> to implement these.
> >>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >> =C2=A0 include/qemu/host-utils.h | 21 ++++++++++++++++++++-
> >> =C2=A0 1 file changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> >> index 011618373e..e2a50a567f 100644
> >> --- a/include/qemu/host-utils.h
> >> +++ b/include/qemu/host-utils.h
> >> @@ -56,6 +56,11 @@ static inline uint64_t muldiv64(uint64_t a, uint32_=
t b, uint32_t c)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (__int128_t)a * b / c;
> >> =C2=A0 }
> >> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint=
32_t c)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 return ((__int128_t)a * b + c - 1) / c;
> >> +}
> >> +
> >> =C2=A0 static inline uint64_t divu128(uint64_t *plow, uint64_t *phigh,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t divisor)
> >> =C2=A0 {
> >> @@ -83,7 +88,8 @@ void mulu64(uint64_t *plow, uint64_t *phigh, uint64_=
t a, uint64_t b);
> >> =C2=A0 uint64_t divu128(uint64_t *plow, uint64_t *phigh, uint64_t divi=
sor);
> >> =C2=A0 int64_t divs128(uint64_t *plow, int64_t *phigh, int64_t divisor=
);
> >> -static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> >> +static inline uint64_t __muldiv64(uint64_t a, uint32_t b, uint32_t c,
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool round_up)
>
> Perhaps better avoiding the reserved name: muldiv64_internal?

Thanks, that would be okay. Or could be muldiv64_rounding?

>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
>
> r~
>
>
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ll;
> >> @@ -99,12 +105,25 @@ static inline uint64_t muldiv64(uint64_t a, uint3=
2_t b, uint32_t c)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u.ll =3D a;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rl =3D (uint64_t)u.l.low * (uint64_t)b;
> >> +=C2=A0=C2=A0=C2=A0 if (round_up) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rl +=3D c - 1;
> >> +=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rh =3D (uint64_t)u.l.high * (uint64_t)b=
;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rh +=3D (rl >> 32);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res.l.high =3D rh / c;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res.l.low =3D (((rh % c) << 32) + (rl &=
 0xffffffff)) / c;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return res.ll;
> >> =C2=A0 }
> >> +
> >> +static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 return __muldiv64(a, b, c, false);
> >> +}
> >> +
> >> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, uint=
32_t c)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 return __muldiv64(a, b, c, true);
> >> +}
> >> =C2=A0 #endif
> >> =C2=A0 /**
> >=20
> >=20



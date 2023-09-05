Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EB792040
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 05:57:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdNB5-00048j-W7; Mon, 04 Sep 2023 23:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qdNB4-00048D-8Q; Mon, 04 Sep 2023 23:56:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qdNB2-0008Fn-00; Mon, 04 Sep 2023 23:56:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so15537235ad.3; 
 Mon, 04 Sep 2023 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693886190; x=1694490990; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zd/3S2fDc+7LTfUH8eghxdMw0uNg3ey+z/255BtBqw4=;
 b=ZlTch/W3pXm+L7h3ogTzvsf3XKUO45Lx7dSQtoL84Rcs2VKHgNumTXck3CGBRbY32A
 aiwYSC/29SghZDrRYJn23VbScKusiNRXjeBCM2jHRsUK56E8R4Ff9TxWPXf86owV5G0R
 ahF/jFSJSW9CKndH4x0FTsPO9E/tN1LC5wuPtUajByQ4PzEGqy79/EHI62x9J3mg+2G+
 sf1gTJONc3AAsD3u3WMdLW0dH8LXuET8VR9RV6cGTTAx6aRTIDxF0i0Z4vK7UduoVnhW
 Y6MjX5uJyvo2fq0UcZQv2tRE0BSB1vDPW2FWGU1nrBoqKHIhYyzx/lZBE/TcPAU11mw2
 ed/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693886190; x=1694490990;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Zd/3S2fDc+7LTfUH8eghxdMw0uNg3ey+z/255BtBqw4=;
 b=FQYgaeQBIA6b7AZdFAoufaLasxLTlQJGuC7Ezi3TEG8f/1fuMaRyoAAm810Yp041LJ
 xERFUA2PWCvovySCW/PxQVkcW16LSWpME4gQfO8PWuHPvfX48UhrBEYJ7RchbbT063X8
 /o9IKtgK8PR0OG/X2yfl57ZOdu7dBeavb/X7Xu6dzFNfMZsHHsTjiTQt+SP5qqBOJj+e
 cs+IgRxi6+TThxYf97v5VUmSfuWcwgn+xXmIbJbIADNyODfkobMZ97i8KrPpvb7RboZj
 Z5b4e+/8pSUbh3FCYSGk9WblJT0n9RHDwBg1wyZAQozxQh9X3j41xJHOHyD968VQ7L9G
 3MCg==
X-Gm-Message-State: AOJu0YyyCrt4d2gyTXeebMcLvdql7eN3dxIgqX4TLScNlPMMGLxlgCfA
 B8wBLBiLfHLe/Divvm9Ugt8=
X-Google-Smtp-Source: AGHT+IFcKUKoO+nba/ZLYL8aFQ10GgEpsEGpSNCfvpLhMAr/gVJ20RT90JO/1kLWEmq/1yQQ055SBQ==
X-Received: by 2002:a17:902:6b8b:b0:1bb:9b48:ea94 with SMTP id
 p11-20020a1709026b8b00b001bb9b48ea94mr12127598plk.32.1693886189999; 
 Mon, 04 Sep 2023 20:56:29 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a170902ee1300b001b9d8688956sm8242344plb.144.2023.09.04.20.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 20:56:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Sep 2023 13:56:23 +1000
Message-Id: <CVAOJDUN9ZX3.1WW9S8M3AWBQY@wheely>
Cc: "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz"
 <groug@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Paolo Bonzini"
 <pbonzini@redhat.com>, <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: Re: [PATCH v2 05/19] host-utils: Add muldiv64_round_up
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230808042001.411094-1-npiggin@gmail.com>
 <20230808042001.411094-6-npiggin@gmail.com>
 <ef43cbed-ac93-4be1-2a0a-54ffb608871a@kaod.org>
 <52695ffb-9294-f6ad-85e2-da4c3841682b@linaro.org>
 <CVA5N2UCW62Q.1XROBBZ9RWCER@wheely>
 <e32cdddb-8455-7bae-3280-4ab7d33d4a57@kaod.org>
In-Reply-To: <e32cdddb-8455-7bae-3280-4ab7d33d4a57@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Mon Sep 4, 2023 at 11:30 PM AEST, C=C3=A9dric Le Goater wrote:
> On 9/4/23 15:07, Nicholas Piggin wrote:
> > On Sat Sep 2, 2023 at 3:02 AM AEST, Richard Henderson wrote:
> >> On 9/1/23 04:51, C=C3=A9dric Le Goater wrote:
> >>> Adding more reviewers since this patch is modifying a common service.
> >>>
> >>> Thanks,
> >>>
> >>> C.
> >>>
> >>>
> >>> On 8/8/23 06:19, Nicholas Piggin wrote:
> >>>> This will be used for converting time intervals in different base un=
its
> >>>> to host units, for the purpose of scheduling timers to emulate targe=
t
> >>>> timers. Timers typically must not fire before their requested expiry
> >>>> time but may fire some time afterward, so rounding up is the right w=
ay
> >>>> to implement these.
> >>>>
> >>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>> ---
> >>>>  =C2=A0 include/qemu/host-utils.h | 21 ++++++++++++++++++++-
> >>>>  =C2=A0 1 file changed, 20 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
> >>>> index 011618373e..e2a50a567f 100644
> >>>> --- a/include/qemu/host-utils.h
> >>>> +++ b/include/qemu/host-utils.h
> >>>> @@ -56,6 +56,11 @@ static inline uint64_t muldiv64(uint64_t a, uint3=
2_t b, uint32_t c)
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return (__int128_t)a * b / c;
> >>>>  =C2=A0 }
> >>>> +static inline uint64_t muldiv64_round_up(uint64_t a, uint32_t b, ui=
nt32_t c)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 return ((__int128_t)a * b + c - 1) / c;
> >>>> +}
> >>>> +
> >>>>  =C2=A0 static inline uint64_t divu128(uint64_t *plow, uint64_t *phi=
gh,
> >>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t divisor)
> >>>>  =C2=A0 {
> >>>> @@ -83,7 +88,8 @@ void mulu64(uint64_t *plow, uint64_t *phigh, uint6=
4_t a, uint64_t b);
> >>>>  =C2=A0 uint64_t divu128(uint64_t *plow, uint64_t *phigh, uint64_t d=
ivisor);
> >>>>  =C2=A0 int64_t divs128(uint64_t *plow, int64_t *phigh, int64_t divi=
sor);
> >>>> -static inline uint64_t muldiv64(uint64_t a, uint32_t b, uint32_t c)
> >>>> +static inline uint64_t __muldiv64(uint64_t a, uint32_t b, uint32_t =
c,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool round_up)
> >>
> >> Perhaps better avoiding the reserved name: muldiv64_internal?
> >=20
> > Thanks, that would be okay. Or could be muldiv64_rounding?
> >=20
> >>
> >> Otherwise,
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> oh, and I already sent the PR with the Rb of Richard ... :/
> Sorry about that. Can we fix it later ? Or I will respin with
> the update.
>
> Someone really ought to take over PPC. Daniel and I are real
> busy on other subsystems. Volunteers ?

I suppose I should. I could try do the next PR after this one
is merged.

Thanks,
Nick


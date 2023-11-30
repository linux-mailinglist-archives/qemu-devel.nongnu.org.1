Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB337FED7E
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 12:04:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8epK-0004Mh-La; Thu, 30 Nov 2023 06:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8epI-0004MK-G1; Thu, 30 Nov 2023 06:03:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8epG-0001TS-FR; Thu, 30 Nov 2023 06:03:24 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cfb4d28c43so7586145ad.1; 
 Thu, 30 Nov 2023 03:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701342199; x=1701946999; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CA4hMSh8baJcecNmTirTLG0Rl5oCnwlvvCUB8mNGD3E=;
 b=S/Zh80T2fiSkEI7war7hxlhIalV0p8Lhb7RgG/sKp6B8TZhxeInxpoxeaWPwTTWeZO
 JJgIyqqzHmY5kM1MXNOM+5l8OwF0hQv+hitletCeMmgkH0Af+ScgjiRb5FqnXtrQAQAj
 +KAtxEptizaEZq8nyG5Tk7HcniMEX901ZKGfhJaBCUI+rfGD+OCbyDR+xK05DMcL3pH1
 Fft7a3yXPB4mEmPh/OVj7WcEJnN+KVPhV4ClX47hC7vacTuxFqZfcTm//pnx2ZNieyPG
 xgtaxPAD/HP926hMl31GAkRgfped3S+4icEaZGwGC0Anq2Hp8QJ1nEb0uejpJIMT0eFO
 YMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701342199; x=1701946999;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CA4hMSh8baJcecNmTirTLG0Rl5oCnwlvvCUB8mNGD3E=;
 b=buFr/4Z/KjiQd53aRtYuNMB/iDj4iJVjHqtQtBGvHLPEcQeCDn6uLYVAaZs17RZHM5
 /oJVaGvdDQ1RwjHDdWXfuACAOjD8a4UI4/kJV6Stl0YsDB72cTdlHvuQVz3ugC5HDKyE
 +3iT4M8njwFWhwmAT8ukMjqf4zq/1aKtKgrXfmFW5fJ3Z358M2L2Wr7VZCb/Fub55jE0
 KdL01eQMMVyHbJHNQ9s+gJ9fTWQvxA8sALeRSKxKd1iy2GqQi3q8LtGwNu8LVfzp3xrU
 nZiGEJhM1IdNyQA4IZB5vRXRGcVpwbu3QWZoDUHwrgZpBqIDd53AKeFI9E2z8BSlcIb4
 bCCw==
X-Gm-Message-State: AOJu0YwebJshj5vrw71QVQbyjyD2/O2lzlFEePnKhQqvJMQGy0gIETjy
 oaQ7OTGzHwazN+RAfYHTwTVuyTE4NA8=
X-Google-Smtp-Source: AGHT+IGOeEcCSCr+HZbvQRqS0UvB12UTiGPbQN6tz8B5qMl3Cjc2if2TOo/dg6Bq4nGZXCJyURSJ0Q==
X-Received: by 2002:a17:903:11c8:b0:1cc:4e9f:d27 with SMTP id
 q8-20020a17090311c800b001cc4e9f0d27mr22818204plh.1.1701342198957; 
 Thu, 30 Nov 2023 03:03:18 -0800 (PST)
Received: from localhost ([124.170.16.164]) by smtp.gmail.com with ESMTPSA id
 y11-20020a170902b48b00b001cfa4178981sm1025469plr.309.2023.11.30.03.03.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 03:03:16 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Nov 2023 21:03:11 +1000
Message-Id: <CXC3H0PGQZEG.1QL49XWJNHLL6@wheely>
Subject: Re: [PATCH v3] ppc/amigaone: Allow running AmigaOS without firmware
 image
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231128013253.80524756078@zero.eik.bme.hu>
 <8df98507-3b2f-426e-ab25-f571f06c769b@kaod.org>
 <356aadfe-98d6-1b31-46e1-4d01ceedd477@eik.bme.hu>
In-Reply-To: <356aadfe-98d6-1b31-46e1-4d01ceedd477@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Thu Nov 30, 2023 at 8:49 AM AEST, BALATON Zoltan wrote:
> On Tue, 28 Nov 2023, C=C3=A9dric Le Goater wrote:
> > On 11/28/23 02:32, BALATON Zoltan wrote:
> >> The machine uses a modified U-Boot under GPL license but the sources
> >> of it are lost with only a binary available so it cannot be included
> >> in QEMU. Allow running without the firmware image which can be used
> >> when calling a boot loader directly and thus simplifying booting
> >> guests. We need a small routine that AmigaOS calls from ROM which is
> >> added in this case to allow booting AmigaOS without external firmware
> >> image.
> >>=20
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >
> > Since this is 8.2 material :
> >
> >
> > Fixes: d9656f860a38 ("hw/ppc: Add emulation of AmigaOne XE board")
>
> This has missed rc2 but I hope there still will be a pull request before=
=20
> rc3 which is the last chance now. I've sent a v4 which simpilifies the=20

Sigh, yes a few hiccups but I will send a PR with your v3 and a SLOF
update.

> inserted code as I've found there's no need to do it like in the rom as=
=20
> the only place it's called from just cares about the result.
>
> I forgot the Fixes tag again, sorry, but the one above is still the same.

That's okay I added it. I'll just keep v3 since I have done some
tests with it. If it matches the the old rom then it seems like
a good starting point anyway, can always patch it later.

Thanks,
Nick


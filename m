Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B37C7049FF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrZC-0003Pv-0l; Tue, 16 May 2023 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrZ6-00038p-2a; Tue, 16 May 2023 06:05:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrZ4-0003w7-AD; Tue, 16 May 2023 06:05:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ab0c697c2bso128389705ad.1; 
 Tue, 16 May 2023 03:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684231552; x=1686823552;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=534Rr7U7Peuv/215NzJJHJ2YBxoiUHCz406Gk4/3bRw=;
 b=q/I4lYihF1ygSflpu1+S0AzS0bOs9/Pc/hg/gN6/2wgdlrsbjI6ciLz8RL1cjU1zT4
 2NMFQM6sCoWfqT76UrV8aPpWSH4/cQu3ahHWXiqW9DKFNzeJwlLtw2l0eX2ic0CRvyZo
 S38XjC/BIIJgEmSKiaGOYQCHwaUUzi8XDYmfnDMKz+IgEyNbWq0CAsVZWyiwb7ZkbBz6
 cntGMTpAlqtNg+h8CCZNNxdI37GjFexaAghoPv8R8+h/GM30qFJU9qqyNlPU8i9Vbleo
 XSv78z4bSNb//iJHfwuY8Kot3e6PnvGODuJQMblaHQGiZevYbPUHNn7sdz8KYIrwm+8w
 mhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231552; x=1686823552;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=534Rr7U7Peuv/215NzJJHJ2YBxoiUHCz406Gk4/3bRw=;
 b=A4vh4hDanUsUvFmbbtmQJKmdQrYwo2rzutvgYYxEOl/YzHCvhWzO0gR0+IcM6HEmK8
 N50KMqgmG3rW9QjXUKokjyGWc9LZRPEnMng5Ms0ewRIJ3u2S4+5iejxym9s+Rn4S2KZM
 aEBUtVyJDA3vObITBDc/iWG4FvA24L1144khbq9OIAFQoUsPDI+kkJch3FSE0hNM5rky
 ZiZqIV1Pq/6QW6j7b1UtW5rlbveXKjGY8fe4quGt0PDLOw1XDkrsFnbxF71mcl4Z/Jh1
 HsIc7W1H1TiZLXiBc1Sw/jhNCU8ytb9QrJoh2wPDXPKfsKWn3zTxgDjdUNIXdRVTq2fJ
 aXdA==
X-Gm-Message-State: AC+VfDzqLeuzanxwRx29lJpFmvPScBoO2qVbrUV6KEHLwN6/DKt1OJPK
 RTUxZ3r3EFahavbRo5HWVlg=
X-Google-Smtp-Source: ACHHUZ6sSUiJjj46IULYIPvfAjsBPUqzVNTsXp11qnLx84rcfIxNo/n1Ee4WMD6nhP1gWEA4w5icXA==
X-Received: by 2002:a17:902:e84d:b0:1ab:eee:c609 with SMTP id
 t13-20020a170902e84d00b001ab0eeec609mr46992196plg.40.1684231552413; 
 Tue, 16 May 2023 03:05:52 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 ix10-20020a170902f80a00b001a6d4ea7301sm15061298plb.251.2023.05.16.03.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 03:05:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 20:05:45 +1000
Message-Id: <CSNM96SEYQFO.1IW8E63TQM7TS@wheely>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harsh@linux.vnet.ibm.com>
Subject: Re: [PATCH] target/ppc: Use SMT4 small core chip type in POWER9/10
 PVRs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230515160131.394562-1-npiggin@gmail.com>
 <d49a6ddd-9c45-ca3a-7573-de2d39f518ce@kaod.org>
In-Reply-To: <d49a6ddd-9c45-ca3a-7573-de2d39f518ce@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Tue May 16, 2023 at 6:44 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/15/23 18:01, Nicholas Piggin wrote:
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
>
> Will small cores POWER10 CPU be available ?

I don't know the answer to that, but even big core POWER10s need
non-standard OPAL firmware to use bare metal...

Small core is nicer for Linux to use and matches POWER9 so I did
that. In practice I don't think it will actually matter anywhere
because we don't do SMT.

Thanks,
Nick


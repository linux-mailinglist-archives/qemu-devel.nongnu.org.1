Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FE82852D
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 12:35:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNAMv-00049j-Hm; Tue, 09 Jan 2024 06:34:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNAMq-000477-1q
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 06:34:00 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNAMb-0008Ee-5t
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 06:33:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-557c188f313so2799839a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704800023; x=1705404823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/b4KmREwjS2tjnn23cKaTF/OkKLKVQt/2XYGLc5ZDMQ=;
 b=w4DW2OypxFodzOaYxSo5pDFYLYJwgPfIulpXf7+/lxQXb1+mlwvxOeDDx5vdECAfjj
 yZWnchhidOGq8iImiNXdz0XUM2HpkLRVBWMXE4rfLH+cvenSCzrvZsbsOZwkIwvl84eL
 VupYDOyi7f2fmG1ntw8+utL406dwa94Q1+iSDPtRA91Z5f3KtRYnLokki/UxAsVNWiAq
 n0MPkVngF484wYpbtYGuP6ayj73YkK0hULurEz7bwrgNPPvTA9pNODmRdsQ8sgYkhuA4
 FV8siz5PJ72KCXgAn4ImRjoWG3R98FKt5oNNA2WA5Ujcp0uusdRq72NVRhL9KaWzhw2n
 K7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704800023; x=1705404823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/b4KmREwjS2tjnn23cKaTF/OkKLKVQt/2XYGLc5ZDMQ=;
 b=jzqODoo5DmXvMOtN6JRDjbx2PFDmB7TsugKRNhC0M2U+5QSChgGBHXAY9U4jdYvLEk
 vu8NbCCBz880D0Xa977Az3yqj+tA1u5S7ggAQSmsrjT2keVTOwthk+nFkGlZXBgtHZ4D
 9d2O9w6BNCfGJJFGF9bJemlcCWEK9aTlQxPn+40Zf6nnVBjtOFYiYLtEzF/H+wusUjvy
 yGbca5WRuxO32fO4Akq9pNH5OfEcLLKBWFOF6aakwvDreF5DJ1uj2lfGdG36NG80Zw9Q
 Kt5RAmEW3ev7HbVPIkMVwZ/XjrJRD1UGHKUm7aRAm5X0tYf+x0TkVjslGwQ+5vzLH2Bl
 5ZeQ==
X-Gm-Message-State: AOJu0Yx+6+Za4+32aEbXEyGBgj/kZIUjuSJ2xqe/OS2vWzi9U34P1rob
 Dg8uvgeBjmAxHq1G7Azeg2s7F3aU8RYnGm8xc76hlW9ju8rUIsKSjREwb02c
X-Google-Smtp-Source: AGHT+IE8oRc6DfLoWjq0vL9125xJVeuid76soI4eKlvgEvaVHfY4r8AihAqHITM59YanX+JMU82hezLS26Pvh9a7jOc=
X-Received: by 2002:a50:d4d8:0:b0:554:4bb2:9a6e with SMTP id
 e24-20020a50d4d8000000b005544bb29a6emr622552edj.11.1704800023228; Tue, 09 Jan
 2024 03:33:43 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
In-Reply-To: <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 11:33:32 +0000
Message-ID: <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 8 Jan 2024 at 17:38, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 08.01.2024 20:07, Peter Maydell wrote:
> ..
> > I'm trying to figure out what kind of kernel config causes
> > this. If I do an upstream build of v6.6.9 with this config:
> > https://people.linaro.org/~peter.maydell/arm-6.6.9-config
> >
> > then it successfully probes the PCI device even with -cpu max:
>
> (with -cpu max it worked before but broke in 8.2 (after that commit).
> Without -cpu max it doesn't work for me neither before nor in 8.2.
> But ok.)
>
> Speaking of config. This is standard debian config, I'm attaching one
> to this email.  It can be found in the package, eg
> http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.6.9-armmp_6.6.9-1_armhf.deb
> in /boot/config-$(uname -r).

It does seem to be a config thing -- on a plain upstream
v6.6.9 my config works and that debian default one does
not. Now to try to identify which particular config
difference is at fault. (It's not the CONFIG_VMSPLIT one,
I just tried that.)

thanks
-- PMM


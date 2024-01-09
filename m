Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C6828771
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:53:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCWy-0000uG-8s; Tue, 09 Jan 2024 08:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNCWq-0000t6-6E
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:52:30 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNCWm-0001R3-3c
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:52:26 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so5291103a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704808339; x=1705413139; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WnreYP7oKVTmKN0K5yWjwkKhxfzzFqtEcKcDrhJfqZw=;
 b=O2dPyX/d2k85nDjtfew7krdIvdZqrTWf2hhg2qZWVz3eTP+KecRYuQ4tXrMevTiiV3
 wsRzOrJcqsZnLdgJ5M3WBuDDebaLT9flvxvW/YxpIhszuO8moieny0NQG94ZBj8kLiil
 67oPij7fWm8YwjmDRf4PjH0AgI7wFX9k/bRVXEMorPHDObrMS/c1g7Y2aaFAOx9N3MGr
 X6fBYKq2dnFbNj0fVozoriUYH5MuaAMNY34JXbuohetQ55fDdclrO7Gq0Xwfort4ipff
 u9lp4hFOT/7PTqmV6QqYgoO2HE8VgaRhImUaT60qeSHxD+DYorpY5dC+1OuVq+VR5uzt
 R9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704808339; x=1705413139;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnreYP7oKVTmKN0K5yWjwkKhxfzzFqtEcKcDrhJfqZw=;
 b=GG5FuM8Dk9JkJ7G8Wfjqi/mQX9S3/K0Vlvyq7O7kucxxFwBxDsRLg6c4GYacMOf4cF
 MFgejyEaN2fbsKpufhsPBsLtgCRrs0p5SCkvQjaP8BUW9AKjuu71ResbpYXD1OVH3GAj
 VUiqYMQVnIj4VIAP3SQE3ZWme5fbBm6RLyNlya62ytSAOj2BPdWcBt3PyZCyKlaGWMkn
 5i03JmQ/FG+qU5FWt+rKfcdY3L6PK3qdRcLhsfYEzXJMVuPUAOnB+VNMvJVA15+TuQDe
 muqqoV3YMnNDuIjS/M2fKdzDGGN8T77Vaa4bg5TtGGbB4NZOg6D1rIPmj+EdfZCYLJ9F
 XCIQ==
X-Gm-Message-State: AOJu0YxJWBznx0HvwaVcXXNne4+F5wOx9ri6+MIRAI7dHdGTja+GnT54
 BFYW6P5AZE68464Qqpm8hU6TQtLlJOugUCKug00FeSJ6H0xkNw==
X-Google-Smtp-Source: AGHT+IEKSGCwjmcyfDMlb6+IKq213otwK17gdiZvBCUX8nwgOBr27VtXQTtEgAB6Cds8blo+lp98oGnIWOev9IW1p6s=
X-Received: by 2002:aa7:cfd8:0:b0:557:dcb0:f830 with SMTP id
 r24-20020aa7cfd8000000b00557dcb0f830mr755291edy.1.1704808339227; Tue, 09 Jan
 2024 05:52:19 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
 <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
In-Reply-To: <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 13:52:07 +0000
Message-ID: <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 9 Jan 2024 at 11:33, Peter Maydell <peter.maydell@linaro.org> wrote:
> On Mon, 8 Jan 2024 at 17:38, Michael Tokarev <mjt@tls.msk.ru> wrote:
> > Speaking of config. This is standard debian config, I'm attaching one
> > to this email.  It can be found in the package, eg
> > http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.6.9-armmp_6.6.9-1_armhf.deb
> > in /boot/config-$(uname -r).
>
> It does seem to be a config thing -- on a plain upstream
> v6.6.9 my config works and that debian default one does
> not. Now to try to identify which particular config
> difference is at fault. (It's not the CONFIG_VMSPLIT one,
> I just tried that.)

Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
set). That will obviously never be able to access registers
above the 4GB mark (though the kernel's error message in this
situation is a bit unhelpful and could perhaps be improved).
If I set CONFIG_LPAE on the non-working config it starts working.

I think then the answer is:
 * if you want to use the (default) highmem setup, use an LPAE kernel
 * if you want to use a non-LPAE kernel, tell QEMU to avoid
   highmem using '-machine virt,highmem=off'

It was just a bug that we were accidentally disabling highmem
for the 32-bit 'max' CPU before b8f7959f28c4f3.

The linux-image-6.6.9-armmp-lpae_6.6.9-1_armhf.deb kernel
will probably work (though I haven't tested it).

thanks
-- PMM


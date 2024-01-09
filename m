Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039718287F2
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:23:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCzM-0004An-3D; Tue, 09 Jan 2024 09:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNCzG-0004AF-NP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:21:50 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNCzC-0006qN-Tc
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:21:49 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so2276100f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704810103; x=1705414903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvAlUp0Lm7HLuy//mcmBihaQF11N47ty4kHGLomPIXs=;
 b=L9v6IE3Tsc1fE23zyDcrsAglffj1hY2sWGWQEjc3sN4SgjcefsYIGq+KsmAtISRoP1
 AYg7+KHyTrEtl8dgpEzOuV7V0vGx9J5NnQCUB/DfmyGqiF7a5SFVztOIOstxNy8xtSfO
 1IG4CsXjAsEOyDXbrtitnF+2Kkv3o2ICGsgo1+6vWOVbz/zzQ4JlK5mZ5t+M3qrFWK5U
 7jz9Gv9d/GPg4D7Hz6rLI1U+ARiTxqNTrDOadwWymcvlPjvX0zWVnLDcnLqHuLySw7Cw
 2t2do+alG9ufGIJmkDefB2qfnBBDB7R4uwgOVtpEPuzp3PUv/uT71gl0/Z2Po3JE9wNm
 MiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810103; x=1705414903;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nvAlUp0Lm7HLuy//mcmBihaQF11N47ty4kHGLomPIXs=;
 b=f3zg1w2gQtqBBkbBHI68Ifter9xdkp4AYcfIJNSoSh4p0z2TgUc65MFRWJiuE8tT+S
 CweqPC3q4ZwPOEu9NbNHvuLvAWOxBDeYSmc6/IzqGHmQl4QnnTBENqNvtzGnnVaOhpI3
 HVfv6bmiQWUggThYN0E4U6D8pAX0X6kqIxe+9zLk5lq3U3qMxjGIn6Ih5kSTEddi4tep
 L3S5H5plHFnv45md1KJUX6gF4oSWjTX3YQ/B+eRhH5jiTADNrIrsCg/Oy/ch1s+99+JD
 LF0XzVUQn2t8JRD61O0t3cksRQanqNEkNyj+iMs6rC2BZQVX4OgXXPVjJU8Go3/77l6x
 WKpA==
X-Gm-Message-State: AOJu0Yz2Y5VftmTV+bCUelQ89ra3iLiVMZ7/VJQ/Ec2EhYofU9A7Y7h7
 4kJBezmBuF91lDhPvL/wjVQe+s1nErk1upjOwguWn6atZbM=
X-Google-Smtp-Source: AGHT+IGxjwoWPcjaWaDICZzxWc/g0Aw+R3RZkGW5kh9/Z661Eudc4AlJqf7vOYkTI82lQfKweyYofg==
X-Received: by 2002:a05:600c:5492:b0:40d:a283:5269 with SMTP id
 iv18-20020a05600c549200b0040da2835269mr494241wmb.112.1704810103501; 
 Tue, 09 Jan 2024 06:21:43 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s13-20020a05600c384d00b0040e4a2b36bfsm5589858wmr.22.2024.01.09.06.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 06:21:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87D245F785;
 Tue,  9 Jan 2024 14:21:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
In-Reply-To: <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 9 Jan 2024 13:52:07 +0000")
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
 <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
 <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 09 Jan 2024 14:21:42 +0000
Message-ID: <87bk9uh9jd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 9 Jan 2024 at 11:33, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>> On Mon, 8 Jan 2024 at 17:38, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> > Speaking of config. This is standard debian config, I'm attaching one
>> > to this email.  It can be found in the package, eg
>> > http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.6.9-armmp=
_6.6.9-1_armhf.deb
>> > in /boot/config-$(uname -r).
>>
>> It does seem to be a config thing -- on a plain upstream
>> v6.6.9 my config works and that debian default one does
>> not. Now to try to identify which particular config
>> difference is at fault. (It's not the CONFIG_VMSPLIT one,
>> I just tried that.)
>
> Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
> set). That will obviously never be able to access registers
> above the 4GB mark (though the kernel's error message in this
> situation is a bit unhelpful and could perhaps be improved).
> If I set CONFIG_LPAE on the non-working config it starts working.
>
> I think then the answer is:
>  * if you want to use the (default) highmem setup, use an LPAE kernel
>  * if you want to use a non-LPAE kernel, tell QEMU to avoid
>    highmem using '-machine virt,highmem=3Doff'

Could we expand the "highmem" description in
https://www.qemu.org/docs/master/system/arm/virt.html to make it
clearer. I'm sure this isn't the first time there have been 32bit
difficulties with non-LPAE kernels?

>
> It was just a bug that we were accidentally disabling highmem
> for the 32-bit 'max' CPU before b8f7959f28c4f3.
>
> The linux-image-6.6.9-armmp-lpae_6.6.9-1_armhf.deb kernel
> will probably work (though I haven't tested it).
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


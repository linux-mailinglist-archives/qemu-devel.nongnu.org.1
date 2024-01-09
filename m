Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F235C8288AF
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 16:03:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDdK-0006Oc-LM; Tue, 09 Jan 2024 10:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNDdH-0006NC-Lp
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 10:03:13 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rNDdF-0000nh-31
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 10:03:10 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e4f692d06so4515945e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 07:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704812587; x=1705417387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bMCIZkhJJvpb7DyTODzhTGE3JWll8OFtAiYyBvwGmik=;
 b=b+Aes26zrtE8ilgFD4/Jeor5fulinVwt0HffC7712j7VWHV1Uw+qJjCqpKsFDKkZ2r
 IO4/BlbqQEzIUUNr5C8/cjj1L9W27NdQjWI+mtyA0XbgN+Uqr3t9NMMlCY9DvKdtzL3l
 iMEqwWFpvcV/WuzFS5/V16PKCAAjZvA6XaW5HGFojqaJpZpQR84KwBWlyWomXYI4x2hb
 cXb/Wm+8EgHvnp4mWQUN2mQvry9hnuAxVTV0wPAUTPHWpNqOLNmPDx1rU7zOia4CfaYL
 i7W4Mmfsq8v790mhddY6HEf/ioebYVGnTGGCniA44lwkWamPst3yIIW87h/air+c5X+K
 LJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704812587; x=1705417387;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bMCIZkhJJvpb7DyTODzhTGE3JWll8OFtAiYyBvwGmik=;
 b=CjgDtTMtzbLYQsFE0BLZ4kAf8g0Aimd/aBGHhYZUTzQaSh4VfTRI9DOnD7p+2vnoyn
 /SgRroCUy3HSXa9UAQPNAZCwllafiHFKbsMSXjsG0tuOsTipZI0eqOU1LZTNzebkGI49
 FrcxeH7+2+nS/gk9Zl8lZjQM/pICa91BNqWn3Ea/YKJdRQ7h+elJIH5uI3vpStUbtNer
 cV5TAW5gsQKVqz5JhTkt9xN/uPNi3VhYgizFMCDOiDzrffyvCGHh5ejwSzgj7xv52m14
 j9RRnM64mqRIUQ/hHI0E+4DjGdjPTX2AQ+wVaAJ0CKwWuf9apbbMLJDJr7axfOi3udps
 tAZA==
X-Gm-Message-State: AOJu0Yy1CodjE1tg+2BRBCw4belksYwigWL+Ws9NrRc2+G7pc1EeUzAa
 FtELB2Ih8XtU6dRUzkDknx4zpN5J3GWtUA==
X-Google-Smtp-Source: AGHT+IGLsy7eKNgCuG4w7hafs0T2A1r/89JKgtzIFTDqXG9YXodo/+FY1pz3y/RmNSPdA2A7hy/b5Q==
X-Received: by 2002:a7b:cc0d:0:b0:40d:785e:34a8 with SMTP id
 f13-20020a7bcc0d000000b0040d785e34a8mr498924wmh.65.1704812586952; 
 Tue, 09 Jan 2024 07:03:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c154900b0040e4ca7fcb4sm3795922wmg.37.2024.01.09.07.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 07:03:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2A0C45F785;
 Tue,  9 Jan 2024 15:03:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
In-Reply-To: <CAFEAcA9K2jf3BfHY3xpP4T-_iH9nNX=XLrNp=mPg5nqZURBOrw@mail.gmail.com>
 (Peter Maydell's message of "Tue, 9 Jan 2024 14:31:45 +0000")
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
 <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
 <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
 <87bk9uh9jd.fsf@draig.linaro.org>
 <CAFEAcA9K2jf3BfHY3xpP4T-_iH9nNX=XLrNp=mPg5nqZURBOrw@mail.gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 09 Jan 2024 15:03:06 +0000
Message-ID: <875y02h7md.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

> On Tue, 9 Jan 2024 at 14:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Tue, 9 Jan 2024 at 11:33, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>> >> On Mon, 8 Jan 2024 at 17:38, Michael Tokarev <mjt@tls.msk.ru> wrote:
>> >> > Speaking of config. This is standard debian config, I'm attaching o=
ne
>> >> > to this email.  It can be found in the package, eg
>> >> > http://deb.debian.org/debian/pool/main/l/linux/linux-image-6.6.9-ar=
mmp_6.6.9-1_armhf.deb
>> >> > in /boot/config-$(uname -r).
>> >>
>> >> It does seem to be a config thing -- on a plain upstream
>> >> v6.6.9 my config works and that debian default one does
>> >> not. Now to try to identify which particular config
>> >> difference is at fault. (It's not the CONFIG_VMSPLIT one,
>> >> I just tried that.)
>> >
>> > Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
>> > set). That will obviously never be able to access registers
>> > above the 4GB mark (though the kernel's error message in this
>> > situation is a bit unhelpful and could perhaps be improved).
>> > If I set CONFIG_LPAE on the non-working config it starts working.
>> >
>> > I think then the answer is:
>> >  * if you want to use the (default) highmem setup, use an LPAE kernel
>> >  * if you want to use a non-LPAE kernel, tell QEMU to avoid
>> >    highmem using '-machine virt,highmem=3Doff'
>>
>> Could we expand the "highmem" description in
>> https://www.qemu.org/docs/master/system/arm/virt.html to make it
>> clearer. I'm sure this isn't the first time there have been 32bit
>> difficulties with non-LPAE kernels?
>
> Sure. We could make the highmem property description read:
>
> # Set on/off to enable/disable placing devices and RAM in physical
> # address space above 32 bits. The default is on for machine types
> # later than virt-2.12 when the CPU supports an address space
> # bigger than 32 bits (i.e. 64-bit CPUs, and 32-bit CPUs with the
> # Large Physical Address Extension (LPAE) feature). If you want to
> # boot a 32-bit kernel which does not have CONFIG_LPAE enabled on
> # a CPU type which implements LPAE, you will need to manually set
> # this to 'off'; otherwise some devices, such as the PCI controller,
> # will not be accessible.
>
> How's that ?

LGTM and even if the users don't read it hopefully the LLMs will ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


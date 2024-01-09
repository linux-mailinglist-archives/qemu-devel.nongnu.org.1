Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F7828A2E
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:42:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFAp-0000sA-EJ; Tue, 09 Jan 2024 11:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNFAd-0000qu-EL
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:41:47 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNFAZ-0004kw-B4
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:41:41 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e7af5f618so3413326e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 08:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704818496; x=1705423296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T4gYJ9a2z6T6xGbeYuRLyHysVXA79r1YTQYdgAOJOt8=;
 b=JLNG1Ppzv7P3S0/adQ6H6z/Csl/7ZidhCZk9401k1+G8NNUVCVXYgtxHTs2nTgyDG5
 fATaGz3i0P/KR1RmXP6MAEtIpXP3Ff2qAXzZfMWHGQNcLvRDcM3cv5ZoptteI7ZukCZw
 yjNKE2mYljEOaTVIsGZYjGT3h3vJ4pUsbBrWZTd1B0Dx7OMrdTD6ZIsRITNlT82jNNzY
 CMzGervrWm8SYrW/07AyQd8hpZKacfom3DaUaez8V7VpuvoI5GFfz8iNcS9JK7z6O9no
 jjCsPDo4Uz3eZ0r5+AnvnXaAXHy37hOleyzH9byVMW6svUE8t5hiB3Vw9iljlBv84p61
 3XCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704818496; x=1705423296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T4gYJ9a2z6T6xGbeYuRLyHysVXA79r1YTQYdgAOJOt8=;
 b=SXo/V4PB+iMmaRqPXUO+paSCTRJm+3BYJIf/gW8vijm8U1Yki3+0UdP+/lqmTqk27u
 01vdCdg4F5y2W446k/bNDkyFGFD6a9yBcl5+caK9MFtFphtH4L3XZDBZUGCGgHGdZWzC
 oBjF15jtjryxjU7fDFAH6KcAEo7hP6cDQ8YLo+vzrytk+ixhMg/8uhucOlsmZzpBiqBL
 I2LQH4VwGyCY+GDgZCLDmOzPnWwqGWxu4pHMWvKNbeKCHG0euQnxVpdGqn/W6C43OHmG
 +SbqJNmlknF0w4wpaJa5LP6dvq0u6K/Wi0X5cD+EHzP7n9mCdcSFTN620ZLnUJHV/06F
 htEQ==
X-Gm-Message-State: AOJu0Yz62C73IkTuPQAAEQUTqAmDsZJAcqXEjJ3j/HRbyTbHzBGb65Jo
 /nBz43HzE2IWAE27no0x7wt0nVwO8TbtLX2sP+RnEfVMy3eKvQ==
X-Google-Smtp-Source: AGHT+IFcdLGpWb07PlQHHGlVMUJo2EkPmZ4+PtwsNeBWGiYQ23YTxVpM0fb6nfcXEZ4CHBJkC7r8DCpYEir3+NbbOO8=
X-Received: by 2002:a05:6512:45a:b0:50b:f841:c1e7 with SMTP id
 y26-20020a056512045a00b0050bf841c1e7mr2119695lfk.63.1704818495970; Tue, 09
 Jan 2024 08:41:35 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
 <CAFEAcA_wnSF-OAKNaDNjbEiMi-AXv2srJ5JjmiaT4+_wWee9aw@mail.gmail.com>
 <560c9f56-f0d8-4def-863a-63ba4226209e@tls.msk.ru>
 <CAFEAcA-hkd=VQdqw7-P1RGwu-c9JLn-NUHC1kgU-YgZ1FOMQww@mail.gmail.com>
 <CAFEAcA87qdWR-GLEjkGpGHxMhviFidi2=k7c=OFC3+hzn1P0Dw@mail.gmail.com>
 <2a34bd5d-2997-48cf-bcb8-32d97e3f7690@tls.msk.ru>
 <CAFEAcA83r12Y6d5Ba-3v1eNe1TfA9kO-PLtkots8C1SzgDNeaA@mail.gmail.com>
In-Reply-To: <CAFEAcA83r12Y6d5Ba-3v1eNe1TfA9kO-PLtkots8C1SzgDNeaA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 16:41:25 +0000
Message-ID: <CAFEAcA9ZR9DDM5Y5Ot6heH8C3aK_otKer4sz8ncddTX0K6PzvA@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Tue, 9 Jan 2024 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 9 Jan 2024 at 16:24, Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > 09.01.2024 16:52, Peter Maydell:
> > ..
> > > Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
> > > set). That will obviously never be able to access registers
> > > above the 4GB mark (though the kernel's error message in this
> > > situation is a bit unhelpful and could perhaps be improved).
> > > If I set CONFIG_LPAE on the non-working config it starts working.
> > >
> > > I think then the answer is:
> > >   * if you want to use the (default) highmem setup, use an LPAE kernel
> > >   * if you want to use a non-LPAE kernel, tell QEMU to avoid
> > >     highmem using '-machine virt,highmem=off'
> > >
> > > It was just a bug that we were accidentally disabling highmem
> > > for the 32-bit 'max' CPU before b8f7959f28c4f3.
> >
> > Wow wow wow.  So it's a pebkac bug, not qemu bug.. :)
> > I didn't even know about LPAE before this email, and knew very
> > little about arm stuff too.
> >
> > Thank you very much for your work and time!
> >
> > The diagnostics here is definitely.. "interesting", so to say, it's
> > very "obvious" what the problem is.. from the kernel messages :)
>
> Yeah. I don't personally have the time to try to follow up
> on improving the kernel handling of this, but if anybody else
> does, I think the problem is that the function __of_address_to_resource()
> which fills in a 'struct resource' from a DTB entry silently
> truncates over-large values when it fills in r->start and r->end
> (which are of type phys_addr_t, and so only 32 bits on non-LPAE
> kernels). So that function seems like a good place to put some
>
>   if (taddr or taddr + size are above 4GB) {
>       warn("resource foo is too high in the address space to use
>             (did you forget to enable CONFIG_LPAE?)\n");
>       return -EINVAL;
>   }
>
> type handling which would then catch this user error relatively
> comprehensibly for most devices.

...and the less pseudocodey version of that probably looks
like the similar check in of_pci_range_to_resource(), viz

    if (sizeof(resource_size_t) < 8) &&
        (upper_32_bits(taddr) || upper_32_bits(taddr + size)) {
        ...
    }

-- PMM


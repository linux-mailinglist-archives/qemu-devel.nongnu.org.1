Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB0828A09
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:32:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNF0t-0001nU-72; Tue, 09 Jan 2024 11:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNF0r-0001nI-5q
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:31:37 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNF0p-0007w7-EC
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:31:36 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-555e07761acso3798284a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704817893; x=1705422693; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XCFz67O30cGWCwumEtc0V6mGc2glrm95RBgOYxVSigg=;
 b=aTAwCystk4plvGi2mMKPdly63chz9MYKccrl7SAZpYXzZLt9rxSsEzQOUDldAx4Gg2
 2ECjoA0n/jQGN1r83lv5m7EJ7m/4Nn7K5TrchYUofiv/ib7VP2NCOSLM7KCwIYEnnqNS
 tLRgbFa3diWGoJKKpdsEF/CWqeRjMYQT4ske2XsMugRKchOtkPnvr+q2TjjaTn23rs/d
 d2lbsXDFOxZVxsempnqV1kOQj1wSNF7vatKbR/p42hucGNT8vNWl7EoJ5AZtf1y018iq
 aZpD1XkNPiJpfBCuc4a6tLfyJHfGUIBlNeHe0a9EiCxUKl+gDV5seO8VCQxE/JbODfDT
 scyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704817893; x=1705422693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCFz67O30cGWCwumEtc0V6mGc2glrm95RBgOYxVSigg=;
 b=r47zrPkqF7SfqiHLM1h2nT040+XFwTr7CqvF7wU1v2NU/lE8W75TWrMVzEZTL46Lby
 gQvuguKSosBQwR1XNBDgukjWYI6SUTEKWt1ToRSdV8OVXPtRx0C4AZJ6DhAJLDJlXx49
 AOWaMy+AIJbKXj3E+INGyFm2j6mao7bL+ycSj6Wfqzb0XIe8BfGq7xCY7G0S7i8qJpC5
 ldoC02aifHUQIIVPfZXBkqqLQLPvRl8WHwua2fORXvXEskNf3pm5PQpH85eszIxt0wdo
 zB7o5TQCG+bQ6dNcnnDjC8ZO/9TuilJPNQORhXjABvonOKnwqr7rIi6ndHYzAkbF5pPg
 L5PA==
X-Gm-Message-State: AOJu0Yx45pkm3LKHk3Ffv6/c2byiSTqyUoUT3FuEjimIYmdYSvoE6xME
 WBmHv5BJjypFazRqCsFMCkxkqq8kg3I5B4+mXVlCR+H8qkaW+A==
X-Google-Smtp-Source: AGHT+IFCgDvyB8118SkZGV7Fxyx0OMDjykk40thCj5YloQ4qE0hC7qjZ2kW85nXIWgNDh23aSpCwFw/S5kPZpsYXVIo=
X-Received: by 2002:a50:a444:0:b0:557:dffe:e9ba with SMTP id
 v4-20020a50a444000000b00557dffee9bamr777473edb.45.1704817893045; Tue, 09 Jan
 2024 08:31:33 -0800 (PST)
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
In-Reply-To: <2a34bd5d-2997-48cf-bcb8-32d97e3f7690@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 16:31:21 +0000
Message-ID: <CAFEAcA83r12Y6d5Ba-3v1eNe1TfA9kO-PLtkots8C1SzgDNeaA@mail.gmail.com>
Subject: Re: virtio-pci in qemu-system-arm is broken in 8.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 9 Jan 2024 at 16:24, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 09.01.2024 16:52, Peter Maydell:
> ..
> > Oh, your kernel isn't an LPAE one (i.e. CONFIG_LPAE is not
> > set). That will obviously never be able to access registers
> > above the 4GB mark (though the kernel's error message in this
> > situation is a bit unhelpful and could perhaps be improved).
> > If I set CONFIG_LPAE on the non-working config it starts working.
> >
> > I think then the answer is:
> >   * if you want to use the (default) highmem setup, use an LPAE kernel
> >   * if you want to use a non-LPAE kernel, tell QEMU to avoid
> >     highmem using '-machine virt,highmem=off'
> >
> > It was just a bug that we were accidentally disabling highmem
> > for the 32-bit 'max' CPU before b8f7959f28c4f3.
>
> Wow wow wow.  So it's a pebkac bug, not qemu bug.. :)
> I didn't even know about LPAE before this email, and knew very
> little about arm stuff too.
>
> Thank you very much for your work and time!
>
> The diagnostics here is definitely.. "interesting", so to say, it's
> very "obvious" what the problem is.. from the kernel messages :)

Yeah. I don't personally have the time to try to follow up
on improving the kernel handling of this, but if anybody else
does, I think the problem is that the function __of_address_to_resource()
which fills in a 'struct resource' from a DTB entry silently
truncates over-large values when it fills in r->start and r->end
(which are of type phys_addr_t, and so only 32 bits on non-LPAE
kernels). So that function seems like a good place to put some

  if (taddr or taddr + size are above 4GB) {
      warn("resource foo is too high in the address space to use
            (did you forget to enable CONFIG_LPAE?)\n");
      return -EINVAL;
  }

type handling which would then catch this user error relatively
comprehensibly for most devices.

> And the author(s) of the tool used in debian to run arm guest (which
> triggered this issue with qemu 8.2) didn't know this thing either,
> obviously.  Also, it seems to be a little-known fact that qemu has
> highmem enabled for 32bit arm by default and that one - unlike e.g
> i386 - actually breaks system (with pci bus being unaccessible),
> while on i386 the only outcome is not all memory is available.
> That feels like unfortunate decision to enable highmem by default
> on arm in qemu 2.12.

Yeah, in retrospect the other option might have been better.
But at this late date it doesn't seem worth revisiting.

> > The linux-image-6.6.9-armmp-lpae_6.6.9-1_armhf.deb kernel
> > will probably work (though I haven't tested it).
>
> Yes, it works.  Also -machine virt,highmem=off works.  There's
> no bug per se.
>
>
> Thank you for all the findings, Peter!  Much appreciated!

No worries.

-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4364A8254E0
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:10:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkto-0003Vq-00; Fri, 05 Jan 2024 09:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLktk-0003R3-Hw
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:10:09 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLkth-000381-LG
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 09:10:07 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5572a9b3420so1078740a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704463802; x=1705068602; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bahS9iB2kqF0K/bP/F4Orc6xeRWqU4OLx4XmMHcT0DE=;
 b=UtiujScjwZvQvtoZJ/CxMQA/9eNMZGhwLIQyfUBTPh7pFXYwfnq+LjWjfSypZVwDtM
 cj4vyVe9w6xhXJXqHkZEZi82W05qrOtSPYfa+5kHsRUBBxhmuTLi4wgww6/PW38PBcBP
 EFPP76qT26ppZN2A3izkowkX7mkASoODUzGfUUtH9/Hr4prAjoSqkypT7LGm3F5qoDxF
 yY85gIeD4DQC0aCSi0XiTg/sJlhbDD+gM/BfrO4yAOw/r/F5O+dfr+LF2YcEm8pZP2if
 ml0MLRgwA0au7VQtIKCX150+l42P9fJQtKeLHgB97YsmB5knYp6BM/ljZTxvPf2UnOk3
 o0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704463802; x=1705068602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bahS9iB2kqF0K/bP/F4Orc6xeRWqU4OLx4XmMHcT0DE=;
 b=ahs+sj7zN5H+s44n68uE2AfvUlF23VYZe8OdDuD18hqPX5DOMDJ2Mfnc8xsSogjbVn
 loDd3hCXpmq714nF28m7C1TGMxRovX5/InXtX1z+yLq72RPlK7QeuNaTpfNZ8SpABxlO
 168ex/RJACd8gaikw+LW9YB9RCIwiWKHpUu9SY6QkwA0wFmE8yQwbGWKpNSgohJweNYZ
 CeOz1Sy0MSSY4Nf9n8MUzsXTvlOwQ/+jcw/C05IrFvmXgkN7TcEYuTejYU1FM2Fb2Cqo
 mD19cCCymOrQta6y4hMF/7gtWFj5ptis5UfOaRb5dLMZEWYQWMqElNdwx7ldwjsJsyN9
 shOQ==
X-Gm-Message-State: AOJu0Yy02+tInjpTHXn4bJrAMvjFgS61Y99wVerE7+SBsdCQFugIxfQd
 8tbpOSLDN4D6lDEcwa3CJPwIvaoHvn2Fl14SrLJM4QshAJ7zGSquV8VHKQaO
X-Google-Smtp-Source: AGHT+IFRxp7wWkE+7Wgug84jK5WlO4MQsu/Ugz3dYBTWYZQI5Kx9UW32/E9pNfuVBzTeHN/LaEY/PPyGzVVe/LQmqDw=
X-Received: by 2002:a05:6402:3506:b0:557:22e4:437e with SMTP id
 b6-20020a056402350600b0055722e4437emr1163162edd.7.1704463801692; Fri, 05 Jan
 2024 06:10:01 -0800 (PST)
MIME-Version: 1.0
References: <90d7351c-2680-4ab6-95ee-5dac4e3f21c5@tls.msk.ru>
 <CAFEAcA8DdsHQ0eCYnh4vNoybodj0mcHCnOMEr9b_aOk7yO2Osw@mail.gmail.com>
 <ea7dd9f7-b40f-436c-a469-97ef26ac66a2@tls.msk.ru>
 <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
In-Reply-To: <d08930a4-7e01-41eb-b118-b20fea0f8556@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 14:09:49 +0000
Message-ID: <CAFEAcA_7WZwTeQrdV1NTW7_V0YKtDT6HHcnghWGBwvpEV7HEdQ@mail.gmail.com>
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

On Thu, 4 Jan 2024 at 17:17, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 04.01.2024 19:25, Michael Tokarev wrote:
> ...
> > this archive contains kernel+initrd.  I run it this way:
> >
> > qemu-system-arm -append root=LABEL=debvm -nographic -machine type=virt \
> >   -drive media=disk,format=raw,file=vmlinuz,if=virtio,snapshot=on \
> >   -no-user-config -m 1G -kernel vmlinuz -initrd initrd.img
>
> This is actually even more fishy.
>
> The reproducer needs -cpu max to "work." Without -cpu max, it
> fails to recognize virtio pci devices in both cases - in 8.2.0
> with or without the commit in question (b8f7959f28c4f36496).
> Only with -cpu max it works after reverting b8f7959f28c.
>
> Additional kernel message in case when it doesn't work:
>
> [    1.372841] pci-host-generic 4010000000.pcie: \
>    can't claim ECAM area [mem 0x10000000-0x1fffffff]: \
>    address conflict with pcie@10000000 [mem 0x10000000-0x3efeffff]
>
> which isn't generated in case everything's ok.

This looks in fact like commit b8f7959f28c fixed a bug which
was masking problems with booting newer kernels. What happens is:

 * arm_pamax() is a function for finding out the maximum
   physical address space size supported by the CPU
 * it is called by the virt board on a CPU object which has
   been inited but not realized
 * before b8f7959f28c the implications like "V7VE implies
   LPAE" were only done at realize, and so arm_pamax() has
   some manual workarounds to do the same logic
 * but those workarounds were missing the case "v8 implies
   v7ve implies lpae", so for a v8 CPU we incorrectly reported
   that it could only do 32 bit addressing (affecting only
   "max" on qemu-system-arm)

b8f7959f28c moves where we do the "v8 implies v7ve etc" logic,
which means that
 * the workarounds in arm_pamax() aren't needed any more
 * we now correctly report 40 bits as the pa size for 'max'
(That is, '-cpu max' then behaves the same as '-cpu cortex-a15',
as intended.)

Unfortunately it seems like these kernels don't correctly
handle how we report the PCI controller when we're using a
40-bit address space. This seems like it's probably a kernel
bug, but it might be that we're getting the DTB wrong.
In any case it seems a bit awkward to actively require the
guest kernel to be LPAE in order to boot on an LPAE CPU,
so maybe we should tweak the logic to not put the ECAM
in high memory for a 32-bit CPU.

thanks
-- PMM


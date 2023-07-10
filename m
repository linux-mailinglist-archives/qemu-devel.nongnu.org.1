Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5316974D1C1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInKc-0006E2-KI; Mon, 10 Jul 2023 05:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qInKL-0006DT-Na
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:37:06 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qInKK-0008WO-3T
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:37:05 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so8368556a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688981822; x=1691573822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HjvgNz4yYIQ73hWrHDN/LOsecI607ZvwfXdHHOuMgZ8=;
 b=kM/SKi17di7/JKrnmIzA4xgyDkX6h4OvuggAedL4mQK/RmSbx3jwfEkfTLkyqHII0v
 dX1RU0b115DXfOVSLAWhjS/BxRyy0X1nIhIKsUfxg4BjKfnyQ7AQ1kB82i7oq/Hd2kW2
 fOO5/dZNKRDnFzccmm2wjssy+aAlWzkN5suvQzOvNtb3UHQEHMMrzS99Qv5lRk8OAwnm
 5mvr/ocJzMVUrA4L5IozTBb1dQcq5mnNb6G0/Rc44UEtkiKtMbq4j1JywMATx6aWLwXH
 rQShxEa6vSPG0u1oOkCzT5R5sQBJdAusU+QIVR2wxOIvxxxIah4gDln890Z8ep6brYSt
 xdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688981822; x=1691573822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HjvgNz4yYIQ73hWrHDN/LOsecI607ZvwfXdHHOuMgZ8=;
 b=VV99oCmviTHoWs3OFTVxwwxKvo4eGw4m2LpKvH9xQW1X/DSd3Z/7JsQ6JjbUAxws8v
 Dfo1PnzPzva3nxt96qFaW9WSgh8EfoNKZdeEOUIH54ferPk5bWVv10r0FUh5qXKKQwqD
 i3F8j0xX58wDivhkUh++1Wjcr0Jm5h9BuH7xKFhG4uD9gXYSQ1azysgaenl3UwVET6lz
 l+HvJLSB9TvExImWSPtmKGG7BPpKAlikcInd/0cwAi+hzXoOebVF9xD8DCHA4q1Z1ixU
 xINv6pRVE3+peLxh/9p4cUTMB7+JIGna2FxRhI4WqsxdJrIA9sLzS2U/IwpLei+SMKeT
 BcQw==
X-Gm-Message-State: ABy/qLZ0EeSFPifSuLMVSp1siuaOQbL1KqXfbzqeRaexGgQ579w+mT/Y
 DSosF3hteINfdLK+cyvlHH1TBrvLrX5wgrFWUca49P45X2z8SVLd
X-Google-Smtp-Source: APBJJlF2cMv+z/QWnss8mjh9Ms9iGgC7KblpPNaGe8vArLrxKpSt0O1DxZj0j7YhABB6LfgmtJBHB0zYn+eAMWz2jRQ=
X-Received: by 2002:a05:6402:1914:b0:51d:cf7b:c9f0 with SMTP id
 e20-20020a056402191400b0051dcf7bc9f0mr20286471edz.12.1688981822157; Mon, 10
 Jul 2023 02:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAC583hH=tPw=hdv8tuS1QQ4GcK+bwXB8d21wB7WcVMmnSjKXAw@mail.gmail.com>
In-Reply-To: <CAC583hH=tPw=hdv8tuS1QQ4GcK+bwXB8d21wB7WcVMmnSjKXAw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2023 10:36:51 +0100
Message-ID: <CAFEAcA9C0ykbDa1=c0BKnSE1R+jWGE4twSx-G8GrLSkuGtFFRg@mail.gmail.com>
Subject: Re: Request for Assistance: Adding I2C Support in QEMU for Raspberry
 Pi (BCM2835 Peripherals)
To: Shivam <shivamvijay543@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Sun, 9 Jul 2023 at 11:11, Shivam <shivamvijay543@gmail.com> wrote:
>
> Hi, I have added bcm2835_i2c.c inside the i2c folder and wired up it with bcm2835_peripheral.c , I tried to launch qemu with "-device pca9552,address=0x60" , and it launches without any error means it can able to found the i2c-bus
>
>
> But in the emulated rpi terminal I cant able to detect this device
>
> I tried to enable i2c but it says *Unknown parameter i2c_arm

The problem will be a bug in your code, but it's not really
very easy to guess what without looking at your code.
I think at this point it would be a good idea for you to
make sure your code is in a well-arranged set of git
commits and then send an RFC patchset to the mailing list
(mentioning this bug in the cover letter). Then we can
see if the problem is anything obvious.

You may also find that there are clues in the guest
kernel's bootup log -- there is probably somewhere in
there which tries to detect the i2c controller and which
may be producing error messages at that point.

By the way, in the qtree output this line:

 mmio ffffffffffffffff/0000000000001000

looks a bit odd. Do the other working devices in the rpi
have that ffffffffffffffff, or do they have an actual
address there? If they have an actual address, you should
look at what they are doing that your device is not,
to get themselves put in the correct address in the
memory map.

thanks
-- PMM


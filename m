Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B77FA311
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 15:39:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ckP-0007wN-3S; Mon, 27 Nov 2023 09:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7ckN-0007vu-0T
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:38:03 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7ckL-0001dY-C9
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 09:38:02 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50ba73196b1so3286760e87.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 06:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701095879; x=1701700679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JDV7NNWbW7feY0WfjlX/ZuNLxICHisJ+q0zr+V7dXXU=;
 b=vzAsu/CbsIE/xsotB3VNML7L8p/Po9tDtXVXTuUd/Mxt61Sa7MgnaeoLqDWSs5bGMm
 U2WzJA8BGu676WuwENwfKz+EUlnYzJSAq4dpFJGwdN5F7kVI9AQwZcs7QJKpgYYUnBpH
 H5ZxrVnTXlEzqT2TjFqLVydGxJB3J0HTKspaRH3w8/nf2a9+H6SjbkjVMYTakNcBmXl6
 tFKeChg11X4N9SeZ+oYIBS9Ay3bpqMVVAQkoRyVnAK3/xHR0o6+huxHS1NE3RTQx0oNA
 RP2Fm118t+z2+X8dO0U1BIpvAfp9ZO2qEctP2hq8tI+YK/DySZvNgIgUQN85D4rhy1S0
 BLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701095879; x=1701700679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JDV7NNWbW7feY0WfjlX/ZuNLxICHisJ+q0zr+V7dXXU=;
 b=xHX3gXFNYKkf++Z1aKAmGxFeJMFBWsD0/WhC9iDCm0mdx9DGwMoBUeOgOshcbycNKK
 6Nc/GzIPPA6XI5ZBUQWemcKftt0kx1BCW7rw28GGphlvQhiaAnZtvpterAiNwrKdl+GV
 66NcZKQ1mnThL+PCK2hyKcWupnIMeoZI5czx8xc0MBdHqzrR1tMTR/gAN9J+woxV/AAp
 HhdrF29eBX4P38coE3Xir6lj/yckNLiPl9Xrklnzr045hdwW5wbdpWcVlnPq2RZwX5Hu
 GqLnc2Ww3U31aJlPPgGODxBtUiWtVFYo1glT+W7bh9ji18MXAR1PDYKzPVoHh25MEgoO
 Sw+A==
X-Gm-Message-State: AOJu0YwT0DPzudstwCwXQdKpxzj5fylSV/Ahf/6BoJ7ysuyhgo8FfhXG
 ib4D6h+L4uRD5Tj/uy3apB11uKv+WsoyaFmZH02/Kg==
X-Google-Smtp-Source: AGHT+IGIB619fZUypFeYYDiBVTqpyVsX3ELzRSXp8GJGbrlBy36lfY3EYY+jOtgzaIz3kcP2UL8VogOOOI3ZI+H28UY=
X-Received: by 2002:a05:6512:280c:b0:503:3808:389a with SMTP id
 cf12-20020a056512280c00b005033808389amr10887334lfb.11.1701095879038; Mon, 27
 Nov 2023 06:37:59 -0800 (PST)
MIME-Version: 1.0
References: <392b2fb5-1747-0f73-826f-b410cdc84f07@redhat.com>
 <CAFEAcA_F9+XDA_5_oyqqpjS+iaeOx=J05WsZ0QMB0016rUzDfw@mail.gmail.com>
 <531d4099-747f-5ab5-8c9c-30c50e6115c8@redhat.com>
In-Reply-To: <531d4099-747f-5ab5-8c9c-30c50e6115c8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 14:37:47 +0000
Message-ID: <CAFEAcA9c6Guo-juq37Lkfav9TR9zec_ymQkPdq4wSAmHRSb2-g@mail.gmail.com>
Subject: Re: hanging process with commit 69562648f9 ("vl: revert behaviour for
 -display none")
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 27 Nov 2023 at 13:08, Sebastian Ott <sebott@redhat.com> wrote:
>
> On Mon, 27 Nov 2023, Peter Maydell wrote:
> > On Mon, 27 Nov 2023 at 12:29, Sebastian Ott <sebott@redhat.com> wrote:
> >> qemu fails to start a guest using the following command (the process just
> >> hangs): qemu-system-aarch64 -machine virt -cpu host -smp 4 -m 8192
> >> -kernel /boot/vmlinuz-6.7.0-rc1 -initrd ~/basic.img -append "root=/dev/ram
> >> console=ttyAMA0" -enable-kvm -device virtio-gpu,hostmem=2G -display none
> >>
> >> ..which I've used to debug a potential virtio-gpu issue. Bisect points to
> >> 69562648f9 ("vl: revert behaviour for -display none")
> >
> > Is it actually hanging, or is the guest starting up fine but
> > outputting to a serial port which you haven't directed anywhere?
>
> Ough, that's indeed the case. I only had a quick glance at the bt in gdb
> and obviously misinterpreted what I got there.
>
> > The commandline is a bit odd because it doesn't set up any of:
> > * a serial terminal
> > * a graphical window/display
> > * network forwarding that would allow ssh into the guest
> >
> > If you add '-serial stdio' do you see the guest output?
>
> I do. I was using the serial terminal which got setup implicitly I guess.

Yep. The issue fixed by 69562648f9 is that we briefly incorrectly
made "-display none" do more than just "disable the display window".
The revert brings us back to the normal behaviour that if you
want a serial port you need to ask for it. (Or use the -nographic
option, which is a legacy 'do what I mean' option that does
multiple things at once including turning off the GUI window,
and adding a serial terminal and a monitor multiplexed onto stdio.
But personally I find it clearer to explicitly ask for all
this stuff via '-display none -serial ...' etc.)

-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6128A7F19D0
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:26:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r582V-0001QA-4x; Mon, 20 Nov 2023 12:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r582S-0001OE-Os
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:26:24 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r582Q-00077a-KG
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:26:24 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so6844151a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700501181; x=1701105981; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PW/m+doSsfC1tDv8iaxMIsedk/4LD5Ru6zO6xuPKDM8=;
 b=Hk8PqPbBg19dxna7JJpH+tsI8WtW4Rsed4G3Nhk0hkcpx2i1fTG2xYod89UpcSLRlv
 m9UMCs12pdMZYGxfy1cGceizKzXNbltUMy/YnL03ycasTu9gWqA0OCMMtrXIjfCegzsJ
 ApSnkug5qqSVxvo1D0CHtAxtXa83IQj912q0ZIG0QRzqpoFZnyuvBEHSjCQ7+alpGsUp
 R1KG5hzrsXvpN0kUv8OYe/tCVb7cBTiUALhz5tbkxvZw/36Fg8hPVYd2vG8/PTqH3G4w
 AHYMDUfcNUZ1c3glro5sqFS6TCNVoWkJX4lyJan26rKPSSjA0Th2uBCpsA78QqmZLwSS
 Dv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700501181; x=1701105981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PW/m+doSsfC1tDv8iaxMIsedk/4LD5Ru6zO6xuPKDM8=;
 b=ihdJ1LU2V6R7XBp8lG/15FgIQP+Q3GyFtEAFNi1m6vXXV/u1GLZJR38rfomsgbCii8
 btEEL1JG0OGuPn86vONyiac3Ga0uPlLtnuOy6O3PabBwpuGpSSLz6ps/JanHWsum4Y2G
 TLtYO3awQh5ljscxW1uWTJunnDKiO2LHl1CiWQLwGLIR9gH5xGN0LT6o+9QyVyNFuIYa
 8aP7kCs+wSbU0C1ihkKaFKoBkwcrbvCApLIt2KRcMi2Tqqyp0V/D35HYyPvtQlgux9E9
 ZJTc6dQi11ESnMJTdHLR72o/rXrvqRCCHYc5qBWik/nTcTZZyXPzIjytEjjJZOhYmTlj
 KJ5g==
X-Gm-Message-State: AOJu0YxLPwN6g36hDsbsxUupNQc83uu6mKYk6AV8P8n1VXfKECTm1K/o
 jd2F6X6K38lJSaYnAmzoCT+C4WU/yk+yZe22WYHlWQ==
X-Google-Smtp-Source: AGHT+IHv7i9e38rfFjRA1pZ+oR+DEuzKU77OFXNetiLLG1xsefvr3Sg219ZgLRFuezyPzjTYIZfiHo6cetQgD8rKZn4=
X-Received: by 2002:a05:6402:797:b0:548:af73:6747 with SMTP id
 d23-20020a056402079700b00548af736747mr36231edy.38.1700501181058; Mon, 20 Nov
 2023 09:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
 <20231120150833.2552739-9-alex.bennee@linaro.org>
In-Reply-To: <20231120150833.2552739-9-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2023 17:26:10 +0000
Message-ID: <CAFEAcA-oYNZ=kNJ8C6FkGi==H4cHoTJ5xo3PC6P1RRH+0A3Zow@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] docs/system: clarify limits of using gdbstub in
 system emulation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, 
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org, devel@lists.libvirt.org, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, 
 Chris Wulff <crwulff@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 20 Nov 2023 at 15:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> It seems some users will try and use the gdbstub to debug userspace
> inside a system emulation. While possible clarify the limitations of
> this approach and direct the users to a less head scratching way of
> debugging user-space.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Clarifies: https://gitlab.com/qemu-project/qemu/-/issues/1274
> ---
>  docs/system/gdb.rst | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
> index 9906991b84..c0cc0c9c7e 100644
> --- a/docs/system/gdb.rst
> +++ b/docs/system/gdb.rst
> @@ -60,7 +60,7 @@ As TCG cannot track all memory accesses in user-mode th=
ere is no
>  support for watchpoints.
>
>  Relocating code
> ----------------
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  On modern kernels confusion can be caused by code being relocated by
>  features such as address space layout randomisation. To avoid
> @@ -68,6 +68,17 @@ confusion when debugging such things you either need t=
o update gdb's
>  view of where things are in memory or perhaps more trivially disable
>  ASLR when booting the system.
>
> +Debugging user-space in system emulation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +While technically possible to debug a user-space program running

"While it is"

> +inside a system image it does present challenges. Kernel preemption

"image, "

> +and execution mode changes between kernel and user mode can make it
> +hard to follow whats going on. Unless you are specifically trying to

"what's"

> +debug some interaction between kernel and user-space you are better
> +off running your guest program with gdb either in the guest or using
> +a gdbserver exposed via a port to the outside world.
> +
>  Debugging multicore machines
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

thanks
-- PMM


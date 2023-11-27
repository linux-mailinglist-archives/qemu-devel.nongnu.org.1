Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B88BB7F9D1F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 11:08:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7YWH-0001Kj-3K; Mon, 27 Nov 2023 05:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7YWF-0001KF-15
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:07:11 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7YWD-00063s-5k
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:07:10 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54b0e553979so2890544a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 02:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701079627; x=1701684427; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ctx09G1AlIbdXbdPkbmPp8uHJhSI3Fj4H1lqWKt/5Ss=;
 b=s4gxrXFqfd+zrzNGBZO9/9ZFZCHNKEfyRWd/CLMbmlOlCHNG9AOVwDo2EMfhUjhAfO
 iUzLOcaLaYT6WG9/8zXgGg8ZdOBH1j13M1KBdPvlFLHN3vLOcZ2L9IN+5O7LKSgF0/Sa
 FG/Jt0XSvvzf1bYh+IXgmVp5Tbk7qBNQo7sZjTVgMvxR9ZDsNueA9cV4CXMIr5OMDZap
 y77tNrOvgfbTz6ERg9J9WtglZFbtv741OPNUxW2bIBorocFsRyuC3u51YtRhmBEkj1gV
 imlg0VqX7JRbiTSDbNBdTWUiNsuWJ0V02yCo7auRFUNuRSGnEVTvzay1YshjRErnbqNa
 wsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701079627; x=1701684427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ctx09G1AlIbdXbdPkbmPp8uHJhSI3Fj4H1lqWKt/5Ss=;
 b=DBx4STJQQFEB47jMkbeNQfjVU6LQ2kZs1h5V42r3E1gMECcbNl5QvL5yvSDK95Yf99
 gJLYrpuC541a/4DQtz3+LDuY5rVR0euP63JdIP3Pt5AVZf87EKf0ZffwWHjwP2PO/+OQ
 VCQeomsAUsdd9DDLiLkp/fDO7YgAf5RCWbNoaYNbpBfE7Z/6qnFbSlvpWTp9GnqtYQAr
 gpBh89YY5hJ3f6jC6aAAdKUOh2B/aSMSQ1LdzuLAu1Ymj6+4Fg/cPCk9UM+Pw1+OZ7IM
 uiBZlsd8Bf0ClikShu9N5SpJOFN1623moi3qDtFfZOXTuukDEs61QUSB7bUACQEO/QnH
 CpUA==
X-Gm-Message-State: AOJu0YxbhTpEM3kYoy3ABr1pjK0JhLF3LwPo3GV0ssKU+S2CurNUFzKA
 nvflUfm0YNVZqRen5KUR0QTxkwiI09wdWqrW3ZRXfA==
X-Google-Smtp-Source: AGHT+IGvEggRK+6fl1f7UjU3GN6CXqx4p5usoi7UTko/QQ26lcwNgbB4wHqUscfPU/ZgS3Mqr3sQcs9IxbX6KyveD5g=
X-Received: by 2002:a05:6402:22ac:b0:54b:8c42:210e with SMTP id
 cx12-20020a05640222ac00b0054b8c42210emr431915edb.4.1701079627180; Mon, 27 Nov
 2023 02:07:07 -0800 (PST)
MIME-Version: 1.0
References: <PH0P222MB00109DEBEA0D55483D5FCB63DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
In-Reply-To: <PH0P222MB00109DEBEA0D55483D5FCB63DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 10:06:56 +0000
Message-ID: <CAFEAcA8WC=MMsX9tQjBddt=1EBrT1Ud9j_6tmbuvbRJBvnV9jA@mail.gmail.com>
Subject: Re: [PATCH] avr: Fix wrong initial value of stack pointer
To: Gihun Nam <gihun.nam@outlook.com>
Cc: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 27 Nov 2023 at 03:52, Gihun Nam <gihun.nam@outlook.com> wrote:
>
> The current implementation initializes the stack pointer of AVR devices
> to 0, but it should be set to RAMEND according to the specs.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
> Signed-off-by: Gihun Nam <gihun.nam@outlook.com>

Hi; thanks for sending in this patch!

> ---
>  hw/avr/atmega.c  | 3 +++
>  target/avr/cpu.c | 2 +-
>  target/avr/cpu.h | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index a34803e642..3a8caccf99 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -233,6 +233,9 @@ static void atmega_realize(DeviceState *dev, Error **errp)
>
>      /* CPU */
>      object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
> +
> +    s->cpu.init_sp = mc->io_size + mc->sram_size - 1;

The board code should not directly touch fields inside the
CPU object. You want to set up a QOM property on the CPU
which the board code can then initialize using a QOM
property-setting function.

For an example of how to do this, have a look at how the
target/microblaze code handles its "base-vectors" property
(in fact any CPU that does a DEFINE_PROP_UINT32() will
be similar):
 * you have a Property array with a DEFINE_PROP_UINT32()
   line to define the property name, the struct field
   that it corresponds to, and the default value
   (you can list a struct field directly, don't
   put it in a substruct 'cfg' the way MicroBlaze does),
   plus a DEFINE_PROP_END_OF_LIST() terminator
 * the CPU class init function calls device_class_set_props()
   to say that that array is its properties
 * the board code sets the correct value using either
   object_property_set_uint() or qdev_prop_set_uint32()
   (doesn't matter which)

> +
>      qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
>      cpudev = DEVICE(&s->cpu);

As a side note, one of the answers to
https://stackoverflow.com/questions/46949227/compiling-an-assembly-program-using-avr
says that older AVR CPUs set the SP to 0 on reset, and
it's only newer ones that set it to RAMEND. That's
probably why we reset to 0.

thanks
-- PMM


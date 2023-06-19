Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C029E735663
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBDcD-00076g-Pj; Mon, 19 Jun 2023 08:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBDc3-00076O-DD
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:04:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBDc0-0007sY-DG
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:04:02 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5189f49c315so3428048a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687176238; x=1689768238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrgcOcrpK+jiIpJ5+B6PKmWyy9++LCvABXodNiWcYnk=;
 b=jANekh7JkEN+lbf//AQ1Y04UBksS3t8hi0BencKQkvdsNC5QPDX1WmesqDeZs7K0ta
 lZm7JyZ63sNWJCEAVUZSnLyF01XKUjDJ6Irs7/J9L5qJW3cD9/r0TjcSnQaxMs4RyjCX
 uzt8OvPK1ZzcgPC8G2QRQB/91tYbptnF0lLnZh3DFLIn5Hgiqd3VFS4FbhhbgvlkmTxu
 rKfid89/iOPbN9G5VLRZdE4yZA78aZpCGJXktwWbwKQ2nMYw3qL66U/DhrGj08YO7Yew
 I5iiPnImzFRCkeF74K46WSLSpcsJqemr/gaLX8MH+I8UJ75L00BzQwTF+0d2F3w6pONZ
 bRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687176238; x=1689768238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrgcOcrpK+jiIpJ5+B6PKmWyy9++LCvABXodNiWcYnk=;
 b=cWBMU/BTnsuZf1YlmttnxocshtWZwLZxLqUq35uCTQ4niSiw4VM1/GDYefVlddHwtN
 d7sUlhpQZs2SB/4wscpoUuJkTvVgSI4FcHhg97WBtXAUsdzoBetK+RUk40PATuY49aPF
 4HWVnzVRhbVws7CPjiT1cNN0rs0cbXb/gfCRiCr4AqEHvY7DWxNDp9waSpKMYZacWfG3
 mybEa5IgmnWqj1CxunXXrLVYQuGqoo48jNWzRmW8Nx/vh75Iv8C8tJU5F87A0qrC6j8C
 YV/Sckz3DyI6ofzxXJLMg94kuAIPdOECd8MavIt2rVlW4CYHR2nOu+8Va4dHturAkE0x
 Vbwg==
X-Gm-Message-State: AC+VfDyD4CDI5G19fF1LwszJYuXZ5ENYOskUyi+5f9e+t+YV41bYq8wb
 OefM1DS1yv4t5zNERBzIzrfpT5KO977MUNwLrMy00Q==
X-Google-Smtp-Source: ACHHUZ7/L0luIqMk9hcpy9KF1YmLMBVItW/Cwmuf3JxGLv+GBpKaLDsIwWIDZT5ld7l48emH15N1ZewdZBs6k+P2U3c=
X-Received: by 2002:a05:6402:1651:b0:51a:1f10:8a6f with SMTP id
 s17-20020a056402165100b0051a1f108a6fmr5857533edx.5.1687176238370; Mon, 19 Jun
 2023 05:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
In-Reply-To: <j6_NJPGssQ1eBAedcPGs0eURXeMcehbzMcwJtaGvzN_FdUbQKyTP1cyEJWC759G72UNSVpX-QmQ4u6iJvZmt2c_vRO7rhryDQs9icVy5iEI=@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 13:03:46 +0100
Message-ID: <CAFEAcA-L=LsAiLAeeQUH1AFFdNJw3D=mNtd4sQW7ZVDme4yhyw@mail.gmail.com>
Subject: Re: Emulation of 'System OFF' mode in ARM nRF51 SoCs
To: Chris Laplante <chris@laplante.io>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
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

On Wed, 14 Jun 2023 at 14:02, Chris Laplante <chris@laplante.io> wrote:
>
> Hi all,
>
> I am working on improving nRF51 emulation. Specifically I want to impleme=
nt the special "System OFF" mode. System OFF is a power saving mode. In thi=
s mode, the system can only be woken up by a reset or a handful of peripher=
als (most notably, GPIO via high/low level detection on configured pins). S=
ystem reset is triggered upon wakeup.
>
> I've been digging into the QEMU mailing list and source code and have com=
e to the conclusion that deep sleep and low power modes are not implemented=
. There seems to be support for turning off ARM CPU cores, e.g. as used by =
imx6_src.c. But that doesn't apply here because I only have one CPU.

For QEMU, "power saving" is pretty irrelevant. We have a
couple of different modes:
 * CPU is executing instructions (i.e. it is powered on)
 * CPU is not executing instructions because of some sort of
   "halt" or "wfi" type instruction that means we should pause
   until the next incoming interrupt
 * CPU is not executing instructions because it is powered
   off. When some external device in the system powers it on,
   it will start up from reset.

The powerctl APIs work fine for single CPUs. Of course
the external power controller device in the system which
is calling the "power off" APIs needs to arrange to also call
"power on" again later.

> So ultimately what I think I will try to implement is what the nRF51 refe=
rence manual calls "Emulated System OFF mode". From the reference manual:
>
>     If the device is in debug interface mode, System OFF will be emulated=
 to secure
>     that all required resources needed for debugging are available during=
 System OFF...
>     Since the CPU is kept on in emulated System OFF mode, it is recommend=
ed
>     to add an infinite loop directly after entering System OFF, to preven=
t the CPU from
>     executing code that normally should not be executed.

The reference manual is very unclear about what this "emulated
system off" mode actually does. I think that implementing
real "system off" is probably simpler. For that you should be able
to implement it something like this:

 (1) the power management device implements the SYSTEMOFF register
     to call arm_set_cpu_off() when a 1 is written
 (2) make sure the GPIO device implements DETECT as a GPIO output
     signal, ie an outbound qemu_irq (if we don't do this already
     the functionality will need to be added to the device model)
 (3) similarly for ANADETECT from the LPCOMP device
 (4) Wire those qemu_irq GPIO outputs up to inputs on the
     power management device. When the power management device
     sees those signals go high and the CPU is in system off mode,
     it should trigger the reset of the CPU by calling
     arm_set_cpu_on_and_reset().

NB: this doesn't exactly model the defined system-off behaviour,
but it's probably close enough. Specifically, it will only reset
the CPU itself -- all other devices in the SoC will retain their
state across the power down. If you needed to implement the
hw exact behaviour (only "retained registers" keep their state,
others are reset, watchdog gets disabled, etc) you'd need to have
the power management device tell the other devices to do a
system-off reset in addition to dealing with powering the CPU
off and on. It's probably not worth looking at this extra
complication unless you really need it.

thanks
-- PMM


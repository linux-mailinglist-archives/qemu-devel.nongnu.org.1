Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599C82C577
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 19:32:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOMJJ-0006Cm-Sv; Fri, 12 Jan 2024 13:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOMJ4-0006C7-Ge
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:31:05 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOMJ0-00032o-9P
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:31:00 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-555e07761acso8158448a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705084255; x=1705689055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jAZ50sCHXjPtr6GLeckmxNmSfg+2WEi4HZiZmh3kdWQ=;
 b=ojr291YTzPGdpYpliyFKYsYfEeDXHVXQSeN+OHeihb+H+S5vnYOtnxKfy+c7FduATV
 u3XPm/3GqiYc13qPHCdK7POKaIdY8aqHPfpLWHtG55Qo7NzwCQAIqu2mMvCfHM7/oqYm
 Xlqybx9UTAg2x+Mk2Cq56P7c7Lx1nChDs6RbcwKqQ0RCM9dwJlNj+oBvzeKE0SQeCxqt
 NLOgnJG4u0NXr5JluRhVqJfM1vdGxtzaO75WYWbg2kRSW/MrtE8Jxow6eJEOCXpZGanV
 gGcoaYojaiGRZ/toEbCFFJfDwKihJSqkQpLrxLmIiPRSS//KaqRHY83U5XGyqlQ/93Z9
 fh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705084255; x=1705689055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAZ50sCHXjPtr6GLeckmxNmSfg+2WEi4HZiZmh3kdWQ=;
 b=wJe68CDkPwWawUPpar1bd1shPF/aRXXceciD0EExuotAhcatNOIFu/cfIrqekY+Cwo
 qM9F+3bhVzr8aZDQB90uF0QQTXO25CEMc3ila+LByhDze1nuZnmadDUtSrIkLZK/oXK7
 6H7OPeVZXmv5P7aeHajQ4A0thmQ4OIVpBRcdUrZlJ/tsj8SjFLOJZT5ZtKbYIdSIH+1a
 m2l877DIptqefFujQDh2V+zrvj9j9qmctyXqR8hJrgWXn7qnG7kIKZoFGf4+Z04XUgkR
 WuUM+oTNJ41cFIFGriOTE5Fq5qmkLi1397mN0sZTILkpn+4Zsv2VHCxPq+37BxVBIXfH
 7nWA==
X-Gm-Message-State: AOJu0Yy3KFVDZLCmXQssUY6NcIaoAYKt4Ob0Ql+AAtED+WcJrtcHDsg7
 IeYSJBmxmMa46+pON9TJVkQLsMU526/enPUohvotLZVQdlX87MvHpbcNmelM
X-Google-Smtp-Source: AGHT+IEnZXL0ovpE9Iyz8QrKnS2GUSYZrFONZFWTr2IR+qrD9+k8rCATl5SbNp0JZsX/8tFZnECCGqCy84JOtkcX31k=
X-Received: by 2002:aa7:dd0f:0:b0:558:991c:96ee with SMTP id
 i15-20020aa7dd0f000000b00558991c96eemr588754edv.51.1705084255618; Fri, 12 Jan
 2024 10:30:55 -0800 (PST)
MIME-Version: 1.0
References: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
In-Reply-To: <CAA3Sv1LQ8yDUNLCB5WqLVZjsHffrU0uSbL_YYJW_m+Db2PhEeQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 18:30:44 +0000
Message-ID: <CAFEAcA8mJU16UL_H4wXGNh77nkuoMc3XMwtnAaV5XwdFn2f=sQ@mail.gmail.com>
Subject: Re: [PATCH] Fixed '-serial none' usage breaks following '-serial ...'
 usage
To: Bohdan Kostiv <bogdan.kostiv@gmail.com>
Cc: qemu-devel@nongnu.org
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

On Wed, 10 Jan 2024 at 14:38, Bohdan Kostiv <bogdan.kostiv@gmail.com> wrote:
>
> Hello,
>
> I have faced an issue in using serial ports when I need to skip a couple of ports in the CLI.
>
> For example the ARM machine netduinoplus2 supports up to 7 UARTS.
> Following case works (the first UART is used to send data in the firmware):
> qemu-system-arm -machine netduinoplus2 -nographic -serial mon:stdio -kernel path-to-fw/firmware.elf
> But this one doesn't  (the third UART is used to send data in the firmware):
> qemu-system-arm -machine netduinoplus2 -nographic -serial none -serial none -serial mon:stdio -kernel path-to-fw/firmware.elf

Thanks for this patch. I'll have a think about whether it's
the right fix next week. In the meantime, I suspect you'll find
that if you use "-serial null -serial null -serial mon:stdio" in
your command line example you'll find that does what you're aiming for.

("-serial none" means "don't create a serial port device", whereas
"-serial null" means "create a serial port device, but have its
input and output go to nowhere".)

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09613807400
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:53:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuCX-00013V-Sl; Wed, 06 Dec 2023 10:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAuCV-00011d-9o
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:52:39 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAuCT-0003mJ-BB
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:52:39 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3332f1512e8so829838f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 07:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701877955; x=1702482755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lEAhPalQBhGBHVPkI4W7STKNhY3WIAHAv5ERC+26Wqo=;
 b=qHfukm1+Toob3m3Qq9JJIIU5zbp1vJ3pRzaea5nrFA7bz4ijWRgUWHRr8lbPZvXz51
 dnMcOZHGJ7J9wVsZ1EFsq8VEtLfHzAqkjVJBW2MTy9RgEAtWQ9zDfNsGIhDfIev7odcz
 sduuONCUwZcLbnUpCC1UdD4JP+3B6y+RJggJEw5kDRORy9FHSHVIgw4DjITgP7GlXYZI
 xzbYrmo0neca9C0rZ7FEVGh96DM/ietlIkiQ4V2M+hoN1TkhAjPq3lWp0WS0YVO0FBbo
 G5AVCDb2RmY68p6uZEswOz+eIflP6l+1GMDJKlA+Bt1doSx2aYm9zgFqNbIeYZ7ZegGl
 gBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701877955; x=1702482755;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lEAhPalQBhGBHVPkI4W7STKNhY3WIAHAv5ERC+26Wqo=;
 b=fJtDsZq83mXTS30Wh7XtMVIRGrTC5lBidX3i6SaLi9VDcEF0nwGjgmmiiNR7aak68q
 fSANPDqZulXwCe4ObMycfcQUt/Z/0vazH9FQ8iCLom+ln+aui4UF6Y1rzFwfnnfYSGAJ
 TJx6M0IcSsARa1dWYBoZY+fldxRpH8wxV/ThbzaN/j+F18E9hagWgsNxjYb5a+EM/ThO
 e4cpW6ctkWwEsos9Hct6wV8RKYzXzBiJrUJ+plgn8EjlEX+yT0oShL3t4HFcl8c5sE1D
 AgfJnckhKrD+nc8TUKEOkObNKc/rWbBSVnAOPRPyxHBkgkloJ/WO9NQsLOGzAcpDkUn6
 HkJg==
X-Gm-Message-State: AOJu0Yzryk+k66NwiX1Zu1XdlX0KHjo7WyjCzifatYjL/97rfbigxNE9
 AnD+JjAphuN3bOuud+Ir+JtlfQ==
X-Google-Smtp-Source: AGHT+IEsKmRxMyGeZU1EDOYOY8492EwbjRO0rQSMWoix5Ob2dgdyoTsB7FRGibm/72Z5fo/6BN87TA==
X-Received: by 2002:a05:6000:4f0:b0:333:42ac:2009 with SMTP id
 cr16-20020a05600004f000b0033342ac2009mr645215wrb.96.1701877955167; 
 Wed, 06 Dec 2023 07:52:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k1-20020a056000004100b0033343b1ec1asm12140wrx.26.2023.12.06.07.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 07:52:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5A6CC5FBC6;
 Wed,  6 Dec 2023 15:52:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: ~lbryndza <lbryndza@git.sr.ht>
Cc: qemu-devel@nongnu.org,  ~lbryndza <lbryndza.oss@icloud.com>,  Alistair
 Francis <alistair23@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH qemu v3 02/20] Fixing the basic functionality of STM32
 timers
In-Reply-To: <170152443229.18048.53824064267512246-2@git.sr.ht>
 (lbryndza@git.sr.ht's message of "Sat, 02 Dec 2023 13:05:19 +0100")
References: <170152443229.18048.53824064267512246-2@git.sr.ht>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 06 Dec 2023 15:52:34 +0000
Message-ID: <87wmtrz5tp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

~lbryndza <lbryndza@git.sr.ht> writes:

> From: Lucjan Bryndza <lbryndza.oss@icloud.com>
>
> The current implementation of timers does not work properly
> even in basic functionality. A counter configured to report
> an interrupt every 10ms reports the first interrupts after a
> few seconds.  There are also no properly implemented count up an
> count down modes. This commit fixes bugs with interrupt
> reporting and implements the basic modes of the counter's
> time-base block.
>
> Remove wrong qemu timer implementation

I suspect this breaks bisectability of the series. Each point in the
series should still be able to compile and at least function as well as
it did before. So in this case I think this patch needs to be merged
with the patch that brings in the replacement functionality.

>
> Signed-off-by: Lucjan Bryndza <lbryndza.oss@icloud.com>
> ---
>  hw/timer/stm32f2xx_timer.c | 55 ++++----------------------------------
>  1 file changed, 5 insertions(+), 50 deletions(-)
>
> diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
> index ba8694dcd3..f03f594a17 100644
> --- a/hw/timer/stm32f2xx_timer.c
> +++ b/hw/timer/stm32f2xx_timer.c
> @@ -23,12 +23,17 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/timer/stm32f2xx_timer.h"
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "qemu/typedefs.h"
> +#include "qemu/timer.h"
> +#include "qemu/main-loop.h"
> +#include "sysemu/dma.h"

Seems odd to increase the includes needed when the rest of the patch
just deletes code.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


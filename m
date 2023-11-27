Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BC7F9CD2
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 10:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Y3m-0002Ue-4M; Mon, 27 Nov 2023 04:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7Y3h-0002TW-R6
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:37:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7Y3e-00013O-2x
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 04:37:40 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-549070a04baso5410534a12.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 01:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701077856; x=1701682656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2gdF+10FWfbjAhaLZZCsre3wvTNLSeZJmCAbtcFR63k=;
 b=CSzbLbS0WWaN+qLJaCj7d3xUx1h9gCmsPoKnI6MUEatxaaLKIdDqSCa34FypnbaOrz
 eIDuFP7nInsI+jDebL+anhQUOsmOaE1C8I2dh8vMjBEttGo9SIKDDvWZywHQWGSVJ2Th
 6pR2tN80TZ0V5Y/IpzcRKHu6GI2UYoeB8Nki5jdzDjLaB6SY9Q9MaK5v81U7/S9BqUQg
 6sJkZc5icZveJXnrY2p2u6+cK99WkKrKNvdRgiaeQP+9eYBp1BMp5bSymyq1E+oDg+oD
 H3qtql9ZhmOkNL16EqnyggeV644oifQdvHpsR+vJsDSOBzJnXgvY3R8hRKbnFr2tUjwn
 5YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701077856; x=1701682656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2gdF+10FWfbjAhaLZZCsre3wvTNLSeZJmCAbtcFR63k=;
 b=sy6ZmQAie5elRZ/FZTddgJiWbPqrXZXS/28dg/nVx+4cMuR3uIBFDka6jBRjbaU0tH
 M6zdHlZCpHAkrNU6au+6vwh//O2qPZHL3PDUNEo/JPZn9+CxX5tAqMCvxd3cyGuk3/Pm
 ujCaRSlt+93NFiqIJrBbe9Digfaf9tSeKC/VfGynO+SSpPQVEBNNwx7IdoGmFEzK9N4O
 oDb1HJN6asDVTwiPcj6SSqafiekXt2ooarCNdntjphvDMgxaIkRdfhjStcTH7ikgpI2c
 2iJ/JiAVCCMgcmQDhvyaQ0UnQwZrZvbP7ngMa9UF7PRHo/1QQJM5FxjdiskhllPUvC67
 NUYA==
X-Gm-Message-State: AOJu0Ywws1Gw+lZQJHPmJlK6XtbbGUSgYpmh15aI13tuNrr0BmIqMjq5
 bCiEtKD1rRHrfwzEVEpAbg0JHWKEoDl1NIbtxJbwbg==
X-Google-Smtp-Source: AGHT+IGdFkFhvfzskrDUIhbgcZdIf9cV0CGwCWnWhppSj4lw4L8yZW3ABRIIlOzEvYq6aZ/LmPJGoeFj3GbjQoO0X20=
X-Received: by 2002:a05:6402:704:b0:548:657c:9110 with SMTP id
 w4-20020a056402070400b00548657c9110mr8016128edx.38.1701077855863; Mon, 27 Nov
 2023 01:37:35 -0800 (PST)
MIME-Version: 1.0
References: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
In-Reply-To: <79bd7607-7590-4809-9412-7cf7276567d6@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 09:37:25 +0000
Message-ID: <CAFEAcA-yvyB_t=JsEAp8eoX01gSKi04aNZ5Fq6F+gneRUMP6_w@mail.gmail.com>
Subject: Re: [BUG] accel/tcg: cpu_exec_longjmp_cleanup: assertion failed: (cpu
 == current_cpu)
To: Petr Cvek <petrcvekcz@gmail.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Sat, 25 Nov 2023 at 13:09, Petr Cvek <petrcvekcz@gmail.com> wrote:
>
> It seems there is a bug in SIGALRM handling when 486 system emulates x86_64 code.

486 host is pretty well out of support currently. Can you reproduce
this on a less ancient host CPU type ?

> ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> 0x48874a != 0x3c69e10
> **
> ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
> Bail out! ERROR:../accel/tcg/cpu-exec.c:546:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)

What compiler version do you build QEMU with? That
assert is there because we have seen some buggy compilers
in the past which don't correctly preserve the variable
value as the setjmp/longjmp spec requires them to.

thanks
-- PMM


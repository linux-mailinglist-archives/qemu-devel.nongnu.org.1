Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE377A09E4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgohv-0005yi-UQ; Thu, 14 Sep 2023 11:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgohX-0005kB-2L
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:56:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgohU-0000Xy-5b
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:56:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-404314388ceso9852955e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706974; x=1695311774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2D3ULEhRy+9WwXw0QKX16DdcHnSzD2yth0Za/p9gC34=;
 b=zp/WHEzKs5g/2hADlFvDOIiOwd0TWHvBPPH9FXXB3BYECgHVBu8hO0SFl8/72ijmG5
 2/Lu90Ym5DFksDjqMQJALg+slqkT3b5zFW13WTGItjNBMYMcTYZpSB7kh1dhzm/C5dTc
 yyD+ETXz1Q4UhQjGAhHSetUFpOGo+Z1G/XRbTXrV9X9dzZEBROq2MQMGXyxcIB2kxMva
 peAoWcgbvfRVin/r/3nBgZhaOZoXIW+5pHhPNpbyG2YtfNB0/GqlyEptfP1h0AG7bNCa
 +P1TPQMz9UX9EtSiCafr4/6VFF8O/ngrWMj9kdAmRUW2P0oF73y/yzXf68m4/VcSDhqQ
 oy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706974; x=1695311774;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2D3ULEhRy+9WwXw0QKX16DdcHnSzD2yth0Za/p9gC34=;
 b=MvOBQNV+MuGIQymyCRyrM9ZRHmz4+iYqvWVCyCbLOMyW8LmmqiJyaaZyDSOGuKJlk0
 l0YDePQHu64XcGlPyiptpTemaNn70YC7Xn0+6bCBy9pG0HWa1B3K4XwHateuz37diqBM
 13m9YOT7i3nDrkOFfZtCu8DuNB2bf5zhJwoJ7+bNVA+f+dVak7mC49r5r8iOsCbZQuYb
 vzXeLPiIIfGn8BJkcOtr3dkIqBCi/SY/jIx2xdRJYtMykBbUN+pgLaoZvSCGK0OgOjHn
 NMAJncrMy38qrX2qnuGT+D96mTVblFh7IGJKbhvsOD4tOQY0rGFwEwN4cHWFs+KDYRnW
 3JGg==
X-Gm-Message-State: AOJu0YzFl9wdrsJw1/Xfpba1S5+opdNZ9/XZyjJbJC7TgHTECaahidsd
 XXagUAN3HYgVexEFFmEHTYFZkw==
X-Google-Smtp-Source: AGHT+IGwhfKmlzjpSxs7EVfMa+DSQPoBL9ASImlciwcbAAyCY+PudiZOCkIgzIek+/45o22v75Y11Q==
X-Received: by 2002:a1c:4b16:0:b0:401:1066:53e4 with SMTP id
 y22-20020a1c4b16000000b00401106653e4mr5014131wma.38.1694706974345; 
 Thu, 14 Sep 2023 08:56:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k23-20020a05600c0b5700b00402fa98abe3sm5180215wmr.46.2023.09.14.08.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:56:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7E1F91FFBB;
 Thu, 14 Sep 2023 16:56:13 +0100 (BST)
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 00/12] gdbstub and TCG plugin improvements
Date: Thu, 14 Sep 2023 16:56:06 +0100
In-reply-to: <20230912224107.29669-1-akihiko.odaki@daynix.com>
Message-ID: <877cossq8y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> This series extracts fixes and refactorings that can be applied
> independently from "[PATCH RESEND v5 00/26] plugins: Allow to read
> registers" as suggested by Nicholas Piggin.
>
> Patch "target/ppc: Remove references to gdb_has_xml" is also updated to
> remove some dead code I missed earlier and thus the Reviewed-by tag is
> dropped.

Queued to gdbstub/next, thanks.

>
> V2 -> V3:
>   Added patch "plugins: Check if vCPU is realized".
>
> V1 -> V2:
>   Rebased.
>   Added patch "gdbstub: Fix target_xml initialization".
>   Added patch "gdbstub: Fix target.xml response".
>   Added patch "gdbstub: Replace gdb_regs with an array".
>
> Akihiko Odaki (12):
>   gdbstub: Fix target_xml initialization
>   gdbstub: Fix target.xml response
>   plugins: Check if vCPU is realized
>   contrib/plugins: Use GRWLock in execlog
>   gdbstub: Introduce GDBFeature structure
>   target/arm: Move the reference to arm-core.xml
>   hw/core/cpu: Return static value with gdb_arch_name()
>   gdbstub: Use g_markup_printf_escaped()
>   target/arm: Remove references to gdb_has_xml
>   target/ppc: Remove references to gdb_has_xml
>   gdbstub: Remove gdb_has_xml variable
>   gdbstub: Replace gdb_regs with an array
>
>  MAINTAINERS               |  2 +-
>  meson.build               |  2 +-
>  gdbstub/internals.h       |  2 -
>  include/exec/gdbstub.h    | 17 +++----
>  include/hw/core/cpu.h     |  4 +-
>  target/ppc/internal.h     |  2 +-
>  contrib/plugins/execlog.c | 16 ++++---
>  gdbstub/gdbstub.c         | 94 +++++++++++++++++++--------------------
>  gdbstub/softmmu.c         |  2 +-
>  plugins/core.c            |  2 +-
>  stubs/gdbstub.c           |  6 +--
>  target/arm/cpu.c          |  9 ++--
>  target/arm/cpu64.c        |  4 +-
>  target/arm/gdbstub.c      | 32 +------------
>  target/i386/cpu.c         |  6 +--
>  target/loongarch/cpu.c    |  8 ++--
>  target/ppc/gdbstub.c      | 24 ++--------
>  target/riscv/cpu.c        |  6 +--
>  target/s390x/cpu.c        |  4 +-
>  target/tricore/cpu.c      |  4 +-
>  scripts/feature_to_c.py   | 48 ++++++++++++++++++++
>  scripts/feature_to_c.sh   | 69 ----------------------------
>  22 files changed, 146 insertions(+), 217 deletions(-)
>  create mode 100755 scripts/feature_to_c.py
>  delete mode 100644 scripts/feature_to_c.sh


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E368271C7
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:48:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqvN-0008Pp-Cr; Mon, 08 Jan 2024 09:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMqv2-0008P7-Hf
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:48:01 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMqv1-00057o-2s
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:48:00 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-556c60c3f9aso2301975a12.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 06:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704725277; x=1705330077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h1zjyM5K94HNzD0G3uJzO/KMoQm+1Hqsn7WyA7Mglyo=;
 b=xqGEtCSZsQhF2AwhLthfObhgn3rN8D9xZSorGOcykc2VYt7Av+5rt2H52bkVhN2Nol
 DqrKEonl/AULVaBJZzmaaZbBv+6i5eSnwlin/4iozirxUyIuYzv+YyCuGaVYVhRhQTqV
 LOrG8Yq4M5MIzjvGFG+aQG5aHHm8+ThyYSNnZfsg4lNssN+DxnqJRcm30Uix9FgbJiOf
 XC7T/rIomu4oApdv5sAO+WJtLe+vrckMJDDQqi23Dxv5caGrcbfJZ4xy6VaOqvQIT4cY
 sKMJOcQE15bT7+wV5gk47ic7YF2/954yaaT4KRgnyq+O0SCYsXef0Uj37MOT5kGwh9hO
 TNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704725277; x=1705330077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1zjyM5K94HNzD0G3uJzO/KMoQm+1Hqsn7WyA7Mglyo=;
 b=bj2CDs/hJyTaicdrHOBDL2qvNTpOiDBhW4VpwQslk2eFyDskZsDWfHsvH5r4k3acjF
 hFUN4+efz49ymHOc9l8u37JcTZuJoQ4YyIKxUN6IIodvi7Vw92BaahuduDqgudRtwWRj
 3MCgbSaogeY8//MBCjVwjcdIPYfiDUmjtFy2DYjepP+/k91fHoTHE6EFRZEFZ5E1NErJ
 89gCz2WjJB5hhVhE9TBbWM2EERbjuk2jgtpHe7SdzyWzDPHgaPsvUXaiCnh75Yug022+
 UzsoZK/oNB+Uv0U/c2yztI0+ror1vhUrDeDYVjDMru0hTWapcaBDIrF+VyoxuPBEvUr2
 FUdQ==
X-Gm-Message-State: AOJu0Yyx2EUMS0jjQ0Aqvg5uR5d7HdogG4ctPAkfdLT0uK1RQFoBxUf3
 5VC7vZp5WLdERPO6vLc/gflsosnci2tfiaAqOY2OHP1NyHOccg==
X-Google-Smtp-Source: AGHT+IEKlkHlvLr16a5dlUGEqNkcLnbglcyX1UP7iaki/JyCs99xwy6AcYQujK2eoDd5pbS8nm4CzypQzag3sSZb7xs=
X-Received: by 2002:a50:9fcd:0:b0:556:51a4:1426 with SMTP id
 c71-20020a509fcd000000b0055651a41426mr2862716edf.0.1704725277617; Mon, 08 Jan
 2024 06:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20240106181503.1746200-1-sam@rfc1149.net>
In-Reply-To: <20240106181503.1746200-1-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 14:47:46 +0000
Message-ID: <CAFEAcA9o=ep2AjYS6e7q9g-mYZ8eM8iPfd9936k__jaDw7anKA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add "num-prio-bits" property for Cortex-M devices
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alistair Francis <alistair@alistair23.me>
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

On Sat, 6 Jan 2024 at 18:15, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> This patch series builds on a discussion initiated by Anton Kochkov on
> this list in 2022. It allows setting the appropriate number of priority
> bits for Cortex-M devices. For example, FreeRTOS checks at startup that
> the right number of priority bits is available in order to guarantee
> its runtime structures safety. They have added a configuration option
> to disable this check when running on QEMU because QEMU always use 2
> bits for Cortex-M0/M0+/M1 and 8 bits for other devices.
>
> While this change allows the number of priority bits to be properly
> configured, it keeps the same default as before in order to preserve
> backward compatibility unless the SoC configures the exact value.



Applied to target-arm.next, thanks.

-- PMM


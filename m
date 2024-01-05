Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0AE825955
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:47:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoGX-0004fs-Ix; Fri, 05 Jan 2024 12:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoGV-0004fV-OX
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:45:51 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoGS-0005Wr-R6
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:45:51 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cd20d9d483so22152861fa.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704476746; x=1705081546; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tt2KkEKR/O3GKUqEJluYFu++1FBZrwVdsu+Pdswpigo=;
 b=hCfyAKdavCJuka5JaNmqthHNa/sTLOwQ2mmjm3vV6woupkHxoONcWeXKyIRzgK068g
 jZzddLWKZo+0j+ysw5Dzx2UicjIHUNLKF+zKD8knWmRJ1iPk4TJhxn3TXGnD9Ra0/jDK
 npNVaaiRt6yxqYjFPksLYSTLAxcaBFDT5J1B+Ol9pyIP/DwLdB2YzLJD+NF/AbxlzEdO
 2acrGQxmJ0CXXy3sf7HGFBXzQLtPlS1YjN+UvE+aHY1Z7vSL3PyxF9+TZOe7hybKqa/Z
 xMiZsIRP+8Lg1xfxjyP0l8MrrapmUQSgrUJwpjIqD8UyD88B2pT5C8TFuZ/WQJqKJr0p
 DjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704476746; x=1705081546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tt2KkEKR/O3GKUqEJluYFu++1FBZrwVdsu+Pdswpigo=;
 b=v/PFSMWDPi95x/hvq4DfLkVqCtuUb8D2Bh5bAgrzZzt1MSfPtg/+0s8IY5VBrf3v4B
 MK9w4wioepLmgsPqiXAaWRaqSi8yU/7gm3/BzV/z9agOcllhUqOSzypWqb+Ba+u3o0b9
 pSFglHtYI8ldD4y0BvO8mBrFSwNSYsngb0jnrw4u9IW18HejY+PAq209v77hGrz/7w0M
 E2vtQwhnGjSoHzYVrEbIVt4aOl/E+lGeXK9evZDxdzOXtoHOP7yb7rYWIaBlGE5EBfwJ
 4lhfZLlSeCVjZxgzODaWNtbFuT/eM8IHx1VoobfEP4/QXMgDVNp+3FtTG7uFdya8/vc/
 LO8Q==
X-Gm-Message-State: AOJu0YzYtP8pkuPpwZIg2uqexwLewbNeeWySpRTKspphFC5xSz/Fsj9A
 tapNlKfLlzXq4e1Gp2mUgOrMcijTh8dTKaZTfk5jAnx+AL7pyQ==
X-Google-Smtp-Source: AGHT+IGofl3TpoHa4jr8Ub3QXAq7Ot+Be04up79nRyJimlRUsvzPyrVLprHi7KmQSswZz7PaOSx2+qJqWWEjEdTiJmI=
X-Received: by 2002:a05:651c:1a07:b0:2cc:866a:79e6 with SMTP id
 by7-20020a05651c1a0700b002cc866a79e6mr1713551ljb.10.1704476746543; Fri, 05
 Jan 2024 09:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20240103155337.2026946-1-sam@rfc1149.net>
 <20240103155337.2026946-2-sam@rfc1149.net>
In-Reply-To: <20240103155337.2026946-2-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 17:45:35 +0000
Message-ID: <CAFEAcA8oWpr+AO0tENSyS_ExPW8F5wLp5+5cDFF6gm0pQnAcCQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/intc/armv7m_nvic: add "num-prio-bits" property
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Wed, 3 Jan 2024 at 15:53, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> Cortex-M NVIC can have a different number of priority bits.
> Cortex-M0/M0+/M1 devices must use 2 or more bits, while devices based
> on ARMv7m and up must use 3 or more bits.
>
> This adds a "num-prio-bits" property which will get sensible default
> values if unset (2 or 8 depending on the device). Unless a SOC
> specifies the number of bits to use, the previous behavior is
> maintained for backward compatibility.
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> Suggested-by: Anton Kochkov <anton.kochkov@proton.me>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1122
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


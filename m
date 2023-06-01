Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3D471EF3C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:39:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4lKc-00019E-4D; Thu, 01 Jun 2023 12:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4lKZ-00018q-Ol
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:39:19 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4lKY-0008Se-28
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 12:39:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-514924ca903so1626893a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685637556; x=1688229556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uv9luzTU0p6UXz3uluPT2PgWXkOyXiF0blju11cjGkY=;
 b=kWNPuYVap0se/5owakJf/E91FL52n/3I/PJxytzY8mIM3o9Uv6/ExcWjqwi27exUjc
 dX17zVbVSnwZ3ZBp863/TML+jgc89Q5Eh0MIgKV/MohqH5tBWN4Tfk34bPKOhSBN+Dmy
 28AlWkLQsbm7wyYIZs7c+smd/MraNrj0FtbmmtiS0dbVdZD/M0emwM1Ju/h3VG4rNNTA
 +W6/vPYZCLmnHk52zkBfwfWIcxZshsnvffqdd98D3XD86nVbcT35RUeOd2CD0LfRdZhF
 cjUxgT4KYAcX5KandxQDKem5vsauWsWmpo1bt0X+u4Wob/7eENEyUH9soNuTsFiCpD5t
 iWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685637556; x=1688229556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uv9luzTU0p6UXz3uluPT2PgWXkOyXiF0blju11cjGkY=;
 b=cwcBITizB4mWnZgqvpgsr+mDX8m2HNY8biSfOEiz3CxHZR0HbEmc9IA4ea8IYbBpPM
 FbyQGLX5acZuWxl55FeBZfZkrbNnOq55wsevFKmW56n3syJpw1a4Onkm277WO9FG4OjL
 Wm8i28bnaf19RbnrPHimiuMDpicE+Gi3jc2b02tmF6EDvesAIsiTZ1GqelWWbpGQ6A4q
 YAMtvgNaknCLhR0T4JkzifB/oHFZOzO6TgSWsbBZtfbOVyviQ4DaRUHZ0rYlwH7IsPyZ
 BKCfE7AxK7+t/k4J7ewEYotF11Ua+suBJLLzJOx4aSW4/TJXLsLlb7t+QRf0S0flyy7a
 aipg==
X-Gm-Message-State: AC+VfDz52HnVdOD4aa3wmaDEmy38tvRkcgM1DqYeW1SNyCGSvGoh4bJu
 mv4LnlUbxLImEfT086C8u6ZDJZcysO7yWPngUKpYdA==
X-Google-Smtp-Source: ACHHUZ4Qq3eb+wNofO/FLZ/8Fkh/AI/BwbVzB8lb/991pHZEQO7SLA5baZ4Un3mjrrq7w/w74+JKx6bWpwMUXGotBtY=
X-Received: by 2002:aa7:cf90:0:b0:50b:d553:3822 with SMTP id
 z16-20020aa7cf90000000b0050bd5533822mr332048edx.7.1685637556064; Thu, 01 Jun
 2023 09:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
 <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
 <CAFEAcA8h9-YWUYsvuERttmsEK3xi+K+xasFdoWmnFm26S6npNw@mail.gmail.com>
 <b663fb55-dc8e-9fd8-9d82-7e693c3c4ad3@quicinc.com>
 <CAFEAcA_9Prr1xV2s1q2+GpWEnrsEEFT57bbLDnop5Hw3MaxM0A@mail.gmail.com>
 <da42c1fc-4adc-5eaa-2d72-6747b74f8ae8@linaro.org>
In-Reply-To: <da42c1fc-4adc-5eaa-2d72-6747b74f8ae8@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 17:39:04 +0100
Message-ID: <CAFEAcA9pUGUa4ev_y3U1z1BdU+AaGGKtRMcQjC5prvWvT9AWEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Graeme Gregory <graeme@xora.org.uk>, 
 wangyuquan1236@phytium.com.cn, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Thu, 1 Jun 2023 at 16:30, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 1.06.2023 o 17:01, Peter Maydell pisze:
> > On Wed, 31 May 2023 at 17:37, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> >> Ah, thanks! That explains why we did the thing that made no sense :)
> >>
> >> To skip the migration hazard, my prefernece is we just leave the EHCI
> >> device in for now, and add a separate XHCI on PCIe. We can drop the
> >> EHCI device at some point in the future.
> >
> > Why PCIe for the XHCI and not sysbus? At the time the board
> > was originally added the argument was in favour of using
> > a sysbus USB controller (you can see Ard making that point
> > in the linked archive thread).
>
> So something like below? I only tested does system boot into Debian.
> To make it work also changes to EDK2 would be needed to list XHCI
> controller in DSDT.

Yes, and you also want to drop the useless EHCI controller,
and (as you note) both these things mean firmware changes
so presumably that's a version-bump event?

-- PMM


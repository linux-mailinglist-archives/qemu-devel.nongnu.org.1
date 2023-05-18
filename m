Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D208F707EF8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbXp-0004ub-Oz; Thu, 18 May 2023 07:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzbXl-0004uD-FI
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:11:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzbXj-0006U8-VB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:11:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f4271185daso18353725e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684408294; x=1687000294;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZ3nQMGOxUQHSwfAZvqeRwdh0cwuqvViTTcbn2Dkiq4=;
 b=BrIafM9tzS5YqB3/yLQD/gcWXGhlzDL4BHRK6yjKsJpI4N9p1bA5dOCBzAqa65Wznv
 Mw7koBNq9QiOVK/OWpQf0DEl+qn2L4BjUJbHuQnjBn9Jicbsxzc+Dutg0l31xEPWTxUD
 XWpjEZKBKvnORvbYxUrg9PAKC0fHEyzufLifK9Rce179QtHBhL+k2Oj/Wdgm30/3Pjqk
 lwnSDwb3D9y0UX/dKJfvfJTR1iFK2nv1WbiMN1bmrLqtKNw2P4UCDOSzb6+d8AUIZWE1
 qMfK0v9dnmcFD9guZ8eYVick7GfYY1MMBNLy4el9wOWE7kA7fW9871ODrlJg1Vmk/dE2
 X3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408294; x=1687000294;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NZ3nQMGOxUQHSwfAZvqeRwdh0cwuqvViTTcbn2Dkiq4=;
 b=LmwifbBabI3kM2zS+veoG5WG3bDxUmsq3QieM3EedpKANwXHwxqlTEnwXPEwhvkAP7
 IjJC8+2dm5OKyqM8epFOUjPSo/dmeVVKB4wgIDAf3DQ7BxZadoE33effZMg0e6sAbKYd
 rSLs5Myq2kRGTowokZhAYyD+msDwRBwjz/oxMprKcH3gGOc6ejCpzRksszKp1JrR6gyb
 c8/oDQ4m4jaeJL+SVnnc0WHapfa0P0dcuX53GmhsNsf/tjiPo/jhNmCT5TuZefm8Cr8g
 wLXUQn2itCbaPY2GIryk9Gj5hj3qNucM64J+laC9OXLGhkuj/uORSyqAd8drn2Nu6u1w
 MCpQ==
X-Gm-Message-State: AC+VfDy5Ija73Z/1TrWJQk5HsxsKQFzIpQqOKc2EleEfH0JKQZC5tleW
 SYNkm59xMIkNsTunwjSFtPrszA==
X-Google-Smtp-Source: ACHHUZ7/Hlb3L5dUKkxNeNY7ToH8X0V+XXJth9gS7JYdkMgDZ9WxlY3xrvPV572q82c3c7dvDdjAfA==
X-Received: by 2002:a7b:ce09:0:b0:3f5:14ed:80bf with SMTP id
 m9-20020a7bce09000000b003f514ed80bfmr1248525wmc.30.1684408294068; 
 Thu, 18 May 2023 04:11:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r11-20020adff70b000000b003021288a56dsm1783010wrp.115.2023.05.18.04.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:11:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0EEC81FFBB;
 Thu, 18 May 2023 12:11:33 +0100 (BST)
References: <20230516104420.407912-1-alex.bennee@linaro.org>
 <CAFEAcA8fu-+YUeuhVw8mpgYXO=ueXrCecC-LkhFwoubUkMvg4Q@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anders Roxell
 <anders.roxell@linaro.org>, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>
Subject: Re: [RFC PATCH] target/arm: add RAZ/WI handling for DBGDTR[TX|RX]
Date: Thu, 18 May 2023 12:09:47 +0100
In-reply-to: <CAFEAcA8fu-+YUeuhVw8mpgYXO=ueXrCecC-LkhFwoubUkMvg4Q@mail.gmail.com>
Message-ID: <87a5y1nbbv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 16 May 2023 at 11:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The commit b3aa2f2128 (target/arm: provide stubs for more external
>> debug registers) was added to handle HyperV's unconditional usage of
>> Debug Communications Channel. It turns out that Linux will similarly
>> break if you enable CONFIG_HVC_DCC "ARM JTAG DCC console".
>>
>> Extend the registers we RAZ/WI set to avoid this.
>
> Applied to target-arm.next, thanks.
>
> (In theory we could implement the DCC and wire it up to a
> chardev, which might be a cute way of getting early debug.)

I wondered about that - does DCC give you anything that you can't get
with semihosting (which I think also can support earlycon)?

I found it a little unclear if this is an always available feature.
Should you expect any modern Cortex/Arm chip to support DCC when
attached to jtag?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCC832EA4
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:11:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtJE-0007ZF-Gj; Fri, 19 Jan 2024 13:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQtJ9-0007Yp-Dk
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:09:35 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQtJ7-0006W2-R0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:09:35 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-55a34e08775so3046607a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705687772; x=1706292572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ka+tZ98I4RebCKjSaYFNELphOPWKiUktZA8UV6N1nR4=;
 b=NjUf133k9tdnn2NbFKTisVXKBiRsi/Zv99Kd2ZuOM2RfrowLXPPVQaa0D93dpOzgek
 un0+y5K50kCSG3w/Ge6Ondcvwi56iwljp7kUzEL/7OdLGrI2Z2TwY3VS3MCgCwGKlTdM
 OZaQRlbi1YrzVO89S7SOPf2IiWmgOyKllz3lJsNBLMPblcSyfskvd2fAJwv2Ey8bDhs/
 yf3lG+6XigLOIjHLgLTWFzErqMq2znuB1A4YqAZmcysq34SmCbt1+6ttQW8s8IrfpbK+
 kYSTx84gtvsUnLLlq2TTc5dPwmGhZcFeNxxIyK0P+KfILpjeK18QJKIT8td8WaieIp1D
 EXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705687772; x=1706292572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ka+tZ98I4RebCKjSaYFNELphOPWKiUktZA8UV6N1nR4=;
 b=KXdaU2ylalRVgvJlb2cLDkGLyszjGj3ZokFI3nQx5hjIzln6cFqlFi44M03dYrTQuL
 5fl1M/ao8b0U8xOoWM7Gt16hIyDzznrfyqEyIFWVjwfPh6R17UK3Qmhj6a84GlReW4+7
 LRQ8nhg9Oig/VSAkXQYII9DItjydjjuOso03QBuKc1LFldSdEOqrzJT/bWqkuS0aTbhm
 iFhWF4VwqTpvO0Z+gdBC6OruF6Lpdgi0xNN8Ehxc9LasMS80WvmP0euEscG/AdsMbSVN
 NXgJrTo7epp8R0pkEpbamJ6q2QOrqfQ0EmKumz/dRsseQSmRMnC0nZ9Lka7BQ1OkUqi0
 CR8g==
X-Gm-Message-State: AOJu0YwmeFyceGN+V4441ywVZhEh+4hCynj4oB/FIEZ4ytDKhgSoxSk4
 A7kxSW/t8MplzTQUUdvTX68KPVMcUcNbQydt5Csamscm3mNRDYrx5ZZaukZkFdtdLW7t2iWxDFp
 XuiWWEE6Q6TPq3FPP1D7AHpaHTdYeRlzJ4LEgUQ==
X-Google-Smtp-Source: AGHT+IH6YCYWaUoOMDt7utojgTHGk9T2jLCxk9qdIrGqALHUenS/OCV61NvN4WF17TmlRNIUHK2XlkjcdCmhWASsuu0=
X-Received: by 2002:aa7:da43:0:b0:558:f2db:1ce7 with SMTP id
 w3-20020aa7da43000000b00558f2db1ce7mr1586459eds.12.1705687772017; Fri, 19 Jan
 2024 10:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20240118200643.29037-1-philmd@linaro.org>
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 18:09:20 +0000
Message-ID: <CAFEAcA93c0aq3wN8zXG9C8tb8JdDVOwxjQaFcs8MxPtGRDE=Rg@mail.gmail.com>
Subject: Re: [PATCH 00/20] arm: Rework target/ headers to build various hw/
 files once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Auger <eric.auger@redhat.com>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>, 
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Joel Stanley <joel@jms.id.au>, 
 Hao Wu <wuhaotsh@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 18 Jan 2024 at 20:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> In order to fix a bug noticed [*] by C=C3=A9dric and Fabiano in my
> "Remove one use of qemu_get_cpu() in A7/A15 MPCore priv" series,
> I ended reusing commits from other branches and it grew quite
> a lot. This is the first "cleanup" part, unrelated on MPCorePriv.
>
> Please review,

Applied to target-arm.next, thanks.

-- PMM


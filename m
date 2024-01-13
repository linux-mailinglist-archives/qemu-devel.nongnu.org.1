Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E282CCAF
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 13:29:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOd7F-0000xL-Sx; Sat, 13 Jan 2024 07:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7C-0000wN-66
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:27:54 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOd7A-0007md-KF
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 07:27:53 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a28ee72913aso1415505666b.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 04:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705148871; x=1705753671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=atfGxe1vLKTGP5SfPWMvrSFlCNgr5XOCwebov4xxLik=;
 b=YwKqFkYMSyeblcSDHlbS146eGKcXg5pAHej0lDxTsenJ0UEkAQLUIgZ35RjB2vf8Dj
 fHVOhPO/Qe7QTrHOGslKtyc4RjsqcTlrzubkPyypHR7Nh2JhM+l9H4u2/0fDwOLPfW9C
 m8S58sc3ZIyhxUE3awo+9Qs6+9Vlr4k/rMKm9Zni6sg5VTFigKJ/tn+gMkxGJrgx4AbC
 peOR3Bp96BuJ2QW2coSy5rSSvjNMS/5CtBXpwAIKvpEXVrRc1xS4N64g4TcS+mveFMH4
 0AqPXLbjkq1DclNHiSAZgF97msJLmu4OQ8tQDyjS0gAuMF6SQPvVPBWK9/xA5f2sdMqb
 wzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705148871; x=1705753671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=atfGxe1vLKTGP5SfPWMvrSFlCNgr5XOCwebov4xxLik=;
 b=uy3AyIfjUYhSAVulUGW6FNu5Ejj1BFOOE+AP25ceB8QO8KVScMhYkXsqBADy2vFtY3
 siooEBp6u2yRWVl8BMdS5L7dFYrnHkKIZsFWjZSkVRZUzOFVNyMDWtTjgjex49M27Kiw
 xBIePzIqFKc1CLA2nEgK68ejAzmEyQVdlgP8557F+r5+qZNLV9cP7BO7DNH+LY1a86Q+
 r7ijxnXAsmni2OTWbTTjwPmhmOs+qWxX6H03R0j8eElY+2QrPWC5btmgpfUXuXXAgi20
 ccOz5x+oipMvcXn0iz11l//rmidFfY8QSMkwLdbxDXInCAjcd5LN61DZDWHsrDw3Hz3j
 pLBQ==
X-Gm-Message-State: AOJu0YyokGX2T0m2WI/DcfhNc8LU8xeAUk8DJrcIZ0tLNcEr0NtZHDD4
 UNDAXqD5HyFJPrs1XBnJ9VBtAmK2m9vj52hLCsS2kGEYkdQ2Ow==
X-Google-Smtp-Source: AGHT+IEQ+UdMfPDxUAHKPNSFx23Jxt21K5b8XMdNcfWOk/mOfIMPo8Cpv3hdGMP9+0pptZezTctTG/vbCFRRXBkGPDA=
X-Received: by 2002:a17:906:6ad4:b0:a29:d805:20ec with SMTP id
 q20-20020a1709066ad400b00a29d80520ecmr3218437ejs.22.1705148870986; Sat, 13
 Jan 2024 04:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20240110234232.4116804-1-nabihestefan@google.com>
 <20240110234232.4116804-2-nabihestefan@google.com>
In-Reply-To: <20240110234232.4116804-2-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jan 2024 12:27:18 +0000
Message-ID: <CAFEAcA9BmpHNbf_MkD=VOqmr+N6dvw0bUti_eYCA2Xqf9kTByg@mail.gmail.com>
Subject: Re: [PATCH v12 01/10] hw/misc: Add Nuvoton's PCI Mailbox Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Wed, 10 Jan 2024 at 23:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> The PCI Mailbox Module is a high-bandwidth communcation module
> between a Nuvoton BMC and CPU. It features 16KB RAM that are both
> accessible by the BMC and core CPU. and supports interrupt for
> both sides.
>
> This patch implements the BMC side of the PCI mailbox module.
> Communication with the core CPU is emulated via a chardev and
> will be in a follow-up patch.
>
> Change-Id: Iaca22f81c4526927d437aa367079ed038faf43f2
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>  hw/arm/npcm7xx.c                   |  15 +-

This patch shouldn't be changing this file: all the code
that adds the device to the SoC should be in one patch
(patch 2).

>  hw/misc/meson.build                |   1 +
>  hw/misc/npcm7xx_pci_mbox.c         | 324 +++++++++++++++++++++++++++++
>  hw/misc/trace-events               |   5 +
>  include/hw/arm/npcm7xx.h           |   1 +

Similarly the line adding the include to the SoC's header
is part of patch 2.

>  include/hw/misc/npcm7xx_pci_mbox.h |  81 ++++++++
>  6 files changed, 426 insertions(+), 1 deletion(-)
>  create mode 100644 hw/misc/npcm7xx_pci_mbox.c
>  create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h

thanks
-- PMM


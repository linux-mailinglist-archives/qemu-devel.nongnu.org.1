Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F917CC214
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsidy-0005FB-Uz; Tue, 17 Oct 2023 07:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsidu-0005Ao-GW
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:53:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsids-00057V-0t
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:53:46 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507973f3b65so6478287e87.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697543622; x=1698148422; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QOOY5JrfO4GpTG8CZNRDaBIYx08D0HRbf1Tnt5GUlMA=;
 b=npyDSJRJ4FBaS0CFzXijHNEqd/mElgDHp38XfO+dWerYPh40w9VGqkHrEnDbW10WN2
 6AXZtELf6w2RWViT7j0f3NlzExxT2hQpdHr6C95/VK1L+rL2Bi7kigdkHKIQiOR7ZuLB
 7jFdDXa+J9SUdIw4IipSKbNI/H14mAsDD1XAnasHn9YjoqssWbWZvXbqliWns72Ze4t+
 x0Rz+8kCzHqvYszlZWppox77oFONYSNqGDTtzbIY1p1/cEUKERstjilkNSGjBC4PYDhD
 rmtWXDGT7ickPioJn9HECWCKHQLHIQRNVm01mG8tLei4OsYd5d6KSPmhkxVp85b10nm0
 DA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697543622; x=1698148422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOOY5JrfO4GpTG8CZNRDaBIYx08D0HRbf1Tnt5GUlMA=;
 b=qyltdsquW5BxFkGRpaYUaybJLiu165jrqYbZhjtYcye5bZCiHpPaT9yI7cCBSNvp4k
 nEAE87W70zMz//Ci2w9DADZ4yWFJAq45Anm7QZAAH3HpCbT0Gu9Vye3opHSMHoBTEM85
 Tqtqm2yNQaNWLx6jRZjjk+So2C+f+6tMadZe2lfNPBb5KCLomVti4x2o+sC10rh9BgKk
 8yDFJaAIMG+vE2VymsjvXDzOIg8WGrtPEsvFYjWfMFzFkhTytr2sHVaEC/ccqFKL4Cl2
 xY1mR60WJQUBoirlvp24SL3zecf02LpWdbMtTI41N+fWUJRSVDBcgYZzgedS81V9amka
 +DbQ==
X-Gm-Message-State: AOJu0YyvIdvlsXcFai2Bq9CyRgK0dHL+WzrUwXBdro9v5MFM+U9Itn3K
 pTmY9B13JcXIUbf5LLkDv3OUaAY+gUnlGGxVldL6pQ==
X-Google-Smtp-Source: AGHT+IGSrXjY2sQ9bwZFYf3XqrHoHOBvMA1dRDGTQSSHSgRn4oxN9ztYP4vVsZ7twq7WocR7ZS2Qy5SkutH632PAFOQ=
X-Received: by 2002:a05:6512:450:b0:503:1d46:6f29 with SMTP id
 y16-20020a056512045000b005031d466f29mr1489862lfk.37.1697543622302; Tue, 17
 Oct 2023 04:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230919090229.188092-1-quic_llindhol@quicinc.com>
In-Reply-To: <20230919090229.188092-1-quic_llindhol@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 12:53:30 +0100
Message-ID: <CAFEAcA8_05mkFSqsA7NR3dP3UYqF3h0O6_SEEn_7N90FcKCQ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Refactor PPI logic/definitions for virt/sbsa-ref
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Tue, 19 Sept 2023 at 10:02, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> This set reworks the handling of private peripheral interrupts in virt
> to use INTIDs instead of PPI IDs, to make it easier to cross reference
> against Arm's Base System Architecture specification.
>
> It then breaks those definitions out into a separate header and switches
> sbsa-ref to use the same header instead of defining its own values
> locally.

I've applied these patches, with a few tweaks to patch 2:
 * the macro PPI_TO_INTID is unused, so I dropped it
 * I sorted the defines into numerical order
 * I added ARCH_TIMER_NS_EL2_VIRT_IRQ, which fixes up a
   minor conflict with the recent sbsa-ref change which added
   use of that IRQ

Applied to target-arm.next, thanks.

-- PMM


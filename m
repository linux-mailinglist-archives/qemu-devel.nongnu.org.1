Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C57E059A
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 16:35:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywB2-0002Km-FW; Fri, 03 Nov 2023 11:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qywB0-0002Jv-Av
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:33:38 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qywAy-0005YV-MJ
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 11:33:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e2308198eso3761115a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025615; x=1699630415; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I9QQ2Kb1TDHTSTEXasTasc4uaT9oP1TN/f4o+aoanwg=;
 b=NHgL6b/8avCLVRy+CVBYSCPBSy8eed/5nZ/aJu2OlPK3hkeLwWLxTAsTKlIeUnEIz7
 aiVtbcPU8RjeTBhMfUduvlaW8XzzOoDr4FE6iAFVnCHrQbR+MfA1Jq0SLYQBI5QfeDq0
 uIysPJyut9vc0ZZ5rNkOidBOPaciPlC53cQ//oG0+bXooqJDEbnZLFxUCoH4q1T5v2Sk
 M0mu8VPnsDne6yEdjHOWXehkmLB3rkUt7uMSCBuOki/LDs5h2z0n2T+zmsTOMt2WlCAD
 cEnFBA/LcsSRIW+Jf7x50CIqx2uWmhzzyusLfuAoulXI52if+gkIy0KI3axPTRTeBUcB
 Bv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025615; x=1699630415;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I9QQ2Kb1TDHTSTEXasTasc4uaT9oP1TN/f4o+aoanwg=;
 b=SpNqUZ8gSy/+A3CIjtSGa4BCpJcT2dxh6RqVPf2oHeqwcB/nDmiDLsp/3uZknAW5iE
 iXKjK8Ywnx0HgRjIi2k9lN6yLOgdEQv0E7ktSf6PiHhhTpx7Te4B+Xz4qnUplp6TxJn5
 2S37tg77rnRy32lpXund11vNIGiX4wPI+tq2Iwxa/bBwJA04/IVbGRr8spvH8WRokqKp
 7H5KK6S7vliCzwaeepl6N9cW0FtlEaXvX7Eg3suphANP6JIesFgIIp4pqqtNgCGlRS8t
 WJAIeJqGqkMLdyeLo5ASX9MZPYsRRpPeExSYv3yL6wymobFH70lAEttaeK4ThaRgKwz3
 u3hw==
X-Gm-Message-State: AOJu0YzQbX0FmdpFiIHbo8DTWnu/PCfeECPIirOnUYUfwhwN1CEtAOVZ
 /4gpGn0QQI0EJAFKTSlnTIWW4b3QgLjW0mo13ycxJw==
X-Google-Smtp-Source: AGHT+IETFZUdV0Rel5A6+Ydik9Y8zfwJPjSI32kqP5K1tAjqXZbcsHecP8aJ0dTlJokb3BxwgBn9AkOTDMwys6ul6tU=
X-Received: by 2002:a50:9b16:0:b0:543:bba1:426b with SMTP id
 o22-20020a509b16000000b00543bba1426bmr5765783edi.27.1699025614992; Fri, 03
 Nov 2023 08:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <475d918d-ab0e-f717-7206-57a5beb28c7b@redhat.com>
 <CAFEAcA_w5fM57L81vpByTnOPvdn455xBXtU7UnHFGuJuq-0New@mail.gmail.com>
In-Reply-To: <CAFEAcA_w5fM57L81vpByTnOPvdn455xBXtU7UnHFGuJuq-0New@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 15:33:24 +0000
Message-ID: <CAFEAcA90SQL3BdH9teaoLu-YLrcijzKpsDqib6KJjZjhrgEm1Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: fix PMU IRQ registration
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Fri, 3 Nov 2023 at 14:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 3 Nov 2023 at 14:14, Sebastian Ott <sebott@redhat.com> wrote:
> >
> > Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> > PMU IRQ registration fails for arm64 guests:
> >
> > [    0.563689] hw perfevents: unable to request IRQ14 for ARM PMU counters
> > [    0.565160] armv8-pmu: probe of pmu failed with error -22
> >
> > That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
> > where the PMU IRQ is actually referred by its PPI index. Fix that by using
> > INTID_TO_PPI() in that case.
> >
> > Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> > Signed-off-by: Sebastian Ott <sebott@redhat.com>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1960
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

...and applied to target-arm.next, thanks.

-- PMM


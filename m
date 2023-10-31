Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF347DCEF4
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:26:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpgo-00054i-K6; Tue, 31 Oct 2023 10:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpgi-00053j-57
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:25:50 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxpgf-0006zw-Tt
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:25:47 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so9383860a12.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698762342; x=1699367142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV3LzPc7PL1PiTxwDU3XSSZS8OxNMaMVGyaMfMydExI=;
 b=TDEg1fiZ8XVfFtY5NVNljvmvZ60/hKxCR/0tebGzBGIy3L3lj0LDp8hYHermWXhcjo
 9vxLmZgm5XkeOf3pC7DNwqLQZqTTH5JyuOrMgP1W86rUDJ1xyvqKmegMq8BQjVaZYfkn
 STb1Ld4K0E7qPpTW30KWR5kCMH1bkGdKIZbXM7axEbv+x4soQpSMsbOVxac8/TSiQ68i
 foViaCwqfsFkLZGthsFIWyd3a2u/Q++D/CMf3lUNdeZ0Y7CGh/4+5QxDeHMoaAOlOF7t
 hlHHtaaDgVK9KUFHJhh4MgVC9zAgQwNlLCTX5Al8Gp1k55xSj6OLmomZQ/wCbJ9hridH
 jFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698762342; x=1699367142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PV3LzPc7PL1PiTxwDU3XSSZS8OxNMaMVGyaMfMydExI=;
 b=Cxwo5PSCQNa9JvOXmIBHmCclWblDmtfGVFb5sZPnu5sZFQoLhg+vkKlmwz5dEz8n1U
 v1GYKp+MELFUMaloDVVUeqdArjFB04idtikP7nmXJhUhDMmN6CXpa9veOegbWqrsc5Rv
 Qbb/DFlojtbGOeyPKNryvvXANMfbr9B1ZAxT6ID+HFY+KPcEjuLLvSyFymc7wmWybSop
 lP9cSISQgyH+SY8MeAtkL9XqA8TLnMIQA8Au1Y27MVCmRuSdOj5xsJa0+dz3foeVbuZg
 ZVRpmLidjw0bZobhSSnmXry7zSO0CzqzJHFlNX/XZu6C/ak/Crep6QBtEs7lCushwJhi
 Cq7w==
X-Gm-Message-State: AOJu0YyH/PQ1NsWXaZTBe5wWLHsom4Y2D0Dsl4LTAnrn/Tmn01Q2LvVb
 ujAzwqm1L9FRnuPGY7cg9gvvaeyJoS2hTjilLCMHYA==
X-Google-Smtp-Source: AGHT+IG34RqoXFVlgq51h1rW3huKmnZHK0eONrGu+poXLH8B07hlQN/gFEP4ZHrG1KOWpwfMcAi7WfqETz6NmzQ3DKg=
X-Received: by 2002:a05:6402:17d2:b0:53b:9948:cc1f with SMTP id
 s18-20020a05640217d200b0053b9948cc1fmr9723959edy.12.1698762341897; Tue, 31
 Oct 2023 07:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231030083706.63685-1-philmd@linaro.org>
In-Reply-To: <20231030083706.63685-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 14:25:31 +0000
Message-ID: <CAFEAcA-PZtTEAT2KtY=5=A-yCwS8rD9OgmnGjrYpBMXzpTV4QQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/pxa2xx_gpio: Pass CPU using QOM link property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Mon, 30 Oct 2023 at 08:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Instead of passing the CPU index and resolving it,
> use a QOM link to directly pass the CPU.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM


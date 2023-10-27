Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F5A7D96F4
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 13:51:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLMo-0001bp-9I; Fri, 27 Oct 2023 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLMd-0001TH-GS
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:50:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwLMc-0007h7-36
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 07:50:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso3305240a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698407451; x=1699012251; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfVCRhTvg2AKt7pFrqXCIbLBZfzHqk8QnIhyroAtK40=;
 b=PouZMVXmrMt3YVgN4kZFftNi1Tt+e4loQKT4Ec/321rVsIoBRohgdH6WaFxGmA2Hlw
 iGI6HCkPubRPUk5VOcfVqoOK41v2AwS5pX8akP+nCxFBAzO+l5Ya+TbcEfdur5CuWtQ8
 Q8FrKABq0bO1DQKtZSk8eTxqYhVU5NLc0mvJhvGqnKSpBweomfcgYnYnxQ4iP+YcI7oW
 MNWctOWfjybeV5M4LwAr/7bc7wCIx7UfJ9shy5C5bsMHEkR2ejv+8qoGL6XhiyH79G6o
 unEsuB2xEiIs4YeyRUpyMk89pqNinKRldTpgFSSg30nTIZ6F4/gMuw0wPXMQ2VlPlm8Y
 NUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698407451; x=1699012251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfVCRhTvg2AKt7pFrqXCIbLBZfzHqk8QnIhyroAtK40=;
 b=S9TBh98SxvX6IrdfFOqAilAJpSEFNJ0i+M/dRAKa0HA3nM8vbiDeA7/LkqhOvXTEYF
 PBPWRM4lDbFNhswVoJyi3ZIjQNxymnZyHEziIcxosB208a0GIp9zvxx9VgA8dY3F5KLw
 qjcolE6K0rqaUlQNIv6doJd1bMrTkakgLf2yW2/rp/znMvnS/0C+UOcJwLaMIE/+1j1c
 GOQEnJadGYrZToZg1BvOe1lg8JB+BtLRuxwaREtqnFqhEKv2+L7fNmrdiiEXzaQ7XHMo
 8Gy7FK4ZHYmBADM6l/y9KBgyA3kozuYS71Ka8wqBBnX60EyfKAoMwat7g2wb2U2oqPLT
 GotA==
X-Gm-Message-State: AOJu0YyFPkf11ag1kRQ3jV6tKD7gsGyOHWj9QioGB8LLvC9QN4vsD5kf
 nrDi8pmMwKpNXqSuNQ7S5RCKz3+7+8ajA2vGJZusoA==
X-Google-Smtp-Source: AGHT+IG0aeDLhSo1OjLoWuLJrj1AAjKrho6QPU3nIfOqWywiZrCtzWubh3NsEhtixnL0rePrmpB0WHpgwJU8KMQZ03o=
X-Received: by 2002:aa7:cf1a:0:b0:53f:6ee5:2cea with SMTP id
 a26-20020aa7cf1a000000b0053f6ee52ceamr1942372edy.17.1698407451203; Fri, 27
 Oct 2023 04:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231025065909.57344-1-philmd@linaro.org>
In-Reply-To: <20231025065909.57344-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Oct 2023 12:50:40 +0100
Message-ID: <CAFEAcA8aspECn4d=V7N0fb8mkJqVSSkRBaCRzMo70T2ZFYzHVw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Avoid using 'first_cpu' when first ARM CPU is
 reachable
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 25 Oct 2023 at 07:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Prefer using a well known local first CPU rather than a global one.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM


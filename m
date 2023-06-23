Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAFE73B551
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCe3t-0003eB-4T; Fri, 23 Jun 2023 06:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCe3l-0003cq-I6
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:30:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCe3i-00036y-Eh
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:30:33 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-988a2715b8cso297044866b.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687516223; x=1690108223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S9ksx/UadnDs5AooqtmHod5cgh8NeEHWBTNiF5vomBc=;
 b=un0r1xr/YYxa2UbuTt270TCXGddSL7VuxcGuJPEwOc4uKfNjNbpjari9y0EV4vAzZW
 sDWZuMn2uha2iy7BV6MuuU+MHOzyfR58saDnegOABSWNIhVLih/iBEDw1xhfrcCa9iM8
 vD0ujbjqvGd5EgJqekIXGK4tqG/R+13pgR2WX3kri2RGZYD1BV28tEUrIFtgK2cZrpw0
 TSlzBmnqpJISLDK5w+gaqn7id2em5nvKiOdc+A3t/jUMXKFz+vhhdrztYk5gWW+EKcbn
 jembeabmVnmFv6EMCgZF3OOvBPu0IAiGI6ITOVNHZmWlrE+2ZIzRFBt+osKREaUR63jz
 nC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687516223; x=1690108223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9ksx/UadnDs5AooqtmHod5cgh8NeEHWBTNiF5vomBc=;
 b=JvBpwBTPSg4j090iLa83UXcNSkFoguYf9ZccX61fFmF9XLXhAWK77LdEnPKI5kVdjQ
 6sxH0v2JSoA6OailDtTVa5UdCGfEp331O51uQryt1LY6mxNLmEUSIRJNA1aVrf04Z3EW
 fwwyawb+6lqCQIffzJYrH+5CxjPQuWmnXWdsZKBETtxlVo9wcQmYkuZVJqzYf0qDKBzR
 bc4yzfzlisPXiHH/lu7iWHmld1PdYIe/oTvIIdhHP7O7DhZEP5UBjowqp+qoW9/Egzh1
 WLoEZbPiNmKJL46ajAIxXcAjNlPPqmVY52WzOlwasvnLts/Z5Iw/6jRULZ8AfyXG4/tA
 LNfQ==
X-Gm-Message-State: AC+VfDw9TpmrGPznMmytoxsSXSxU0kZ5KjUzqAZxBMbtn4CzirmFByMh
 ZDYQYVrItxpFWiGzNiLyaFvzNkSUmWnKH8/rwQgJxg==
X-Google-Smtp-Source: ACHHUZ4ssCFxSHsO11q1x8cmRv9DzCLoK0dHKRkt8gytH1Q3U/t5hg79JC6MRiRAPmAwXsh+MkLG5sLppqfVytSB47c=
X-Received: by 2002:a17:906:ef0a:b0:978:2b56:d76e with SMTP id
 f10-20020a170906ef0a00b009782b56d76emr24672116ejs.12.1687516223223; Fri, 23
 Jun 2023 03:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230619170913.517373-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230619170913.517373-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 11:30:12 +0100
Message-ID: <CAFEAcA9pUPBx2aLtY_2DMy5t3yn=TbhFWhZbTKbXW1g-M+tnkg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] hw/arm/sbsa-ref: add ITS support in GIC
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Shashi Mallela <shashi.mallela@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Mon, 19 Jun 2023 at 18:09, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> In 2021 Shashi Mallela sent v8 of GIC ITS patchset [1]. At that time it
> was decided to do platform versioning first.
>
> 1. https://lore.kernel.org/qemu-devel/20210812165341.40784-8-shashi.mallela@linaro.org/
>
> Now we are going through our list of changes for SBSA Reference Platform
> and GIC ITS is one of early ones. There was decision that there will be
> no option to disable it and platform version will get a minor bump.
>
> This is refreshed version of v8 one from 2021. GIC ITS is placed behind
> GIC Redistributor in memory space to allow use of older EDK2 firmware.
>
> New address is placed in DeviceTree for firmware to use. Due to it we
> also bump platform version to 0.2 version.
>
> Trusted Firmware will read GIC ITS address and provide to EDK2 via
> Secure Monitor Call (SMC). Same way as it is done with GIC addresses
> already.

Applied to target-arm.next, thanks.

-- PMM


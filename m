Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D423770380
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRw6g-0004Ap-Vv; Fri, 04 Aug 2023 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRw6c-00043R-Ei
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:48:42 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRw6Y-0008U5-RQ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:48:42 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe0c566788so3747116e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691160517; x=1691765317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cAWVLc1K7QecAiVqR3cpuGD9GUuVRHI5lMpSMKQ7RN8=;
 b=ppF9fNMDzNj18Vrjz7lQ62hQFvjbVm2dbhpSSi3RHARJhQNmZgr7Ix4FOZZrPslLbD
 BgH70yyESW2QKlgsBAwLJUSOrdVFRflWDgOlqmQYNdeUdX+AZ8Jn11EN7EISbAksAHju
 q43D4i5HJoAHs/fRJdcC5lsno+0hDh3XlheuR3cJbUHx4o9qlQ8z76EB2lt/zbAH2thO
 7r078jW84xH3kxKgCctmgKszSU664v0gi81Swgos7OVLf1Jj92INIu7RMCMXPjwE6d60
 IWuF3Tg237CIpD83aHawWe9ZdonLcee203oWtymA0svVRzJFqUE/vNL9qOV8lUuHhXTv
 4xAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691160517; x=1691765317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cAWVLc1K7QecAiVqR3cpuGD9GUuVRHI5lMpSMKQ7RN8=;
 b=gyf+mD2Vlx6Pmou6e2LbVGpvSBVogWxzkhQXo2lvlm4GPDtW0/pIi8PvJcsYcBFHkc
 1H8qG7UWjpavKZPSEPncyP85uHmDegizK94x0SNMYiU4XYfyEuyQFSE5ZMCm4pa9IpU4
 4hMnB+sQX1xjXdi5JaG9I4EPemnz008qSgba+8o6b16qfiXmkAjXMJfsSBOI/BPZmgMo
 OjXotxDZQKm90UXv86xv19SrAo0nJxee78Mxy1nGe1DGN93cC8G6ryYNPCw3/ffqkWrY
 y5V/jey1wgFSqg7G29UOUxckQ+hCuopntP5Ba5iqnKUWoLGZtBEVZNco6wUdT4QF80Kh
 nRXQ==
X-Gm-Message-State: AOJu0YzGJPbTWcgWpbHk1CUZGGuFvp82PTuhA34FSEvdjxihc2WzPkaC
 fkb9jX3JUy8OG/rM3OK70Qjvg6dgzwsN2ZQTwBP56w==
X-Google-Smtp-Source: AGHT+IGJB3Y+FRQS/1xOozDYWHTrZwv8W0KkqDqFySGQPWmVIGmxZRnmGVlgjxEup4mECxbcC8a9q5x1xsmCzb2Jpdg=
X-Received: by 2002:ac2:592c:0:b0:4fd:fef7:95a5 with SMTP id
 v12-20020ac2592c000000b004fdfef795a5mr1384894lfi.11.1691160517057; Fri, 04
 Aug 2023 07:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-24-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-24-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:48:26 +0100
Message-ID: <CAFEAcA9EXd2r+r1BPH=VpDwJ=nf1Szhg1Lm18B7S5BPsbtgfOg@mail.gmail.com>
Subject: Re: [PATCH 23/44] Add GENET register structs. Part 1
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Wed, 26 Jul 2023 at 14:44, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  include/hw/net/bcm2838_genet.h | 125 ++++++++++++++++++++++++++++++++-
>  1 file changed, 124 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
> index f62b24fa2f..89b45eb39f 100644
> --- a/include/hw/net/bcm2838_genet.h
> +++ b/include/hw/net/bcm2838_genet.h
> @@ -18,8 +18,131 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
>  #define BCM2838_GENET_REV_MAJOR         6
>  #define BCM2838_GENET_REV_MINOR         0
>
> +typedef union {
> +    uint32_t value;
> +    struct {
> +        uint32_t gphy_rev:16;
> +        uint32_t minor_rev:4;
> +        uint32_t reserved_20_23:4;
> +        uint32_t major_rev:4;
> +        uint32_t reserved_28_31:4;
> +    } fields;

Don't try to use bitfields to represent guest register layout
or in-memory data, please -- it's not portable or endian safe.

> +} BCM2838GenetSysRevCtrl;

> +typedef struct {
> +    BCM2838GenetSysRevCtrl rev_ctrl;
> +    uint32_t port_ctrl;
> +    uint32_t rbuf_flush_ctrl;
> +    uint32_t tbuf_flush_ctrl;
> +    uint8_t reserved_0x10[0x30];
> +} __attribute__((__packed__)) BCM2838GenetRegsSys;

Better not to use packed structs for that either.

thanks
-- PMM


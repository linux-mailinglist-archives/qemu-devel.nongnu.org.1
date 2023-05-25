Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95D71097A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:09:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27tj-0001YV-Jg; Thu, 25 May 2023 06:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27th-0001Xz-U7
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:08:41 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27te-0004K7-LV
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:08:39 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-510d1972d5aso3573165a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685009317; x=1687601317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EisLXafH+ZAfhp7I9z0OiXumwDmsVY8hcBpzulyBU4Y=;
 b=jHsWoVOuVsq3QmOWRhIso29bqqp0K5T1OHPVv9iDrBrDuDQdBKovZDO/kgbQR4F0uY
 Vlz2eHFb5IXDxiQIDBy2/ofM/7Ebqk87s8uAKBxiJlBm9HHBZEv3jechJCCXMdhQytnw
 Cog8b+Brpyji1/W1Q0kiF+yFZ8gGsMghb84C0vEdgSjdek7akPFWkP2jgPCOJTXGGZIj
 kEH1tx6wAHRexV+yL0U56PczALx5rdOaf2uQbYivziZcOd3uZDeHgPTFCjVB9TyyY7TM
 1TTAlskTUma0KMBcYsDlYeiLjrkiOxqlBogQAL4tqFDLfiyc3DD2wQNvUGlmKUMc0P6L
 ui5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685009317; x=1687601317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EisLXafH+ZAfhp7I9z0OiXumwDmsVY8hcBpzulyBU4Y=;
 b=J4u70tNF2K3D6ZAVe1B83vGE6VJjHMdhtuhq7jrRRhniGeEbMUUp9nE+oICPui/xKy
 LyD2vbC6srp4tT2qXseILLlARfOVhqjnmNl1U88tvtqjItdLwPxWqrWGUmdB2BUu8pM0
 PtsGPC9knKL2kTIhC2JqMTJY1pTuj0Xvyh02wW7BdW0BybktYDf7PrqgwwjtHZ/aVAw8
 B11oXz7+xOfpH080R+YHrBRMMk43TVoT3FlIvgMGO/vEDN08F+O9xZNRe99T0aguXId6
 Z0l/tDcW7AFXBZmGHy/rBQSO22xCxGg/oItLcCdk29G9icUuQfHewCs305Qv38mf7LLj
 s5xg==
X-Gm-Message-State: AC+VfDzYOWuNL7FtUAbCj0VYquZtI/NVLkxVgM9/bm316sfq9MV7TpuN
 2YQTxf6m/h8C9RKkMB5FcDszkcNNM4za0SPPErQ05wVj9sjAT1BG
X-Google-Smtp-Source: ACHHUZ77O4Q28Eul5vbpSYJgwZSDNDP74V+jTLzVs4B+REO8SYseBQpOD1KB2sRPL2pX1rjFE+x3SKSQzJJTB65OPxA=
X-Received: by 2002:a05:6402:3451:b0:510:ee0f:1eab with SMTP id
 l17-20020a056402345100b00510ee0f1eabmr3415504edc.41.1685009317028; Thu, 25
 May 2023 03:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230524113308.834675-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230524113308.834675-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 11:08:25 +0100
Message-ID: <CAFEAcA8VxcdRvrRN2-pztriakGsXoGhaEcyptJ9z-0rPua0HGw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] hw/arm/sbsa-ref: platform version 0.1
To: marcin.juszkiewicz@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 24 May 2023 at 12:33, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> About year ago support for setting platform version for sbsa-ref was
> added with "0.0" value.
>
> This patchset bumps it to "0.1" as we export basic GIC information via
> DeviceTree to the firmware. TF-A will then take it and provide to EDK2
> via Secure Monitor Call (instead of using hardcoded values).
>
> Basic documentation about platform changes added.
>
> Marcin Juszkiewicz (3):
>   hw/arm/sbsa-ref: add GIC node into DT
>   docs: sbsa: correct graphics card name
>   docs: sbsa: document platform version changes

The cover message subject says there should be 4 patches
in this series, but there are only 3 listed here and
only 3 emails arrived on list. Is there a missing patch?

thanks
-- PMM


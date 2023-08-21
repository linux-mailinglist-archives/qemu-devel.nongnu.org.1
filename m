Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431A7829DA
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY4XP-0001WX-1u; Mon, 21 Aug 2023 09:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4WD-0000JM-1c
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qY4W6-00018O-AF
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:00:24 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so4126279a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 06:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692622821; x=1693227621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eQ97yn9LmhXMkkljav8VxB1MxKDDJ9e7hqeJlzODl7g=;
 b=J1pBAALn6kYCnfJxeVItgjwqQzi9hfRJWuhv/s19vrxqluv1aydCcoSADn2KB+N1R+
 qc7aHL1iwCGQsQmI4P/nHxxh+Klq/6bt3xaBN2d/YEOc5GwTUW1vp4SlqUjVQozcoPAj
 lvE98OZL9an8z3wLegLYSk/AwQBHYL/LzJCnct8G/YDvsLVvivdD2vEWddKhc1G+YKxf
 dSpV8JXMPWb9pdJqqWVrb3nS6EhBfyFrkRx6oGePRlNEDqrVceveFL6NiG3SVTZ/lzkw
 dmeRZ1WFUVZ8RNO3AiK65uADjw6x2gka23sUDCw6pDp4pjoWfvyeaceGKMZLLaG5VKDL
 W0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692622821; x=1693227621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eQ97yn9LmhXMkkljav8VxB1MxKDDJ9e7hqeJlzODl7g=;
 b=cREj/F57xljkZVGyGDu6BtCp99Kleiu3J0emVwxqbGnk4wZIaXJwNziW+7XA92kc5H
 AsKvG2UmS3fVIHcynCLjRLEmpzUUqKpubNRdvMp7gqwq98fnxcEKsGTFcY1/y0DONzpC
 x8klpSh0DjIuAorqPcKd+xPkSeJELALmGGyt1cZX2LIEoGbH5IDkG7+5iG6ePi43xZAj
 G3qngCSQCru6MCgmCdM2vAeSvpR21iurF0r9ZgEKwgwHhZXzy+pendqoMbZ20ciN5u92
 VIGryD75CXrxho9J9ZKPdqXmrKUNvi37qIqSCl1P6OAGc3TmEUk+hRQW04YjX/HJT6SI
 AX0g==
X-Gm-Message-State: AOJu0YxrPy3tcBM4wVW+u+tTEAwEB0qqeU2xX8/vKjaEoUlCfzK7sQtl
 iZeIkbKJY3xm7lyDB+4Eo/ZQ5xWDm6tIulquL0xvfQ==
X-Google-Smtp-Source: AGHT+IETu2l3fYAX/EXJGso6zYLoagGpHSDGAYEuB3q7wN5phpk1c1bMn2ajDt7Qj1fvGuUonYY4Imw51MbhA9m0DSk=
X-Received: by 2002:aa7:d3d2:0:b0:522:ab77:36b7 with SMTP id
 o18-20020aa7d3d2000000b00522ab7736b7mr5663386edr.4.1692622820501; Mon, 21 Aug
 2023 06:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230810191626.81084-1-francisco.iglesias@amd.com>
 <20230810191626.81084-7-francisco.iglesias@amd.com>
In-Reply-To: <20230810191626.81084-7-francisco.iglesias@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2023 14:00:09 +0100
Message-ID: <CAFEAcA-XsRrX-AjhX=nAKSHsm-vgTkYz8JjJyoaG_fjgqO=msg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_BCAST_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Thu, 10 Aug 2023 at 20:16, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Introduce a model of Xilinx Versal's Configuration Frame broadcast
> controller (CFRAME_BCAST_REG).
>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


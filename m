Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC037FA4F2
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 16:40:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7dhc-0007cw-8U; Mon, 27 Nov 2023 10:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7dhZ-0007bN-Ol
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:39:13 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7dhX-00050c-Ca
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 10:39:13 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54b8276361cso943205a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701099547; x=1701704347; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l2PDJzhJCzfCpI7ibyz+gkjE41VqY5k7sYsjfM2g0Js=;
 b=jl0qFRS0kyisYb44x8N3UlLu3K6+GYGczzJME8d+IJfvfsSXa5k6B2Jrl4Xvshvtmc
 jKDXfTLk2qVggZxO62P/91HcU6rBJfv91tW9/qq/DcxqHDptXyQG0N2+2C53C3V10XpQ
 Gu14gKTERH1SCds/Pde9Yl/ETIz9cjQcJ71gIdG4/NaPBavOhGdcNUEbqurT3M6F0ssy
 c8TQz5QNGjC9pIO6TOOJjwfBtgSZaTP6yihgje9Xu1aFuoAf4qZSOudNGTXmEv7He1w9
 502Pox7suJsa/ZzV8ZE+cDDwNInHBaFQmnjKnWfFkDH/NnR9Qi8/Z8taOJV0dWWSXTyq
 nL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701099547; x=1701704347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l2PDJzhJCzfCpI7ibyz+gkjE41VqY5k7sYsjfM2g0Js=;
 b=G1b3UrxQibTnvW1CI9oOJObSBw1AmoYIwUp5erITn7WAjLaewC/yNjBTqx3P1HR5aw
 cq+yA1HBH4FrjxuzlJe/v+HGRg5SOCIKHKhWK8PYdjTXM9xlhcv0ZS0HehHFx5Eh6V16
 CJGl5IMnPqXKgcere9QR8FsF3SY5M8WjProGgSMJfeK/ZYvMkXAikouQww1Mk4UkzlLk
 h84N05d1Rh0C3MeAed7dwOJlk3wzkbh1RORfUyOOo4ju6NNNV7yXqheISuABODGzKm9x
 qHFij/DsoeiPChmkIEzyjPpsXnE/au7M8x5dj0/lekzy4eRumuLZca0mvSPSfdF0totV
 VNtg==
X-Gm-Message-State: AOJu0YwLZD9GLMeZNxGaKFwPRA+lNv7F06KBYzGzPHry0FUNlcz4C60T
 YUVIwTdZH3Sxm1OxQ69+bHCUQAGh0Iq7/CGxfquafA==
X-Google-Smtp-Source: AGHT+IE3bsuF8VD2brV9CC+FHxESlpZBxpGsJ5DJHBe3CekBC42Hx90w5mZHkZqbu3Y6FqjJHI9xgypg1mOoq+K4Fx4=
X-Received: by 2002:a50:c292:0:b0:53d:b59c:8f91 with SMTP id
 o18-20020a50c292000000b0053db59c8f91mr7620026edf.27.1701099547741; Mon, 27
 Nov 2023 07:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20231124143505.1493184-1-fkonrad@amd.com>
In-Reply-To: <20231124143505.1493184-1-fkonrad@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 15:38:56 +0000
Message-ID: <CAFEAcA8mqZHCC5+AWswWvCRXTyxOx4ezxtE5MaB+7irJ0q2ecA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ZynqMP / Versal: various fixes
To: Frederic Konrad <fkonrad@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, francisco.iglesias@amd.com, 
 edgar.iglesias@gmail.com, alistair@alistair23.me, luc.michel@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 24 Nov 2023 at 14:35, Frederic Konrad <fkonrad@amd.com> wrote:
>
> Hi,
>
> Those are various simple fixes for ZynqMP:
>   * 1: fixes a possible out of bound access in the SPI model.
>   * 2: is a trivial fix for documentation url.
>   * 3: is a log guest error fix for the CSU DMA.
>



Applied to target-arm.next, thanks.

-- PMM


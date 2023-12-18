Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB218176EA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:07:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFG8p-00008l-1k; Mon, 18 Dec 2023 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG8h-0008V4-0m
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:06:44 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFG8b-0003B3-Hh
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:06:42 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e18689828so3706910e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702915595; x=1703520395; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ziet/5GPRfY/4z7BJpvIceS9XR38XkHOYidZ9w/7C+o=;
 b=UZzAfGzqKRIb+cXuzSwN2oPFIfanRUB6ZVBcdMK/nRKXRz8WFK3/tic4lDReSj0v4Q
 HYz6C0W4ZdgaILXXl+pgZBHF5hDWWNbEaHf1+LR1Qyc4Ngtbsh7icvMwbcYQC7jeMCwg
 eZR2EdUjozsSUJ2Y5SeUHVr/yh8LSFmzO/6aiKmi0jDSyrreF9I97d5k6qbq0vvsm6E+
 oHfxYMJqoBJlBcOOWOGptDOuFJHiRmRBlFLPfI4SLyBhz7Hp1HkbPnLgnIRhm4m+AzLj
 YhyLXRKBvGnLWxi50YesJFv4Pxovnkxopui8006jYeZhy+GISGaM3C5yY1WZT5tFfnwS
 Btmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702915595; x=1703520395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ziet/5GPRfY/4z7BJpvIceS9XR38XkHOYidZ9w/7C+o=;
 b=pYuGl8s7Rk16UY+8XQGmCH0fNfBEkpJtlJFVQzVfDt7ziuWvKx8N/QDTYlf28IEKHo
 pUUEdgap3E1tf4Cgq3ZqZhBYUKbe6EAsscDMBNht6z/Ha6ttZhl+4A79S4mpei9GKWRH
 qF7/6MoOKg3R39Vd4MQTK9vpDxZ1vTNUDtCybnjrS2h2gqOAp0kfHtdIbDYP4S0YsXer
 BCseaXQpzuGvQqoeeg34XCmnyZNOP2fIWZe4GyXy/EAcSq8QsVSBHBPkpRWY9YU01aZp
 93RkcwjG4g4CJALNDKKRP3XKQWhYMPlEw9v3+pKI7TzJSV826ST2vP1tB81cco3yemCK
 URTw==
X-Gm-Message-State: AOJu0YyuqGQkJhH+10w1LWdliawRKok3vfWcOr9Mr+jKNL4zs3VCPcDU
 IBrR/fq2y7kiUtr4k2Esf2dEVe6VhQNE/R+D/7v7myc6IB0PVfn6
X-Google-Smtp-Source: AGHT+IFdMaPwJKhhStItknBMEvgvK7MQSmizaJ510sBu04bqqgau7P4mo3IOw4PDKbAI0cWOjYjQaNwU2KU8Ha9IeJg=
X-Received: by 2002:a05:6512:a94:b0:50e:34db:a601 with SMTP id
 m20-20020a0565120a9400b0050e34dba601mr1439405lfu.48.1702915109661; Mon, 18
 Dec 2023 07:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-2-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-2-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 15:58:18 +0000
Message-ID: <CAFEAcA-xQ44whk0BEjdMehmH6U=SSxOanKAJtsR6GAaFC2cVmQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/45] Split out common part of BCM283X classes
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 8 Dec 2023 at 02:32, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Pre setup for BCM2838 introduction
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


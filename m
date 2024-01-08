Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E6826F80
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 14:18:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpVf-00063z-CW; Mon, 08 Jan 2024 08:17:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMpVK-00061C-4L
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:17:27 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMpVE-0001B8-5U
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:17:21 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50eabbc3dccso1628324e87.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704719827; x=1705324627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfSegeIh7wopyMD5hBdnvaa/4zTPrbAy35LwfLCht7g=;
 b=XdH454vh3KsWe55gYhSVUf7Uy1RAhTSWju37k6o8tx77STnuucMwRQL9mBNw61MqZ1
 JxaOgaeA2zctg4gKMnjyGufMIeomyXAaKIMybbPcJkZZYzQU/ukTMTscp+TTsq6RdO/U
 fY3BdbuzpPP7xBaQVnRqB4E097oR/85GHVIGk7d2ay9+BZskUPewDyC6QkyekrejIRom
 XisDwQGffC14OVAXezMbEMOGQG/Uo8UCLMd5vnadE7Q4Vghj7LewglnZhL/1ru3P/7He
 NEIExzOj2LHBFI1xG8NvMk2jR4CPl6XPJQpI9skhONgF+M84TrYELPnE1P2k84IrsJYa
 kQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704719827; x=1705324627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfSegeIh7wopyMD5hBdnvaa/4zTPrbAy35LwfLCht7g=;
 b=qOg8QaTpx6Q40fq/cAT67O9oGTZ2wrVD/jQ96wIp4cs6AehbW34Mmz6GSuEWjfasES
 wzVWbFapBvUHfC+G3bq4QnWDKx+ncTdCu9B19w3HbFc9vNvfF+TAN5X06rzIhO6Vt4Rc
 8tLtNuzn6qTzxD9EGdQFFTtW/LR+gm6vlFpwPj2pnmWu3Vvsq2psY20IMmwBniYeiEOC
 YSugXHlOd1aYGmDXPd0/5Ek9seTTWktbNUxJCDZREKpJHVdINP2g1K+JNhU0r6QfAMgG
 pUh1y/e+06lPGY4MpsmpCgz52GIJzkVsbyu8FIREPQpgm0LLSz6QJ2+JEho2PWJsSaWu
 Jrbw==
X-Gm-Message-State: AOJu0YwTBxRMP8bbMowu8ecR7HanFkrKqnE1IKvTrjWuXkUSC0y9Vlit
 +viu6dIohxQ563vZff1uKBxoL3nTzgk6IHHhqKmbywzkljYjaw==
X-Google-Smtp-Source: AGHT+IFhjJZx2/Ypa8G89+gqbizTAa/UDarS5hyzeC/AE2CJ9QHeDJR/v/QhikcKGk/XLv9Ne4tU/2qUx9VwIDotlFY=
X-Received: by 2002:a05:6512:3288:b0:50e:2e88:1157 with SMTP id
 p8-20020a056512328800b0050e2e881157mr545309lfe.107.1704719827296; Mon, 08 Jan
 2024 05:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20240108073232.118228-1-clg@redhat.com>
In-Reply-To: <20240108073232.118228-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 13:16:56 +0000
Message-ID: <CAFEAcA-7reB3bXzq2xdR_3kC7PtSGfqqUiRs5qTyWXt9Dk8trQ@mail.gmail.com>
Subject: Re: [PULL 00/17] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 8 Jan 2024 at 07:34, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d373=
28:
>
>   Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into sta=
ging (2024-01-05 16:08:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-vfio-20240107
>
> for you to fetch changes up to 19368b1905b4b917e915526fcbd5bfa3f7439451:
>
>   backends/iommufd: Remove mutex (2024-01-05 21:25:20 +0100)
>
> ----------------------------------------------------------------
> vfio queue:
>
> * Minor cleanups
> * Fix for a regression in device reset introduced in 8.2
> * Coverity fixes, including the removal of the iommufd backend mutex
> * Introduced VFIOIOMMUClass, to avoid compiling spapr when !CONFIG_PSERIE=
S
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


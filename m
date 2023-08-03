Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142776EF42
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 18:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRazZ-0003Gq-AR; Thu, 03 Aug 2023 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRazW-0003Ee-3l
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:15:58 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRazU-0006tf-IP
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 12:15:57 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5231410ab27so414956a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691079354; x=1691684154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hGvBPvFqSUYeXV6Thm4UF5fp4yvklhVIGy45xkUmcsE=;
 b=Xf34b6gmUl4RlNl+zBzOROrv5cN9byTAAfLtXnJ6YlIbfpwylvn6SuDccCHWTqkc5/
 BovmGCsNl02LFJrtB+OyhJ1e7lO2pLi0/tEseAwMohv46/dkGYT9uDUd2lFvkhHEvn+1
 8+D4gB65Unkiws8qR1YGMQuy+rGNhzBT0zPCycad2pbe6LJrczm9d21yKD1LbD7h6uoz
 TSyRZAgULgYa5fHp7/k7ZTWQW3ptP0gc+Hf8LQWzPU0PQXFhSXBmepPhZZXq+TfZl3G8
 lCCZcbC+mUiapovTWI1i/5NcNYTdfnSC1vNvbQ7PjYWcZgsoULNL9XFQmaab9qYRdnZ2
 QswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691079354; x=1691684154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hGvBPvFqSUYeXV6Thm4UF5fp4yvklhVIGy45xkUmcsE=;
 b=NMCy2wFU4oSaMYYMYD2+9vllSWJQ90Als8Kkvz6ZOEHhTWBQaD8VKgwC0n5tDWAJSu
 MFw5pfCaZxae/A4EImEXPxlVj7cY88oYm5EB0PE/iaFM5bji22qAWW+O5blI6aP7fmTn
 6DUJV393s8Jm06YhDvOCNsk0rdrj0QmHpzmiHZki8Oc0ox7k8PSmOwioToV6/lPnznTn
 iPYqak2A5WnICOns0w36ybEWlZhSZm2ooJqPLfLzOXNBbYK7kOn5epq6i1shIB+6eRn2
 gA9QXsJhE0H7SJPAF57nVQj8PIofXr5oW0OGMlXv3RPt2mtVJ78ZpyPvE/poNiqYtlZU
 34Yw==
X-Gm-Message-State: AOJu0YzlUdFxlobXEMoCQ3WxGVopyZ25zlPaPuLLPS9uJ8iqeK9QgSP0
 +Rb1xIWEgM7IAKiatuKHnjrGs8jLLQvtLOwM+ekR7A==
X-Google-Smtp-Source: AGHT+IEdiZjfQT7jBX3mV89SGZwVJ6oQBZWz83ajF0ziJTFjx74n2IbinvD6B2sVnn/WnlvX5pLko64AUpZR9Z0cGJY=
X-Received: by 2002:aa7:c744:0:b0:523:1400:2d7c with SMTP id
 c4-20020aa7c744000000b0052314002d7cmr675449eds.35.1691079353841; Thu, 03 Aug
 2023 09:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-2-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-2-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 17:15:42 +0100
Message-ID: <CAFEAcA9oKFF7bRvKUWLMEvyaPobmShyf=i57oYombD3oWAbEkA@mail.gmail.com>
Subject: Re: [PATCH 01/44] Split out common part of BCM283X classes
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 26 Jul 2023 at 14:43, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2836.c         | 102 ++++++++++++++++++++++-----------------
>  hw/arm/raspi.c           |   2 +-
>  include/hw/arm/bcm2836.h |  26 +++++++++-
>  3 files changed, 83 insertions(+), 47 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0880769524
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 13:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRKu-0008Tl-Bz; Mon, 31 Jul 2023 07:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQRKs-0008Tc-Fi
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 07:45:14 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQRKp-00077x-Pv
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 07:45:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5222b917e0cso6591935a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 04:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690803908; x=1691408708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CkXwgh/SZZuXdDsdYgbRsuV2PdSYYV+b3mOKm82ZilI=;
 b=ml3C3czRk0I4jayuO2nncTuMq3WrmEm7QPQ0UFAtDwcK2T2zyhAvKCWZIFgUACBA3t
 +yxm8tde1G/cZfKxDmWe2U0FqYRiYBeYfiAfVhLl1C23JbiawZpXVbYrhyqzIqHvsUmf
 5YfEZmGCfPJcoymVw5UEMTCeXPvJeEjyML2i7aCOJzBCgHXxYAlqkt6g1/2iJ1g/7TWP
 O7QxYD4BaXhbQdmDmWkQt+b9PUnqgfbShsbwEqlK5KD8MU58TAFBMBI5kTcgKXoJw4Ar
 wJW7H7OUnlpDjAUfDEVL0xaKygLWkjbUA6OxZTLygBB+9LuUxqxtxZhwt4A6XfooZivK
 vOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690803908; x=1691408708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CkXwgh/SZZuXdDsdYgbRsuV2PdSYYV+b3mOKm82ZilI=;
 b=WBfdvuxFpaQFLJ8cq3IJrY5b9flhwv/0U/yMgsnXS2g98cd+ZzGWRZl9oai5DOyADM
 8ZIE0khNFTdi0UG/rio2g6RsUbM7OBZNTD8yl+o+0ITGumbjKaaj9dL2AAjLCm94I90W
 hQz5+/4fAavW3Y/cXNi9ekTgiL1iwf+nKTvoNY8z8COVBki8PJPH4mqIoHd5LX9JTMDj
 Uzmv2VlJGzJsbiguM5wWbhqV9moXLJc5Ze44KJ9xnXWVvBCrhVJaR95x+aKMeIAZXQD+
 bIp0tgc94e7dknvPxbAvk+mjiMklXihYHVrmGQ6kkJDWr/LtyYc34sdwXo+gxWzfhhPJ
 5M7g==
X-Gm-Message-State: ABy/qLbHB/rmcv5mArP6sG9i1C/tOqwNn/z/zh4KXmm0U5QpjaoE9vd6
 Zqm8nKIblaLCUDrD1qqsX6YV9LudnUNnKNinFItTEA==
X-Google-Smtp-Source: APBJJlG08I6VoI7/MZ539KrIphoc9yFuu1r3bDg7ioU2O482GyAV2SLu0fX1dvW/VPEFHEr4UO6E9Fi30U37mZ+0/yA=
X-Received: by 2002:aa7:db53:0:b0:522:18b6:c023 with SMTP id
 n19-20020aa7db53000000b0052218b6c023mr9146161edt.18.1690803908380; Mon, 31
 Jul 2023 04:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-4-akihiko.odaki@daynix.com>
In-Reply-To: <20230731080317.112658-4-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 12:44:57 +0100
Message-ID: <CAFEAcA_gdK_nSkiaJQ2mDPeb3Se39AYN+DkDg1U-D2CJ1vUOuQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 31 Jul 2023 at 09:04, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
> concerning that the new mapping overwrites something else.

MAP_FIXED_NOREPLACE only came in with Linux 4.17. So
I think we still need to handle the "mapped address
is not the one we asked for" error condition, because
it can happen on older host kernels that ignore the
MAP_FIXED_NOREPLACE flag.

thanks
-- PMM


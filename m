Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D255706C57
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 17:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzIox-0006ll-Qw; Wed, 17 May 2023 11:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzIow-0006ld-5e
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:12:06 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzIou-000699-FD
 for qemu-devel@nongnu.org; Wed, 17 May 2023 11:12:05 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-510d6b939bfso1209663a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684336322; x=1686928322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N9rDsIsV2ls2kwqemDxHfidcU7uVqCzmDzSwfqO73BI=;
 b=FSXbAzi2QYnC8yJa6u747IMPhaUYQpsts8Dd7jzyI3XctybFao0G0UobmXNJn0LzkI
 wZtfOUHUt1zAGJ7DMKtNgQKM1v4TBLTujc4TcW5EhZa/823DjEa6lt690QZ2aao1kqrX
 JAAEq7YRWRTI8W0q85OrFnN/H7u1Umti1SG1X2batjcTImcVzLJNefO/3QaNb3EWzVf9
 V1VXM8+LerrN9ZaulZe/FDk0PXAp1x4ZmdswYF6/ZJrc2e0T0o3vaEj8EWvGElU77nEe
 MVkCgdN18NzIZ6YpMoOqrCV8gSG3/f96ZsaQcwV0Wxg7Frtl/UC0dqO5JQJj3e9zXhl1
 CiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684336322; x=1686928322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9rDsIsV2ls2kwqemDxHfidcU7uVqCzmDzSwfqO73BI=;
 b=frXtq+af7khM/Hx8/j+fg+AjaiLZG5HZkoZ4XYpOvklKLTIZHZdmyYlfNYq5pgsi76
 c0sdDmRLsAzYTtfT+OL3G0tn4eC2BisDoC5PXT8iobjJGMsAHeNZMGHii59aCqrT24Bo
 YeqqJ0plz+yrtqW0IXxEG82PEyOYAJT1+MyAfGwMX204ybykUN9L9vXEMXRC5GYUsK7N
 FkL/2br4epqi3teg7CrFWDOq3eTpAXtsRnPtW+1EQRLXd0RYhFbJtmG35cXeANMSReR7
 G/0lLH70NQsXkgtPOCAP8Ypiu8m6ogBmRUF0GSdAcEEwNHPzg5k0rOnOyKd5/pt8wUiy
 zVrw==
X-Gm-Message-State: AC+VfDxqgyG+Wh0qrOpokoJ6aDLlfhfPqtoTXGlsLSJjZbKWijsY78/5
 751Wih7oeUMmt2lhMSzZc7IRR6BG/Xs65jRJWHlnOA==
X-Google-Smtp-Source: ACHHUZ7HLdpC1zAREThwqhcZBv+a0iw0/oiWjixYux/PecCZ9jbrGkFSeBPN0u9FNAYdcJqSLE0Dc7FFSnUQVW6k3jo=
X-Received: by 2002:a50:ee11:0:b0:50b:febd:3cde with SMTP id
 g17-20020a50ee11000000b0050bfebd3cdemr2160454eds.42.1684336322338; Wed, 17
 May 2023 08:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 May 2023 16:11:40 +0100
Message-ID: <CAFEAcA-rw7-Ptrp47zE7+AxTEWvMez0u8Ur97=f3f4uZjokdaQ@mail.gmail.com>
Subject: Re: [PULL 00/80] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 16 May 2023 at 20:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
>
>   Merge tag 'or1k-pull-request-20230513' of https://github.com/stffrdhrn/qemu into staging (2023-05-13 11:23:14 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230516
>
> for you to fetch changes up to ee95d036bf4bfa10be65325a287bf3d0e8b2a0e6:
>
>   tcg: Split out exec/user/guest-base.h (2023-05-16 08:11:53 -0700)
>
> ----------------------------------------------------------------
> tcg/i386: Fix tcg_out_addi_ptr for win64
> tcg: Implement atomicity for TCGv_i128
> tcg: First quarter of cleanups for building tcg once
>
> ----------------------------------------------------------------
> Richard Henderson (80):
>       tcg/i386: Set P_REXW in tcg_out_addi_ptr
>       include/exec/memop: Add MO_ATOM_*
>       accel/tcg: Honor atomicity of loads

Didn't we determine yesterday that what we were doing in this patch
didn't work (because it assumes that the compiler atomic load
builtins for 128 bits will never do a store) ?

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CB716284
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zh3-0001K4-4l; Tue, 30 May 2023 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zgw-0001Dp-9D
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:47:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zgu-0000Gf-R4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:47:14 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51480d3e161so6002669a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685454431; x=1688046431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qhq+1FO/EIQe0BRgNkohT6DFOMOYO68w/Ys49eYQmHE=;
 b=VRxTcxTh0IGBGzh+WG0mibQzARWlthxWEZ+GvWD8B4taNGi99hplj7I7JFTyTItHuH
 NVbh5aidxLp1pdA7Zf+6brzHPxfn6M+ja5BRQJU2T1lL3i7BtnE4U6fKPWE5wl4LFFiq
 gclso7+02j7YtMWFA773TQLqVl7y5k8uHC8wG3Vkszyq3V/YA6OxM8qz6sK8zta58iAy
 kcUBMJyE9f1des/at7wKZmCZEQKZmvopFFYXaJbTRobVtV4N7VVz1wThFeR7O3W0T+xv
 Cd+/zv0JCF57oK29GVvqnYaeONu8d1d49GYLAaU6bjGKd1bDGoDWvswqWoEH/pCnSiCJ
 zs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685454431; x=1688046431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qhq+1FO/EIQe0BRgNkohT6DFOMOYO68w/Ys49eYQmHE=;
 b=EGcJ4NDDAqYwrsRsPxnlMIJbBmikWAPi/WIBZAKSm/5ZOkH7oJNTRC/20HvWWkytNr
 0vqIfAwByg4BLZgsng8LCddZ5VNIT9UVX3HRnDmWy9NcCF97ZFT3bbsWytZww77IdJUw
 EhSJ839Tfhw29mRpsqb5VjdEKbixa6tdlgsemSvTqDLI6NRhl3N5oTBRUONXv4OJo0Mu
 E/jMMDEvhmZh3eNgX8cinltCC29EQf/q2ghzvpDzHTL4ANMHu1amQtYIZ6yW7dJdD/Gn
 3okT1svvj15GKosFWytH8t1cvb4rOjKwb5mPIfjH3wNan902f4plFoSIcoaawU/4qCoz
 YXag==
X-Gm-Message-State: AC+VfDwpWhQDYlJdr6GlHo9cHXEu/Ln0Agn8n6oLERmIq/M7kpsoS2Qg
 kJeHWenewNkLLQ5yHTXBslbosZVozHFngJrbyutjlg==
X-Google-Smtp-Source: ACHHUZ4MHxfBzG9YCECIAjPBWYT34oG5dARm20kgLEdSYcUGya3rMQWIEv+l5/Kz9Ig+qgdzYGNHqy3yhxBfAtj0Il8=
X-Received: by 2002:a05:6402:31f5:b0:514:a3e5:e434 with SMTP id
 dy21-20020a05640231f500b00514a3e5e434mr1421953edb.34.1685454430986; Tue, 30
 May 2023 06:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-4-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 14:47:00 +0100
Message-ID: <CAFEAcA_15ewWUW4xEb0fYmt5=6FH+dPDcVEh1__6Kfcc3GPnZA@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] meson: Split test for __int128_t type from
 __int128_t arithmetic
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 26 May 2023 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Older versions of clang have missing runtime functions for arithmetic
> with -fsanitize=undefined (see 464e3671f9d5c), so we cannot use
> __int128_t for implementing Int128.  But __int128_t is present,
> data movement works, and can be use for atomic128.

"and it can be used"

>
> Probe for both CONFIG_INT128_TYPE and CONFIG_INT128, adjust
> qemu/int128.h to define Int128Alias if CONFIG_INT128_TYPE,
> and adjust the meson probe for atomics to use has_int128_type.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488B75F57E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNu8F-0000WR-En; Mon, 24 Jul 2023 07:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu83-0000Vs-Mk
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:53:31 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu82-0008B3-3O
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:53:31 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51e99584a82so6066497a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690199608; x=1690804408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BthpGxNNBiQVpqClI8i+f1mpsMeG+dqxveHSn0tgDps=;
 b=TXhlbpGo+93DGCPeztasn7Af0rquWPuNeLjENCbVfqjqkzRsCEIQcTqO+UJwxZjQCK
 goq1dGTp11su9WbFMpgbbOsspqbVFEqaSL9yS7S0Modv8ip9kbUKIluSMAXp59TBDoTF
 Cl7ZDrXdedpK1crDoqZxeTnXlyML6SuUpsoLIk8sfdJikBOattPW+uPn5NdIz6a4LfCI
 rC8jsdtTCw3ONENm118b+ditfd/fhr6ZgamjnX3X2S6fuG8PG9CjaoNQj3uelLP+P1ju
 tLikT4uSJtKYTyYyea4SOth1Y9hFH7PcisItQPiqJ1mJG1Z5QVZHz2atcQML0RPlC5n2
 GugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690199608; x=1690804408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BthpGxNNBiQVpqClI8i+f1mpsMeG+dqxveHSn0tgDps=;
 b=UOug+X72ZFClYitouUQ+yaLujtwNRk9ZFn2dyqwiVJc3/iziuk2e8lNfmrtOFPTmdP
 /g5PyO8R3PKGXcqIlzYwox7hwvtZ1DxNElYJO2Ka/GBIlqJRyU2TbnCFcZKTvcKn28NC
 m69ahUpbKLbfRBHQD/A9/bFAh+dFaG6V022hz+CvgxRqRv5Ootd0kcgxQ9ylXLpfiwee
 NtXYrhqAPxR1atUKd93A9D+ketBiNvRBaOB0+dNR8JLhqKfFqu3cJPa85ECp1ltCKJEE
 5I+IVyeamr2SCecAYMSX4npPdeKWN7N/Cen+dtYVN6n4TbhFiKM04M0eUKWHc1+jSbwF
 5uDg==
X-Gm-Message-State: ABy/qLYvGigwDedgLQ6NCMrXL46Oyp0YHBQvElReOsODkEB1ll9LXlAy
 40pc8xy3HzElek58VXF2JRkeT10NPHNdx6wGIlNfrg==
X-Google-Smtp-Source: APBJJlFj+/EIyXPCRSkvye8ZRr5hiIxR1LZGeOFkcC2n5qk8ryxSjpTX1f4Rw5ht/W+2QxccdJgl3mQCHfTzkgpRq3I=
X-Received: by 2002:a05:6402:5145:b0:522:2ce0:d80a with SMTP id
 n5-20020a056402514500b005222ce0d80amr2480545edd.35.1690199608028; Mon, 24 Jul
 2023 04:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230722214422.118743-1-richard.henderson@linaro.org>
 <20230722214422.118743-5-richard.henderson@linaro.org>
In-Reply-To: <20230722214422.118743-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 12:53:17 +0100
Message-ID: <CAFEAcA-6uLvrRbPE7m5NgpF8ADrUJV_kDDxG6xChzeUFu4f5-g@mail.gmail.com>
Subject: Re: [PATCH for-8.2? v2 4/4] util/interval-tree: Use qatomic_read/set
 for rb_parent_color
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 22 Jul 2023 at 22:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> While less susceptible to optimization problems than left and right,
> interval_tree_iter_next also reads rb_parent(), so make sure that
> stores and loads are atomic.
>
> This goes further than technically required, changing all loads to
> be atomic, rather than simply the ones in the iteration side.  But
> it doesn't really affect the code generation on the rebalance side
> and is cleaner to handle everything the same.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


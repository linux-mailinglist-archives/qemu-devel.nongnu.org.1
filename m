Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D35B7874A7
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCfP-0001tT-F8; Thu, 24 Aug 2023 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCfI-0001hY-0Q
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:54:32 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCfF-0007ur-Qb
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:54:31 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so84608a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692892467; x=1693497267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsEth8sbDfay0Ga6U64XKle7ua+19xrdRzWa6bxCVVk=;
 b=XxsaRFGgbgq0BPz+V26mhESabFHd2XkOfpmDNl3Gjuf0LWAY39A9sFUFmVGCzjv082
 Lkx1hRy8XoVEeSCbzU+1Eo2w/whZa6p2jQNAt3SqMHegsHvzeoR24KRly3NbT/eIyLyv
 uv+H3E208Gkmx0HWegN6r0lKGK7t1JVwXGEBXpmC2H4vHcuA5jXy7/sdb+xriB3W1fjs
 eMFd2RcCllMUFw95LqNxcuobkxKBnzF0QxpqIivAi+iY70g9/2pey5czf40+CLDjk5lG
 TYZ7glEUNgwlZlR1lEjXbFlFbw+dNszClBsS72kOdkxN4tllJQGvFWQn1BuEDAqjhneX
 QwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892467; x=1693497267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsEth8sbDfay0Ga6U64XKle7ua+19xrdRzWa6bxCVVk=;
 b=FVJ+h3scHuoI1nF2057qfcuxt8PzxNtqh9pIGdIPdOeNvNlqv11Fv8ygsocsnTXyMq
 ciY/OehQe5jc1ddqC3ORgw4TbsJujj0O4B/o7ESs8ijRNiWz74c2CejrMOeV0SZeb+tp
 1+5HMA68eYIZG14uO+KkuKmFeWLTdhwS6XWuZK0DJrpKplD2inzYiq0pk33lhlc52LuI
 Fwg7JYVqQ51QnxS+IF7tRQ/1ULcUF34aeDO0Nez6oGL1Gz6snxlVSiBIWfd8li8V/e+0
 Sro3Te5/OBjGMxNXxkiOTKUp9ap8Jf0cVMEFGay3uD5bD89mrbwvFUiePiicLuL+6bP2
 eeBA==
X-Gm-Message-State: AOJu0YxARXLjc2qDkbqXztPeQS2p2Ini3nzuMoXNcnuNZuC6GGbrljA5
 5v3JbcBRf1vldqd1W40lD379CAa33YWcSmHVLfShJw==
X-Google-Smtp-Source: AGHT+IG9dsv+CJeAfFrTOP66uvqSvDgHv++rI+HYe1RPTULY0PlJsD253DVS8VGUfSAr9t31iEn+h7D5iPNipaF3n4c=
X-Received: by 2002:a05:6402:1610:b0:523:38ea:48bb with SMTP id
 f16-20020a056402161000b0052338ea48bbmr13728235edv.24.1692892467356; Thu, 24
 Aug 2023 08:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-7-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 16:54:16 +0100
Message-ID: <CAFEAcA9+B+7TZbbOD33qDN0UZqy1=t1n9jPk9V14oXGyBvyk_w@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] target/arm: Apply access checks to neoverse-n1
 special registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 11 Aug 2023 at 22:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Access to many of the special registers is enabled or disabled
> by ACTLR_EL[23], which we implement as constant 0, which means
> that all writes outside EL3 should trap.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h    |  2 ++
>  target/arm/helper.c    |  4 ++--
>  target/arm/tcg/cpu64.c | 46 +++++++++++++++++++++++++++++++++---------
>  3 files changed, 41 insertions(+), 11 deletions(-)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


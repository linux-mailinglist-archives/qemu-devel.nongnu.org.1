Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB80703501
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybSz-0007Ny-Mg; Mon, 15 May 2023 12:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybSu-0007ND-Mr
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:54:29 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pybSs-00047E-9d
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:54:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-50b37f3e664so22983028a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684169665; x=1686761665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L+CxrV89IkCmnKnEFrSX2ZYAi09id4f5Zn78gg12roc=;
 b=kd3/IeJ8qNZtiKpidpVvnX7xNhopvMZjkHJBr3UNEB0PJoCc/nl/SRu5Toal++NbVs
 6XimqCfZDsl055BpT1sco2o6bvPDuP8uPQPDtH/pyYA8NJQSPkVZudxfR1XnLmfd4oAc
 EFflms7brK3BCRumbdmNYfPQlKDOHcFCQfWM1bfEHBl6RXTEWTIpE7dDcJ1QEeYbfz/p
 0qRrRS1p6qEW/12lEcD4dNfUstIaK3QhwWXUCBaJbn6bU5RUWWaX59lK4w3VftzPmHwB
 D53Mg//Oj7SY9j1kaHp4i17DQTx7xgqvvhmIwJiUImzRilXj95ELiDCwvYViWD8qbcfV
 QqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169665; x=1686761665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+CxrV89IkCmnKnEFrSX2ZYAi09id4f5Zn78gg12roc=;
 b=e4qPkmQrcud4Z/FA3KLKWZFxX+J7psTLc6cmzq+8sZtz95KGPTFee8JBy6HKftNmf1
 F1wWEu1woVq3G5r4JZJKB3+KCgvHIJCnzHvV/VXgKiE/1ymvTzKX5FJyK/iHuZRpBRJe
 218tvWE8geW1JtY7ioKa6pgA2Y1u9gBxKiWBl5hZ7oJAe1w7ljr8Y9MCYlj0H59aH/c3
 ZCBNysl8psI88z1EUnonpq+5lvBerYXs1ABiVa13j/69AbnkZR/GdhR4vgCfanRjzkVQ
 /SfWsCCuH0f6yrOCn4hdHNw2oVEI8oK/Ob7BAipOKoBxkaY8DQpUD5SML82OYXInvqaC
 zB6A==
X-Gm-Message-State: AC+VfDwrcm/Y+eMfz5W2gmRYuACLGThz8w3LQlJxW6oxNzLqfNU93SJE
 EGRf+EJVXyMR01ssIUYMHt84sJ9DS4dDHZKJkmEslw==
X-Google-Smtp-Source: ACHHUZ4ezQaF6Djc9mP4B1vMqMvyDEQcTmgU2YS7uDfmB2VkZam6UpqmbaWSWRjegXLObWVWyZ7pAusXFXqdYIRpoxw=
X-Received: by 2002:a05:6402:1347:b0:509:c669:1e93 with SMTP id
 y7-20020a056402134700b00509c6691e93mr26555405edw.23.1684169664762; Mon, 15
 May 2023 09:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-8-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 17:54:13 +0100
Message-ID: <CAFEAcA_9TYj9+Mrz8tjOYWKMt3-JvL2t2nMXLje--FsWvB1oWQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/54] tcg: Add 128-bit guest memory primitives
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 15 May 2023 at 15:35, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Dropped r-b because of MO_ATOM_* reorg
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D97E6D03
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16jB-0001hP-5N; Thu, 09 Nov 2023 10:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16j9-0001h3-Mu
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:13:51 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16j8-0007kE-4F
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:13:51 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so1681346a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699542828; x=1700147628; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R49ThQxgPs8GvNCvhXeL3LX5ZVzmB0y5Wzv5GxqqZQ0=;
 b=Unnw/AtxCYuyl7QacyDS6jWK4AGgRIykQYKMQoEzgkDp6tJJ1zWMzURNmeht+eAVaf
 mUK2RFkJZ462K3dwAOP6hs/kilj0YRPw1yElPibreKYhY52SQXi3IgVfBHhQMGA3m8xH
 iY4JEX8pVjC8p3AEvuKguzYPScPS8ke5GRehctIUTi/JX8mtqnYK28rNvupeX/dJ6akJ
 WXwqrvgJFpjMIiKOZQmwDTAX9EewOJxRf6kLXNOnMOMI9upVf8QgJy1HgcjyuLYzDK0q
 KwmZylk8tDpQQcNnUSNqaHCK9Q7I+24nZRoF03NcNNYknFi8CyalADMsuX/DjMCGMxxl
 6Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542828; x=1700147628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R49ThQxgPs8GvNCvhXeL3LX5ZVzmB0y5Wzv5GxqqZQ0=;
 b=wgTB5UUhRkWzCttcOfQN+HMpExXdsq59xhP7UDMckGLZ2/vHLmjTyXhIDHgIgrK8rA
 ktfWoYIKsY6R4qxSooF63TpxPlxHgTETzP4gaUgtJyZRzuJ/pmxkGECFq6SDhUJyaGrn
 NxwRCxQ7+xqw8hGj4FddKmCMZYLQhXZLVT6mdOSw58nGuP/Pf5PtqhJAtLDsbKuRGZZI
 9JnCPvh8qsCT7fWNWAJCqaFUu/wuv5x14ndUwQM/K1o6HDpDdU6isSbXFhXzlz2pVsjE
 WgvPn9/Sh7f7i5w2EohcLe3EXEzXyPHsbvn5CCis5W3gAKSq2HC+DG4vHQ4yXYtFbt7B
 oo5Q==
X-Gm-Message-State: AOJu0YxmXJcZAOAqVfDT/a2qnVgWMxPJZ3bKBP2WYmNbPOGavpXB6IaU
 Qru0PWhHA9aPp4MQiusLAizatRTt02NSwYKmd8eUTw==
X-Google-Smtp-Source: AGHT+IGT6DRuKnHnoh1woMsDCa722XyvZxvq6JM+2ErCVhM9Sq1g2Tjgw5NK8F7e43MrSv8bzCpsA/zEAdp2nE859eA=
X-Received: by 2002:a50:9f26:0:b0:544:f786:d7c0 with SMTP id
 b35-20020a509f26000000b00544f786d7c0mr4240650edf.35.1699542828701; Thu, 09
 Nov 2023 07:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107030407.8979-1-richard.henderson@linaro.org>
 <20231107030407.8979-54-richard.henderson@linaro.org>
In-Reply-To: <20231107030407.8979-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 15:13:38 +0000
Message-ID: <CAFEAcA8sHrkz+uo64Ek_UQLPYoSaA0mFG=ZVm_7nys=Oon-N-w@mail.gmail.com>
Subject: Re: [PULL 53/85] target/hppa: Implement IDTLBT, IITLBT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Tue, 7 Nov 2023 at 03:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename the existing insert tlb helpers to emphasize that they
> are for pa1.1 cpus.  Implement a combined i/d tlb for pa2.0.
> Still missing is the new 'P' tlb bit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>
> +static void itlbt_pa20(CPUHPPAState *env, target_ureg r1,
> +                       target_ureg r2, vaddr va_b)
> +{
> +    HPPATLBEntry *ent;
> +    vaddr va_e;
> +    uint64_t va_size;
> +    int mask_shift;
> +
> +    mask_shift = 2 * (r1 & 0xf);
> +    va_size = TARGET_PAGE_SIZE << mask_shift;

Coverity suggests this needs a cast too, for the same reason:
shift of a 32-bit value by a shift that might overflow.
(CID 1523908)

> +    va_b &= -va_size;
> +    va_e = va_b + va_size - 1;
> +

thanks
-- PMM


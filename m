Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02975B4BA
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 18:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMWhi-0000dC-4d; Thu, 20 Jul 2023 12:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWha-0000bn-EZ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:40:32 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMWhH-0008AN-6Y
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 12:40:20 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fba1288bbdso1588435e87.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 09:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689871207; x=1690476007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PO4Fi4YWodYZUA5UitbRNAl4v58seTuH9vn83Yaei7I=;
 b=Skie1lD5tVlVC/CSKUqp15zXsg3wGKgBtFTa0G5Ur5Y6e012hIn0IoFBiJH8dAXGdC
 o3LJYvyT8cLCAm1LH2fqJy2yltE9FWp7F6LqqE4L2A1Ieqc/Z6dtlpLa+x2061fCR4ST
 Ur06jLANWy7FzdmlWZaMMtznJfT6f4RagqCR3nHtckpzlLTqG0fEiQ6KP2Uu5Liey27s
 yi2LODhzFt1JsoofwxR2WcmnwpCu4s7r3BKawODaUaTiB3EsuNuHyJUavbzFgV9ctOn8
 DXd5ezvksII03i0S77TO5xLNNFNQ03hvhZL4VV9eS0JMsDtMlbaeBfZSC6I3BFxFGc5B
 /Hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689871207; x=1690476007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PO4Fi4YWodYZUA5UitbRNAl4v58seTuH9vn83Yaei7I=;
 b=EWAKHphQbpKCw3NjM0BloYfgeSCMDH+PYsHkDnOUX7HGIkwo3iRqbZxES2X1TzSuPQ
 8WTvACyK2fc0tJ5dKDKGqP+NktXogHRxQS0+lFQOWrF5UfAWbqSLZ7K4QGpWKJU47+PJ
 svUKL57gcI7b0CQ2xzotR1URuGSqHZNwxi2tgQUwZC+pybEXCvvoz/LxH8pY75CBXmpu
 Fbeb6/jEfGXg7NZsJZ3rHwe5dzi/A/oqi/PXxliKBC/b2Fdd+7GMFm2V/UDioZ+Tf+am
 e93MzOAUkN0Ob6y5UFexpGhSkGEPbIWqmG96r8BmQG7JAs0tSLIanik78Gy5Ycsifiy5
 67xw==
X-Gm-Message-State: ABy/qLbjFckMQI65MheTJFTXsR878ZOA6t2JoCJasi+yjq2cGqqMxd9z
 lXkxDQemNXICwPZNon2M0IsS1jQd76JcmbN2YaguWw==
X-Google-Smtp-Source: APBJJlEOiyVFnaVbLBWsy2yeonuLyG9hF4QIMEhyXUl6RZSz/GuHbZJDHcHiJdhDRj2eVn/PmI8g5DG0aCYUQbEEPD0=
X-Received: by 2002:a19:7418:0:b0:4f7:3ee8:eede with SMTP id
 v24-20020a197418000000b004f73ee8eedemr2441017lfe.61.1689871207299; Thu, 20
 Jul 2023 09:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-5-jean-philippe@linaro.org>
In-Reply-To: <20230719153018.1456180-5-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 17:39:56 +0100
Message-ID: <CAFEAcA8e_-r6b4iaeDUv64iydFe7iAb4Y0eObyO4tUYizcYLVA@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/arm: Skip granule protection checks for AT
 instructions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> GPC checks are not performed on the output address for AT instructions,
> as stated by ARM DDI 0487J in D8.12.2:
>
>   When populating PAR_EL1 with the result of an address translation
>   instruction, granule protection checks are not performed on the final
>   output address of a successful translation.
>
> Rename get_phys_addr_with_secure(), since it's only used to handle AT
> instructions.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> This incidentally fixes a problem with AT S1E1 instructions which can
> output an IPA and should definitely not cause a GPC.
> ---
>  target/arm/internals.h | 25 ++++++++++++++-----------
>  target/arm/helper.c    |  8 ++++++--
>  target/arm/ptw.c       | 11 ++++++-----
>  3 files changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 0f01bc32a8..fc90c364f7 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1190,12 +1190,11 @@ typedef struct GetPhysAddrResult {
>  } GetPhysAddrResult;
>
>  /**
> - * get_phys_addr_with_secure: get the physical address for a virtual address
> + * get_phys_addr: get the physical address for a virtual address
>   * @env: CPUARMState
>   * @address: virtual address to get physical address for
>   * @access_type: 0 for read, 1 for write, 2 for execute
>   * @mmu_idx: MMU index indicating required translation regime
> - * @is_secure: security state for the access
>   * @result: set on translation success.
>   * @fi: set to fault info if the translation fails
>   *
> @@ -1212,26 +1211,30 @@ typedef struct GetPhysAddrResult {
>   *  * for PSMAv5 based systems we don't bother to return a full FSR format
>   *    value.
>   */
> -bool get_phys_addr_with_secure(CPUARMState *env, target_ulong address,
> -                               MMUAccessType access_type,
> -                               ARMMMUIdx mmu_idx, bool is_secure,
> -                               GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> +bool get_phys_addr(CPUARMState *env, target_ulong address,
> +                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> +                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
>      __attribute__((nonnull));


What is going on in this bit of the patch ? We already
have a prototype for get_phys_addr() with a doc comment.
Is this git's diff-output producing something silly
for a change that is not logically touching get_phys_addr()'s
prototype and comment at all?

>  /**
> - * get_phys_addr: get the physical address for a virtual address
> + * get_phys_addr_with_secure_nogpc: get the physical address for a virtual
> + *                                  address
>   * @env: CPUARMState
>   * @address: virtual address to get physical address for
>   * @access_type: 0 for read, 1 for write, 2 for execute
>   * @mmu_idx: MMU index indicating required translation regime
> + * @is_secure: security state for the access
>   * @result: set on translation success.
>   * @fi: set to fault info if the translation fails
>   *
> - * Similarly, but use the security regime of @mmu_idx.
> + * Similar to get_phys_addr, but use the given security regime and don't perform
> + * a Granule Protection Check on the resulting address.
>   */
> -bool get_phys_addr(CPUARMState *env, target_ulong address,
> -                   MMUAccessType access_type, ARMMMUIdx mmu_idx,
> -                   GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
> +bool get_phys_addr_with_secure_nogpc(CPUARMState *env, target_ulong address,
> +                                     MMUAccessType access_type,
> +                                     ARMMMUIdx mmu_idx, bool is_secure,
> +                                     GetPhysAddrResult *result,
> +                                     ARMMMUFaultInfo *fi)
>      __attribute__((nonnull));

thanks
-- PMM


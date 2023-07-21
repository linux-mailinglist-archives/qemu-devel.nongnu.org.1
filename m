Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFEB75BEF8
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 08:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMjjP-0001Vr-W0; Fri, 21 Jul 2023 02:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMjjN-0001VY-FC
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qMjjL-0007fF-Gc
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689921310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGz9gk5cFhRoFMNloUUz4+9xJHx8gi2wjNNlo1otg7U=;
 b=HRXLFoNnGOjoHWv3aZ6WmdnlR9ey5a6LfNUjtI9OtNLaOmUdgjcThsVvhJurV06luQmbCS
 s7kj2Rt6XrRN1FGmIUbDhB4nC1+JhcjNrjU2Q/z1bVC8ZX8+sGYeOZqVu7eycrdf74jkpO
 diABpOuSmkHTePxquNdclFwPO1m+YVo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-QoofinbKOWC5Ow9-9AneGg-1; Fri, 21 Jul 2023 02:35:08 -0400
X-MC-Unique: QoofinbKOWC5Ow9-9AneGg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fb40ec952bso8336195e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 23:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689921307; x=1690526107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WGz9gk5cFhRoFMNloUUz4+9xJHx8gi2wjNNlo1otg7U=;
 b=UHbbSdVhNNpj+QPVg7xZ42A339EyIEQmS4nzwyJbC4l1GP9RysJQ1ee7644HkdxvsL
 4jiEGvzOUIvJnOt+uqy7WA48U/MMJJvIZR5KdGcIXXJBj60fNAa7KisPqCJJ6ZjYWkl+
 KtsPOdOs3qJ8S2nEKqrisNJG3ZwwEsdjOr1i2DARKvvwATF3OX1mKYXS34gTXexGP1/s
 Yi5Teeliox3H8/tHCvI3cEAvkNSujwzTnRmx8cWLp5sCjPIZa8tImf+w7/dXp6klLZCB
 TXHzyLK291Nl4Q2/w53q2h74HuSLHgGzkL+sVv6akW/6p0YHuu4Hg/5O/CbFHa9MSnBF
 yrWA==
X-Gm-Message-State: ABy/qLZniSblBUAcziAnJES27pcLtuNs7YFL0lPl5Td86WOJsZ7TbP68
 qq15KMpe33EYZOoBYL480dZPdiX1O/2IUbz3ZHXXYzJLe/dqgM3HxmJe52utiKagUkuo3HQJLXs
 A47eD8Hut8r0aD2s=
X-Received: by 2002:a5d:4809:0:b0:313:f1c8:a968 with SMTP id
 l9-20020a5d4809000000b00313f1c8a968mr727062wrq.2.1689921306957; 
 Thu, 20 Jul 2023 23:35:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHXYrwNepuHjYusIoGDRUKNoRibXTJzXRHOMWLvPKG6vDEx6FRBdgh2mI+8mY3HICLmaL18zA==
X-Received: by 2002:a5d:4809:0:b0:313:f1c8:a968 with SMTP id
 l9-20020a5d4809000000b00313f1c8a968mr727053wrq.2.1689921306588; 
 Thu, 20 Jul 2023 23:35:06 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-165.web.vodafone.de.
 [109.43.177.165]) by smtp.gmail.com with ESMTPSA id
 h18-20020a5d5492000000b003142e438e8csm3265144wrv.26.2023.07.20.23.35.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jul 2023 23:35:05 -0700 (PDT)
Message-ID: <463afc6c-4c42-6d98-5ea6-9c8437ffda2e@redhat.com>
Date: Fri, 21 Jul 2023 08:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/tricore: Rename tricore_feature
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: chenrui333@gmail.com, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230721060605.76636-1-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 21/07/2023 08.06, Bastian Koppelmann wrote:
> this name is used by capstone and will lead to a build failure of QEMU,
> when capstone is enabled. So we rename it to tricore_has_feature(), to
> match has_feature() in translate.c.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1774
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/cpu.c       | 8 ++++----
>   target/tricore/cpu.h       | 2 +-
>   target/tricore/helper.c    | 4 ++--
>   target/tricore/op_helper.c | 4 ++--
>   4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index f15169bd1b..133a9ac70e 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -104,18 +104,18 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
>       }
>   
>       /* Some features automatically imply others */
> -    if (tricore_feature(env, TRICORE_FEATURE_162)) {
> +    if (tricore_has_feature(env, TRICORE_FEATURE_162)) {
>           set_feature(env, TRICORE_FEATURE_161);
>       }
>   
> -    if (tricore_feature(env, TRICORE_FEATURE_161)) {
> +    if (tricore_has_feature(env, TRICORE_FEATURE_161)) {
>           set_feature(env, TRICORE_FEATURE_16);
>       }
>   
> -    if (tricore_feature(env, TRICORE_FEATURE_16)) {
> +    if (tricore_has_feature(env, TRICORE_FEATURE_16)) {
>           set_feature(env, TRICORE_FEATURE_131);
>       }
> -    if (tricore_feature(env, TRICORE_FEATURE_131)) {
> +    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
>           set_feature(env, TRICORE_FEATURE_13);
>       }
>       cpu_reset(cs);
> diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
> index a50b91cc36..3708405be8 100644
> --- a/target/tricore/cpu.h
> +++ b/target/tricore/cpu.h
> @@ -277,7 +277,7 @@ enum tricore_features {
>       TRICORE_FEATURE_162,
>   };
>   
> -static inline int tricore_feature(CPUTriCoreState *env, int feature)
> +static inline int tricore_has_feature(CPUTriCoreState *env, int feature)
>   {
>       return (env->features & (1ULL << feature)) != 0;
>   }
> diff --git a/target/tricore/helper.c b/target/tricore/helper.c
> index 951024d491..731a6e9cb6 100644
> --- a/target/tricore/helper.c
> +++ b/target/tricore/helper.c
> @@ -155,7 +155,7 @@ void psw_write(CPUTriCoreState *env, uint32_t val)
>   #define FIELD_GETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)     \
>   uint32_t NAME(CPUTriCoreState *env)                             \
>   {                                                                \
> -    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {       \
> +    if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {   \
>           return FIELD_EX32(env->REG, REG, FIELD ## _ ## FEATURE); \
>       }                                                            \
>       return FIELD_EX32(env->REG, REG, FIELD ## _13);              \
> @@ -170,7 +170,7 @@ uint32_t NAME(CPUTriCoreState *env)         \
>   #define FIELD_SETTER_WITH_FEATURE(NAME, REG, FIELD, FEATURE)              \
>   void NAME(CPUTriCoreState *env, uint32_t val)                            \
>   {                                                                         \
> -    if (tricore_feature(env, TRICORE_FEATURE_##FEATURE)) {                \
> +    if (tricore_has_feature(env, TRICORE_FEATURE_##FEATURE)) {            \
>           env->REG = FIELD_DP32(env->REG, REG, FIELD ## _ ## FEATURE, val); \
>       }                                                                     \
>       env->REG = FIELD_DP32(env->REG, REG, FIELD ## _13, val);              \
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index 821a4b67cb..89be1ed648 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -2584,7 +2584,7 @@ void helper_ret(CPUTriCoreState *env)
>       /* PCXI = new_PCXI; */
>       env->PCXI = new_PCXI;
>   
> -    if (tricore_feature(env, TRICORE_FEATURE_131)) {
> +    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
>           /* PSW = {new_PSW[31:26], PSW[25:24], new_PSW[23:0]}; */
>           psw_write(env, (new_PSW & ~(0x3000000)) + (psw & (0x3000000)));
>       } else { /* TRICORE_FEATURE_13 only */
> @@ -2695,7 +2695,7 @@ void helper_rfm(CPUTriCoreState *env)
>       env->gpr_a[10] = cpu_ldl_data(env, env->DCX+8);
>       env->gpr_a[11] = cpu_ldl_data(env, env->DCX+12);
>   
> -    if (tricore_feature(env, TRICORE_FEATURE_131)) {
> +    if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
>           env->DBGTCR = 0;
>       }
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>



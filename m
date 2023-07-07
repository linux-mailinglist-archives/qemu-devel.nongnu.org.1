Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F2974B843
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:45:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsJs-0007eP-Fd; Fri, 07 Jul 2023 16:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsJj-0007X9-ND
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:44:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsJQ-00044f-HT
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:44:39 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso25519405e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762658; x=1691354658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1jGym/mYCo2k0gksX+nw+AihnByWl6o6I71FrLVtmts=;
 b=FvRAkLkps0G0ht30x2KXGt+mJM5gGIf1qz69lUne0jVaTaFmW45DHVBHopzu8lPwKH
 ebOAo2kVQxQW+UEeYgtTkdNS43e3L34sCnfHNLnpTYuggMwE8Gk8SWOQm/LhtuiLHbNj
 baF4sFecF0Ziso6ONAlInlOWcxX5l5058E6FexQlwb4TulIdlTxos8s8Z8apCgkvxL/P
 7qyrcLDToSwmXz9Ss6hygnbm8Vm+7cw34zLiCiXvPAR2llQ86mlrQUajABn5HNtrHsmS
 tXu73zKiVjQmW1HrOgRZheycNq3cr4NikYZ8lESOFyTyt+KH/AI8uBMXkPsbcosxtgNu
 yBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762658; x=1691354658;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1jGym/mYCo2k0gksX+nw+AihnByWl6o6I71FrLVtmts=;
 b=dTmSEuJ7JgvsoJN5OqCM+2akcmdfrHpCnch+9xXkwhV63uqpcn/IszfFZLsnxyHC3z
 AnNoS6dQ0AjCmjHT5E9JroeIUE0JlOPCKGzErivOYBPW7yaX925U8+KngeiQmwKzXPTF
 vCUzjBIf5MfP2vQVfW7yvbJqWbiPnM+sdC/hRY5ZTpyoNt/e04Kc8mATuhj2AmOZ185W
 lXCtoVnl7mmy/q7Apd4ll31LOXM9iHLJw/nYu5ZvEk2+51EdFWk2B9+FWHhsk3KfMpe8
 rHSmpOPRdR/S5uYdmgNfY+LuvHOQ47OvwebYrVzpzTa0CnFGCMwPPcDIZQwyrP3a2PKn
 pWgw==
X-Gm-Message-State: ABy/qLYVscxSaDMXP7PwM8fY7TmaKTan7DamDW5J+U3MstdU9nUgJh6o
 AFTzDVZ8mY7nsCRlIIX2MiHhtw==
X-Google-Smtp-Source: APBJJlFbdO78snxn4MQTSSdTQqgfXYx7cpV62PYZYErzKdOV0AzL3rNBkWx54/IutB9IkSm/k0t3FA==
X-Received: by 2002:a7b:cd1a:0:b0:3fb:cfe8:8d12 with SMTP id
 f26-20020a7bcd1a000000b003fbcfe88d12mr4941105wmj.14.1688762658607; 
 Fri, 07 Jul 2023 13:44:18 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a05600c00ca00b003f9bd9e3226sm3408169wmm.7.2023.07.07.13.44.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:44:18 -0700 (PDT)
Message-ID: <d400dedd-ca21-4c72-629a-f79cfcf7b5da@linaro.org>
Date: Fri, 7 Jul 2023 21:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/6] hw/virtio: Propagate page_mask to
 vhost_vdpa_listener_skipped_section()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230707151719.70613-1-philmd@linaro.org>
 <20230707151719.70613-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707151719.70613-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.092, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/7/23 16:17, Philippe Mathieu-Daudé wrote:
> In order to make vhost-vdpa.c a target-agnostic source unit,
> we need to remove the TARGET_PAGE_SIZE / TARGET_PAGE_MASK /
> TARGET_PAGE_ALIGN uses. TARGET_PAGE_SIZE will be replaced by
> the runtime qemu_target_page_size(). The other ones will be
> deduced from TARGET_PAGE_SIZE.
> 
> Since the 3 macros are used in 3 related functions (sharing
> the same call tree), we'll refactor them to only depend on
> TARGET_PAGE_SIZE.

TARGET_PAGE_MASK?

The code looks fine,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> Having the following call tree:
> 
>    vhost_vdpa_listener_region_del()
>      -> vhost_vdpa_listener_skipped_section()
>         -> vhost_vdpa_section_end()
> 
> The first step is to propagate TARGET_PAGE_MASK to
> vhost_vdpa_listener_skipped_section().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/vhost-vdpa.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 3c575a9a6e..87653bf841 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -42,7 +42,8 @@ static Int128 vhost_vdpa_section_end(const MemoryRegionSection *section)
>   
>   static bool vhost_vdpa_listener_skipped_section(MemoryRegionSection *section,
>                                                   uint64_t iova_min,
> -                                                uint64_t iova_max)
> +                                                uint64_t iova_max,
> +                                                int page_mask)
>   {
>       Int128 llend;
>   
> @@ -313,7 +314,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>       int ret;
>   
>       if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
> -                                            v->iova_range.last)) {
> +                                            v->iova_range.last, TARGET_PAGE_MASK)) {
>           return;
>       }
>       if (memory_region_is_iommu(section->mr)) {
> @@ -396,7 +397,7 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>       int ret;
>   
>       if (vhost_vdpa_listener_skipped_section(section, v->iova_range.first,
> -                                            v->iova_range.last)) {
> +                                            v->iova_range.last, TARGET_PAGE_MASK)) {
>           return;
>       }
>       if (memory_region_is_iommu(section->mr)) {



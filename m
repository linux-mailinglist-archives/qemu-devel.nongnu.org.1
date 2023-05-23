Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF0270E9B7
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bfQ-0007q4-N5; Tue, 23 May 2023 19:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bfO-0007pf-E0
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:43:46 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bfK-000605-Hc
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:43:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae557aaf1dso2410205ad.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684885421; x=1687477421;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lrIUM/zjMljHi6FkBWc1L4dsCYrPyo+GFSVCad90VDo=;
 b=WZsY0Zy54GQpXwuCf9RW1VV6E0eaFPXdXMvanzDCxPRoS/bIhImF4cgl2fkQ2e0MPc
 zQZDoQ++2OycOKu4QxS9HeGZkz1KMhtoIQwUxbaNUId1FqcCeOEZQhhCr3kzRxmRw3hf
 ZMzFGAZiI5NyZqlD3YLrcypsj1EV22NvvFHNmwxg1yrqkFZgos7Qp8dLQG8hcv8KNPro
 92MIH1dK9OG/4goIYnxNSsXnjuo9iFCHAzcRRl6+LIiiJJHjZLz+TvyyNo+evkq//ZZ3
 94GNwrTTAO9kBPtQBEQGlOwnMJtW/r8gOu+UetVLOsYYtq5G8pHy46R8fezTPJNW1g7l
 xOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684885421; x=1687477421;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lrIUM/zjMljHi6FkBWc1L4dsCYrPyo+GFSVCad90VDo=;
 b=NVII+QcK/L/3HQ8QYTOZnww5IHN1mHO1C4gNH/TH0bhIOV27sOajqtBlMBwGDkBrwG
 YfcW7wVWU1ogfdMxboyZUcra5WVnKxAIW0xuBVqJ42dZs4kfFNZAEn7WTJ9JvqIwVtRq
 DeHXThdBOQBcTbp7fjDH6MsIJsqVhtDjnolNSx3pQUbr01yfnQqq516neJfRsfwSM6eV
 QyUHklN4pEaRFk/DxliKPEJ/UQC6i1+QqWec8BsDtlS//23Mk2ycEbSrmDhAkZV7Pcnv
 yj6cEMIOX4ZGgJ1nSMUZJvkn+Pu/0zkadi2fDv85K3uqf++OZTgMcUzqvNLYAiWt2WPH
 aHSQ==
X-Gm-Message-State: AC+VfDxfR0szb5rMKNmaHQ96tjisdEHYJoN2UKSvg3bBA6/Tm6Y/Aayo
 eVU3iJSwzYKw7uDduazKaIEgcQ==
X-Google-Smtp-Source: ACHHUZ7GGbbWmQDW1v40NcuJFFY5J7e6Z3Uai4Wk27wIPRwZXKBfChWrYyITKW/G6qMLvbU+62KkOg==
X-Received: by 2002:a17:902:ef82:b0:1a5:3319:12f7 with SMTP id
 iz2-20020a170902ef8200b001a5331912f7mr15388582plb.50.1684885420882; 
 Tue, 23 May 2023 16:43:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001a52974700dsm7313343plh.174.2023.05.23.16.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:43:40 -0700 (PDT)
Message-ID: <1f8fd0c6-5a6f-aebb-ae61-c3d5b45b7ecf@linaro.org>
Date: Tue, 23 May 2023 16:43:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 11/11] hw/virtio: Make vhost-vdpa.c target-agnostic to
 build it once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:36, Philippe Mathieu-Daudé wrote:
> @@ -321,13 +321,13 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>           return;
>       }
>   
> -    if (unlikely((section->offset_within_address_space & ~TARGET_PAGE_MASK) !=
> -                 (section->offset_within_region & ~TARGET_PAGE_MASK))) {
> +    if (unlikely((section->offset_within_address_space & ~qemu_target_page_mask()) !=
> +                 (section->offset_within_region & ~qemu_target_page_mask()))) {
>           error_report("%s received unaligned region", __func__);
>           return;
>       }
>   
> -    iova = TARGET_PAGE_ALIGN(section->offset_within_address_space);
> +    iova = qemu_target_page_align(section->offset_within_address_space);
>       llend = vhost_vdpa_section_end(section);
>       if (int128_ge(int128_make64(iova), llend)) {
>           return;

I'm not keen on using 3 function calls to get one constant.
This could be

     int page_size = qemu_target_page_size();
     int page_mask = page_size - 1;

     if (section->foo & page_mask) { ...

     iova = ROUND_UP(section->bar, page_size);

Also in vhost_vdpa_listener_region_del.

This then removes the only uses of qemu_target_page_align, so you don't need to add that 
either.


r~


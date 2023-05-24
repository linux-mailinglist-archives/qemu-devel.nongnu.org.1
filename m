Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5163770FE55
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:14:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tus-0006ls-3v; Wed, 24 May 2023 15:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tue-0006kp-Il
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:12:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tuZ-0008VM-17
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:12:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ae4c5e12edso4964315ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955557; x=1687547557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N6NxrZMdWccwqs4vNCW4LU++Q2ar/ayHy5pVrDVUv80=;
 b=P8jJPvNN2B6Uhk8MFPCtUIM4MOVYpwnfclbGGFJVRS4tY4iYOIEZlGA8JMW6ylpqvh
 CrDr0Lq4knMHm+WQMtq4U1CLhjHEDXoEj+VWEY3BDpNyjC2AGkEJR3D1H6zOIUXReju8
 rmHN0kRmh+MJUSS1R2qX3RfxDG45RHKvr0sd/6Lb0AVMCsxJQnPRVEp7m0r2/kf6EsJp
 t4Jj9nTpXAacHhrQwgJlELm9TGbkD7oRNyBQYfXioIqaocGoL9ARSF1++DqpwT37kYfn
 iiltQYJFhWHEaNiWqpoGB4ZvOW5AGdm//QUFnbdoXUFvIZAlWATKgKqFpkg5xOrIVKu/
 CrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955557; x=1687547557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N6NxrZMdWccwqs4vNCW4LU++Q2ar/ayHy5pVrDVUv80=;
 b=KZSf4H1XprZfTiC1vencTP62DmRo56TZHCzGSQV62ZWMJ2qeCxtVCDNrCMWnV62EKT
 LUBugF0fIHJrC2x95uE/HDBNyIQOGjyJEXk0q4bcqzBQKNV+e9oEVW2w7b2chiqJHSlH
 CqNLSBa/QUUfy+jbXrip8bcGIGX2W1ckMQt287kqhaXacJqIVsLZEVqkRWMqdA3ZGkpO
 odDvAcYZ7fR3H0tFWNTbIvrjZbCwpqe1L6ad7iJVEYLL6FVOZC5yvPJhDCWXgJNeZZ1a
 kqsFuMExBBONOwXopBEPZlonSP/BQY8jQu3lgDicEZdJNppyPM4XIRhkUoXhyHZ/Co9W
 W/wA==
X-Gm-Message-State: AC+VfDyApc7mvlTYYJS5j+5CK7UZt0xBx/Z22sYU3ztRa0x0Z4INtp/I
 qvV9j3AReMwccVAB9H5fy3tVXw==
X-Google-Smtp-Source: ACHHUZ69ZEfrM84S5JQevQHJccQpmEOGgwEQ8/MjyRju+WgKoBsdwx3VTlE8EezXRfSXLrfEvUplKQ==
X-Received: by 2002:a17:902:f689:b0:1ac:8148:8c40 with SMTP id
 l9-20020a170902f68900b001ac81488c40mr22406756plg.53.1684955557585; 
 Wed, 24 May 2023 12:12:37 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 iw10-20020a170903044a00b001ac2f98e953sm9082224plb.216.2023.05.24.12.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:12:37 -0700 (PDT)
Message-ID: <1c197199-8033-2089-e660-90657397e4ee@linaro.org>
Date: Wed, 24 May 2023 12:10:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/10] hw/arm/realview: Move 'mpcore_periphbase' to
 RealviewMachineClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:59, Philippe Mathieu-Daudé wrote:
> -    int is_mpcore = 0;
> +    bool is_mpcore = rmc->mpcore_periphbase != 0;
>       bool is_pb = rmc->is_pb;
>       uint32_t proc_id = 0;
>       uint32_t sys_id;
>       ram_addr_t low_ram_size;
>       ram_addr_t ram_size = machine->ram_size;
> -    hwaddr periphbase = 0;

hwaddr periphbase = rmc->mpcore_periphbase;
bool is_mpcore = periphbase != 0;

would be cleaner and require fewer changes.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


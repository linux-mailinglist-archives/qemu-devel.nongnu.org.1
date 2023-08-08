Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A8774CE1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTU79-0002f2-W5; Tue, 08 Aug 2023 17:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU77-0002ei-Rg
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:19:37 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTU76-0007uw-9U
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:19:37 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a4875e65a3so4306266b6e.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691529575; x=1692134375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cqktlrYm6i8mlon/jccQI66imk9yJmujkdtkRCZEOEU=;
 b=t9qulUuIzftcHNNoZu2XujjNB3rlV2Z2WQsi+iLEPa0nz1i0IO8x8npWzL+2XUSs9D
 SBLtVk23YQQyOHAaCgGuJyxEqJOrrJEVCCmY5BexDrck2AyxhUpghFxr3e8XvpuCNpRd
 Nzo5XePaNystSLFSf3h25bmzpYmwcoMptQGfwnEJE5bmxYak2WonEqTFJZTRW2tbUh0Y
 8MRAPzW5MuUYLIn7XyXqCUjccOIurdDsOlyxqkgq2928hJejIf6VIbCHfBNku6uUWctW
 Pk+FjSQMRhNgY4cYqV8G5TYF6DEDmNoo1IUHMhbUB0i/X6K/WSghu863FJQ0ccoecwtc
 ySpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529575; x=1692134375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqktlrYm6i8mlon/jccQI66imk9yJmujkdtkRCZEOEU=;
 b=BUponVHHOV3AbsqT11kNG4L8vDIuYEaF96BLwWeYqUS688JJgJcy76jbWAYIN4FNNO
 uUeE66PmBBFUGMdXrXTUkH2Yj3x1nGA7+cltjdABbjmCHjuBzztEwoOuhPMuaPe0pJCy
 Rc3hak1HrAY4o/fRSCKpqj+uA3+gojp2iEZV6V/bTudVuXl7Qp9slN1UoakOELst08nS
 iHLGYQBMfYIfqLB2kb+L8S//APXlpaygjdi//GF5yrOi8Ub3KlnguoTrqVdnIqYh7d8C
 MdbVtukW2rO36XriY4nuXzUcxl3gjfiU03+QommMa8l5ERvx+SENy30DHezahNYuOhgq
 LUWw==
X-Gm-Message-State: AOJu0YxRgjCm/kv/bXq+Ms05g+XLQptck7h3UqNFjdlnDQliw3yPYFGK
 ehLorA3OMcmxboWe13d0VA0FSw==
X-Google-Smtp-Source: AGHT+IEw1KUZWXDDQwuJPyyxFwK9bd98kDxRz82aXJFuh2DwbJCa6+qFaJPdwvBTH61kL2J6fUXShA==
X-Received: by 2002:a54:470d:0:b0:3a7:1e86:e83f with SMTP id
 k13-20020a54470d000000b003a71e86e83fmr912181oik.51.1691529575008; 
 Tue, 08 Aug 2023 14:19:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 rj6-20020a17090b3e8600b002635db431a0sm8317318pjb.45.2023.08.08.14.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:19:34 -0700 (PDT)
Message-ID: <f4dc1de6-40ba-2fd7-bb83-2e0ee4f20d99@linaro.org>
Date: Tue, 8 Aug 2023 14:19:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/33] Forward declare functions defined in os-stat.c
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-6-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-6-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Michal Meloun <mmel@FreeBSD.org>
> 
> Add to bsd-user/freebsd/qemu-os.h the forward declarations
> of conversion functions related to stat syscalls.
> 
> Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/qemu-os.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
> index 7ef4c55350..12adc50928 100644
> --- a/bsd-user/freebsd/qemu-os.h
> +++ b/bsd-user/freebsd/qemu-os.h
> @@ -32,4 +32,19 @@
>   
>   struct freebsd11_stat;
>   
> +/* os-stat.c */
> +abi_long h2t_freebsd11_stat(abi_ulong target_addr,
> +        struct freebsd11_stat *host_st);
> +abi_long h2t_freebsd11_nstat(abi_ulong target_addr,
> +        struct freebsd11_stat *host_st);
> +abi_long t2h_freebsd_fhandle(fhandle_t *host_fh, abi_ulong target_addr);
> +abi_long h2t_freebsd_fhandle(abi_ulong target_addr, fhandle_t *host_fh);
> +abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
> +    struct freebsd11_statfs *host_statfs);
> +abi_long target_to_host_fcntl_cmd(int cmd);
> +abi_long h2t_freebsd_stat(abi_ulong target_addr,
> +        struct stat *host_st);
> +abi_long h2t_freebsd_statfs(abi_ulong target_addr,
> +    struct statfs *host_statfs);
> +


This appears to be the patch that matches the subject and comment for patch 4.


r~



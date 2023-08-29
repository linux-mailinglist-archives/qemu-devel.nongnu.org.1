Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAD678D08B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nt-0001b1-AK; Tue, 29 Aug 2023 19:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Ld-00050z-ME
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:30:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5La-0004Hv-Ui
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:30:01 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-569deb93999so2535542a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693340997; x=1693945797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wOM8nOV1ZTW89eAy5V+tZ2xQzyo40BGKFsHVOFoMV8o=;
 b=IdGn6aQwFwncMiuUJvZqfnmBnUT1lg/E4pX+gzAC4mYny3r+O4qfZ42u0T8MJCHtbL
 c3TFUNMiGAG4h8Y6bmqR2EL9LIS3c+SyGp9AuBmIhVbnk6O/HfJJTVv1fRb8oVbmnWzS
 v+lr+zZGjhbXIqFhYvOYSWcSwIqXLXZVHnIrpzYr0wM/0JJBrovxYUW1zffT42sK93If
 6tdwd1R1g/zzk7OIO26SXLryRvLhE4mLTwmSvlAAbH3d5MDuqCy5BAem3gik273lkjEu
 BYL1V24H53k4Ea4qxURIrtePiEgt9KpvvWvYUomswFjlKWquV5aeJ/5QKeguVhWUZKlE
 pW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693340997; x=1693945797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wOM8nOV1ZTW89eAy5V+tZ2xQzyo40BGKFsHVOFoMV8o=;
 b=Ou5O0b+BKEe1327laflq+IRFF5C6M1jYndrOYV0xY8b6iVxXeoLVZYZrAKrKNYB5Hd
 Rh0i/ntwn/oibcg8pRYRs3P7KSkrKZpFcceXDJijqpKcovW1Me3kEXTBU6Gewa9phn7Z
 XNCH/70KnfU28JFNts4W9ZieRl2UDvnlBzAcoi9syZe6DgbZsBgX0UvbTA6gLJai62Sh
 DEbwNb9edeKFFmmY1iWZga1wsCvUuBVo6++jyjcpwPr/YvTSa3QTVqm2mRrTzbLI/EPi
 ZlYz9ng3W+g9HH7oA8wTVnxoDSTwC2IDt0ppC2guET5zfl8ckfjIZBvhsAjovbOWWBDe
 D6Mg==
X-Gm-Message-State: AOJu0YyqicXo1lOqmzB2G3jrWghCdu9SO111bhnQM49K95jFqG/Z3fGA
 jh0MWQFyjjf4pNkN8NtHoL3dXw==
X-Google-Smtp-Source: AGHT+IHxBa9ZszpAGpdSeOgi6BV9zDdbGBa/1DMvA3FJIHweca/nomHLtWegt+XKBpbRWL0WB3FNcA==
X-Received: by 2002:a05:6a21:272f:b0:13b:a1eb:79e6 with SMTP id
 rm47-20020a056a21272f00b0013ba1eb79e6mr347648pzb.53.1693340997364; 
 Tue, 29 Aug 2023 13:29:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa781c5000000b006889348ba6esm8862980pfn.127.2023.08.29.13.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:29:56 -0700 (PDT)
Message-ID: <f834ac8f-35a0-b2b1-c8e8-fe8ddd202d78@linaro.org>
Date: Tue, 29 Aug 2023 13:29:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 24/32] bsd-user: Implement h2t reaper_pidinfo and h2t/t2h
 reaper_kill structs conversion functions.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-25-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-25-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.c | 50 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> index f069472156..a413109bc2 100644
> --- a/bsd-user/freebsd/os-proc.c
> +++ b/bsd-user/freebsd/os-proc.c
> @@ -301,3 +301,53 @@ h2t_reaper_status(struct procctl_reaper_status *host_rs,
>       return 0;
>   }
>   
> +static abi_long
> +t2h_reaper_kill(abi_ulong target_rk_addr, struct procctl_reaper_kill *host_rk)
> +{
> +    struct target_procctl_reaper_kill *target_rk;
> +

Unused functions will error; non-bisectable.


r~


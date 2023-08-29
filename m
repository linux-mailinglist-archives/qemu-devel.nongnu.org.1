Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A074D78D078
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nu-0001nA-TO; Tue, 29 Aug 2023 19:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5YZ-0008Fl-HG
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:43:23 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5YW-0006sT-2F
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:43:22 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68c0d262933so3075737b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341798; x=1693946598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Um+z/7+hxbxlGhpkDHaB/ZCyJv6rTeBjfyF1z8H1e0=;
 b=Csc7LSaFnKHHwq3T80wp+gNX3AXmOohFWHk9EYIlilbjH0hT2ilq4I/RQJV/Mj2V+q
 sDVlR7muMdsI+JaiEs54o3uU8nM+U2n6UE27aCq5E5YrBEGZ2s41bYu6gZDroxXV4Kzy
 ZHE/NgNZMxB32ls8jWU5ZZfqEojhAl7m0vTEJxfqb6/TPJwY0tndAv2mm+PGUDtabL3L
 bEQyF2wwj4ArGb3VidmDpjLPlejaIHx5e3iQF2KoLmkK9yAQg2+dzW/EjcqIaefSMOj2
 4VmtSbBaYHAENOGPudK/lT4d+dKfF+/YqDNvS3cZgNqVNPDP8IjIJVS/TRmfx1b9erV9
 53fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341798; x=1693946598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Um+z/7+hxbxlGhpkDHaB/ZCyJv6rTeBjfyF1z8H1e0=;
 b=MyFrEJiaIR9aibADCjFB/cbFuYVMKm1azJe3ilIcpzKivflmPSKO20SktTasCJWCgU
 V4DkbkKCpWwX9RA0+XFv3/gMh6hQ9hkKjKbkS+eFfrHMuof/YpHvwPYX+QPPHo+H4T8V
 LZ6OKg250l1yJAz0AUiDC0jnwKomG1VCPBXX/F+LfsyCMP8fY/ZqhwAE1MS2tfqf4IX6
 JuAlWBaRJ2JS5BiTPYVdZN2Z8OksM9BAUIn9zYdTBlVb0m8QXOgNqul/JtgAbru156R7
 I4TLKFOUwrWKLV3cWw00XXNOnCBNpAZASpXXT1mcbf0h0ghnlc/dudtQKp3xq/FrySrP
 GRqw==
X-Gm-Message-State: AOJu0Yz6kDfmCMmDqeCHeyY6ox/la+WnvLUK6q1vgslGetRLtm6GpeJ9
 3SidqSobE/llWoRGvxKIAR/R9w==
X-Google-Smtp-Source: AGHT+IGxWd575zyNXZH4KQawBpJqWV6l5b2kRBhp1Cg4F1/2lqP3d6u8Zk1HF8uBKW91MnMRWr78wQ==
X-Received: by 2002:a05:6a00:15cb:b0:68c:4c29:9c49 with SMTP id
 o11-20020a056a0015cb00b0068c4c299c49mr348358pfu.31.1693341798157; 
 Tue, 29 Aug 2023 13:43:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b29-20020a63931d000000b0056afdbd0a24sm9373730pge.9.2023.08.29.13.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:43:17 -0700 (PDT)
Message-ID: <c3dd4e5c-d62b-35aa-6d50-0e8453248312@linaro.org>
Date: Tue, 29 Aug 2023 13:43:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 31/32] bsd-user: Implement rfork(2) system call.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-32-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-32-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.h    | 38 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ++++
>   2 files changed, 42 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +    /*
> +     * XXX We need to handle RFMEM here, as well.  Neither are safe to execute
> +     * as-is on x86 hosts because they'll split memory but not the stack,
> +     * wreaking havoc on host architectures that use the stack to store the
> +     * return address as both threads try to pop it off.  Rejecting RFSPAWN
> +     * entirely for now is ok, the only consumer at the moment is posix_spawn
> +     * and it will fall back to classic vfork(2) if we return EINVAL.
> +     */
> +    if ((flags & TARGET_RFSPAWN) != 0)
> +        return -TARGET_EINVAL;

Braces.


r~


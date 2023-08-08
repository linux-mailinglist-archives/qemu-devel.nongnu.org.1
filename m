Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F39773AC2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNvL-0006dO-UH; Tue, 08 Aug 2023 10:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTNvJ-0006dA-1Y
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:43:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTNvH-0007sX-DN
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:43:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bb893e6365so37386635ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691505777; x=1692110577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=72aYr4EaxbaS/OzvpRxPgQQqhUzMwSOO90oKlvhys/k=;
 b=FmLvEeMmeNwA/LbUNF3E7qlIw31modSuNfnkmyKkf5103LojTWbvEp3zOOjLRDd1pK
 WkSFesa0WBBEaGVxJqExyf/cpc6vuBfTXfQcHiuLRsvwaAVvk7LWcJFVRa+XecdS4rwo
 nxgY+KZDSS7Q6CroqbtCo6juDBwmnn9RRsHgPpwn2ogOy8iBVHcADsFgZQHG3fkcHasK
 q/K/0NUFuOXgV49m9rQQyzFj3iY4UUruVarraQjwbftaCwUXT+YUK0E021JhgNXFj96Y
 0GAp0VRjsXvsxu8U6P+XNK3rBx/TEfevvvNUuSQFhZPx8G3HqpNkV5fX1SUC2ZeJbMLp
 /kFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691505777; x=1692110577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=72aYr4EaxbaS/OzvpRxPgQQqhUzMwSOO90oKlvhys/k=;
 b=fxwnGy+PPhmjGYpXe2qJ5O+O03LspYxZHhkccnmetTDEMiTscQ7DTqn1WFeorbCM05
 pYJhX9O/fCGm/L6FX1hrFxcagB9yC9zO7YuKU7a95txU9nkGH9YOSXOwxyDbu8JegGcF
 wQTP+o3zkVlQ1yzyhdH+iIl7JIW9Y9YU95O3CvR59j4f/5QQ7nYZRNKBOegbsaU9aFO+
 j6BFVmz5oCJzlYd2VP6tCNcWNGgoarwP0W0LgnZzi03tH5AM3OJB2b6S131ozqtiOA1n
 446/R+E7DVOQFU4I0xDIK/WtMvdo2M19jKWpPBBw5fSBDdcd/abdEeh5Llhbf/qh3Q/H
 ifcQ==
X-Gm-Message-State: AOJu0YzsFuPdUQrwT6eUfgPwZCvv/3t1I17MaAYrf9bBIL2yBSrTVMJ+
 iT8PloEU4jczzDfptsoBf1x3bg==
X-Google-Smtp-Source: AGHT+IF0k9aSSSzVaj/jkEGoRHrly3zvDGFq4DOd3DolycG83WaJlQToNddc0QC0QnyvEh6x7XV23Q==
X-Received: by 2002:a17:902:d4c3:b0:1bb:c7bc:ceb4 with SMTP id
 o3-20020a170902d4c300b001bbc7bcceb4mr12120510plg.60.1691505777585; 
 Tue, 08 Aug 2023 07:42:57 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a170902ceca00b00198d7b52eefsm9099195plg.257.2023.08.08.07.42.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 07:42:57 -0700 (PDT)
Message-ID: <637ce4c6-9ac6-0bb2-aedb-632f79777902@linaro.org>
Date: Tue, 8 Aug 2023 07:42:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] linux-user: Define real MAP_FIXED_NOREPLACE value
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 qemu-devel@nongnu.org
References: <20230808115242.73025-1-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808115242.73025-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/8/23 04:52, Akihiko Odaki wrote:
> do_brk() assumes target_mmap() emulates MAP_FIXED_NOREPLACE even when
> the host does not support it. However, such emulation is not possible
> if MAP_FIXED_NOREPLACE is defined as zero.
> 
> Define MAP_FIXED_NOREPLACE with the real value instead of zero if it is
> not defined.
> 
> Fixes: e69e032d1a ("linux-user: Use MAP_FIXED_NOREPLACE for do_brk()")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/qemu/osdep.h | 8 ++++++--
>   linux-user/elfload.c | 1 -
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index cc61b00ba9..1aac17ec2f 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -289,8 +289,12 @@ void QEMU_ERROR("code path is reachable")
>   #ifndef MAP_ANONYMOUS
>   #define MAP_ANONYMOUS MAP_ANON
>   #endif
> -#ifndef MAP_FIXED_NOREPLACE
> -#define MAP_FIXED_NOREPLACE 0
> +#if defined(__linux__) && !defined(MAP_FIXED_NOREPLACE)
> +#if HOST_ALPHA

HOST_ALPHA is not a thing.  Also, see

https://lore.kernel.org/qemu-devel/20230808120303.585509-3-pbonzini@redhat.com/

where host support for Alpha is completely removed.


> +#define MAP_FIXED_NOREPLACE 0x200000
> +#else
> +#define MAP_FIXED_NOREPLACE 0x100000
> +#endif

Which supported hosts do not define this value?  Can we simply remove the fallback?


r~


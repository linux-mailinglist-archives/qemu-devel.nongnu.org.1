Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D5A78D02C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ns-0001aA-JN; Tue, 29 Aug 2023 19:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5SP-0006EH-2I
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:37:01 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5SM-0005qg-Nl
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:37:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68a6f6a66e1so3542955b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341417; x=1693946217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mxH2Vxtezv6G7eT4uDlCmSXHRuBqPDBg+fZxBMbcmZk=;
 b=Ipwk4N3u9y2tkaqnJ5qedblAyrLBwdPcnleWVgrgCGr1iEypNpBGuqgVTAE9gyxMwT
 bgNJmcZ/99DbA9lLG5JBPdKmBI8vlmyo7Knjcybu0ZK4NkNGfxAUKVs6W1u/UCi/+w+2
 NnT0GRWF8ztv2MdMg8AedAojpi9XeWGSPTZ1XdY1vmhob4Oy25pztP4Ga3Vo41JBok7c
 jiwM+SBJlwmu7qfoiHk4bRHmWnIpN6Aia09aH3EpDqGHO7KXDbNahlYhlxTzlzJI3SjZ
 pNf9xZL+FcvXzV46AdsiT2c6bFK4cUS+xlbksK1epxxJC1llxrgdO3GpgrpPR2Sc3FG4
 k/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341417; x=1693946217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mxH2Vxtezv6G7eT4uDlCmSXHRuBqPDBg+fZxBMbcmZk=;
 b=N6DLD+J9OzmvY0F7atKAtCOT0EglfnVfohKe+Onsv8RxDHup0+QR3b+ouFjCsb8CxU
 qzf1eZaVccFS4uGdc5GC1gJwdAJ5SMhQeS1kqS0ke/evrn8p4NmxF1vb0up5whj1wwlg
 5rnHcFpoWGIgBkYLgK3jh+HirrWDS86ZmQBIrTxmXeGe1CuBY7Cb3fSBqdhPxIDa3XCw
 44dYmtR/rVlG/n0Yfzgw60tUwkyHBfo12nln1r15wIS1BnP9Sv8wJtCMvtsIfs03IH8t
 BZitreuk47T6WZ9z+Gn1+rYPxvIikknMvh7EBxrznfMSdnjuOCEpRd6EMJkV/n3B9xgE
 IzKA==
X-Gm-Message-State: AOJu0YwZryZq+Xn18dBN0rULWbvRhD6DJojYtWGIp8lQXb5BghBYdtcE
 IJvpjbv7TZiagf2GM5oY98f/uA==
X-Google-Smtp-Source: AGHT+IHGy9YJ8cgmDMFwAz3Zkn07F8YTjNELusJpx64jcRn8N+LuXX1DTqM4Pj5reJ+w4J9jNouEWA==
X-Received: by 2002:a05:6a00:178f:b0:68c:3f20:5e8b with SMTP id
 s15-20020a056a00178f00b0068c3f205e8bmr340647pfg.15.1693341416984; 
 Tue, 29 Aug 2023 13:36:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a62ae19000000b00686f0133b49sm8881539pff.63.2023.08.29.13.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:36:56 -0700 (PDT)
Message-ID: <f2150b44-e20a-2bb2-4764-d0668497708e@linaro.org>
Date: Tue, 29 Aug 2023 13:36:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 29/32] bsd-user: Implement pdgetpid(2) and the
 undocumented setugid.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-30-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-30-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
>   bsd-user/freebsd/os-proc.h    | 23 +++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++++++
>   2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +/* undocumented __setugid */
> +static inline abi_long do_freebsd___setugid(abi_long arg1)
> +{
> +    return get_errno(__setugid(arg1));
> +}

Given that this is

#ifdef REGRESSION
...
#else /* !REGRESSION */
         return (ENOSYS);
#endif /* REGRESSION */

in current freebsd, we could probably just stub this out?


r~


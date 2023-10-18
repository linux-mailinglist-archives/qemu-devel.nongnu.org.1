Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E497CD1D9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:34:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvRf-0001AT-QW; Tue, 17 Oct 2023 21:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvRd-0001A1-Qg
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:33:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvRc-0002jR-7L
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:33:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so3280144b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 18:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697592835; x=1698197635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xs0BLIsdmJFNS+yu7PReUGpjpfBUR++ynzHUGauQfQ=;
 b=JNUVjLYFNdaIXh1GBVzncbVGYnPkGv02k/CEO9Uvss9EMsMvI3f4kBdeGnGng1ct09
 cWJNxKEaqB/E9TKXLAZYPUUmxZ+EkDr60Ql3Zbqzy7nhRcqkT3M5CThXvYvi8r5ZyIZ9
 dB6/chfjyY9mYcotW44DeQbd1sNI+2jJInUoGQ+UOJwB7JG+7RuqzGR2IVHgZgf0urqy
 XWEmxK7pIkjoxcpuYhi4BaZoh5WvQzsjxbXAuiqA6JIOYxTD2SiGjnLk+f+Fv6lN1j0E
 1lJyODn/KU0CdA2vRUODYj3CHk5RFt00NVQyGHbTI4zVio/3FIq300qS7xQi8sZnuM+9
 Bx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697592835; x=1698197635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2xs0BLIsdmJFNS+yu7PReUGpjpfBUR++ynzHUGauQfQ=;
 b=aD1aV9PnyuuzLbPz+0Fw9D/0KJ8tfflFi2mK9v8k2ra4aatZfO74Pg2+/Vw7NCXLuN
 SWKdsI/pv0a94VJ4nDVB/fl+o5zdRctqY1d0dbjIzpr7318hpXP+qAnGKXIUPPdO9DM0
 Tc8yHroRIhnsbCDw5XZS4Z9QnYyuugg0rUkSkQCqWUDPVPL/ZRhKugOXnxPLuyJHDVFo
 oajucRTD1dGbaa1RMACAG5UUU1iU524u30c8W6yImvR/ih1jJzRjZqwN23baRblj4t3o
 rRQSd8k6jHxA9KOeZJNVTvx4EijrN/X/kOJoPjGWSGzUaTSzDDzbCUAB9G2mKip9lvgO
 9okw==
X-Gm-Message-State: AOJu0YzdRIko6t74qMvevfFWfalu9e1eZy1QUbdeN+j89ogj3H1YQB/x
 g9DgF2Pgt1APaocEdOAXkpzj6Q==
X-Google-Smtp-Source: AGHT+IHHmIQebqEAelgNUz2MiM3QULAYjwhHUgzoZqmZqZ9cGtV828IzJbPzM42BsYuvrC7r2ijFCA==
X-Received: by 2002:a05:6a20:7d97:b0:129:3bb4:77f1 with SMTP id
 v23-20020a056a207d9700b001293bb477f1mr4278592pzj.0.1697592834629; 
 Tue, 17 Oct 2023 18:33:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a170902d48d00b001c7453fae33sm2204214plg.280.2023.10.17.18.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 18:33:54 -0700 (PDT)
Message-ID: <db34f1a4-84e4-47ea-adbc-d2c7b0c92eca@linaro.org>
Date: Tue, 17 Oct 2023 18:33:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] target/i386: do not clobber A0 in POP translation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-10-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> The new decoder likes to compute the address in A0 very early, so the
> gen_lea_v_seg in gen_pop_T0 would clobber the address of the memory
> operand.  Instead use T0 since it is already available and will be
> overwritten immediately after.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


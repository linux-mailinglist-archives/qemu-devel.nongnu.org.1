Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B57DD8A5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxcd-0008UR-BL; Tue, 31 Oct 2023 18:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxcb-0008UA-57
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:54:05 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxcY-0004sb-Pc
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:54:04 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso4055364fac.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698792841; x=1699397641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tgr04EbpKU3TnjahQvQjK04nKu0I9n4zWLqA5soAWhI=;
 b=GE0zNyCb1Ei56opBO/WPqCXeA5nnlc3iAETT25lGM0t07vu1wBM7yrKuFhxFc3x1B2
 1QmkZfKhLXfBAUmvNU6jdD9CxJTfiWehIvIID5a31iKyDygqZW6yLPikQ3pQ/tOESmcs
 f3v4FQ4b9wY+EPsj74KOhMMKmD1CSLMHmuiB8WuuT9Fr78v4tOdbfsJ/St77cOyYmBd6
 Oo7DY3VWXc2PayimDmonmMqdgRR2F4CRqxNqmGgGkqnKQzexjHsIlGX/dXwD/x+q+bRH
 9xdO2ztprbV0V/zpJy3fj5MLxZKHUY5vWbsQM+EWiSKh2nxelcr1w9Gw8odcPH4Xycj7
 f/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698792841; x=1699397641;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tgr04EbpKU3TnjahQvQjK04nKu0I9n4zWLqA5soAWhI=;
 b=fRWpaXX66Zv2M6vbVx+kLAjZ4vm9YRaJLRwX7Rucd51PBXW+6apWfz300Ayz3ZjXLc
 jHNwZnJAcca8/ZRBsAMX+635/tdGLRIIXiZmKBKkydC5t+hIVDhhNQ1b2i977PZjqMRv
 EAfSBU7tkygV4G/HVzMXyKcPPl+kPw4GtR9DHFn7Mx7Z0Z4tZrn/Hsgm48K64gLYM/df
 GVg7fVHTtAPxesV8YZicL8UG/8nZVHuYZqbzU/Pqxm0HS/0LIUo0EIO/i+isra3eeM6M
 ESkNNELn0gV7LSYDkkYcGV8Hbu/Qy8weMdvVg/H0ScqoDyNIBlDX5+jyuMCgsIMvzmmV
 NAyw==
X-Gm-Message-State: AOJu0Yz7owDPglxNoGefy57REG12S4h+8wzhLhiHlUrv/boAe1bKNTVc
 hwPjj7LeTA3dQYryxLS8qJSLzQ==
X-Google-Smtp-Source: AGHT+IFfz8iU6AEmC2H4Hdo62S4LIWRwDAtA5gBE8n3nnZ5pah4bcpFdIbz+k0PWeySZQtUYovVCSg==
X-Received: by 2002:a05:6870:1094:b0:1f0:15f4:41df with SMTP id
 20-20020a056870109400b001f015f441dfmr2296696oaq.37.1698792841558; 
 Tue, 31 Oct 2023 15:54:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z127-20020a633385000000b005b67d666159sm1472712pgz.53.2023.10.31.15.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 15:54:01 -0700 (PDT)
Message-ID: <9963393c-f641-402a-94a1-86e6ef740adf@linaro.org>
Date: Tue, 31 Oct 2023 15:53:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/tcg/s390x: Test CLC with inaccessible second
 operand
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20231031053718.347100-1-iii@linux.ibm.com>
 <20231031053718.347100-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231031053718.347100-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/30/23 22:32, Ilya Leoshkevich wrote:
> +int main(void)
> +{
> +    register unsigned long r0 asm("r0");
> +    unsigned long mem = 42, rhs = 500;
> +    struct sigaction act;
> +    int err;
> +
> +    memset(&act, 0, sizeof(act));
> +    act.sa_sigaction = handle_sigsegv;
> +    act.sa_flags = SA_SIGINFO;
> +    err = sigaction(SIGSEGV, &act, NULL);
> +    assert(err == 0);
> +
> +    r0 = 100;
> +    asm("algr %[r0],%[rhs]\n"
> +        "clc 0(8,%[mem]),0(0)\n"  /* The 2nd operand will cause a SEGV. */
> +        : [r0] "+r" (r0)
> +        : [mem] "r" (&mem)
> +        , [rhs] "r" (rhs)
> +        : "cc", "memory");
> +

You could just as easily set cc based on CHI or something to avoid hard-coding r0, or even 
clobbering an output register at all.

But I guess there's little point bike shedding this too much...

r~


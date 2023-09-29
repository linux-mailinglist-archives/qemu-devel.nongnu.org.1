Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C43E7B3BCA
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:06:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKgn-0002jz-4R; Fri, 29 Sep 2023 17:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKgl-0002jq-P9
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:06:19 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKgk-0000t8-7X
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:06:19 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-690bccb0d8aso11880748b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021575; x=1696626375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AmOEi9S8toxSpBud/4PwUH0i5kcePrtLmfEaLUkkmJQ=;
 b=BH4ImMUtXKet7ZhcC9LuKyaD7kmK0JtpmwuF7rSWgvfkP/+UGONvLTBj+w5kai/P6r
 XlPGMCRqQT42EuSV+dS2YoaJqtIajqn8XhAozWXKCvPs8H5LYPR7JeGGuQHDDdUX4F0h
 UHlc5dmmQ1fo+t7n8T/Q55aSK39Zz8ELBOKJSN8EPu1+1hXNoL8c2+h58fDw4XUhJLt3
 Krisp7ddxfVfP0uW9O9R6h0hl2o50dGh86JHeva+Lbf4QCmp8+xgcJpQ+cblvkFr2AR6
 FicY7OkSEdMLVwijZbK8zTiW9UKl4aMQGzqreBAlBuILgXYkeB+bw474O3S+mMCSsvPk
 FNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021575; x=1696626375;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AmOEi9S8toxSpBud/4PwUH0i5kcePrtLmfEaLUkkmJQ=;
 b=pBZhezd8zl5y1gNOr3lflzDOTmAJHyXB+lqvqN/OHtNXnL2KHfmwADAoYhJaCrSGfb
 iziPcNBEMrNUDepX76qIbskK8lM/3nRVyJJql1K5zFY/Qz9JrTO/saUQxnARzz/Az6N4
 jlDUrVE8aBETphbRM9EW4QEQZt6bDySgLNwqCMxlpyMpxZid4DAu2pzsuBWFALWdaHEg
 6wncZcoyeTW6locFUijCTgdEKLrLat1p6b+ovB9XlNz4lpjNVTJnDWWeOPKQ9sKae83G
 zaqpoGlb1SrHEVRlVacIplAImejKn+HZiLKzuMbU2EBln/kQJuX35tyANG3F8Q36rQqe
 jnoA==
X-Gm-Message-State: AOJu0YwKpozbUaf34EyYae41Maomio8pYbmGQSpNv75FZywb03F5alYn
 hN2t7Ww//eODSEYSsu+ItebcU2cexDguPCsPa34=
X-Google-Smtp-Source: AGHT+IH6UMwx3okucBh4xuaB7NitrgrmVh2ojlr/OfknGx/uw3GMIRvi+Jv9dL1KR2ateNaYBRHphA==
X-Received: by 2002:a05:6a20:3d02:b0:15d:7e2a:cc77 with SMTP id
 y2-20020a056a203d0200b0015d7e2acc77mr6577351pzi.48.1696021574986; 
 Fri, 29 Sep 2023 14:06:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w18-20020aa78592000000b0068890c19c49sm4022639pfn.180.2023.09.29.14.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:06:14 -0700 (PDT)
Message-ID: <c8acc597-8e65-c1da-c320-3c77255f19db@linaro.org>
Date: Fri, 29 Sep 2023 14:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/22] exec/cpu: Call cpu_remove_sync() once in
 cpu_common_unrealize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> While create_vcpu_thread() creates a vCPU thread, its counterpart
> is cpu_remove_sync(), which join and destroy the thread.
> 
> create_vcpu_thread() is called in qemu_init_vcpu(), itself called
> in cpu_common_realizefn(). Since we don't have qemu_deinit_vcpu()
> helper (we probably don't need any), simply destroy the thread in
> cpu_common_unrealizefn().
> 
> Note: only the PPC and X86 targets were calling cpu_remove_sync(),
> meaning all other targets were leaking the thread when the vCPU
> was unrealized (mostly when vCPU are hot-unplugged).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/core/cpu-common.c  | 3 +++
>   target/i386/cpu.c     | 1 -
>   target/ppc/cpu_init.c | 2 --
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD0981FB7A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:13:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIydO-000452-P2; Thu, 28 Dec 2023 17:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIydH-00044q-EE
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:13:39 -0500
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIydF-00062e-Ka
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:13:39 -0500
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-35fb0dcec7aso29079495ab.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703801616; x=1704406416; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsllLRWVRlcdBoqQymuvs23PuJyxqm7gAVrQjURV3Gs=;
 b=kkNNzoNeI0GypFLHUq2ayga4hD6H3UU0yUIaOdmv34QofhX8y00Q2Yt1falvxwDh7j
 0ccMX+/7DuqZkk8a3uLdOINTO9Y/Vh7WlXQMBfo7g4xS0q2ViKowE/+SXHgKt49zZpu6
 RUl8HOmpADRDEyIEo/I6jsELOGQhPMxkoIzxpwV8kZ15gdm4bpeViATd/2MSMruMjrc7
 jTIUfEfm2nQv76Pfogxd35jJP4lX2ysjxI5biQqiPWd1N7jg3nNoGC4D9+R7i7LfiQCS
 P3YvAk2gXVok4chBOAGM31YIX7iOcJRTza/v0etB5q7lJGpZs8UjDXd2gKqFQt0KBU/1
 udmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801616; x=1704406416;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsllLRWVRlcdBoqQymuvs23PuJyxqm7gAVrQjURV3Gs=;
 b=CGcpG44mMc2/5VhU6C4vTQ6CHjQrm6JIzEG1Y8Vl631nHW+rfB91FcYY9PukjckToK
 wRJrx2KQcI1kpdp5EoXa7tZrt91BArZEkXA2XGowU2aKI53zP90E5zQbmL+WfKlUMba+
 4LWr4nz47kweb2Jl+I44XcDhtVl16peaRZfnSSn7tBVW7Q/NaNhSiPCa3qvTa+C4toRP
 np4Ibeo4cbpeJKI+j6uPWmkG8ofygJT7ELHkjRefi3iTLHvzzpep0qidqpL1unzxespi
 eA/W+oNSG72lpTeQoRblfoS7N6MJcTO9p/9aBR9jeNYMn9ZeATD6DQ6JSbfxWQWeopBD
 iWZw==
X-Gm-Message-State: AOJu0YyIwI90yMCsl93vu7nkuxMjbfUHq9OBs8cZ8l+CNmsWCMxjOG9i
 5OdHimrikjAr4tCAwgJCbjxPOBZul49FjA==
X-Google-Smtp-Source: AGHT+IEH82nO9ebZg3qwdoATNPqTo9SiPO182QVJ/kX5FZSOoJH5ya9s/bJutxYcKmgErC+zGORY6g==
X-Received: by 2002:a05:6e02:1a0f:b0:35f:e864:f84 with SMTP id
 s15-20020a056e021a0f00b0035fe8640f84mr13445751ild.34.1703801616361; 
 Thu, 28 Dec 2023 14:13:36 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:324d:cbc2:5f8b:3a9d?
 ([2001:8003:c020:6900:324d:cbc2:5f8b:3a9d])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a63f406000000b005c66e25497dsm13780300pgi.83.2023.12.28.14.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 14:13:35 -0800 (PST)
Message-ID: <6b33f21e-d02c-43c8-b7b0-a36ea3b82a51@linaro.org>
Date: Fri, 29 Dec 2023 09:13:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] target/i386: split eflags computation out of
 gen_compute_eflags
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231222181603.174137-1-pbonzini@redhat.com>
 <20231222181603.174137-15-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231222181603.174137-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/23/23 05:15, Paolo Bonzini wrote:
> The new x86 decoder wants the gen_* functions to compute EFLAGS before
> writeback, which can be an issue for instructions with a memory
> destination such as ARPL or shifts.
> 
> Extract code to compute the EFLAGS without clobbering CC_SRC, in case
> the memory write causes a fault.  The flags writeback mechanism will
> take care of copying the result to CC_SRC.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


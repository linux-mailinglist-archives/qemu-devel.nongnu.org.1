Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE27A95D2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 18:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjMu5-00037n-Qy; Thu, 21 Sep 2023 12:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjMu2-000371-WD
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 12:51:47 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjMu1-0007Ns-9o
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 12:51:46 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so148297766b.1
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695315102; x=1695919902; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pVXBC0L9QfvtW86GfaQjLjNtgSEazJ9DYEgnylnW4do=;
 b=rpx1fTJ8XEY+9JUeqJzN2AiXq/OttStmmmjQDNUqa6aJmdl0bYzrS8TH6v19dnZKcn
 zSOSGSf14H3JYMvBPwZXVdrKx4mCSiO9AJ6lgZMOXupf4BclsC4a30UrKkWNpcRyeZAr
 yx7Zp1Bn4k2C0V89kdNpmzNmjOsWKj+EkJqnYQ9X59OosrAafcAxfyy5LNA0+43nnfTh
 qKRSBQtdewfHK4oegpeLaWiSoc39XEsEeoTZecMAr3C+oEdfvLox9cTq0ClkMaDJJ4TJ
 EoWtZ0EGvRsFMTpLr1q/ot77dT+ywpCHg/Tu+//fugdun83z27Wb1Bpqfa4oF1V3D9rq
 dKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695315102; x=1695919902;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pVXBC0L9QfvtW86GfaQjLjNtgSEazJ9DYEgnylnW4do=;
 b=mKos4a44wZximtCXzomUg/ffiEyKIR8x7Se+nWwdIbqS7JMzq6D6XMrzvC31Q+uQcr
 1k9nVJhjIT8sW5z8PFBFkM7KdFnr5CDJnfBL3jdhk/b7oKy3QCZBGRtCr6XzBYxU30fz
 O39O4PA8J0rlK6k9xs6gmnzUTx4tWo4UKQ/pGzY9cDXG+byIxDzOl5I76D7iiqDJrPUe
 T62ZlqVsZgRPWLZX0RRtL474UW6AfKKVDfjJYXMI3m5yY6f0/i+d8cj4kUSkJEjTH65Z
 p/jNIdrxUfXRsP4tSQK+8OhYNzhwCz1W5cruTTPAJk2Ut4lPc0u3acAerlOn7WZBIe1c
 4/pw==
X-Gm-Message-State: AOJu0YyfGNu1WHJyDY7WNJMSHQFD94wHm5DDHLDo2UPlVWBhg00N8GSz
 +jrgmiMHJgvvY+Vrtnrw6JBlLA==
X-Google-Smtp-Source: AGHT+IGwSOiidFwbgp3IC84p5+upDFUUEtCu+fAZZW0gdqfKUfpyGKXHHz8FOh4HcCngbonqnmvfkw==
X-Received: by 2002:a17:906:845c:b0:9ae:5765:c134 with SMTP id
 e28-20020a170906845c00b009ae5765c134mr2677399ejy.15.1695315101877; 
 Thu, 21 Sep 2023 09:51:41 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 a19-20020a170906275300b0099290e2c163sm1278132ejd.204.2023.09.21.09.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 09:51:41 -0700 (PDT)
Message-ID: <d47f9e78-cbac-83d1-e29d-373e4c45ceb0@linaro.org>
Date: Thu, 21 Sep 2023 18:51:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] linux-user: Fixes for zero_bss
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, qemu-stable@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20230909184559.36504-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230909184559.36504-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/9/23 20:45, Richard Henderson wrote:
> The previous change, 2d385be6152, assumed !PAGE_VALID meant that
> the page would be unmapped by the elf image.  However, since we
> reserved the entire image space via mmap, PAGE_VALID will always
> be set.  Instead, assume PROT_NONE for the same condition.
> 
> Furthermore, assume bss is only ever present for writable segments,
> and that there is no page overlap between PT_LOAD segments.
> Instead of an assert, return false to indicate failure.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1854
> Fixes: 2d385be6152 ("linux-user: Do not adjust zero_bss for host page size")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Pass errp to zero_bss, so we can give a reasonable error message.
> ---
>   linux-user/elfload.c | 53 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 40 insertions(+), 13 deletions(-)

To the best of my knowledge,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



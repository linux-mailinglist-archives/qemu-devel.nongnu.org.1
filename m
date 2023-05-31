Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105E717624
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EMR-0000Wo-8X; Wed, 31 May 2023 01:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EMK-0000Wg-Nb
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:26:56 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EMJ-0005uS-3W
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:26:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so1341595f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685510813; x=1688102813;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClAqDDOgE9OaLr0V8/8hoxlPdfQjkVfzGMBHbjNV0Sk=;
 b=o8nWrrkC8SZaN6IDLySwBHa5ZY7FyPbHZEsEqZpaQJXQg9K3Le6fFtJevHgPA4DmPj
 jkevffkjtQy0ua+BupMQsrFXmcC3O+8MA7QytCuLtfI26lq059mZvCu35kVWPOxhQqfg
 SfLlXIMjDYcjAStPty91QkeTq22XbxsLM5Uuq4W6Bjp/hw2BCKK0mqFV+n35Zk06Hdxt
 xsr4WlctX3Oc3Uu0umngWpyMwNhbeZTcAHR+b6ZKfsNxdkDXt1Wo7sH9XNsvYIJHRz6B
 6Sl8pcyp+MzNTGkQgqax0rKDA3t3sbuxDDNkAW5Y7qISfVv/nix1/JoFfQuXpcCqZX7M
 bnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510813; x=1688102813;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClAqDDOgE9OaLr0V8/8hoxlPdfQjkVfzGMBHbjNV0Sk=;
 b=B5qrU8k8XYqS73ox0R3wv5uIgoWxnlOvKeF8rUdMsI3YC+T2ICSemPj3iUXsLy1ZW3
 baTiwJpLqK1DdC6c3bggmdvfe2kc0yTUgcHl4WwH7WzGBa+FWlL71e3uol2ALsQxPihK
 Gr+DydA6EzoINK07i5NjLkRzVWES+zqwZiW0+V4BZdIxnh0rwuf9BStOx4n2N0v6U+XU
 0V7q1i9LG6JNDz7/zgYXIAb51JGaqrYerZeqOY5uaPCvVH8E6DLD78KmlpXUcLFr/Ctv
 lg5IiYKqxGzsA/RMl1NgJ/76EnqmLI+qexTQnmu+pWYcf1w/CePdBLtMdyaIZ9V9o0VO
 EuAQ==
X-Gm-Message-State: AC+VfDwhW5YFVA/Gul2SOBYRwfflJLPMkvD1bHtergEMs3e0GMZDFzIv
 oQgE7m73Spj3YcGlxSQhkdkHCvqPXGrabtjG2plSGg==
X-Google-Smtp-Source: ACHHUZ78DHIandj6jl1k1x4uYbaQhqzi05Tz8wXPVol20g2BXuTJJq+/RytimVRzmNTusOqalGmoTA==
X-Received: by 2002:a05:6000:120a:b0:309:5122:10a3 with SMTP id
 e10-20020a056000120a00b00309512210a3mr2765864wrx.48.1685510813376; 
 Tue, 30 May 2023 22:26:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a5d5344000000b00307acec258esm5396023wrv.3.2023.05.30.22.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:26:52 -0700 (PDT)
Message-ID: <929de289-67b6-87e9-e991-6634e844598d@linaro.org>
Date: Wed, 31 May 2023 07:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 43/48] tcg: Move env defines out of NEED_CPU_H in
 helper-head.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-44-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-44-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Since the change to CPUArchState, we have a common typedef
> that can always be used.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/helper-head.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E51C7C9E50
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 06:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsFT3-0000na-Q2; Mon, 16 Oct 2023 00:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFT0-0000n5-4Q
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 00:44:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFSx-0005ee-6E
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 00:44:33 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-32d81864e3fso3352960f8f.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 21:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697431469; x=1698036269; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvgUH6fan02AktOcAYoAbSs+GGZVMHZo0u0aG216OGM=;
 b=uqBRrBq2SWgT4BOEvzGyuWEnnAC6KFb+GUI38PyVn9dNQJOrbMr5+v7kbE73nsIhbl
 7bm598GL/8CyW2BcstfQ6p04zi06l7azJBJqFu2RHfPdA7nU6J67O2Zedk9VfJPR68z1
 pvO9yO1LbwAwIxsIHSNNz6iRvS0ch9OQFqlWP1pF3zVKcmqnH/ZXq2FV3tkDAssD5+Uh
 0dLzr2OU5MylQZhFWicnfxyo8mO9CzXk4ZDODhFRXHFGeW+wOaMaIyPUbqkdEC5oHV59
 teRlnchud2ZVlvKgAh+jp5fzV3GKEoAtT7y6g0x970fyBb9luYzvyAmG3nJ8KyT4mK0u
 Q9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697431469; x=1698036269;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvgUH6fan02AktOcAYoAbSs+GGZVMHZo0u0aG216OGM=;
 b=gjpzZg0ym4QJkO1i5JAKcVodBJoyOvDnO3ggxAa3OZOTgTVhqAN/pf3E6zXw+HA189
 pE7scOD2oQD69EObOWbs7nkKOaUkIkH6mI8ac7sjeSd5b0npKNtkWuTggoxeQNdqOcGM
 PREtx6xVIJguRIg4/9SHcw8bpLZj+ihYQSb9qnx8szhVE4KWO0fDRzHCGwXL5f3xiPfp
 r2JmkC6oLYg6eCVupmMcfen+qpGSlyKsgB5ulPy/JgIwH0YxIffJYxV1F0NR9iKnMS8u
 1eDSsIpduxlIwKH4lbJ/ctxBmOj0AldyNEmerrGHCPCj4bKAhx17RJDdCviDMxW1bONy
 UQPg==
X-Gm-Message-State: AOJu0Yzo3QiM+HKTtQs3gth7WZFdEwsCWl1mccYtDmDidtfOuee1EgrA
 mxNkoC3ibxJSTfsNNYGjR1Phdg==
X-Google-Smtp-Source: AGHT+IEE6PybTiCDyX3cYp4MyBAJ/GLKGM7BUmaPPoDxOcaNBoYNwQ4RhXcWL8iDjEj6klSB4LLeDQ==
X-Received: by 2002:adf:fa4f:0:b0:32d:8be7:fe6b with SMTP id
 y15-20020adffa4f000000b0032d8be7fe6bmr8928323wrr.28.1697431469019; 
 Sun, 15 Oct 2023 21:44:29 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a056000054500b00326dd5486dcsm26348390wrf.107.2023.10.15.21.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 21:44:28 -0700 (PDT)
Message-ID: <fe719132-a5c6-7b9c-4875-5bde1c10708b@linaro.org>
Date: Mon, 16 Oct 2023 06:44:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] mailmap: fixup some more corrupted author fields
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Timoth=c3=a9e_Cocault?= <timothee.cocault@gmail.com>,
 fanwenjie <fanwj@mail.ustc.edu.cn>
References: <20231013154424.1536392-1-alex.bennee@linaro.org>
 <20231013154424.1536392-9-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013154424.1536392-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 17:44, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Timothée Cocault <timothee.cocault@gmail.com>
> Cc: fanwenjie <fanwj@mail.ustc.edu.cn>
> ---
>   .mailmap | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/.mailmap b/.mailmap
> index d214959288..477c1fae2a 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -30,10 +30,12 @@ malc <av1474@comtv.ru> malc <malc@c046a42c-6fe2-441c-8c8c-71466251a162>
>   # Corrupted Author fields
>   Aaron Larson <alarson@ddci.com> alarson@ddci.com
>   Andreas Färber <andreas.faerber@web.de> Andreas Färber <andreas.faerber>
> +fanwenjie <fanwj@mail.ustc.edu.cn>

Just using the email is enough.

  fanwj@mail.ustc.edu.cn <fanwj@mail.ustc.edu.cn>
>   Jason Wang <jasowang@redhat.com> Jason Wang <jasowang>
>   Marek Dolata <mkdolata@us.ibm.com> mkdolata@us.ibm.com <mkdolata@us.ibm.com>
>   Michael Ellerman <mpe@ellerman.id.au> michael@ozlabs.org <michael@ozlabs.org>
>   Nick Hudson <hnick@vmware.com> hnick@vmware.com <hnick@vmware.com>
> +Timothée Cocault <timothee.cocault@gmail.com>

Ditto.

  timothee.cocault@gmail.com <timothee.cocault@gmail.com>
>   
>   # There is also a:
>   #    (no author) <(no author)@c046a42c-6fe2-441c-8c8c-71466251a162>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



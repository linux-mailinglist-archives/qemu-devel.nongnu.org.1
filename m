Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7388578FF55
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:39:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5Ii-0000Fp-UQ; Fri, 01 Sep 2023 10:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5Ih-00008g-1u
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:39:07 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qc5IQ-0006RO-Iq
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:39:06 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b962535808so36461281fa.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693579128; x=1694183928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cTDUYX/otGgPX0uteOg9yjVX+U5fSqw+19UrJQzcWM=;
 b=Iw+t97DeSFYeQn4v4KvUhLpEWKglsAPf8JWDIGbSYjfHFFMuX+9tilSNC8CZDnf5KS
 Ey2VkBq+ATPKM8eVEEqERPlXty3ID5TGRsYV5SRDfLbTWQr1usU8vRAs5TJbQs4EATbT
 V256oJt/9LUqZ4YOf0eePglhcpVCNRrhUWKOBr2/ZjNCefpmG5EGrCh/qseQmxN5Rk8f
 dcIIlSG3l8CtS1jDiteU5bBDpX1SE17GsKssoRkiEn0jtfH7u0Z0orotWHu+ofskmLTu
 3PZRfTMcJL/WVrD8nDbk+NgdxLlYwj0GJlIGBA5OXIXbbjjCOMxPCjWd92aj3THHAb1r
 XuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693579128; x=1694183928;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0cTDUYX/otGgPX0uteOg9yjVX+U5fSqw+19UrJQzcWM=;
 b=d+fEQWlO/6of9bhIqlCj0d7s9duEO25PgBVFS86Aczj5AZy8QWrO/ikoT/B+CRhuvr
 cmS30sH+NmReXTd5PF1nYcYSf6PFva62ikjq4k4bUj6r6NzT0oY2CaHzeLbMRf4vzwEY
 ZyvDBuUmlEynR6XY2Z+znXI7vNgx3NA0Md+yFaliX0TAJtHz57lrAp9BcZeYKW/FMS6G
 mqVACVLH3lOFOdIboWuJypkv7hy4xtwYDKLUXViH/NSQRoK327xzhtxbeWkmSOq0yuWJ
 wTVBer5YAMxr9ZtV15hpkrYLDd7Gr5pB01omHTiffbh+XkQdQEAoI7b6aLi4lphncQSw
 VeUg==
X-Gm-Message-State: AOJu0YwtJ27NHGHL2tukRJbgEqijedGMnEiKMAil71j9w4uV3Uc9yGGP
 AxMwl3QLVJN4NP7QN8qHkdwMJg==
X-Google-Smtp-Source: AGHT+IGAXv/CPsQB3sRqoXmj37vUgff93vP4VBUdm1oROerz+lbrjsQsJOjhAbOqzjYcti531xHsUw==
X-Received: by 2002:a2e:7e02:0:b0:2b9:48f1:b195 with SMTP id
 z2-20020a2e7e02000000b002b948f1b195mr1727527ljc.44.1693579127864; 
 Fri, 01 Sep 2023 07:38:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.220])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe7c4000000b0031c6581d55esm5434748wrn.91.2023.09.01.07.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Sep 2023 07:38:47 -0700 (PDT)
Message-ID: <9f156dd5-0778-d843-2ec6-e8daaf601bf0@linaro.org>
Date: Fri, 1 Sep 2023 16:38:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 12/13] linux-user: Fix shmdt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
 <20230824010237.1379735-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824010237.1379735-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 24/8/23 03:02, Richard Henderson wrote:
> If the shm region is not mapped at shmaddr, EINVAL.
> Do not unmap the region until the syscall succeeds.
> Use mmap_reserve_or_unmap to preserve reserved_va semantics.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



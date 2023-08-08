Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA2774D0B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:27:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUEk-0008Hp-8G; Tue, 08 Aug 2023 17:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUEh-0008FL-4T
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:27:27 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTUEf-00012j-Ha
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:27:26 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-564b6276941so3806867a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530044; x=1692134844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3LK0YQ0KSRkTzH839YJftL/4JOu6L79CVtzUBqKw7Cs=;
 b=EXkg/P0Vvq6aXGSm4DL3OVdxZeUCyT1aUEGFTLsCvcZtj6wSK3TES0iB2YsesFYMAO
 O6sVXWxXGQ9UtXegLB2753Z+7KwF3QVjpM/OnYJqwlgxQqa4E/ovqRTNPUQkxpMXy0ni
 41GTWLut+DaxjCOncPSMlKW0atRe/B4nEqjDO4yuKiv4RGqnGIIkaYb6HS5aLydp8v51
 fmdhp7sEMTSZ1kFcXQ/wcPyJr6Nup5BSwGdDVmT0vEhq/ALUlsXqq+XJL+2V3Bf2zehe
 tCmLgBAUR3dKNWZVOPiEQDEachdlsil45wsoZuDAItt/8+nJBF1qKMXlQSNbMzD1+Xa9
 ZEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530044; x=1692134844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3LK0YQ0KSRkTzH839YJftL/4JOu6L79CVtzUBqKw7Cs=;
 b=XXaHLAspBJ1w8OJ2B3Bd9dNycEDKuH8B45DCgCKtMvN2oqaQIuvbd7n15rAIl+A8eB
 9ArzGAbK+G4HUjH4EPiUCduTwVsDE+lBuOJOVgcvqV9TckO/ABchKv89DnAMHnhTQYwJ
 RMGSfNHEBQKgiIOcAzUb0gRl3yFGOWpgIiac3x2yKhB5WVfPKZCMkQTrdsc/cK7/jm4P
 Rkhgeqp952ABSFQpo+6ugPuE5mmVkHKOewBZl47VWFvH6MTMy9Vh7YKqI7SndTUeMk1M
 3vT8OqcJsO9wrYu48+2Qlh6fpZDMttfA4VyhpjZ2ATAkIVuZnAiH1rIZYitfsRJVN0jh
 rxSQ==
X-Gm-Message-State: AOJu0YwQAUQSXUB+3t4nwuxMJ9Ed+c2fj7fcV101jGtDlqaLvs9Z8qF+
 CUbSWTjVDFf3X1DEzPFR8S74KQ==
X-Google-Smtp-Source: AGHT+IGmnIYUBoljVnkAIQgXj4AyZfraicz5xfodxuhGRMzBvFb+F4WsnHtFMIhLAfwWByizG6ksTQ==
X-Received: by 2002:a17:90a:928e:b0:268:93d:b93c with SMTP id
 n14-20020a17090a928e00b00268093db93cmr767365pjo.13.1691530044176; 
 Tue, 08 Aug 2023 14:27:24 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1880pjc.21.2023.08.08.14.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:27:23 -0700 (PDT)
Message-ID: <518ae277-5707-26e2-06b7-06e52d46e8e0@linaro.org>
Date: Tue, 8 Aug 2023 14:27:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/33] Define safe_fcntl macro in bsd-user/syscall_defs.h
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-12-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-12-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Kyle Evans<kevans@FreeBSD.org>
> 
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/syscall_defs.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


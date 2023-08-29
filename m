Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AF778D092
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:28:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nr-0001ZH-Ez; Tue, 29 Aug 2023 19:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Kz-0004f2-N0
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:29:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5Kp-0004Bd-BH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:29:17 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a520dba33so3854369b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693340949; x=1693945749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZDnZCVjuDFmpFBSrLZvA/cIGQuXrZXEpEZrfYuW84Wg=;
 b=DQPcaEbJPZYJgRHLZ8beVdCzKQ2oSQc1zgCysrtrpS0Vn6LONcCAXb1QtC/xe7zMHY
 IBg4MQGP7tSGz4NBQlX5wlH7BFtxNWyPoc3+72M5UpF3PsynpCnhcEToVXm/yB/qLprp
 V4w+pLxJKenszUw9vpq/IQ2tKG6ESvHMAKCLUuMQe6YhLa+aoBER9S8r465p8pW3xQiX
 ZPvxe+d8nOUWj4oh8RNXiz7D9AcGaJcRo9ASM2iNKzQHnTgHBSSf3R+KXiQTojFJS7Bn
 H4znYAuHnOpx2RSFPNa3SKd+yr6x+8pWle0w0DR6Io/2snfr9SV4ObL9BX4ySKU4DRby
 VVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693340949; x=1693945749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDnZCVjuDFmpFBSrLZvA/cIGQuXrZXEpEZrfYuW84Wg=;
 b=g6qUdI5cELbz07K/ErLoVeWPBoPuv3F0sLlRqNUXOHL9glmmEMCqPuwnDrpgDDHuCj
 KPbKnUz/G6Kul/tpO7aOhp6SDfxKqQ2dWTENqVVD9xJUlVWCsJjB4Yrk8MXsl+xqcRBN
 cklSgS3ILvzZ43ljOXRhIyKSm31WDXu2h20Bm80yz51aoS/d1R25aFgFSlh9Bw4v+puI
 eib7NctzHHw3gTG9rWvTsQ467DJVowL7NTMToBWMQVZLdDrMLtvlDdl1Pvbg+3J5pR0D
 KuJdhvZgvR78kTusR13t/e2tVDmLGxZsn6yoeLgv5rvI5W3SJEHRJgx6gegdJS/x7k7I
 FUzA==
X-Gm-Message-State: AOJu0Yxxa03JvbXvFu0o8uCwFpFEygARgbAi+3ZWR78bl28SWfd9++8C
 MvTHy0qVlm5j/VJspaLKerQNeQ==
X-Google-Smtp-Source: AGHT+IFFSCwCfZMxvY5Q/ZiMPrI6RYoApQteOzvRLW2usYv3eTl8vBpfaEUUYamokbF7CbSvB649vw==
X-Received: by 2002:a05:6a21:7746:b0:134:dc23:2994 with SMTP id
 bc6-20020a056a21774600b00134dc232994mr422479pzc.31.1693340948876; 
 Tue, 29 Aug 2023 13:29:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa780d0000000b006661562429fsm9136743pfn.97.2023.08.29.13.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:29:08 -0700 (PDT)
Message-ID: <0401b581-057d-7809-d62f-8fa018513c47@linaro.org>
Date: Tue, 29 Aug 2023 13:29:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 23/32] bsd-user: Implement t2h procctl control request
 commands and h2t reaper status struct conversion.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-24-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-24-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.c | 52 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
> index 396f258a64..f069472156 100644
> --- a/bsd-user/freebsd/os-proc.c
> +++ b/bsd-user/freebsd/os-proc.c
> @@ -249,3 +249,55 @@ execve_end:
>       return ret;
>   }
>   
> +#include <sys/procctl.h>
> +
> +static abi_long
> +t2h_procctl_cmd(int target_cmd, int *host_cmd)
> +{
> +

Identity function?


r~


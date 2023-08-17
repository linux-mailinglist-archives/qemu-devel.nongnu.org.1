Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9E77F27E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 10:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWYlJ-0002FT-1g; Thu, 17 Aug 2023 04:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWYlG-0002EL-HD
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 04:53:46 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWYlE-0000IU-7x
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 04:53:46 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fe0c566788so11804649e87.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692262422; x=1692867222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbMzTO52hBGGM/xnpXijdwk4PV+IeaVo9IsQxKgoaCI=;
 b=PNILGyNUeK3VWWg8gkMYY7U0QV2DXrnCeoKiRk51CLQuk3UXQgfLgJydGxrDm+rg5e
 UIvud8KbWX+ApaRfGu2oR98+gIo77eAV6FeG2Ksu86dVSxPx7EMyKbQZhMwkxyCH40Vk
 z7co7X2qQe+UxyNw2Dmp7mG1CPc4CFbDea5v0MTuFX+MDTxyyN4p8SBy48C6OCgHh6yo
 XziG9gCfhx/+KU0tO6qwh91k4LcNcDylH+pgy/L92iW5TJD5jkaz26demO1tZBfECtUJ
 VUjMJJIucFog5vUKzoGUJ/1sIKKop5yqJbdKGIycS0Ijqojqqj6KkrcibsLJBZZpctzJ
 z0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692262422; x=1692867222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AbMzTO52hBGGM/xnpXijdwk4PV+IeaVo9IsQxKgoaCI=;
 b=E3L82ouXX9RADyzeqFvnGQl1Zty2U+qoDGNz1fK9W1v/H8V+MMwF57lJzwRczzWLue
 nYzpGNeuFg9Yfzb7mDck1ssz3d/NNUWpxPKohyruQSLWFBQZ+uUqfDjZFqOGN7uWr+XQ
 ihwdk1K7JiDo8BKNGYc7ev5TtG4L3t8dtWHD79d6S1Pc7zaW0bJbSSt/unTO/6AcANI2
 /V3/yj1fihxtgUM3QoVVRMbSlM7+CgDClBXac+I+V7tVNpN488T7UYrxEOheg6qcoPwK
 n87E3Z9m36qLxftZdLM7GhRYMxewuANxAg7+43jVK8C9GraEVpq1HdJjLxZ8qGj3Ney7
 qWKQ==
X-Gm-Message-State: AOJu0YzzzbZ9fq3lixZ+PGdbe7/MLZOtCb77XnVFgi/HAHes0egUL4t3
 LDbf4v2jp4WrVa0YgO76bpgenQ==
X-Google-Smtp-Source: AGHT+IGNM99jNG8byrcLN87uGp7V+oWuQar5ocEtxkPXIufTzt7zO3jcRVb4QppXP7M22SeKVwH6/Q==
X-Received: by 2002:a05:6512:3c87:b0:4fb:89e2:fc27 with SMTP id
 h7-20020a0565123c8700b004fb89e2fc27mr4207140lfv.54.1692262422214; 
 Thu, 17 Aug 2023 01:53:42 -0700 (PDT)
Received: from [192.168.69.115] (mek33-h02-176-184-23-56.dsl.sta.abo.bbox.fr.
 [176.184.23.56]) by smtp.gmail.com with ESMTPSA id
 b21-20020a170906195500b0099df2ddfc37sm2003202eje.165.2023.08.17.01.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 01:53:41 -0700 (PDT)
Message-ID: <9d0b2bca-f5c1-b23b-484b-259e0d67a1cb@linaro.org>
Date: Thu, 17 Aug 2023 10:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de, qemu-stable@nongnu.org
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816181437.572997-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 20:14, Richard Henderson wrote:
> PIE executables are usually linked at offset 0 and are
> relocated somewhere during load.  The hiaddr needs to
> be adjusted to keep the brk next to the executable.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to executable")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index ccfbf82836..ab11f141c3 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3278,7 +3278,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
>       info->start_data = -1;
>       info->end_data = 0;
>       /* Usual start for brk is after all sections of the main executable. */
> -    info->brk = TARGET_PAGE_ALIGN(hiaddr);
> +    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);

Did you got some odd behavior or figured that by
code review?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




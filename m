Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8079834C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 09:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeW3I-0001QV-Vh; Fri, 08 Sep 2023 03:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeW33-0001La-WB
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:37:02 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeW2y-0001E7-Tk
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:37:00 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4c0so3712296a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694158615; x=1694763415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vBdC+EgHmEoI3wVBfVrOC8KHH125ZVdNmVmrDZYnzg4=;
 b=ba6LFBteXgOMx/3ataiUzfyOjT9qxFvhCRZliKHqWbdJQ7Z5wd9n6TnNPGNEV9Wyu1
 lH2XlMImyt19gev2pvW1USqu/QeOYbFtM/QwSdvvGxfjr6PpNkrcxvBiUaYBtZsJrq23
 FWdIObJHqA2HJYuyA4UPBUTE2JPKFXpNyZtvj4DBpDc8EF7XPEvyy0gqde0o1DBNXiBj
 mdTYUV8amO9NnU8zh3UqY2IJVv+6386FDhm61brn6k/I7fl11LAWonGMePtiPzW1FWPf
 qxWNVMPNSiVa2+g5Fks8gNnlMpw4r4yt9sd3kY/pdZgN9ccDg9s4SJI98Hf3yRjKuHy+
 jBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694158615; x=1694763415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vBdC+EgHmEoI3wVBfVrOC8KHH125ZVdNmVmrDZYnzg4=;
 b=eHtfLjqCq6qFwVo8L31CpXGFteyyvegBNamrvMy/WHPAiaLmXMlEhCA/EYK0ZAZQTg
 XLKGJ16nRelq7QlO/I0ak11c4lvLS3/b1hCAqoTH6Y5NKTP2Dh7Aw/nCkdrrBznT98Tl
 mP6jFRzGw+DM+yyxQURN3fI2ZJermXw7Xv91YCAZHEZXCi/6CsRLM+TB6vHPdSCkE5GD
 hRDmZI8+PfmFgT/cNEgg74byEVx7vAyUps0eoOJuUnNOue70wUNvnUqcjqD4iOqzOsOD
 Lahz/O6GDGtoKqb0gM+AiWS7vYKXQoQKVkAxz7yejjkTubUp4mRvaxBDFzuICpZxLUm6
 uLPg==
X-Gm-Message-State: AOJu0YznrodAtKTZi8Sxcu8OChpPRqfKBO+T77tENVky/SNEC2xnb8Xu
 WtdDK6a38ayxmn9KN7r+WUwCEg==
X-Google-Smtp-Source: AGHT+IFYM4wqTn6AMOUb3kZtHLiKhioxCPm7BN8Y6tSDhyJGXaZp2Qc3r8AYlWRUS0TkiN/jiwqWlQ==
X-Received: by 2002:a05:6402:3551:b0:52a:586a:b19a with SMTP id
 f17-20020a056402355100b0052a586ab19amr5128096edd.21.1694158615171; 
 Fri, 08 Sep 2023 00:36:55 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 u12-20020aa7d98c000000b0052a1d98618bsm653671eds.54.2023.09.08.00.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 00:36:54 -0700 (PDT)
Message-ID: <f98ebf8f-04dd-8429-b40e-e333becd36c6@linaro.org>
Date: Fri, 8 Sep 2023 09:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 03/16] tcg: pass vece to tcg_target_const_match()
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 "open list:AArch64 TCG target" <qemu-arm@nongnu.org>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>
References: <20230908022302.180442-1-c@jia.je>
 <20230908022302.180442-4-c@jia.je>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230908022302.180442-4-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/9/23 04:21, Jiajie Chen wrote:
> Pass vece to tcg_target_const_match() to allow correct interpretation of
> const args of vector ops.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.c.inc     | 2 +-
>   tcg/arm/tcg-target.c.inc         | 2 +-
>   tcg/i386/tcg-target.c.inc        | 2 +-
>   tcg/loongarch64/tcg-target.c.inc | 2 +-
>   tcg/mips/tcg-target.c.inc        | 2 +-
>   tcg/ppc/tcg-target.c.inc         | 2 +-
>   tcg/riscv/tcg-target.c.inc       | 2 +-
>   tcg/s390x/tcg-target.c.inc       | 2 +-
>   tcg/sparc64/tcg-target.c.inc     | 2 +-
>   tcg/tcg.c                        | 4 ++--
>   tcg/tci/tcg-target.c.inc         | 2 +-
>   11 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F74A736498
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBVpC-0007Me-2f; Tue, 20 Jun 2023 03:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVp9-0007MV-FV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:30:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVp7-0000Rr-Jc
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:30:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5149aafef44so5102822a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687246243; x=1689838243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/UiSoe4+3cr/6cPapF4uoXT+4tlHQ3Akl/Bj/1hhEQ=;
 b=AsmHCTwqBaamsdzjTOtdhGnPn4pKyGIElCoGfd3N7JOko/xldaxguFj6GObM0AttFM
 lhU3J9na61mobfrAWCKGC/aPTbkfznJIKYU9Ifr+/aeS1e6UyrcrOaLeKVZ+pr+FB1ET
 UFRakkAEuT+OK/+uR8XhNkVXRhdQ82pYqKOJNUfjI9xVHHbGjsfq1yJy9CH94zC1aGy/
 sDuhVssZB8PN1lMZjl4MEZLG2Wxtsc2G0zCZHx7yLgP8g21V+c7yCTIjZa5HU/LIKumV
 gM6SpnDpWZzvCbptMfrltSagV9Azm6LaqnxKEwVpEDcchhUoFUeY5WlbqpE+ZOWkAHZu
 4IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687246243; x=1689838243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/UiSoe4+3cr/6cPapF4uoXT+4tlHQ3Akl/Bj/1hhEQ=;
 b=BOJFZt+vMTUQr25lp47oSvC3IvLYzfEVLFUXEviUEONZXHw4V7qB9YdhKlvMTFJwKv
 VBQ0PYs+IJA2Yp0ZztGhrd9wnctcpWBHc0nBTs+iRUBN5dqfB5mnDvdOFksBsqOaLz3D
 1+C0a2+mgWjTGAvotTcFSWbhcRmv3Uon9LyZg2kTVjO4PKTRzxQ3P1spmmSzGV8xxiXg
 /9i1vk9T7gTk8+RsKGJrxGXCz5wUeJatiQOD4v9MxGsHOT7A1I8K+o6EBDyy7FMek/bs
 Ie4NzrsQv2OVt2IS6TTquxDX1QiIB3zgfYbkIBvgEfS/zhvPU/+J8eURdb56G1WiHQbw
 Zk7w==
X-Gm-Message-State: AC+VfDy9Qf6hiCzUVK4OYo/wLKAxTC/+ZQ2aK4ejaxxDJXiT5U6uRNUh
 l+gvgy9Z/ujXBgM6M/sgILJku61JBAIS5bTYGcIjez0P
X-Google-Smtp-Source: ACHHUZ5foQ2RqTaB3vhh7Y065ildXkSf+STymNGAGlTRflB2D6jaztxh2J3B5DF3Osr3n/5L5D0DcA==
X-Received: by 2002:a17:906:dc8b:b0:988:e57c:20ed with SMTP id
 cs11-20020a170906dc8b00b00988e57c20edmr3153238ejc.72.1687246243641; 
 Tue, 20 Jun 2023 00:30:43 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a170906258600b009871b3f961asm844240ejb.58.2023.06.20.00.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 00:30:43 -0700 (PDT)
Message-ID: <93013d5b-1b91-8e4a-de7f-d67bc9a3ed5f@linaro.org>
Date: Tue, 20 Jun 2023 09:30:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH qemu 1/2] semihosting: Added to support GDB_O_APPEND flag
 of host_open()
Content-Language: en-US
To: ~foxes <foxes687@andestech.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <168723238949.9156.9853906656288727865-0@git.sr.ht>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <168723238949.9156.9853906656288727865-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

On 6/8/23 11:07, ~foxes wrote:
> From: Foxes Hung <foxes687@andestech.com>
> 
> Signed-off-by: Foxes Hung <foxes687@andestech.com>
> ---
>   semihosting/syscalls.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
> index 68899ebb1c..1a5d39da01 100644
> --- a/semihosting/syscalls.c
> +++ b/semihosting/syscalls.c
> @@ -281,6 +281,9 @@ static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
>       if (gdb_flags & GDB_O_TRUNC) {
>           host_flags |= O_TRUNC;
>       }
> +    if (gdb_flags & GDB_O_APPEND) {
> +        host_flags |= O_APPEND;
> +    }
>       if (gdb_flags & GDB_O_EXCL) {
>           host_flags |= O_EXCL;
>       }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


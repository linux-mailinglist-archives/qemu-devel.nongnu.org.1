Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DCD791359
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 10:23:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4ro-0002oL-6Z; Mon, 04 Sep 2023 04:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4rm-0002je-3l
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:23:26 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd4rj-0001fM-L9
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 04:23:25 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so179120466b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 01:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693815801; x=1694420601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNtZLs9xQ6Sm6wdpRrQZ7nQ4ANRndsOCGF2KscDgIRM=;
 b=cTHirV6xnSpiiCcN//81mcZ5BuIYRwRMizLMrVOBO5B1MKg8BkL1HXWtzRbXnblJ7/
 vrivjYDWVcGS19qleUlJCKNUqb6lKZD57S4o8MiDKXXlB5p6YPJ3z5os60hbwRth+EqY
 Mdy1+9sqrq1O/2N4I5xR3+t48nPkjPkn4W61/zjtT06ACwJzqvtn+otTdyNjMxMDrEhE
 +ny2AjQJVhBUOPOGW+QDJY7+1tRuAiGIYfLW4uOTR4RWCz8DFcWhWpEH1rQuUY7ZZmvV
 /IyWhTncBl1uKO8xIhl+dgvUwsxH0FwrFadqZBNXRHejY1JlOcwqWjbpvqmg0pZT7y02
 ifhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693815801; x=1694420601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNtZLs9xQ6Sm6wdpRrQZ7nQ4ANRndsOCGF2KscDgIRM=;
 b=XvXXavXaWkw7BaMtuqgsXDiWnD71LVyA6PP7EbohK9MND9TZ36rvMnDN042sX6Xq5L
 kHhlE1CMqDxiGkVmZfaomMDvHIFYrEmx0VT9coNrEdegItnNTbaC0vcHzgj/uynQVZNi
 4cZL1jymSljdleX6A9ejC6ituhERyRyWXmquCTzMKWTiJYbUWe8GrWmHEBs/x14OLvDS
 1ukjpA15W8mvUkOD9lKD4ayH5+hYCk7GnUq12JV8lrqmblF4UvFj//gftXWy4xL7ebTV
 o4pi/mD2wTv+IL1WVkI4JM/a13mEiwalIsYkh7L7WEjxNQrEQbYkft11ufkxBWACp4Ov
 7MGg==
X-Gm-Message-State: AOJu0YwZQv8XVHYpteo1NNL08wkUnbJuoESawfRoSspi1ZFtM4c5V7W4
 H/90hCeU6OyWUThtcoc52jcApWcLm85Zc6Q/eX4=
X-Google-Smtp-Source: AGHT+IGL7pzRy3XYhdwRcFA2zmw4J2CboHGtJmlm37Ck6u5xgFpuBatBUDarJK6gWcbQpglnSf+Z9Q==
X-Received: by 2002:a17:906:74dd:b0:9a5:81cf:57b5 with SMTP id
 z29-20020a17090674dd00b009a581cf57b5mr6845961ejl.2.1693815801115; 
 Mon, 04 Sep 2023 01:23:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 le18-20020a170906ae1200b0099bcbaa242asm5761791ejb.9.2023.09.04.01.23.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 01:23:20 -0700 (PDT)
Message-ID: <f3d660d2-edf6-10f7-58a3-d7ad27bb0849@linaro.org>
Date: Mon, 4 Sep 2023 10:23:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v9 12/20] target/riscv: deprecate the 'any' CPU type
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
 <20230901194627.1214811-13-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901194627.1214811-13-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 1/9/23 21:46, Daniel Henrique Barboza wrote:
> The 'any' CPU type was introduced in commit dc5bd18fa5725 ("RISC-V CPU
> Core Definition"), being around since the beginning. It's not an easy
> CPU to use: it's undocumented and its name doesn't tell users much about
> what the CPU is supposed to bring. 'git log' doesn't help us either in
> knowing what was the original design of this CPU type.
> 
> The closest we have is a comment from Alistair [1] where he recalls from
> memory that the 'any' CPU is supposed to behave like the newly added
> 'max' CPU. He also suggested that the 'any' CPU should be removed.
> 
> The default CPUs are rv32 and rv64, so removing the 'any' CPU will have
> impact only on users that might have a script that uses '-cpu any'.
> And those users are better off using the default CPUs or the new 'max'
> CPU.
> 
> We would love to just remove the code and be done with it, but one does
> not simply remove a feature in QEMU. We'll put the CPU in quarantine
> first, letting users know that we have the intent of removing it in the
> future.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02891.html
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   docs/about/deprecated.rst | 12 ++++++++++++
>   target/riscv/cpu.c        |  5 +++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



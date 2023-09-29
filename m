Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C497B3BE1
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:20:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKuE-0000ke-Sb; Fri, 29 Sep 2023 17:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKuA-0000kH-9Z
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:20:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKu8-0004os-O9
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:20:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so857851b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696022407; x=1696627207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JijOgd6tLspOHnLh3H0o8UXBLW4i/1u0o1p2csruq2M=;
 b=WCNUbDjKbmgpBz2R4SfF6HKrUPwCBboig3gmV7GnNHQga9LSoDjTcEgDN0ZWwy4J/5
 R5k/pqnQ93ul5phrHqolWl9yE4OUlpuQF7NF3JqWtlrQkURGuTFqk3ahC7TDQbImuhf7
 bl0kJeXJP/NXgSHL7aTu0McrA85cpTjh7n6dctw9sAsMs5MARaz4pKnUvg4u/lPBqgu2
 gp5jVJJrp1muJMUbRZT0K6FDPvxBTT+3AILrNMc2D5Zv6nnK6unDCt2cPtyVy523X3M4
 T337SbzAnFwtA2O00Uh92Z0lLULlvABDANOB+uOAitKGT/Zx76uhfqWCLC/Gh/0jMCEP
 CBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696022407; x=1696627207;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JijOgd6tLspOHnLh3H0o8UXBLW4i/1u0o1p2csruq2M=;
 b=ucI0TiHcAGAC7RstZ88jglAzmycrfK86lssqvs5u6M4NFFPHtAuZp+PpVOxzFHrLzN
 PPLnoFidbk4CgLu4Io4u4kX8G/wJ42h5ddSgqaZuOpyHFDhBHe/4Mlh12OwHupCdEDYt
 /6pLv/kc+auNm7Gviaf/CNf1dpaeE4lkoLcWO3xPGcHbKL5jkAbek5VBDI001lWno/ca
 ptihMSBs+OF1ssFIhyEdH47ITRmjUJnnozdEhiQFV28FRhsvbBeoHMA2VChU3lbA4WtN
 8LShafBpuAEYYlaUzsnm1wX9rIAkyvApmrlhXHoNeFKmJ7Q/vWUy2lDBKuKYZ2xlOp4y
 kv/Q==
X-Gm-Message-State: AOJu0YwKVQsqBcNO+X4dvuzQ0JLBG7bh/NPaJzNAKT4cY/w8LN6+5Vnc
 ih/VArZLBoawqogt5EzI8RReSBN6Hs3YwQxBQ5k=
X-Google-Smtp-Source: AGHT+IFYnqp3u109QhrmkNT4BTNxwhEyk88OfY+ycxqiw1uwRdhBgGf7npiBZlFYkEJIStJqXcRJ1g==
X-Received: by 2002:a05:6a00:21cf:b0:68f:ce6a:8685 with SMTP id
 t15-20020a056a0021cf00b0068fce6a8685mr7675897pfj.14.1696022406415; 
 Fri, 29 Sep 2023 14:20:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x3-20020aa79183000000b00693411c6c3csm4258138pfa.39.2023.09.29.14.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:20:05 -0700 (PDT)
Message-ID: <a30c23e3-0cd5-3e27-df9c-1b6f254d9019@linaro.org>
Date: Fri, 29 Sep 2023 14:20:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 11/22] target/nios2: Create IRQs *after* accelerator vCPU
 is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> Architecture specific hardware doesn't have a particular dependency
> on the accelerator vCPU (created with cpu_exec_realizefn), and can
> be initialized*after*  the vCPU is realized. Doing so allows further
> generic API simplification (in few commits).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/nios2/cpu.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


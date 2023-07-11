Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 414CE74F6EF
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH23-0003Ps-UU; Tue, 11 Jul 2023 13:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJH21-0003OH-Nf
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:20:09 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJH1w-0005kg-6L
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:20:09 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fa48b5dc2eso9511074e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689096002; x=1691688002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHLloe4KZ9105pUDsOEeGvp5rcVKcbfQS5MN7VYKdT8=;
 b=wf1SadL3vbvJpQ+KmlIeEFUaGHOzM1PfzlSI5o+VaAbu7kRD0RBeHduWWrHiCOiyV2
 dZ/2UWcy4jSvQmjk0sDGo+j96FqhEnwymK+yP2EqmB/1dWS8twDQX3ifmNkC07pTLosg
 +f4lFRbVuFIVtm7R2EuvnTvM97MSL368BBHSzgrxHm/Gw2JvMia+zebjLpY7ql6k5iBb
 as/VUYo8ZSwvr1VNY1ADvj0Ia+CyYuquUEy6a/+YOL4LRQq+RkPGWIz5Ezyx7fjQ+zmZ
 1lx8D6yWrLEayMzI9LEy6VAGiGzVgzwQvjRDBVoB12wDw1TL28EocA1fYisUhXINgXDs
 JjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689096002; x=1691688002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHLloe4KZ9105pUDsOEeGvp5rcVKcbfQS5MN7VYKdT8=;
 b=A9kmJqYbanEhNRPib/FsJ96ErX/9F7pU+1YR20Xuw3hP8UCoIhC7u5zsOKb0aD8xyn
 GGW51rOpyifQL5aZeSLyqcJtnt531sx4ZnfqokvyaN+9FzcsPwW6vkyDP2rB3R+2zNgc
 8lYKwIlI8HdZJc7sUoo58TeN1dm2P9tw+8gCSbYA7xkjihkn/ICG8KR5q+D3dcRH56rm
 k0lXd3DsTNRV2AthjHsqjS8cqvlPy+aLzlrmBD4apqCq4MjfzKn/by9ZRXqcaPo3IIkR
 DmkDB8zHxK+WTb9hVAnlsktw/+W4FRFvZfb9SIvvDfNt1yLi4yB9q/DpmUh4Dp6I9N7u
 9oGw==
X-Gm-Message-State: ABy/qLYZFeBR9DtW3b73KLHlDwI47PfXxNMecQQtVz1cLMeoP4tvcRaS
 NOKI3y2xJx0JFmDz8O7uL99dWQ==
X-Google-Smtp-Source: APBJJlFbG32jhb9tRlxdIvYMN2PCO7LDWQExQatSEQwr+dl5Frp0n7jDK7y/ELUatdys2X6O7IryAA==
X-Received: by 2002:a05:6512:60f:b0:4ed:cc6d:61fe with SMTP id
 b15-20020a056512060f00b004edcc6d61femr12004522lfe.24.1689096001815; 
 Tue, 11 Jul 2023 10:20:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 cw13-20020a170906c78d00b0098748422178sm1403674ejb.56.2023.07.11.10.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 10:20:01 -0700 (PDT)
Message-ID: <98d88af5-aa0d-0497-a038-f473e92bc3b1@linaro.org>
Date: Tue, 11 Jul 2023 19:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1] accel/tcg: Zero-pad PC in TCG CPU exec trace lines
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20230711165434.4123674-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230711165434.4123674-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/7/23 18:54, Peter Maydell wrote:
> In commit f0a08b0913befbd we changed the type of the PC from
> target_ulong to vaddr.  In doing so we inadvertently dropped the
> zero-padding on the PC in trace lines (the second item inside the []
> in these lines).  They used to look like this on AArch64, for
> instance:
> 
> Trace 0: 0x7f2260000100 [00000000/0000000040000000/00000061/ff200000]
> 
> and now they look like this:
> Trace 0: 0x7f4f50000100 [00000000/40000000/00000061/ff200000]
> 
> and if the PC happens to be somewhere low like 0x5000
> then the field is shown as /5000/.
> 
> This is because TARGET_FMT_lx is a "%08x" or "%016x" specifier,
> depending on TARGET_LONG_SIZE, whereas VADDR_PRIx is just PRIx64
> with no width specifier.
> 
> Restore the zero-padding by adding an 016 width specifier to
> this tracing and a couple of others that were similarly recently
> changed to use VADDR_PRIx without a width specifier.
> 
> We can't unfortunately restore the "32-bit guests are padded to
> 8 hex digits and 64-bit guests to 16 hex digits" behaviour so
> easily.
> 
> Fixes: f0a08b0913befbd ("accel/tcg/cpu-exec.c: Widen pc to vaddr")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have a workflow that parses log files to get the executed
> PC values; I don't suppose I'm the only one doing that...
> ---
>   accel/tcg/cpu-exec.c      | 4 ++--
>   accel/tcg/translate-all.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



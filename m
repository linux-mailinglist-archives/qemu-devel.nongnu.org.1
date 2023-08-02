Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C496376D922
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRIzS-0004ha-R5; Wed, 02 Aug 2023 17:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRIzP-0004fK-UI
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:02:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRIzO-0006CQ-68
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:02:39 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3177163aa97so236577f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691010156; x=1691614956;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jQ8ZeOWh7jDTfqDFK40BEHmAyM3QBGNVADxSXIIFCks=;
 b=UJqYd/yg1Mniab7GD6y7vm3R5Rv0mHsfFi7uNt+XntKy/hDwZe29rpwdOFINPNf7Qa
 Bfyie9MKQdBEKlZ/90YqS7p0vXwcEOVRIyx6VMFVWM/mWvQPQevXun9ZM/eGykuny6ld
 5/NZD9k9/vuQFyldOpgIy3gQbhmp6TwdF0S7ze7iz1jhoRtYSlvABn3AaPmwQ7edylH/
 KaJ4iBNM1zmnd8kwlr5Iwj0ZeAx2mfQc2a+R/sMgPgk7YOmLn55kxWvvjmbQmQ+6iAYj
 Fz5e/SMzoMFaMT9X0aBdSzhE/hCyMChtwsttRUL53J11XIGk6VfKayS9iFp2R76ChQKl
 SZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010156; x=1691614956;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jQ8ZeOWh7jDTfqDFK40BEHmAyM3QBGNVADxSXIIFCks=;
 b=K+qSRWUthv8R8KkKNEBBdyVEOf/voQkR5lKsc2es3bPTOpAfXaaaWJQsvyefYmXCY7
 Lo5sFfLCZ8VHTaZ9X9yLTZ6xKsmeS/Ie+O6CairifA64ADEx75G9/IsEi+d/+p7DV19o
 RqpQf21bI/99soV1UV5ETBxtMCB7fdqwakNX8five9jOnXyFhGLZn+0DpMkGYvxYfTsa
 h1uXx0Vpp661WgeayA9yC55DtEoWHEb3iHjXajBZuY6xdLLPHykazbA5QVX5pXAHpIjN
 RsmvLshR333xHqy89C+YCjITHF3kv62cimz+wUH9R/FzG/HZg8PwmdwsyP5o5xOScpcX
 VaKQ==
X-Gm-Message-State: ABy/qLYVB0EekNEYNY0hRKxCzvZemnc7YkXq2juEEyArQYAOYeE/csuO
 6uNfpDgyNA8/pOIhqjQsEuEe7PLqya69jlqj3q8=
X-Google-Smtp-Source: APBJJlHd4gfFdVpjaE5EMma3x9+tFILtaqlHBEAinqZINIqX3g1TA0goyjcva/3hXIKZg7FPuA3X4A==
X-Received: by 2002:adf:ec05:0:b0:313:ded8:f346 with SMTP id
 x5-20020adfec05000000b00313ded8f346mr6194578wrn.22.1691010135457; 
 Wed, 02 Aug 2023 14:02:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 y18-20020adff152000000b0031784ac0babsm18686110wro.28.2023.08.02.14.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:02:15 -0700 (PDT)
Message-ID: <fd0112a7-6fdd-fd5a-bd25-f9adfe2ee140@linaro.org>
Date: Wed, 2 Aug 2023 23:02:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: sparc64 -- cannot get 'Hello World' to run
Content-Language: en-US
To: cauldwell.thomas@gmail.com
References: <CALtZhhPmFfMpGoCPtdEMjYES2c3WrwPYq==sj+HbwBLZ8ZYTgw@mail.gmail.com>
 <CALtZhhOwsquhcHK0aOEn89tu7DynEMeiDZ=aaropn8Hkiyy+qA@mail.gmail.com>
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CALtZhhOwsquhcHK0aOEn89tu7DynEMeiDZ=aaropn8Hkiyy+qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Frederick,

On 2/8/23 22:36, Frederick Virchanza Gotham wrote:
> On Wed, Aug 2, 2023 at 11:04 AM Frederick Virchanza Gotham wrote:
>>
>> I can't get sparc64 to work at all though. Even I make a simple 'Hello
>> World' program in C using only "puts", if I try to use qemu-user to
>> run it, it crashes.
> 
> 
> You can try the following at the command line in Ubuntu 23.04:
> 
> $ echo -e "#include <stdio.h> \n int main(void) { puts(\"Hello
> World\"); }" > test.cpp
> $ sparc64-linux-gnu-g++ -o test test.cpp -static
> $ qemu-sparc64-static ./test
> Segmentation fault (core dumped)
> $ qemu-sparc-static ./test
> qemu-sparc-static: ./test: Invalid ELF image for this architecture
> $ qemu-sparc32plus-static ./test
> qemu-sparc32plus-static: ./test: Invalid ELF image for this architecture
> 
> Making static executables can be temperamental on a few different
> platforms, and so I tried to make a dynamically linked executable by
> providing ld-linux.so.2 as well as the libc files. Still it crashes.
> 
> Has anyone been able to get use 'qemu' on the binaries produces by the
> cross-compiler 'sparc64-g++' ?

Can you create an issue on https://gitlab.com/qemu-project/qemu/-/issues
and attach the static binary you built, that way we can reproduce your
problem.

Thanks!

Phil.


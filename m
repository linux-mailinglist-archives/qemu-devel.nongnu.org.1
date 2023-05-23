Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564970E1EC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V19-0006CK-Jv; Tue, 23 May 2023 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V16-0005tf-VU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1V0z-0001rr-Cm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:37:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-306dbad5182so5099045f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859855; x=1687451855;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRK1QzR9vRytlGeEiMFUALo1izxLpjDB4A/b92g80bk=;
 b=NiY27ba3jgVpEvjM8WVFw2O/qCoH+0MUx4TN7uX/wsRtRVpwbtbY3ZAVr+Aw3u++b6
 ECePxNZrC9ru8M+thazxrZcBffXD6E1vEoACxA4uDIjmQAXRc6FN0RXsEAibGa9VR5t7
 R76YLzCfPBmPvZ7t1nKs6PT8P9uXTkl2m7jgJK5s2gsqXRn2u8M9lHYmmNzu/ELHUjjs
 3HiB6V+tLzUO1MngQEcuZr4SK5O+Zy0j0x20euYffLpsDF+bDx30LNyCA1K8dxrym1+q
 ocOZHo9RsysE+kmAdWRevXhEG57bR4XCbCjb6f6v3Tlu1Ql+xdl5JoExs/AzBpqWq+Ev
 OkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859855; x=1687451855;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GRK1QzR9vRytlGeEiMFUALo1izxLpjDB4A/b92g80bk=;
 b=UTjn0quJwIvOBp7QbM7cU8CHMWqWojnAvojr8ro+MXunV3KqNxn9o4Tg1vapYeKxop
 OwfKI8KmXkaxgzldRD/thdvx9WEFDSsBpZePqHnX7TuRofkIUpurnwbGE+D6xS4IDl2/
 IAZ5ZuaWtadHLdh3lBqF7optgU+PcllW7GVscT2G+vnAl+Amw0PoGkNXeiYFHAXHiLjm
 bvcqcB03nssdRNd5a4riTbZxIuaxQSaftaj+UGJKd1ANveGBkv6LYsTXG6fTOztw0FYm
 aeZG+dCi0NNtOi8aL0EQaHutuyOJllVQZZyJCaganK5TG604ghdFBkNYskPVBbFuShbe
 26oA==
X-Gm-Message-State: AC+VfDwWI2wJ4Fiz4xCkGKaQsAUz4GJQU8cXG5aG1L9dKfuAC6xDMkq2
 TYp3e73YnO70lMhX77yEShz7Ig==
X-Google-Smtp-Source: ACHHUZ4qafIsqfrjXOvDCAKs7iqRjKbYDvDE6gQdee8IzJ5fCcL+2ki5/nTyazvgo3617MJHj2s9TQ==
X-Received: by 2002:a5d:5912:0:b0:306:2c16:8361 with SMTP id
 v18-20020a5d5912000000b003062c168361mr8920455wrd.22.1684859854982; 
 Tue, 23 May 2023 09:37:34 -0700 (PDT)
Received: from [192.168.1.102] (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr.
 [176.184.48.94]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00307c0afc030sm11817229wrs.4.2023.05.23.09.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 09:37:34 -0700 (PDT)
Message-ID: <e789180f-3073-3134-f569-e8042c1b0d96@linaro.org>
Date: Tue, 23 May 2023 18:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 33/52] tcg: Remove DEBUG_DISAS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230523135322.678948-1-richard.henderson@linaro.org>
 <20230523135322.678948-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523135322.678948-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 23/5/23 15:53, Richard Henderson wrote:
> This had been set since the beginning, is never undefined,
> and it would seem to be harmful to debugging to do so.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h   | 3 ---
>   accel/tcg/cpu-exec.c      | 2 --
>   accel/tcg/translate-all.c | 2 --
>   accel/tcg/translator.c    | 2 --
>   target/sh4/translate.c    | 2 --
>   target/sparc/translate.c  | 2 --
>   tcg/tcg.c                 | 9 +--------
>   7 files changed, 1 insertion(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



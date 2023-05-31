Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5BA71828F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M7L-00070z-In; Wed, 31 May 2023 09:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M7F-0006zh-Bu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:43:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M7D-0000Nz-PE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:43:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f60e730bf2so59668995e9.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540630; x=1688132630;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byeYJApVjEUlfGe9HeGbYZLLONllebyLCi6SFalYeGI=;
 b=sTsakm92VLaepOQthDu74JLiPuFBEmzEIsu/uTSVvoerLe88+ZyDzhiW2w1qWp7k6I
 YBk/dt64h29rRlPBMkcMcS4eHRUCq5igFJh/vaXcb5Ts6O34qwcZLWv47A43BdxZOW44
 AYlBzGjb+L8yV+ajqB5OVsmsKzc6xl1SnsTEq6rwR7NfEd9jlPkB8h5aQMlTlAdATkGs
 pe4CM0f/sLw7Kgtl62tm9aVGmGtWU/aW9y1lRIfxA29Yuw87l4ryS5tqH0S+mp4spmZO
 jQst7vCarGPMiczVAsjwx/f5Mr34deCnbECVJA7DoznGAnzquikN+7nMRLKMp+fEo52t
 Vkxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540630; x=1688132630;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=byeYJApVjEUlfGe9HeGbYZLLONllebyLCi6SFalYeGI=;
 b=hNcWZA0z7vHh+uhxx93pji6n+wmhH+jlPKjpaVIN7SkqpWaZSou19Tt843RlkiF/J5
 n06b3prJTi8CWeuZ/zRTKq1Lx41T/b1xant+xsb4TbAPQFOH+rXCzCj2galhRLe1VrEG
 Pp38Vt4aUE2DJVNqTZ+53kuRm+0USsafIGOiYpklwmGURrIc4my1mLvheRo+yUqf3jt6
 Q7BWC6M34HhyoUyGBXGCUz+KGWx1JV1UhANkuTGEwyihwLvkJoN06vAPrUj6kfQ8LXeN
 ZY+ZpKrWj45Qd/YaCleESqxqL098zu8g0BLSAkUZUqsSjSlWeZNk+gHkNpoHLEtnaKtH
 NeKw==
X-Gm-Message-State: AC+VfDxtpqps2JSAL4uJPkgV0MWLhPsQaLxIY/Mux02eCpvvyOFDfVy+
 qKDAq6QDjbueYUZKXqsEohyK6J+x98qSY5SomUY=
X-Google-Smtp-Source: ACHHUZ7efeeo5m3N77rFD8LR78dFAjZGJnKl4zrgyLFnpiN/D988PUYs0JzWq21HiXj1GRJwwx4dzw==
X-Received: by 2002:a05:600c:2105:b0:3f4:2ae5:b35d with SMTP id
 u5-20020a05600c210500b003f42ae5b35dmr4952054wml.40.1685540630128; 
 Wed, 31 May 2023 06:43:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003f195d540d9sm24562088wmr.14.2023.05.31.06.43.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:43:49 -0700 (PDT)
Message-ID: <a6ff4d93-3dfe-7de8-10e3-5cc52cad675f@linaro.org>
Date: Wed, 31 May 2023 15:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/23] q800: move GLUE device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-9-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the GLUE device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 24 ++++++++++++++----------
>   include/hw/m68k/q800.h |  3 +++
>   2 files changed, 17 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



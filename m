Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22471760D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:20:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EFB-0005xY-W9; Wed, 31 May 2023 01:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EF1-0005x2-EW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:19:25 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EEz-0003wr-TC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:19:23 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso6007434e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685510359; x=1688102359;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LLOobzJr0U8FBe2Yg9LHXnqK8pLesU7G6DX/HHaxfR4=;
 b=Zbkbsag6735pFW2gB6cWxBwkY+0YYcbX5klxA0583CtTfqnWiFv5H7HPLZBQ+RS3yZ
 twf2X42cb1/trX76p1xlH30uriidnugirEmkn1wiHCmZBZ0ZfDgCbfz8TBlRW/FWzB8B
 rlam+dCGiv8pyW1jx+jGQXfm4KvTuJuv5aeHhHYjZSM+aUZt8uW0VPPj0TKX34AU6F/9
 6KbYMr+YzY/8/hoLoa4lgbbEpGonJg6FSS212+0aJe2b6vCZg+djpGnrTwwjWmNJpa7/
 13NN2qHZmYoyvXODlyiywG1gfttEVF6INV+L6e/pmV1PcFDT255EKXHrGZdtx1LlUYca
 39+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510359; x=1688102359;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LLOobzJr0U8FBe2Yg9LHXnqK8pLesU7G6DX/HHaxfR4=;
 b=ImRvLyV84y2eIN9uvIHfNvbwzxfpG6WON2O1bloYg4qziPqTiXsiAqQmKi+YBO3NVL
 pv9ONVozi6RoM4ACQy3jy6PmoapcT1pBzlCWsgiuVc4nmN9rtA4Yz2O66At44MUDHzsH
 53vd1Gs0NHY/tZO29Y8E+LKT20/pTDkSeD976Zp2180SEHXXzbJxMg7vNtCMHFY0MGF0
 Ca3goDEC9CfL78CWz/FTRUV4xwhdwnAGctKiXFVsP13cl3OKVAaPiRf38xiSc89TIDaj
 EX7XXW7poC1EKT/QbF8RrXCIvW/ln0VK2dtoSsRfU2iQnwUzc3D7kGVgOOUyvZnHDdx4
 Bdhg==
X-Gm-Message-State: AC+VfDzdN3hLo35Fm5azRq+1bmkWMSH+/eTwNrgMj9n1VqcRfasm0vCc
 TzgsZBNfUN43TRq5qeNzLdgB9Q==
X-Google-Smtp-Source: ACHHUZ4Vt51kiOtBs1fUCK9JknKWfG9Ho7I+AlFqCCbVWdOxeJJ/X2uy+OJIQXQloC0dBr/Nbz5ayA==
X-Received: by 2002:ac2:442e:0:b0:4f3:8196:80c8 with SMTP id
 w14-20020ac2442e000000b004f3819680c8mr1641690lfl.1.1685510359524; 
 Tue, 30 May 2023 22:19:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a05600c220100b003f508115b25sm19500558wml.4.2023.05.30.22.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:19:19 -0700 (PDT)
Message-ID: <c50475cb-c19a-4784-93d9-f72bb67926b3@linaro.org>
Date: Wed, 31 May 2023 07:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 29/48] tcg: Remove NO_CPU_IO_DEFS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-30-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-30-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
>  From this remove, it's no longer clear what this is attempting
> to protect.  The last time a use of this define was added to
> the source tree, as opposed to merely moved around, was 2008.
> There have been many cleanups since that time and this is
> no longer required for the build to succeed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/cpu.h          | 2 --
>   target/sparc/cpu.h        | 2 --
>   accel/tcg/translate-all.c | 1 -
>   tcg/tcg.c                 | 6 ------
>   4 files changed, 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



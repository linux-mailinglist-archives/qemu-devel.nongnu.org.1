Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D92A7721033
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 15:35:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5RO3-000054-E5; Sat, 03 Jun 2023 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5RO2-00004u-Bn
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 09:33:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5RO0-0003Fm-R8
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 09:33:42 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f60804faf4so27871025e9.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685799219; x=1688391219;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UttKKmhfveRFfnXMds31+7Dk4zpGHf/X1BqBi99qpFQ=;
 b=TO6GDQEv4JPiWxdyobqZBkQnyiCUuatD+JHVzwzDj79oXHzgMO/NHZ6Bf9aZYyPz7d
 k86cORj5iaNZvOWXtopHDz7qbJSY7suRoGPlwr3Q5tWb2bDHFIM8IhGmrcxZdHYBPQVV
 wy8jb8dvFWndK9YtCWMT+ou8/jScsfnBiIg6dwBJkSfCWqCmFBoNgPu6MMsrWsyNIm3G
 wIbyf2mEMjpw754OqSZrk2md+PW9WDONfeKgvesALL/+Enh53KFu3yeIA0Ws1euj11hZ
 GsKArnIbwLvrYNACHI/O3NDHCWBV4zHDQ9CMhYAXDjBsAOrO6Y+JACRRJ0yl7Viikaph
 9rIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685799219; x=1688391219;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UttKKmhfveRFfnXMds31+7Dk4zpGHf/X1BqBi99qpFQ=;
 b=AK4rxH1ABn41MGtF0t3qYLqQ6Ue3dMTORMBaE1SgoePwojWuYvE1E0ZfoVYuHs2K+I
 BYOCfk14R/1s9zJ+lRBRotFDUIS8/lljq1IYg2r0XEVPiSGTR9uEp0BN0XH4agqKtoTn
 3nnR5x3e3RJnSpFEUBw+bQ35iidino2hAQjgNgNS8iOD8VV43Ekafso6yGYdN+TArvVK
 dYaKsnjfVRefCnuIrWdIvYT28ye04yJfiaDQy5YHF6LIbw5ZhbU0aViwoUs0GRmjefzs
 3AQkhMqi+oa591+3WjMlImfPM+GO2LUOO7mh/b4gsubLutqPqe4QcQK6XhlCbMt0kVOS
 8Vmw==
X-Gm-Message-State: AC+VfDzQ8ci8bJkNpbjBdh+jCB1rUUveBMxB9WG/UVgIXbBM5zXMsxxO
 P8pyEXRjN5T3VzGULvqhW4QGQg==
X-Google-Smtp-Source: ACHHUZ6Xece7vB3HRo9eyCc+gvAi0BAdM1z5gmkJXyafFQa/JPWSyR/vrIp+2w1vOpQylsy0uh7vYA==
X-Received: by 2002:a05:600c:b47:b0:3f6:5169:1ad5 with SMTP id
 k7-20020a05600c0b4700b003f651691ad5mr4146664wmr.38.1685799218843; 
 Sat, 03 Jun 2023 06:33:38 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.157.140])
 by smtp.gmail.com with ESMTPSA id
 cx14-20020a056000092e00b003078681a1e8sm4565837wrb.54.2023.06.03.06.33.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 06:33:38 -0700 (PDT)
Message-ID: <e06173e8-a938-2aab-2f33-857deebca90c@linaro.org>
Date: Sat, 3 Jun 2023 15:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 15/48] tcg: Split tcg/tcg-op-common.h from tcg/tcg-op.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-16-richard.henderson@linaro.org>
 <5c824199-6da0-85b6-cadf-587eb46294e6@linaro.org>
 <477597b6-737f-1f39-9173-1dc21f97273c@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <477597b6-737f-1f39-9173-1dc21f97273c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 3/6/23 06:04, Richard Henderson wrote:
> On 6/2/23 14:29, Philippe Mathieu-Daudé wrote:
>> On 31/5/23 06:02, Richard Henderson wrote:
>>> Create tcg/tcg-op-common.h, moving everything that does not concern
>>> TARGET_LONG_BITS or TCGv.  Adjust tcg/*.c to use the new header
>>> instead of tcg-op.h, in preparation for compiling tcg/ only once.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/tcg/tcg-op-common.h |  996 ++++++++++++++++++++++++++++++++++
>>>   include/tcg/tcg-op.h        | 1004 +----------------------------------
>>>   tcg/optimize.c              |    2 +-
>>>   tcg/tcg-op-gvec.c           |    2 +-
>>>   tcg/tcg-op-ldst.c           |    2 +-
>>>   tcg/tcg-op-vec.c            |    2 +-
>>>   tcg/tcg-op.c                |    2 +-
>>>   tcg/tcg.c                   |    2 +-
>>>   tcg/tci.c                   |    3 +-
>>>   9 files changed, 1007 insertions(+), 1008 deletions(-)
>>
>> Trivial review using 'git-diff --color-moved=dimmed-zebra'.
> 
> r-b?

Oops :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




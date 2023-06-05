Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D3722FDA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:34:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Fxu-0000Ge-MC; Mon, 05 Jun 2023 15:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Fxs-0000GN-Jq
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:34:04 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Fxr-0007Mq-06
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:34:04 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30ad458f085so4777953f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685993641; x=1688585641;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MAp/W7r1i1jS8xCOuODH7RvfMVVtxCcTVI76JCBaZJY=;
 b=mvP7klhRaSxDoTrPUPBYhexQ5HSfmjRtn+hS4Xh8J3sBytO3Bfjg4VE9nYwh0NkqBg
 YmpPU7MH3u9XnV91iwvqB1/64bimCDY5iJrUTThK2j0qVAhKhX6JBtfWzbnJJk1yrL0k
 fgOaTl4lwktPkeUgS7k7QgJ4f0PBrLlxeGJxMDhBZPpEYr1kNSI9QTi0Mj1DJ0FVc6t6
 LjZQD4CE9i3TogUyh3cPZVu7QL3oDZPzEWc4WRuOD9OOtyByMPYCq9GCkCweDPVRLRH3
 22ScN30H3QW/O35ZoftDm4pkvvLYGcsaC+wd9Eq4fB4rWEX+J2erDpE3kIVSWwX/+5Od
 hFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685993641; x=1688585641;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MAp/W7r1i1jS8xCOuODH7RvfMVVtxCcTVI76JCBaZJY=;
 b=Gdt84LWG8FNWjYShcn6ztQ9pEdpqAYwJ4ZHJn72cNREvfnMVpwnR2dy0mK+AkZWXUU
 c/qIQMxF1LKvlEeUNH7GvgXWLEl8Kzq0RFvxmpIofnIr3ZXMUUyhkPQHNx1a/ywvEAeV
 Fxre1HRhMJ3OpkLeaARzRBgAl20QLx7bQm/2VtTOdqf8umXQuO/9kN3mxFZgLxd8kbM/
 pLYzUopNED/xwKyv0uKkHxdP0jl199pjyiUAKVgGMak5pHHM98E2XfktOJcAEshA+y7M
 SuxS//bnkf6LXFU4Rce45RSL1a3TfKtnh3P2La6uPV3L0frXqsWNlboRSGDE72mViX8i
 TXYA==
X-Gm-Message-State: AC+VfDzb2SWf89g114rR3Zrnuo/xYC5z2E4cxDX7D40gg071M4FU4Y75
 fM1w8e54Xepp6iCwYZhOXwDzDA==
X-Google-Smtp-Source: ACHHUZ5McOrFn8hUAJeRKiPLNPWKDao1/HhjNw++Uy0P3SLlRBzUtIptqTbNDgGFA6UxWvqxKreXnA==
X-Received: by 2002:a5d:6b82:0:b0:30e:47e2:7eca with SMTP id
 n2-20020a5d6b82000000b0030e47e27ecamr1863950wrx.3.1685993641503; 
 Mon, 05 Jun 2023 12:34:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm10554375wrq.89.2023.06.05.12.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:34:00 -0700 (PDT)
Message-ID: <65c71dff-e4fa-4c75-e0cb-c0033c835f44@linaro.org>
Date: Mon, 5 Jun 2023 21:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PULL 0/3] qemu-sparc queue 20230605
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
 <f3070fb9-e175-eadc-e4bd-c0395b593195@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <f3070fb9-e175-eadc-e4bd-c0395b593195@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 5/6/23 19:26, Richard Henderson wrote:
> On 6/5/23 04:32, Mark Cave-Ayland wrote:
>> The following changes since commit 
>> 848a6caa88b9f082c89c9b41afa975761262981d:
>>
>>    Merge tag 'migration-20230602-pull-request' 
>> ofhttps://gitlab.com/juan.quintela/qemu  into staging (2023-06-02 
>> 17:33:29 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/mcayland/qemu.git  tags/qemu-sparc-20230605
>>
>> for you to fetch changes up to 36c9189890bfb936b1b086da639e37fd92b50215:
>>
>>    hw/isa/i82378: Remove unused "io" attribute (2023-06-05 07:43:23 
>> +0100)
>>
>> ----------------------------------------------------------------
>> qemu-sparc queue
>>
>> Hi Richard,
>>
>> This is one of Bernhard's cleanup series where all patches have been
>> reviewed/acked. Please apply.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Also merged as commit afa351fe36 :P



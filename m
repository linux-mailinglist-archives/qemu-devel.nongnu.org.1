Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CEA784950
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 20:15:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYVuL-0003Hu-BF; Tue, 22 Aug 2023 14:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVuF-0003Hm-Ab
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:15:08 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYVuC-0001J0-Rx
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 14:15:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso35015065ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692728103; x=1693332903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XF1AUpyCcaXoU3ikKfREKpJ98dJjM+9lvfDG/KEEXbo=;
 b=ItzDWbyDh7lgyuTpakvMQuaV19pCowRtSr2XeYev6CW97ixkQTeg6M1SV2v4ujE/ya
 +oM/5gihMXyUctGeQfTdDNXOOH1Ki8UJsWCgZ4hNRH+dm7eRJFWKuVZ2ShpnlgVXxKyf
 FhrruurmJmsuSB1iRhqOZJSVfQfxXW3sUYvCHJjYVkP1XIt4SE9h5/ivwE6nkcvjnWXv
 IuPeDRGeuQARJFfjz4XZKydGx6Ddt7yPtepBZ1zDruRoaHJsFTRCQ9YMlXM8EUHNnQdq
 cGOSryIe6B0C4ZkK10AV9Tm8k6ExzdhLrYzoraxJS9LQljGSjKBExLOG0Tp3O4z1aOi9
 h6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692728103; x=1693332903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XF1AUpyCcaXoU3ikKfREKpJ98dJjM+9lvfDG/KEEXbo=;
 b=aXv1wsQfFiaPwXU6PbEp5/0n4QePaTVDmbE1yA7Lhw1EfPhKk/cahO9y+iGhgISZ+O
 /TfBIuG4k6XTOWQtSUFTp0qsBgTJ6xDhaksaS++NnwlLZavJd/7vXwac8FgLUZU9+olg
 mIfPLu0qwWAV4k0bpOqi7izs/7Ddigb98UiKuVxDQ/CIfDaLPucRO8JHLlTYTnZbbxjK
 QyZ5lg6t7dTmNH26q9vpJAGos+6jkpE5NtT98rRGALchmXrE4fIT9NCmuogkzQWdEYbf
 5B+xla2eoBDJev1aL0g2LEyDB9rawgGpHqRKioN0DfGefjXhCbRe2U9/6aQ+5f2rFKt7
 vPhg==
X-Gm-Message-State: AOJu0YwtaDyOY4guXW+h9i+SFT7X3gjWaCFHvFmq0KPsVu+cyUY+hkch
 vDJdb+gV06aMZbW0s698JLzUN2RBcLKZlMoTMD8=
X-Google-Smtp-Source: AGHT+IGLK5sXq9NdA576p/www1ahiGeB28iRgtg8G1dx6K6lFtnVnSLCWyXSMdN6vyeREJ2QoLc7ww==
X-Received: by 2002:a17:902:684c:b0:1bd:c6ca:e0db with SMTP id
 f12-20020a170902684c00b001bdc6cae0dbmr11166118pln.37.1692728102730; 
 Tue, 22 Aug 2023 11:15:02 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a17090332cd00b001bf5e24b2a8sm6895533plr.174.2023.08.22.11.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 11:15:02 -0700 (PDT)
Message-ID: <a363d744-52cf-3993-73b7-6bafc6b0f58e@linaro.org>
Date: Tue, 22 Aug 2023 11:15:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2] target/m68k: Use tcg_gen_deposit_i32 in
 gen_partset_reg
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230813155425.341598-1-richard.henderson@linaro.org>
 <bab2e366-d821-3ca1-ed2a-a46f3f2a1afd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <bab2e366-d821-3ca1-ed2a-a46f3f2a1afd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/16/23 02:45, Philippe Mathieu-Daudé wrote:
> On 13/8/23 17:54, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/m68k/translate.c | 11 ++---------
>>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> 

Queued to tcg-next.


r~


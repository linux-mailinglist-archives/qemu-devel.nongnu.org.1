Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AADB71600E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:39:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ydS-0007vD-7v; Tue, 30 May 2023 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ydQ-0007ug-Mm
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:39:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3ydP-0003GT-5X
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:39:32 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f61530506aso46552855e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450369; x=1688042369;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rBJlVAcRUhLPt1uRiQd+W6OCTmptP73zev0GOuM5lnQ=;
 b=ASz9dUtam6PsbZ9aJd0dIFmoyI5QLEV/IP6SG9MzatmQDG0SeNYDgs3gKt4ZlqiY/U
 VoGUE45ZR4nugER5q8sYNcNgACZQsP6pxY6F/MUP9Ybwck6xWe41yEFRSAqnBUAXfqct
 n88D9Irc6F/8O2gWB7MQ9TorgHAg4KrTxVWFseNysaLm7V0EeeOXpBFzHCvSjL50HOrO
 hqlTMvzQHUwFPQ4kV/3Cbus9rQMXLXkx6sZ6SRsxagCXX24Cq7upI0ZViN9acilrWi4X
 5Ms9L6+pLhTCwJMfzRbWCGGCIysIQlMyMgmQvkfcUxZjb7OBGaQaX3xMFtUQtTpWGx1N
 a5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450369; x=1688042369;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBJlVAcRUhLPt1uRiQd+W6OCTmptP73zev0GOuM5lnQ=;
 b=l5N8qwZWFuSNtBHfEar6BVDy0MMEIQZZ4kdQD7eFfrnZTHy4WQlTWQXZDJblm3nNkv
 nMMDJ6An4vrM/+rCtm7t9mc4DydQKlhSfQBCisG6pwhivYkRYnCuf0LcE1Ik0lJTRai/
 FuTP1FQT+ja+80QhoTbEY+wbyfC65lxDVapvk4IVgyMuRi3zKv3o/6tTW4mIE8t7rFKy
 xuSreX/lqQVpIq212b98AWokiYC0TAqTQxoVWhZq+5hcYHfsXvOLfzGAukbHWcEvZy5k
 JfKOkQ+IHgl65S3pErlhE8buw8hzvqZCsaboXd1YO+1lhOMW+iVLM6Jo8PDEr6Ya1LXL
 6f5Q==
X-Gm-Message-State: AC+VfDym1DhogrZ38JVj+X6GGFcOw8zrOBvpILVEHsLeopG2XqAXtX/2
 6XllYeRYofzXlipKZo1o0hRWwzrys0Exzng42qGYhQ==
X-Google-Smtp-Source: ACHHUZ5J/VkHUV4sFMr16ewpIu8sc7SmcuqYGcKcvWs8OxJP/Ttf5zVSUs7cSKQUXz6FK2f/Z9dpnw==
X-Received: by 2002:a1c:6a0b:0:b0:3f4:16bc:bd19 with SMTP id
 f11-20020a1c6a0b000000b003f416bcbd19mr1759094wmc.23.1685450369649; 
 Tue, 30 May 2023 05:39:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a05600c290700b003f42d8dd7ffsm17323918wmd.19.2023.05.30.05.39.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:39:29 -0700 (PDT)
Message-ID: <8700df4b-8ef9-672e-2b9b-a5d2b9b11749@linaro.org>
Date: Tue, 30 May 2023 14:39:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 01/16] qemu-file: Rename qemu_file_transferred_ fast ->
 noflush
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-2-quintela@redhat.com>
 <f71adc26-975d-2a2a-77dd-642bbc7db553@linaro.org>
In-Reply-To: <f71adc26-975d-2a2a-77dd-642bbc7db553@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 30/5/23 14:36, Philippe Mathieu-Daudé wrote:
> On 30/5/23 14:27, Juan Quintela wrote:
>> Fast don't say much.  Noflush indicates more clearly that it is like
>> qemu_file_transferred but without the flush.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   migration/qemu-file.h | 11 +++++------
>>   migration/qemu-file.c |  2 +-
>>   migration/savevm.c    |  4 ++--
>>   migration/vmstate.c   |  4 ++--
>>   4 files changed, 10 insertions(+), 11 deletions(-)
> 
> To clarify further, qemu_file_transferred() could be
> renamed as qemu_file_transferred_flush[ed]().

Never mind, it gets removed later in this series.


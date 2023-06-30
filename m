Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044F7442C7
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJxZ-0004qO-SI; Fri, 30 Jun 2023 15:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJxO-0004pb-Lg; Fri, 30 Jun 2023 15:39:02 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJxM-0007ov-Rk; Fri, 30 Jun 2023 15:39:02 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5657d8ecdd3so1506040eaf.1; 
 Fri, 30 Jun 2023 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688153939; x=1690745939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kyvOAalyS+E8Xs1yh2YS9NNlft5AUNZAAsR3UtVN4zI=;
 b=TvYuxHD8bxbYvyCALPhC17wnPjxfYGR8sTOREkr4ihABMQPNOakbZyo7mDs0X/ywmR
 IqrQxdWI7bRN090CmqYi7TpQS3N1UTUcU4od401p2HGFfJROTLlryBCDxfuGffPRtvZ7
 kFSP2VzeH8iY3lGY1NDB/x2Y7BjFBgLGY0K8CfEDLP8eDC6We3cW3dfnoBne6jjou/qA
 WHw/PZVAMmgEG7b/2NqhDuWUBPrKDFMwXF+0aqAFtQfeCTf5x2NqXpcAUb35SPqJW7m2
 J/jdNKxAB6MefmX3melaTvwpJvbRivTB3bJ9ug4UFsRawQGGHpCWwOyXLnjsvmvFWuZC
 HJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688153939; x=1690745939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kyvOAalyS+E8Xs1yh2YS9NNlft5AUNZAAsR3UtVN4zI=;
 b=cjjj5bXQhu1maxwHQ5IzPV6kmjuBPr/A5jRh6O+ljlwSt0uGf9C/Okk/m5PDL2zno8
 faYzT94AwVWfRQAj4JLfVkjO7a8cQgFMidmL5edRdgFB9xsdTHHnPmGRNj8x5HRTbr8k
 u8i2zSJaq0T9GzO3Zy4VDZy33bMCmJLvp7p1wFBGHyRc1f9zQ/NsGL6X0M2rfMCsECtO
 2TMwpjBByxtpR7F63qLm5D+LiRBrf9/qfEEb+oxHboJZzALLhIZ1lcHBAxV9yGfPAsnM
 kgl0vZN2WGLNRdVb82Kux79aiijPJuBr1y60/IXdNT4H4cJF5fYFjJP3LzSQNjPOAadC
 7P0Q==
X-Gm-Message-State: AC+VfDyDvqLP2U+Ur1YiAiRFeAZpMp36FwJiEwiYjv6WRp2JPT1bay9u
 I9aYP7e8vJVGz2MsfQ3CZw4=
X-Google-Smtp-Source: ACHHUZ6J3XoKlhWjeWNXA7w9mUMrwcsQFo1Zcp4EIHDgbzQk14JZSp/51lcZ3ZhIzHavXZ7Db1nTTw==
X-Received: by 2002:a4a:52cd:0:b0:563:532c:924c with SMTP id
 d196-20020a4a52cd000000b00563532c924cmr2933834oob.2.1688153938950; 
 Fri, 30 Jun 2023 12:38:58 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 u19-20020a4ad0d3000000b0054fe8b73314sm4647278oor.22.2023.06.30.12.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:38:58 -0700 (PDT)
Message-ID: <9989efc7-5ad9-0c31-e0af-b8a735dce353@gmail.com>
Date: Fri, 30 Jun 2023 16:38:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] target/ppc: Easy parts of the POWER chiptod series
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230625120317.13877-1-npiggin@gmail.com>
 <3f70738c-f30a-99a6-6e06-e53b8f93f830@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <3f70738c-f30a-99a6-6e06-e53b8f93f830@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/29/23 01:58, Cédric Le Goater wrote:
> On 6/25/23 14:03, Nicholas Piggin wrote:
>> Cedric kindly reviewed these already so I think they should be
>> good to go now. This is just a rebase and slight rewording the
>> changelog. Still haven't completed the main chiptod device yet.
>>
>> Thanks,
>> Nick
>>
>> Nicholas Piggin (2):
>>    target/ppc: Tidy POWER book4 SPR registration
>>    target/ppc: Add TFMR SPR implementation with read and write helpers
>>
>>   target/ppc/cpu_init.c        | 82 ++++++++++++++++++++++++------------
>>   target/ppc/helper.h          |  2 +
>>   target/ppc/spr_common.h      |  2 +
>>   target/ppc/timebase_helper.c | 13 ++++++
>>   target/ppc/translate.c       | 10 +++++
>>   5 files changed, 82 insertions(+), 27 deletions(-)
>>
> 
> 
> Daniel,
> 
> When you start building the next PPC PR, I think you can also take
> this patch :
> 
>    [4/4] target/ppc: Implement core timebase state machine and TFMR
>    https://patchwork.ozlabs.org/project/qemu-ppc/patch/20230603233612.125879-5-npiggin@gmail.com/
> 
> It belongs to the same series.

That doesn't apply cleanly with these 2 patches and it didn't look trivial to
me. As if there were some code missing.

If Nick re-send it rebased on top of ppc-next I can queue it. Since it's a
rebase you can keep the r-b. Thanks,


Daniel

> 
> Thanks,
> 
> C.


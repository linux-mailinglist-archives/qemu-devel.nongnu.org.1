Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE47C9E5B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 06:50:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsFXi-00035Z-El; Mon, 16 Oct 2023 00:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFXf-00034r-Ad
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 00:49:23 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsFXd-0006eK-Po
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 00:49:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9be7e3fa1daso255344266b.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697431760; x=1698036560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qyp9Mpb8SovruWifzsJbBIztxTp2VIY62/hl80E9okU=;
 b=foo1ma6OBv7Ra8iKOGxacxM3GsP3INHqMp0BgHuUfFsDooe+HIqYw6YQKtNAaaBxia
 tJ8tkfrAdw/fwf6nGf5n10OBA9Q73lGlAY8QblepwvdvdcilxW+O9zdWY1DNQyhHjFjX
 lsV3S+OkmxWSWpQbHq8wYKSTXzITc+jMKGkzsa9gZ/QwSgr8MxQMIN1Ar1Xj029BBYWY
 Dlv44hatd1jxLTvnOTuySCEB3K3CYjKgG/ONM/wbZJZKwLnBr9f28k+8Ppfhzb0wDXTf
 xpjGQEBVK7BQ43SlwJzpFYh2jhobz4yaJiBvQF+mvEC+QmMs03S8eSHDiXz2jBedI1nH
 uXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697431760; x=1698036560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qyp9Mpb8SovruWifzsJbBIztxTp2VIY62/hl80E9okU=;
 b=rJb2XfGivcMrJLHNMd6O+hKnE962pNfVwNuTR6Go4aq2qCMmA+qy9MHKC4r1tksqlo
 o8N7eQN2MXcBg4vA9ReDLMoqMMgfjMyOqYfsD381wUiP+CFisPGbdnveyGG5lzCDv2c1
 Bdl5zFntv3LPlx67N2zvzmiUkDxb9vKdxbA3KCWjU2pn5ejj3axzJ9zJEhECX/y+uOwh
 oTJMLDYW6+ZOz1es2OdEIhvYUef/o2UgHS+R3pJb4GpS0kyXu7swBmQs15P2eBz5fFAf
 hTcs+0JxuJlIVi5vhrvDZP8tsohHl0Te54EiIKRLYhnpcMZhbZ8UKDZUWgvSwWLmRk1V
 qi4w==
X-Gm-Message-State: AOJu0Yy7ICUP09IJeCwMVBKISDr6RJNGcAP6GsWTvf0KwH+CFEf/LaKH
 /j4sVN0jNxElCgFD+M6wwq0K/YMG4b3XrUWfnE8=
X-Google-Smtp-Source: AGHT+IEW7PhXdKI5BnL2Kmzfcno7TVOH9fD0eZqzz6v+kcos/q5k7zpTf4BmEUo7H7tJ8O8vo0JSCw==
X-Received: by 2002:a17:907:da6:b0:9be:dce3:6e09 with SMTP id
 go38-20020a1709070da600b009bedce36e09mr5381054ejc.68.1697431760243; 
 Sun, 15 Oct 2023 21:49:20 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a17090638cf00b00997cce73cc7sm3259574ejd.29.2023.10.15.21.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 21:49:19 -0700 (PDT)
Message-ID: <de48be92-4553-eaa5-6e73-59543552a95d@linaro.org>
Date: Mon, 16 Oct 2023 06:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/7] hw/ppc/spapr: Restrict PPCTimebase structure
 declaration to sPAPR
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-2-philmd@linaro.org>
 <de55b967-a00a-41e4-b95c-c7dc4d3823e4@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <de55b967-a00a-41e4-b95c-c7dc4d3823e4@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Hi Mark,

On 13/10/23 20:32, Mark Cave-Ayland wrote:
> On 13/10/2023 13:56, Philippe Mathieu-Daudé wrote:
> 
>> The PPCTimebase structure is only used by the sPAPR machine.
>> Move its declaration to "hw/ppc/spapr.h".
>> Move vmstate_ppc_timebase and the VMSTATE_PPC_TIMEBASE_V()
>> macro to hw/ppc/spapr.c, along with the timebase_foo()
>> migration helpers.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/ppc/spapr.h |   6 +++
>>   target/ppc/cpu-qom.h   |  22 --------
>>   hw/ppc/ppc.c           | 107 -------------------------------------
>>   hw/ppc/spapr.c         | 116 +++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 122 insertions(+), 129 deletions(-)


> I saw this series when it was original posted, but I failed to spot that 
> it didn't apply to the PPC Mac machines. I have a feeling this should 
> solve a long-running issue I've been having with decrementer migration, 
> in which case can it be moved (or left) somewhere where this is still 
> possible?

I'm not sure I understand what you ask. Do you want this code to
still be available for non-sPAPR machines? If so, I could move the
declarations to target/ppc/internal.h.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213F7E296C
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:09:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r029R-0005Tg-3v; Mon, 06 Nov 2023 11:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r029O-0005TS-Sd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:08:30 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r029J-0002n6-VU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:08:30 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5bcf83a8f6cso3539715a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699286903; x=1699891703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/5XNPtctPUuEK4JLUiuFEz1XulPDt1QVoCU238QhwNU=;
 b=nJRtB3u/2PoAVF/VfouV7Ah1KQzFT9PFO3r+SRRwlqU6pQYE6nZ3/XBvgNjrrk7fep
 96GUUNno07VF9IoF5IrF61yCcQ4HOOqNslr0/hhLNA4Zp5RldnngK+mQe8CriILuMkUC
 fVPO2YMhP2MH4/pryyZ5SyRWmyllfag1Mj/yawz9EACN5dPErH7ndfh0MoTpjSqYBEQJ
 ZtrxCoW3O6irkbmExvU5DXkyd91YwGy/wBG/2DB3evaI0TOG+AzUErYN/B3q/H9i2vRt
 j3/Gfil7c3n4XE4TeHoq3qdvOwWNbdPPc+qBC9sq8g0wgIykJgFDe4GI8vFiUn/uI0oH
 M9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699286903; x=1699891703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/5XNPtctPUuEK4JLUiuFEz1XulPDt1QVoCU238QhwNU=;
 b=Sk0QJWE7ibeJhjlTPSG2PZXv8zE2C2yAXF/9NXlbyOSoxo42vpQlUI5KHD9gU3rPZV
 zMrKW3pazTlo/ce/lR76/OiCSOVnp5On9Dt9s3Iof+3Wh+1pm24HNkZZtFdA7KWOZcpg
 CN1q4waptmSUS3Fv2zVUSZf6QjuDwTq+SuzsYmqFPfgrUJIiJO1usC1mIEVX63fyEJFs
 geUGhvIvdCtmCtKIevQNl0fSlWpgyjzWl9G0ATvU04+Gm9NWATaYkfuBR18tFRun06tG
 nPkdrOmDmdzFkY7CYLqLp/ElpawPt7EfKSrW4hrmfsvAyKdL1sZj3ANyouLS2Px8zuIG
 9OUw==
X-Gm-Message-State: AOJu0YwIdKCC+VglMesjtzb/dY2CiQbxeifZOW7vxkGJzqJzTHZg9Yx8
 m+fdKIyo2jk0vst+WPwXDhjvog==
X-Google-Smtp-Source: AGHT+IFdkK/6HLMYrRpSgaDHq4NChvB9fS+RH2fRbHuoDgqJFjr0Of/wSFzVsC1KVzkWEp7sBDgH0Q==
X-Received: by 2002:a17:90a:cb09:b0:280:145d:510d with SMTP id
 z9-20020a17090acb0900b00280145d510dmr22390031pjt.31.1699286903448; 
 Mon, 06 Nov 2023 08:08:23 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ep22-20020a17090ae65600b002800d17a21csm5704517pjb.15.2023.11.06.08.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:08:22 -0800 (PST)
Message-ID: <92f76598-abf6-4edc-a7b1-25303a5b79fa@linaro.org>
Date: Mon, 6 Nov 2023 08:08:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 53/71] hw/sensor: Constify VMState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-54-richard.henderson@linaro.org>
 <a19becb2-6f32-2ea1-fd4d-5800bd120923@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a19becb2-6f32-2ea1-fd4d-5800bd120923@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/6/23 03:55, Philippe Mathieu-Daudé wrote:
> On 6/11/23 07:58, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   hw/sensor/adm1272.c        | 2 +-
>>   hw/sensor/dps310.c         | 2 +-
>>   hw/sensor/emc141x.c        | 2 +-
>>   hw/sensor/lsm303dlhc_mag.c | 2 +-
>>   hw/sensor/max31785.c       | 2 +-
>>   hw/sensor/max34451.c       | 2 +-
>>   hw/sensor/tmp105.c         | 6 +++---
>>   hw/sensor/tmp421.c         | 2 +-
>>   8 files changed, 10 insertions(+), 10 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Possibly another one in hw/sensor/adm1266.c if
> https://lore.kernel.org/qemu-devel/20231106110336.358-54-philmd@linaro.org/
> gets merged.

I am concerned that more non-const uses will creep in, but I wasn't up to adjusting 
checkpatch.pl.


r~


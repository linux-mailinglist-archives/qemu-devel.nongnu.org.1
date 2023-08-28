Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B178BA6E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 23:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qak3A-0002V5-AS; Mon, 28 Aug 2023 17:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qak38-0002TI-8o
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:45:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qak34-0007dz-BO
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 17:45:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-401b0d97850so35915535e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693259124; x=1693863924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/h/vWdv5CmDOL9Cr4FGosR9u+cFVbfE1GllsGXlBpk4=;
 b=o2VpZ41XfhcHJoU58RphZIm6NHsd5gR6IAkvSmOgL+0B/SBbFJogZeMpPJXPLBQAvg
 oUbMYl50ma54Fp7bbsc0NaGqyjKMZxAJl0FWxIB/Emgauc61WFOVC/R+nA2SmmJlHx+r
 duzBi4LvUQUpidXnzhB/1JBPrVcJAiqxFXUbVdbtRJx1hf4DcUhDwURjIeyUnfmWyh1n
 nqpxEwdy0LtZv3YgbLf+GPO1U/D+eHxRtROEJgIgTYSFac1iZDsAGHjorw9akP/vklMM
 PSE/nJ5Gh0asqKs3qsBLv7XTgcKidWag6p4jowHLDHi1oa6sB80lJHdT3L7oX+lughPS
 SzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259124; x=1693863924;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/h/vWdv5CmDOL9Cr4FGosR9u+cFVbfE1GllsGXlBpk4=;
 b=bnw4TllABJTV9Ohvna5xQCOQngcOGZGmqd6DxD0AaXBsFw1PyQvscGju6ipMr98SJs
 0k0q8HG9CMSx6eNYcy6oQeknNKOcqIFCNX2gW36BvrZXzAGYz6EzF0Q7IVbjPNpImr5g
 aFhMhZo5qGE5CPklF2340gPq6DIUAWBdPZE0DLYb4Dwn5ykdWTMVw7CQ9aWucP1mQBx4
 LXHIlSPQw+JElq8vuiwh1Mck5RxbC9JjRkMG7bwm+/wm6iYDdW+ss1fXFaJHqaiE3Rw7
 wrjUdpc5E8g4MJ7juauggTG2eShD5EwdzE8uSzTZWn9kenKgiHCvtP5j25QRlfPIOJPf
 jjdw==
X-Gm-Message-State: AOJu0YzLN1Def6KmUt4oeidRbJ0RTAnJqFfT7l9ua1MwGNUZzRLs8odj
 rnShbC+/QBLCGCpF/bKkVdv3sg==
X-Google-Smtp-Source: AGHT+IE1yB9JgC9wIJ+VMTnmilcwsEE32cNGsCd/cij7M2J3X0P8jxfZDnmyEK/YSbYtpyS6ESm/kw==
X-Received: by 2002:a05:600c:21c5:b0:401:bd2e:49fc with SMTP id
 x5-20020a05600c21c500b00401bd2e49fcmr6102608wmj.24.1693259124064; 
 Mon, 28 Aug 2023 14:45:24 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c045000b003fee0741b8csm14982848wmb.23.2023.08.28.14.45.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 14:45:23 -0700 (PDT)
Message-ID: <ac9fafb6-a751-1503-a5c8-f71c9909a6e2@linaro.org>
Date: Mon, 28 Aug 2023 23:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 7/8] target/helper: Remove unnecessary 'qemu/main-loop.h'
 header
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20230828145545.81165-1-philmd@linaro.org>
 <20230828145545.81165-8-philmd@linaro.org>
 <37e187bd-a21e-f9a2-ec51-a114cb5083aa@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <37e187bd-a21e-f9a2-ec51-a114cb5083aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 28/8/23 20:40, Richard Henderson wrote:
> On 8/28/23 07:55, Philippe Mathieu-Daudé wrote:
>> "qemu/main-loop.h" declares functions related to QEMU's
>> main loop mutex, which these files don't access. Remove
>> the unused "qemu/main-loop.h" header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/riscv/pmu.h                   | 2 --
>>   target/xtensa/mmu_helper.c           | 2 --
>>   target/xtensa/op_helper.c            | 2 --
> 
> At least these 3 files do two things.

I can compile these files adding '#error' in "qemu/main-loop.h".



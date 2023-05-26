Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D750B71225C
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SwI-0008Sg-5Z; Fri, 26 May 2023 04:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1q2Sw9-0008SE-Rl
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:36:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1q2Sw7-0002Hv-42
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:36:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae408f4d1aso3825105ad.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685090188; x=1687682188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hL4uswsB26zz5CjaJg8Rcg22UjWkpBjcm1U92qjXixE=;
 b=MQlA0CBw90cz5I0plXZZhmFVNgfNvCMrs2TGrqr0ifoE/DRO34aoHEvsD/8/+5o5Zy
 gMsAiugeJqy/mnqip6zLzWvAbjTHaURcQVXi5BUiM531pr417iivzp+y9uXoppUti8TM
 Sxm3cBHQ8PKP+BIi/Z7yZyiqf0ex33JZTW7rOaLhT6jAKpIB3Mm3VK1MgsIAvuNjd5jk
 OD7iIRRNHe2TXFJ6AJUl0Dgf0TAPbV5Y4JvSM1OTe1gSbhxOkBIHc+gW3ZBPRwzLqJNA
 i5N87TsgDyTicGf1wx+UyO99EQ+7BYvAz4Eb/AF+cAnO7/SLwELjECILDVgnpSt1zJry
 LsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685090188; x=1687682188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hL4uswsB26zz5CjaJg8Rcg22UjWkpBjcm1U92qjXixE=;
 b=mHx5T4At6pZnNQ0XZiq71AhPXBKKGZl0alYL2IeRFbycNaj7bE8tx8MVmunY49xy7r
 CbYZTfp0r3fHPWRTNKFir6l3miVXbhB2bAQ3rFZNcAR0iGUuIwgRLJi44CbBGSFaQaOY
 Thd3fpEOc7SAw1Ql4a5T6Ki4J3kYBJ+GMtSC5Zh4qyMYYCwObGPRz6rotfoHChVF1mul
 PFvMmeKMqxHfDeRTD1CPztct3AwhdMMSoydcU1hmS/LvEWep6wwCYGl62Jiys99F5guB
 39qKsMXwRUcWNLtfq6TLHlUbC8U5PblevmnfAff/0yjmpWD/MhAkPgBQhOaSR6WceqgN
 2t6Q==
X-Gm-Message-State: AC+VfDz9Ns7BbQUIP0BsoNNs5ndUUzrFlGqGgvlkGjSBHCtokoDzXEH5
 hATav8HPfFQhPqbORF6pjHF+IQ==
X-Google-Smtp-Source: ACHHUZ47KVu942r3gBk6Hhqw9Ay4TY8Xwhf9jEtwdko1etDL371JlorWg0tHfVogtI223uK0ckNSZQ==
X-Received: by 2002:a17:902:b18f:b0:1ad:fc06:d7c0 with SMTP id
 s15-20020a170902b18f00b001adfc06d7c0mr1642964plr.1.1685090188625; 
 Fri, 26 May 2023 01:36:28 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 bg4-20020a1709028e8400b001a9873495f2sm2690090plb.233.2023.05.26.01.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 01:36:28 -0700 (PDT)
Message-ID: <6c5bb6a2-9177-ee9f-be7d-7394e8e54ff0@bytedance.com>
Date: Fri, 26 May 2023 16:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH] cryptodev: fix memory leak during stats query
Content-Language: en-US
To: mst@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, arei.gonglei@huawei.com,
 qemu-devel@nongnu.org
References: <20230503115437.262469-1-pizhenwei@bytedance.com>
 <CAFEAcA-rXQwFAj9pz9vtqdk3i5KYDcf_w2-s78VtF7NYQJvsvw@mail.gmail.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <CAFEAcA-rXQwFAj9pz9vtqdk3i5KYDcf_w2-s78VtF7NYQJvsvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x631.google.com
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



On 5/3/23 20:59, Peter Maydell wrote:
> On Wed, 3 May 2023 at 12:54, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>
>> object_get_canonical_path already returns newly allocated memory, this
>> means no additional g_strdup required. Remove g_strdup to avoid memory
>> leak.
>>
>> Fixes: Coverity CID 1508074
>> Fixes: f2b901098 ("cryptodev: Support query-stats QMP command")
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM

Hi, Michael

This patch has been ignored, could you please merge this in next PR?

-- 
zhenwei pi


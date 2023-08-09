Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFB577652F
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTm7c-0003az-Ou; Wed, 09 Aug 2023 12:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTm7S-0003XW-M7
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:33:11 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTm7Q-0006wQ-VW
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:33:10 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so5089771b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691598787; x=1692203587;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZTyfu7guzStRdOGAufoNVKkesDunZqpbIQOI7GKNZiY=;
 b=Ah2QnZiql/NbYUGjiT2+MyLOjYWLSOozVgNk/NiGWB/+9vIZSqgAE7WZ5JWHtOh+Or
 MZelDs9JaT9E77hbGRPHt415dTpCjAAxPfdcKHK8m+kYxgvgvPb69C+0bY+Rpkx1Hx8R
 IRW0n0HztQz6A3TC2zVu13F7o0yP1Ab0CuxqMK39mUvt2Txwx5+YiCw9EbiSnpEcp1rM
 6oXIXRuNoDDUDuedCVdt4tYoLI0oBkgmRAPY/pHNpzm63AiR8jpAGYc9kTMMsGHvABub
 vCNSywZ+wbrqNWO1oqWnuA2sxC2FO22k/XKl0Q69NLluf5dN475o62ZuWwc50ZgL0eDP
 BpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691598787; x=1692203587;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTyfu7guzStRdOGAufoNVKkesDunZqpbIQOI7GKNZiY=;
 b=LRyCqdBuE6Gs1OyoUQJJMeSTLPi6T5Eu1RjJPOSpLJa+pyKuLH7H/z0lJDqR1vueET
 3XX7ElzluLP77YSWiJmQrfbg5cL9C36GNVV3Es32njEhZkGZT9cPMOxUXEkKXUn1INIB
 3cNemXTuFDDdSCT0C93rVrtzOOQUF5Ng67ckfKz0G2oH8fdMl0gx3UGM2cOjtSdoT87o
 Us/Xt3i0W9/zY0iW3/Vc5ivzp2wCkSnx60W68wZ9MuX/97joATQHE2j9HK6mTTFZAsg1
 QTFPdklkVrFd+vAgndPwkNNp80qwvAx04KxR6ZC6+bVrRuZoeiT7RL+5NIVSxEJvu67B
 Q3kg==
X-Gm-Message-State: AOJu0YxM1Wd5L2iUIUhVnmli/yZwI9HHJsjGNdR6J6ghhBEwdJrZOZmK
 KgwMA6p7FHwLhfWl4NRAi8eyjA==
X-Google-Smtp-Source: AGHT+IFVliie93mNC0zuz//4x6oavJE9FICk22AD22Yf7xnhtnsKCyQKksnCi/Xafe0T+XQPACWjCA==
X-Received: by 2002:a05:6a21:329b:b0:13e:fbee:a5d1 with SMTP id
 yt27-20020a056a21329b00b0013efbeea5d1mr3597387pzb.37.1691598787174; 
 Wed, 09 Aug 2023 09:33:07 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78396000000b0063f1a1e3003sm10123458pfm.166.2023.08.09.09.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 09:33:06 -0700 (PDT)
Message-ID: <0765135d-2a91-0260-4d19-de8554908797@linaro.org>
Date: Wed, 9 Aug 2023 09:33:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fix interval_tree_iter_first() to check root node value
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
 <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org> <ZNOsq6Z7t/eyIG/9@p100>
 <9251069c-95e5-aff5-9ee9-de7a493b23bf@linaro.org>
 <6f4c3b1d-4254-526a-4cf1-6aefbba6796d@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6f4c3b1d-4254-526a-4cf1-6aefbba6796d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 08:53, Helge Deller wrote:
> On 8/9/23 17:23, Richard Henderson wrote:
>> On 8/9/23 08:11, Helge Deller wrote:
>>> Fix a crash in qemu-user when running
>>>
>>>      cat /proc/self/maps
>>>
>>> in a chroot, where /proc isn't mounted.
>>>
>>> The problem was introduced by commit 3ce3dd8ca965 ("util/selfmap:
>>> Rewrite using qemu/interval-tree.h") where in open_self_maps_1() the
>>> function read_self_maps() is called and which returns NULL if it can't
>>> read the hosts /proc/self/maps file. Afterwards that NULL is fed into
>>> interval_tree_iter_first() which doesn't check if the root node is NULL.
>>>
>>> Fix it by adding a check if root is NULL and return NULL in that case.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> Fixes: 3ce3dd8ca965 ("util/selfmap: Rewrite using qemu/interval-tree.h")
>>>
>>> diff --git a/util/interval-tree.c b/util/interval-tree.c
>>> index f2866aa7d3..53465182e6 100644
>>> --- a/util/interval-tree.c
>>> +++ b/util/interval-tree.c
>>> @@ -797,7 +797,7 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
>>>   {
>>>       IntervalTreeNode *node, *leftmost;
>>>
>>> -    if (!root->rb_root.rb_node) {
>>> +    if (!root || !root->rb_root.rb_node) {
>>
>>
>> I guess this is good enough for 8.1.  Before the conversion to interval-tree we would 
>> also emit nothing.
> 
> Yes and yes.
> 
>> I've already done a rewrite for 8.2, and I noticed this problem.
>> There I emit what mapping information that I have, which is
>> everything except for the device+path data.
> 
> nice.
> 
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Shall I send a pull request?
> If so, is it OK that I include this patch in the pull-request as well?
>    linux-user: Fix openat() emulation to correctly detect accesses to /proc
>    https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg00165.html
> which already has been R-b: Daniel P. Berrangé

I can pick them both up -- I have other linux-user patches to send.


r~



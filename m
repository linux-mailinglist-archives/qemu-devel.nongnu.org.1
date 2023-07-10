Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492A74D453
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 13:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIomt-0002Yo-W2; Mon, 10 Jul 2023 07:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIomf-0002WQ-Po
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIome-0003TK-3O
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 07:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688987422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lL4leveNES7cuGkUELlahQzfDtYT8d+9g5K4SAa4zAA=;
 b=eRIjsLYt+HJRzH33HeO9aA5I/k6DflA/uXOzYA83psnbDovPIcJJdjE5cC/BeKMB2e+Xly
 YaT+/rsCg7fLPOxMv56h/NTAlyalhPRoe3dZ2owyDEpXnMr6BNkyS2ePsYePpDZoIivOl9
 XVFiV9zYbDpP9OsCk1XaeBs9uMxTBog=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-i1XIf1dxNEOhC8gQchW4ZQ-1; Mon, 10 Jul 2023 07:10:21 -0400
X-MC-Unique: i1XIf1dxNEOhC8gQchW4ZQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-400a5d66a5bso41254021cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 04:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688987421; x=1691579421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lL4leveNES7cuGkUELlahQzfDtYT8d+9g5K4SAa4zAA=;
 b=fptcxQQY5YqX1eOkon7Agx7RAPrUHF68cLkGwvNM0pXt6aj+yFZqjgPD4K6++Cc596
 q+ZfM36s6ctAWm2tjnDr112S/AW81KLuwxVk8WFePXOPpSWxbvLqWiD1OSt1mtO/Y+ML
 Byqqkx7Hu8bX0U8Jo2a0ZQYi6qeEdlWQGpZwQUOsIPzR2RkXCnX77o6qrs9LxgLCH2yZ
 wuCT9+aoPQ/CedDoiRbJ9ubnWhUJ73Vh+K/9CTgXrzq3w7qS2WiQHUx1uOz8G4s8oeK+
 jcbnKSz9t8e3hUaD98TpYI17DIgMepci3oyH4aGWTnbdXc0zCbHnilIxLk9xfg/3zOaL
 yYkw==
X-Gm-Message-State: ABy/qLYaX5K0+TK11rbLqtLINbV+1WUfU05rgvG2TSyt0rpXaqlWeQpC
 oeCOEMInV2fhz2FBhM0d4r+vBLz/ru0O787hRUcWn7r8C4B1Ntut09kXA371neYbNK+I5X6LJhO
 M8T7/egKTM8Z0n+k=
X-Received: by 2002:a05:622a:88:b0:403:b1d3:2d9d with SMTP id
 o8-20020a05622a008800b00403b1d32d9dmr1541203qtw.48.1688987421271; 
 Mon, 10 Jul 2023 04:10:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFvDn1QlM43DSIZvRSCzz8x3xp4ZlzSQ81Q1/cUN7bBGSSpQdEolZAuvHqooo7IohaCrdyhoA==
X-Received: by 2002:a05:622a:88:b0:403:b1d3:2d9d with SMTP id
 o8-20020a05622a008800b00403b1d32d9dmr1541188qtw.48.1688987420977; 
 Mon, 10 Jul 2023 04:10:20 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 z27-20020ac8431b000000b0040353ea0827sm4905162qtm.56.2023.07.10.04.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 04:10:20 -0700 (PDT)
Message-ID: <16a29e78-53e6-1fbb-1e90-4d289b821817@redhat.com>
Date: Mon, 10 Jul 2023 13:10:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: TCG broken on s390x hosts (was: [PULL 11/27] tcg/s390x: Support
 128-bit load/store)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <20230530185949.410208-12-richard.henderson@linaro.org>
 <f783a557-9d30-bdf4-e13f-b3edd405a012@redhat.com>
 <c179c192-ccd7-b217-be90-841eb735db62@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <c179c192-ccd7-b217-be90-841eb735db62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/07/2023 11.31, Richard Henderson wrote:
> On 7/10/23 09:58, Thomas Huth wrote:
>> On 30/05/2023 20.59, Richard Henderson wrote:
>>> Use LPQ/STPQ when 16-byte atomicity is required.
>>> Note that these instructions require 16-byte alignment.
>>>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   tcg/s390x/tcg-target-con-set.h |   2 +
>>>   tcg/s390x/tcg-target.h         |   2 +-
>>>   tcg/s390x/tcg-target.c.inc     | 107 ++++++++++++++++++++++++++++++++-
>>>   3 files changed, 107 insertions(+), 4 deletions(-)
>>
>>   Hi Richard!
>>
>> I think this patch broke something on s390x hosts. I currently
>> cannot run the BootLinuxS390X.test_s390_ccw_virtio_tcg avocado
>> test on a s390x host - it times out:
>>
>>   make check-venv
>>   ./tests/venv/bin/avocado run -t arch:s390x \
>>    tests/avocado/boot_linux.py:BootLinuxS390X.test_s390_ccw_virtio_tcg
>>
>> ... gets INTERRUPTED after the timeout expired.
>>
>> It used to work fine in the past, so I bisected the problem
>> and it seems like 4caad79f8d60a5df20ceed1c396724af745c9512
>> is the first bad commit. If I revert it on top of the master
>> branch, the test works fine again. Could you please have
>> a look?
>>
> 
> I have a patch already:
> 
> https://patchew.org/QEMU/20230707102955.5607-1-richard.henderson@linaro.org/

Hmm, either I'm doing something wrong, or this patch does not fix the issue 
yet - I applied it and the test still times out ...

  Thomas



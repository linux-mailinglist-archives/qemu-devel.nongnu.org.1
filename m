Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235A7971DB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDKf-00016Q-Gs; Thu, 07 Sep 2023 07:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeDKC-0000zM-Fq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeDK9-0002bh-Am
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694086644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kCVUSHAaoNdfu6EYfvddmbNEBHEyGVnH4OHsXNzpbo=;
 b=KQS5zeWc/M9xvKLoDRu2S4wg0QCybdnW2ewEJDn7gFIc5Z/Nyg8E4rMYaQIyK/A/8oVZkS
 8BeTGP7+Rj46V9P136wS9aTf3JPV8mR8fxhru/zYJbeGyG2x0KEfetRfHWKQuQq+V7eEWJ
 Wc/BZ6ETxWHVzpMYWIGYoagvBixQcho=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-yGXeUe5BNoi7yTkK5rCZOQ-1; Thu, 07 Sep 2023 07:37:22 -0400
X-MC-Unique: yGXeUe5BNoi7yTkK5rCZOQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f46ccee0fso831376f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694086641; x=1694691441;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kCVUSHAaoNdfu6EYfvddmbNEBHEyGVnH4OHsXNzpbo=;
 b=SuowpWvNhfV1YHA/X90I3aVVfORVLRqcLUML/bXJkSJSiEmqWEz7QqnKyF9/evkGYs
 auLqU3f+PIY/dmRJ4QU3RM+HKXk/EoyHNN9FZeRuW18KoT1BJ/afJ7m3t2Bt8JqM9GzQ
 h6/u5zHRyKK9a4Jmx46mx4oJ89U8Fvt8IWX5PwwaZR0RWeQcBGbYN7mcaUXg4wkVEB+E
 m//GO7Dv8AOHsdDC/spaRFM0Pmgx8XJz85PfUByXLw8coaQm97xrSQ9QqZJE73mMFiO9
 ba/KxDDf7djhXwStHqAs4gl6/Gw9BJRss/k12BXBC82gzpUHlGbzJIcAoJf3IFCClr8G
 GHvw==
X-Gm-Message-State: AOJu0Yw4z9P5N171jI/ewD25bjIiC+Rld/HwBmuaJOMVEVOMCPk9uxUa
 xec4X6VtApiRVTdpVjx595Ns4zkjnKvNPrYVJG0PqT5NrVejKMGVFm2PFwGKwt5j9pBmyFN5W18
 BZlW2rkmQuV8Bpqs=
X-Received: by 2002:adf:ed46:0:b0:30e:56b3:60fe with SMTP id
 u6-20020adfed46000000b0030e56b360femr1916070wro.4.1694086641558; 
 Thu, 07 Sep 2023 04:37:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRLevAbeDIb/W6ZGXe/y1sn+h1t8m+oXEyZJ8wbfo6pJhzLHFGwG0qpyGDHb1Jga5RbTa48w==
X-Received: by 2002:adf:ed46:0:b0:30e:56b3:60fe with SMTP id
 u6-20020adfed46000000b0030e56b360femr1916057wro.4.1694086641287; 
 Thu, 07 Sep 2023 04:37:21 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 e12-20020adf9bcc000000b0031759e6b43fsm19964066wrc.39.2023.09.07.04.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 04:37:20 -0700 (PDT)
Message-ID: <96673508-be8a-d26b-a731-fd07580086eb@redhat.com>
Date: Thu, 7 Sep 2023 13:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/3] hw/mips/jazz: Rework the NIC init code
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20230825175123.624114-1-thuth@redhat.com>
 <a9aa3e9e-dbde-54ed-1df0-749f483806f6@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <a9aa3e9e-dbde-54ed-1df0-749f483806f6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 01/09/2023 12.15, Michael Tokarev wrote:
> 25.08.2023 20:51, Thomas Huth wrote:
>> The NIC init code of the jazz machines is rather cumbersome, with
>> a for-loop around it that is always left after the first iteration.
>> This patch series reworks this a little bit to make the code more
>> readable and shorter.
>>
>> Thomas Huth (3):
>>    hw/mips/jazz: Remove the big_endian variable
>>    hw/mips/jazz: Move the NIC init code into a separate function
>>    hw/mips/jazz: Simplify the NIC setup code
> 
> Thomas, after comments for "hw/mips/jazz: Remove the big_endian variable",
> will you respin?

I've now sent a patch to clean up that ugliness with TARGET_BIG_ENDIAN first:

https://lore.kernel.org/qemu-devel/20230907113500.185276-1-thuth@redhat.com/

Once that has been accepted, I'll respin the other patches.

  Thomas



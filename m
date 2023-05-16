Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB827045ED
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyoqZ-0008HP-6B; Tue, 16 May 2023 03:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyoqS-0008FK-My
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:11:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1pyoqR-0004HB-22
 for qemu-devel@nongnu.org; Tue, 16 May 2023 03:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684221097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tO2prvN3NU9uTAFb+SfRwOhfvDICPfX7z/QQV4m654A=;
 b=Q5iXYX7UsoSS23JOCV61canp1WG6zupxaN7nW0AgaFFJ/jLmX1r/m/3LeQ4yDyM6b7pkQo
 2Pl1sBTEx0aUqZd2mHxdnXxdBnzJhLEXJQLuxvS4v7+O95rzuz5eXHJ+0uPngR4mahKnqV
 yx3uJmRx9r1T7AC1/ZzaJFsrDzgeZ9w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-I4I_pe6GPyiRJjFDB9B1Cw-1; Tue, 16 May 2023 03:11:36 -0400
X-MC-Unique: I4I_pe6GPyiRJjFDB9B1Cw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41dcf1e28so37758735e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 00:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684221095; x=1686813095;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tO2prvN3NU9uTAFb+SfRwOhfvDICPfX7z/QQV4m654A=;
 b=Gzz4LmrtsjbUApVA10D9jBFt3yQT/kmCRKop4AUHCr20oxrS1sns0rnEAeA/WNHcGZ
 WVH/FxjKic2kt1pIZnFH49w8dMml/N09zPzySxm+kvqE5hmIGjXxxPJMvWHze4cDrH+2
 CFPvNMsK+WpOlaJb/njT/BfJ2YnMvZgYbm080Z2GAKCNXatIxgPXLgfKdJAHqAIuFztw
 h1BRJLn5E9cBJiKR/2nujTcXGtGv2YhvZtX0+L9Og772NSinZa2tbmiautEPBcSEDlML
 0f0vqKmjC6cY2tDEg7Dq3uAzLeEvvRBT6IVONsk/15ahxVzZDFMzv6NZ46l76BYPADLB
 oEJw==
X-Gm-Message-State: AC+VfDxgxyZL2/v5YlvpMmqmkN1CpXufSeXXl5gOWR0Z2bItf4cAM4P2
 F3viWagPMZ5kQiXGsMn7IW6WucwjrPYg+tEi4qok+iPuivc+cRV5njAslzEcrcy/qDcDS+Uo28F
 nq7a36EBtgNc215Y=
X-Received: by 2002:adf:f7d1:0:b0:305:f2d5:34a6 with SMTP id
 a17-20020adff7d1000000b00305f2d534a6mr23011561wrq.16.1684221095337; 
 Tue, 16 May 2023 00:11:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cUoNpur7LIEDzbnPGKM/GiO2YVVqrjveGC6Rwb37qOCX9A/kB2tQAmIhbJjXZJGIyvJoB4Q==
X-Received: by 2002:adf:f7d1:0:b0:305:f2d5:34a6 with SMTP id
 a17-20020adff7d1000000b00305f2d534a6mr23011546wrq.16.1684221095029; 
 Tue, 16 May 2023 00:11:35 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-218.web.vodafone.de.
 [109.43.177.218]) by smtp.gmail.com with ESMTPSA id
 p3-20020adfe603000000b002e5f6f8fc4fsm1455577wrm.100.2023.05.16.00.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 00:11:34 -0700 (PDT)
Message-ID: <fd654751-edf4-7be0-ebe3-eb14bad994d8@redhat.com>
Date: Tue, 16 May 2023 09:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 00/21] Tests, docs, s390x and misc patches
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230515130233.418183-1-thuth@redhat.com>
 <5f7ffa1f-1c97-64f6-959b-52086b887fd5@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <5f7ffa1f-1c97-64f6-959b-52086b887fd5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.811, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/05/2023 22.53, Richard Henderson wrote:
> On 5/15/23 06:02, Thomas Huth wrote:
>>   Hi Richard!
>>
>> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
>>
>>    Merge tag 'or1k-pull-request-20230513' 
>> ofhttps://github.com/stffrdhrn/qemu  into staging (2023-05-13 11:23:14 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git  tags/pull-request-2023-05-15
>>
>> for you to fetch changes up to 055eb1d7de455ecb6b2f5f978b2d12529e09f795:
>>
>>    tests/tcg/s390x: Test EXECUTE of relative branches (2023-05-15 14:50:35 
>> +0200)
>>
>> ----------------------------------------------------------------
>> * Various small test updates
>> * Some small doc updates
>> * Introduce replacement for -async-teardown that shows up in the QAPI
>> * Make machine-qmp-cmds.c and xilinx_ethlite.c target-independent
>> * Fix s390x LDER instruction
>> * Fix s390x EXECUTE instruction with relative branches
> 
> This needs to be rebased after Juan's migration patches.  Something in the 
> #include simplification has caused multiple build errors, e.g.
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4288929197#L2526
> 
> ../migration/dirtyrate.c: In function ‘record_dirtypages’:
> ../migration/dirtyrate.c:68:24: error: invalid use of incomplete typedef 
> ‘CPUState’
>     68 |         dirty_pages[cpu->cpu_index].start_pages = cpu->dirty_pages;
>        |                        ^~

OK, should be easy to fix ... I'll send a v2.

  Thomas



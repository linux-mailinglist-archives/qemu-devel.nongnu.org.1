Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39D76624A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:08:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD8E-0008Dp-Sc; Thu, 27 Jul 2023 22:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD8B-0008D3-M1
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:23:03 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD85-0007IF-9O
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:23:01 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-267f8f36a3cso1022859a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510971; x=1691115771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HC4tFNhHZczwbhV85qMJ2ZRH+G4VuR03PcRHSdd2mw=;
 b=TGbJYEPLfJNsVC6PeWf+ffx1477H89S0Ag/EV6S42x+g+GeSGY61fdRjzSPC8u9v+X
 TdrBVIa/cRtZOkyQCRUvgYs51eouHXGp4SZxcahvAAfvUgBvcbbLX5DlX3qUs8Cm/pKW
 U1rpZvP0uct43n1cdBgvCp+Z7MDdOg5l5mRtnI9YLMarzCDPHSTlmCfTRxd+2aSafX7l
 cugGSYKZIFKxYHpBLK9DGsBvn9kUSI42iSA9F1z/SYCRSQJmJcvZthY+XXtmfCjCTWQc
 2o0js0bLmbeliavBFvwVP2axfaxioJZVwSZccSW9AQug9hKlsGwgJsJHxRM57yvbAXIv
 jGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510971; x=1691115771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2HC4tFNhHZczwbhV85qMJ2ZRH+G4VuR03PcRHSdd2mw=;
 b=fWA5T7Bm6aIat6IdD6zSe8cMyST05K9GuNe9YWUhm4Faim8mox0nfW1WsssglmOpIW
 4172mu+3p1qoq3UiP8/o6VLs6oqc+66pplpeC1bwnmnyjkUcPvDjNXh97xpi4jfDuJXd
 AiTAeaGSjRJK2cuZqfETKgOv/pfZssv4E9fLQZ3LFZSSZJUZZCPUbh9aAy7UYw1/wwbr
 uCa6Og9N0T6LSR1AJ5QHv5WJOnpVknGRs8AJA6q+lbIM+fEkHsYnJfZPPUXkiiolcckK
 yXzwqN49Rd0DbI6cPT0yR2IkKXCUt6EaTjUn3pagmQaJEuElKbWcNhxzrGa5PQOdp6IQ
 CV5Q==
X-Gm-Message-State: ABy/qLazI2m/U3r6+S+8JrBe+kvUQp1ax3AfD6iFdaR19r6Dh7bzLjDg
 q2jpmTpi2RxwjsnYa01/BjkycA==
X-Google-Smtp-Source: APBJJlGMPMxOj7ixxntjP+65u+nR+1vq9qsUi/VqAUcsAdxSLJzloxsoJMRDqgefgDGy2VPVz6vAGg==
X-Received: by 2002:a17:90a:3e84:b0:267:f7eb:f12e with SMTP id
 k4-20020a17090a3e8400b00267f7ebf12emr287843pjc.39.1690510970724; 
 Thu, 27 Jul 2023 19:22:50 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.5]) by smtp.gmail.com with ESMTPSA id
 p17-20020a170902ead100b001b80760fd04sm2320725pld.112.2023.07.27.19.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 19:22:50 -0700 (PDT)
Message-ID: <d1d0b1e0-6e37-a80b-3f23-1add5c833412@bytedance.com>
Date: Fri, 28 Jul 2023 10:19:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Re: [PATCH v4 9/9] block/throttle-groups: Use ThrottleDirection
 instread of bool is_write
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, berto@igalia.com, qemu_oss@crudebyte.com,
 groug@kaod.org, kwolf@redhat.com, qemu-block@nongnu.org, berrange@redhat.com
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
 <20230724100939.1022984-10-pizhenwei@bytedance.com>
 <3e164b63-9a9b-9139-2371-4421e2460ef1@redhat.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <3e164b63-9a9b-9139-2371-4421e2460ef1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pj1-x102c.google.com
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



On 7/28/23 00:12, Hanna Czenczek wrote:
> On 24.07.23 12:09, zhenwei pi wrote:
>> 'bool is_write' style is obsolete from throttle framework, adapt
>> block throttle groups to the new style.
>>
>> Use a simple python script to test the new style:
>>   #!/usr/bin/python3
>> import subprocess
>> import random
>> import time
>>
>> commands = ['virsh blkdeviotune jammy vda --write-bytes-sec ', \
>>              'virsh blkdeviotune jammy vda --write-iops-sec ', \
>>              'virsh blkdeviotune jammy vda --read-bytes-sec ', \
>>              'virsh blkdeviotune jammy vda --read-iops-sec ']
>>
>> for loop in range(1, 1000):
>>      time.sleep(random.randrange(3, 5))
>>      command = commands[random.randrange(0, 3)] + 
>> str(random.randrange(0, 1000000))
>>      subprocess.run(command, shell=True, check=True)
>>
>> This works fine.
>>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   block/throttle-groups.c         | 105 ++++++++++++++++----------------
>>   block/throttle.c                |   8 +--
>>   include/block/throttle-groups.h |   6 +-
>>   3 files changed, 60 insertions(+), 59 deletions(-)
>>
>> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
>> index 3847d27801..c7c700fdb6 100644
>> --- a/block/throttle-groups.c
>> +++ b/block/throttle-groups.c
> 
> Thanks a lot!  The changes done look good, and I think they’re nice.
> 
> There are some functions left untouched, though, which I think should 
> use ThrottleDirection, too:
> 
> throttle_group_register_tgm() should use THROTTLE_READ/THROTTLE_WRITE to 
> index tgm->throttled_reqs[] (instead of 0/1).  It also has a `for (i = 
> 0; i < 2; i++)` loop over tg->tokens[], which probably should use 
> THROTTLE_MAX as the upper limit, or iterate over a ThrottleDirection 
> variable altogether (as you’ve done it in patch 3 e.g. for 
> throttle_timers_attach_aio_context()).
> 
> throttle_group_unregister_tgm() has such a loop, too (over 
> tgm->pending_reqs[], tgm->throttled_reqs[], 
> tgm->throttle_timers.timers[], and tg->tokens[], all of which are arrays 
> over ThrottleDirection).
> 
> throttle_group_detach_aio_context() also has both the indexing “problem” 
> (integers instead of THROTTLE_* for tgm->pending_reqs[] and 
> tgm->throttled_reqs[]) and such a loop.  There, the loop probably really 
> should be over a ThrottleDirection variable, because it passes that 
> variable to schedule_next_request().
> 
> throttle_group_restart_tgm() also has such a loop, it uses that variable 
> to index tgm->throttle_timers.timers[], and passes it to both timer_cb() 
> and throttle_group_restart_queue().
> 
> read_timer_cb() and write_timer_cb() should call timer_cb() with 
> THROTTLE_READ/THROTTLE_WRITE instead of false/true.
> 
>> diff --git a/include/block/throttle-groups.h 
>> b/include/block/throttle-groups.h
>> index ff282fc0f8..2355e8d9de 100644
>> --- a/include/block/throttle-groups.h
>> +++ b/include/block/throttle-groups.h
> 
> [...]
> 
>> @@ -78,7 +78,7 @@ void throttle_group_restart_tgm(ThrottleGroupMember 
>> *tgm);
>>   void coroutine_fn 
>> throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
>>                                                           int64_t bytes,
>> -                                                        bool is_write);
>> +                                                        
>> ThrottleDirection direction);
> 
> block/block-backend.c calls this function in 
> blk_co_do_p{read,write}v_part(), those calls need to be adjusted, too.
> 
>>   void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
>>                                          AioContext *new_context);
>>   void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
> 

Sorry, I missed these. Please see the v5 version. Thanks!

-- 
zhenwei pi


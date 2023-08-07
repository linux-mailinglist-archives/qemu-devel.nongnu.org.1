Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60417717C5
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 03:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSoxu-0004MQ-V8; Sun, 06 Aug 2023 21:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSoxs-0004MF-DM
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 21:23:21 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSoxq-0006Lj-Um
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 21:23:20 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-564af0ac494so1820648a12.0
 for <qemu-devel@nongnu.org>; Sun, 06 Aug 2023 18:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691371397; x=1691976197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9aGe9MRcpYZzEPz8OX+uGn+CKPx7+xmyVgzMOZdJSyI=;
 b=sJmqwGKG8hLr6s/b3gk4tnqLCJwgmJ+o7qtozdRk/FhAWqwDJoQ3TXnw6cqD0dJdGy
 z6Bet8JRW55Hr48VBYorFNwicwbmyQOwrc17iWQo6lWch4lvxhvJr4b/eFSf13tflrRZ
 4gFICAwN+Et8wTqk8ciy915eNiot4xYI+cMypcmZ4VPl/VDeJXx3LY5OeiOYXwAJfOXm
 8QpO+4HazKvKHCD+W2QkD7wBCP9TlFGU7UyvgINT/OxTIDLBQxkMko8WBS3OQjDA3TgI
 aA6DpXH4Miu2HXx5jbTFyIseRJBRWWdb01vntqEPeFMH2CEfyWlpUhYSSKAfVuebf5Lg
 /3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691371397; x=1691976197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9aGe9MRcpYZzEPz8OX+uGn+CKPx7+xmyVgzMOZdJSyI=;
 b=CgUNcxTf9DoeHvIlP2Dc6Kxaeoi1pa2Qu4liQ5VjEIDs5EP4l3+vhGg6rB+1Rif5cB
 SDU6zPp6OIQPPBu8zEN77z/TZUqKdHv4fN1W9cuh1b+WP70vFT1UM5EV+Tv1SP4wQmYc
 3AMeip+CgxwQfZuW5ymRGAVt2wy1pVAz0tq0rQblcq++C5ox8AlRya9DzcD7ZDztnBvO
 28PcpSeOV6HOmMiXo1QizQnCQyHw9eCXc657e4NKyn1Nyl6G85K3S5C+FLkYwLL04BxI
 VKv/8kKLPgiWlxLmBJO6j6+26K7yW7x+bXjZD1FIcgxEQZAo6JEObQtvb/GuNbQaTrWR
 rUxg==
X-Gm-Message-State: AOJu0Yz8DTBI9B0ND1wUGtgGmO3/TeIT+iwZiuhrJeDEaZX990ONkRjP
 zDpmdftidA75sFpCfHtctm1Ipg==
X-Google-Smtp-Source: AGHT+IH/nW0E1CD24GYzppeoAvIX0r4Jdn0woQNpx1iHrWc+XnrKw1WbcnV2XsXOhvSrwZ8DjkSi/g==
X-Received: by 2002:a05:6a20:2451:b0:137:e595:830f with SMTP id
 t17-20020a056a20245100b00137e595830fmr8227273pzc.57.1691371397519; 
 Sun, 06 Aug 2023 18:23:17 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:aa8f:d2aa:4d57:4d3c?
 ([2602:47:d490:6901:aa8f:d2aa:4d57:4d3c])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bbd8cf6b57sm5430387plc.230.2023.08.06.18.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 18:23:17 -0700 (PDT)
Message-ID: <36b163ff-594d-f38d-f69a-703220431666@linaro.org>
Date: Sun, 6 Aug 2023 18:23:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 07/24] linux-user: Do not call get_errno() in do_brk()
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Helge Deller <deller@gmx.de>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <20230806033715.244648-8-richard.henderson@linaro.org>
 <2b3f3769-a047-374b-4609-a7add8737f30@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2b3f3769-a047-374b-4609-a7add8737f30@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.139,
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

On 8/5/23 23:53, Michael Tokarev wrote:
> 06.08.2023 06:36, Richard Henderson wrote:
> 
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
> 
>> -        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
>> -                                        PROT_READ|PROT_WRITE,
>> -                                        MAP_ANON|MAP_PRIVATE, 0, 0));
>> +        mapped_addr = target_mmap(brk_page, new_alloc_size,
>> +                                  PROT_READ|PROT_WRITE,
>> +                                  MAP_ANON|MAP_PRIVATE, 0, 0);
> 
> Can't we add spaces around "|" here at apply time to make checkpatch happy?
> Just a nitpick really..  I thought this will be done in some of the Vn,
> but it is not.

Since I had to re-spin, I did so.


r~



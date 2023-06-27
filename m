Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C906173F3EE
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 07:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE1FI-0004GP-Ew; Tue, 27 Jun 2023 01:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE1F7-0004Ft-Qf
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 01:27:57 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE1F5-0006Lj-2N
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 01:27:57 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6687096c6ddso2029230b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687843670; x=1690435670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDs4epmdppMC6/ESsY2p75c6fCIsSHDos2liM9u3poQ=;
 b=KgvgI7i3wnF5bDugNdHmadLq5O58A+iMT6shvkNoJistocJ0uip2tj1qYTDI2F4TN+
 z3HxJ/XSubU+zzewHGjlxTuTYWEJSfZnMPyjmR6eBndzIJxPBoxc0h3XkWAdeprmH7AV
 YNyfsY43Oz17Jm6tYgYD8XuCrgLnpowld6xmb+7dTXnCLb2h6Ps7ELNY099zfT7l11fb
 CsPhurP1sE/A1VAaa7UuxLXY8KcJhRMmfAmNHACtqRNZkB9y/Pc4h2FVZMvKU1oaqEYi
 LP+u5NImiBeE5t3aWBSWIcLmDhaGjBEpLtIjfZJuh8aiFaeBsDk2b+r1VdcLWOnR/2yP
 hK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687843670; x=1690435670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDs4epmdppMC6/ESsY2p75c6fCIsSHDos2liM9u3poQ=;
 b=kG2i1BhObwsKymYQNKf67kWpCra9ssxtz2xIxKv/xAJOluDgRFn0x/XDqUZuF6rOyj
 Kezx5wnoBdKVY16mQxe/02zgneVBxyGE1862hmKMVIl1Sh1fj20HcHZyCZM9KjdZFOWB
 kn7oDAZSGFh6kkemTZcVPv0qVS8f7ERp1x1L1mYy6kpRV5nrvA+l0iA57PFl0RbgXVnC
 fmF49AnlmCXXX8DiiRKGCMKEYT9FHUAuKf0XeMUmJtmgufT9UyRvAmWsPU3pJFAE6CEg
 b/OBmRG4xXxwug6z3QUg1XgbgD5qBeeRNqTnJ949iZPAEH2/1OwGXERKfVHLG+T3ajsu
 qRzA==
X-Gm-Message-State: AC+VfDyjo38WcguU3zKMum3V5acEBWl+CGFMB2K9ma/HaN07Rjs9AlU3
 chq+3oKA+cYbDyDNVgzC0+K+eouX4I7snSjg6Yo=
X-Google-Smtp-Source: ACHHUZ6n/woMVMQLfuz4la95ZoC3WuepNLuCcFaenNijYj/lu2ifA2MIKQVn7zu+dFvhO1MpvxDgwA==
X-Received: by 2002:a05:6a00:2382:b0:668:8703:a5d4 with SMTP id
 f2-20020a056a00238200b006688703a5d4mr20745376pfc.31.1687843669995; 
 Mon, 26 Jun 2023 22:27:49 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 q28-20020a635c1c000000b00548d361c137sm4894383pgb.61.2023.06.26.22.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 22:27:49 -0700 (PDT)
Message-ID: <3d1a4195-1a99-5e5c-cd58-78f32c7df126@bytedance.com>
Date: Tue, 27 Jun 2023 13:25:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Re: [PATCH 3/5] throttle: support read-only and write-only
Content-Language: en-US
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
 <20230625085631.372238-4-pizhenwei@bytedance.com>
 <w51mt0l52gg.fsf@igalia.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <w51mt0l52gg.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 6/27/23 05:38, Alberto Garcia wrote:
> On Sun 25 Jun 2023 04:56:29 PM +08, zhenwei pi wrote:
>>   void throttle_timers_attach_aio_context(ThrottleTimers *tt,
>>                                           AioContext *new_context)
>>   {
>> -    tt->timers[THROTTLE_TIMER_READ] =
>> -        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
>> -                      tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
>> -    tt->timers[THROTTLE_TIMER_WRITE] =
>> -        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
>> -                      tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
>> +    if (tt->timer_cb[THROTTLE_TIMER_READ]) {
>> +        tt->timers[THROTTLE_TIMER_READ] =
>> +            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
>> +                          tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
>> +    }
>> +
>> +    if (tt->timer_cb[THROTTLE_TIMER_WRITE]) {
>> +        tt->timers[THROTTLE_TIMER_WRITE] =
>> +            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
>> +                          tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
>> +    }
>>   }
> 
> If now any of the timers can be NULL, don't you want to add additional
> checks / assertions to (at least) throttle_schedule_timer() ?
> 
> Berto

OK.

-- 
zhenwei pi


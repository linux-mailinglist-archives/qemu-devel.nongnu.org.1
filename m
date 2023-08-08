Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC37774EBC
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 00:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTVcY-0004gI-3h; Tue, 08 Aug 2023 18:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTVcW-0004fg-1n
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:56:08 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTVcU-0007fx-9w
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 18:56:07 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686b9964ae2so4525544b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691535365; x=1692140165;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rDkuNfRqITiq70RneEW6j8D8G6FxUFoirkYkFqgGAGg=;
 b=TFsdVJud8ONcYFMnxkYFEFCkYj1IWAucgPbXqqbLGiG7hIxMEv+GRylsl4b9jg00S7
 b/3pjoKSL3zqLnLkuspOV1mUFrbE7StOgOpX8qpNwDrXdeIgcw5rDk6wv3Jz1v+037v7
 871KcZU9STkc2xcopB/M0rr+ZyWHzpfRzVh/LoTJVdBzbogr6Z5ZLvoJJ9mFmYm2Hx+x
 JmLDZBoVlEdYkERmyV/B7OribGcpniJIh6STdawYmT7LIzj+hovssNQmIvMrwmwbwVWZ
 ikc8oJ72b20Z5k5al0n/HipnWftVWt4oidRdF1ZkQ+S/RaKOml9g7yB9crGKbZdSd5Jx
 DIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691535365; x=1692140165;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rDkuNfRqITiq70RneEW6j8D8G6FxUFoirkYkFqgGAGg=;
 b=ajBg5kvcktfZwXCRdhgS1J4d9KHnz6Zf2NynffMWv1kEJgghElDH78f/NYxOuvcZsk
 SRzEC6D9KKxR6VcktiTYsQtNx1Dz3OMv6++JbqxxIACCLE/M02YiD92gV39OPhX/OaYq
 hzzb1JiE4cKKZRJB3BUcEEvKuTGT8UzGWougy+rh5wdLXiNfqfhHTzhQmXJyggINhnkx
 jyE69NglhioLB+Cop861oMWcKB/F63lyBGPafwwnx3vEZc1EbPGmY9BUxYoTU4OnwI0A
 CDuFGhznTQfBxNUWw5vTwqvwswk+RxVhfgEPma950Jk2yMRnLA9MgE6+FC0sgCbc377+
 Itlg==
X-Gm-Message-State: AOJu0YxJUGpBnaCt5+K/2ZnF1ad89TKB6PuGf0C2+A1MckK2DU5eGln+
 HHX/Q93daUzAi7/HXLbC3fu6lw==
X-Google-Smtp-Source: AGHT+IF7wj6ivOMG00+kCHSe51nfRSrcnwRP45RXsG+OF5RpZC0shY/Hniwvn5YNiSHaZBJg1vN0/g==
X-Received: by 2002:a05:6a20:8f09:b0:132:cd2d:16fd with SMTP id
 b9-20020a056a208f0900b00132cd2d16fdmr1063691pzk.38.1691535364710; 
 Tue, 08 Aug 2023 15:56:04 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a170902d48700b001bb9b87ac95sm9585555plg.103.2023.08.08.15.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 15:56:04 -0700 (PDT)
Message-ID: <853e1f7b-f626-8a1b-d0bf-bdc1b4ebf05e@linaro.org>
Date: Tue, 8 Aug 2023 15:56:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] gdbstub: Fix client Ctrl-C handling
Content-Language: en-US
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>, npiggin@gmail.com
Cc: alex.bennee@linaro.org, fbarrat@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, bcain@quicinc.com
References: <CTZTUVQXKUGA.11SSOS1KIFLZK@wheely>
 <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <456ed3318421dd7946bdfb5ceda7e05332da368c.1690910333.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/1/23 11:40, Matheus Tavares Bernardino wrote:
> Hi, Nick.
> 
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> On Tue Jul 11, 2023 at 9:03 PM AEST, Matheus Tavares Bernardino wrote:
>>>> Nicholas Piggin <npiggin@gmail.com> wrote:
>>>>
>>>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>>>> index 6911b73c07..ce8b42eb15 100644
>>>> --- a/gdbstub/gdbstub.c
>>>> +++ b/gdbstub/gdbstub.c
>>>> @@ -2051,8 +2051,17 @@ void gdb_read_byte(uint8_t ch)
>>>>               return;
>>>>       }
>>>>       if (runstate_is_running()) {
>>>> -        /* when the CPU is running, we cannot do anything except stop
>>>> -           it when receiving a char */
>>>> +        /*
>>>> +         * When the CPU is running, we cannot do anything except stop
>>>> +         * it when receiving a char. This is expected on a Ctrl-C in the
>>>> +         * gdb client. Because we are in all-stop mode, gdb sends a
>>>> +         * 0x03 byte which is not a usual packet, so we handle it specially
>>>> +         * here, but it does expect a stop reply.
>>>> +         */
>>>> +        if (ch != 0x03) {
>>>> +            warn_report("gdbstub: client sent packet while target running\n");
>>>> +        }
>>>> +        gdbserver_state.allow_stop_reply = true;
>>>>           vm_stop(RUN_STATE_PAUSED);
>>>>       } else
>>>>   #endif
>>>
>>> Makes sense to me, but shouldn't we send the stop-reply packet only for
>>> Ctrl+C/0x03?
>>
>> Good question.
>>
>> I think if we get a character here that's not a 3, we're already in
>> trouble, and we eat it so even worse. Since we only send a stop packet
>> back when the vm stops, then if we don't send one now we might never
>> send it. At least if we send one then the client might have some chance
>> to get back to a sane state.
> 
> I just noticed now (as I was integrating the latest upstream patches
> with our downstream qemu-system-hexagon) that this causes the
> gdbstub-untimely-packet tcg test to fail.
> 
> My first thought was that, if 0x3 is the only valid case where we will
> read a char when the cpu is running, perhaps not issuing the stop-reply
> isn't that bad as GDB would ignore it anyways. E.g. from a `set debug
> remote 1` output:
> 
>    Sending packet: $qSupported:multiprocess+;swbreak+;hwbreak+;qRelocInsn+;
>                     fork-events+;vfork-events+;exec-events+;vContSupported+;
> 		   QThreadEvents+;no-resumed+;
> 		   xmlRegisters=i386#6a...
>    Packet instead of Ack, ignoring it
> 
> So, perhaps, we could do:
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index f123b40ce7..8af066301a 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -2055,8 +2055,9 @@ void gdb_read_byte(uint8_t ch)
>            */
>           if (ch != 0x03) {
>               warn_report("gdbstub: client sent packet while target running\n");
> +        } else {
> +            gdbserver_state.allow_stop_reply = true;
>           }
> -        gdbserver_state.allow_stop_reply = true;
>           vm_stop(RUN_STATE_PAUSED);
>       } else
>   #endif
> -- >8 --
> 
> Alternatively, since GDB ignores the packet anyways, should we just let
> this be and refactor/remove the test?

Ping, Alex and Nick.

I can confirm that Matheus' patch fixes the problem I am seeing.
But I'm also open to removing the test.


r~



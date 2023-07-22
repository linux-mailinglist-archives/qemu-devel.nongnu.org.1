Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470C175DE09
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 20:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNH4V-0002ic-3U; Sat, 22 Jul 2023 14:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qNH4T-0002iG-4w; Sat, 22 Jul 2023 14:11:13 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qNH4R-0006or-My; Sat, 22 Jul 2023 14:11:12 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b9c57c4d12so2525357a34.1; 
 Sat, 22 Jul 2023 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690049469; x=1690654269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jc51zulEpLAYWxsFJZO4jgk+o0SF/GRPvL5oAh/xg9M=;
 b=BOzZHwyIxiw1Lnx+JUSZJE34lE69RocuGDX4GTwTBJIoNwDMijwL0j3Tju0pBTngU5
 GKo4QpjCS/hw/TZ8/1THucnmQ4jZLdwiMCMU92HBD2IwTTZuyEyy8aDyfemk8dpuydo2
 9KEfIgjiEnrKmVCty6s1thgur2GOF/KREiXbrRYohwOHrUkggDXgHjms77xEUR1I35sX
 lySSwIz8kmi9PfSZNlQBpauuVY0thU2arxvq6mib4IkNWeIWWe7To4EioRmnS2EeBANf
 GGIIF13TQi9WL+TnxYfDcl3pz8T7NSBbQyU1/PXut08j5gwgJgoQR9nSRtkISw5p2MpV
 gMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690049469; x=1690654269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jc51zulEpLAYWxsFJZO4jgk+o0SF/GRPvL5oAh/xg9M=;
 b=P4BEv6d+UqgezDSDKEFxxa7gwi4jjgSRDJITfHE+QHHNM0Ee/AcLubLNxjY0hmB/5K
 53ZZfiB5bwVcLYTagnDUuKj74U/B4f0P+3V1YOC+z52EFAnyJVzUMa+029CBct/Kq94x
 VcPOpCCZQIhR4p+oK+8R/Q6HmOm7UO6Qn/sDb88i8WGoO0ajKZ1RhUOlRO7LmuxXljvH
 k6Y5LDBloY85ZktKuzPK5GnWxkHh+ta8joQXf1t9G7eslM/QCOroY7YhXvU962BzICGx
 dBy4Ik1Bq6yoZ/HHngLDnyry0IFgvnlvewzh3sOzVkq3Gswn69dcoUT7Dcber8TOxwow
 6UAA==
X-Gm-Message-State: ABy/qLaQ8kbtuVCvnBs+/LR1tYwoGgg1fEx3OuGImybMRIUdhnKptJtD
 KLR1XKTciTWTaQzFDCLIH3M=
X-Google-Smtp-Source: APBJJlF6HRQZOuMDbDgELhR/xnQZxLdXOx61LIrv/EDnmw/f8cH8UURaFt6iODf3AC9Ea6TG39TqUw==
X-Received: by 2002:a05:6870:c110:b0:1a6:4f6a:8a72 with SMTP id
 f16-20020a056870c11000b001a64f6a8a72mr7864538oad.37.1690049469429; 
 Sat, 22 Jul 2023 11:11:09 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-211.dial-up.telesp.net.br.
 [201.69.66.211]) by smtp.gmail.com with ESMTPSA id
 m2-20020a056870194200b001a2f7ca6183sm2680926oak.38.2023.07.22.11.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Jul 2023 11:11:09 -0700 (PDT)
Message-ID: <dcb027a3-a41a-eca5-0501-1da68c1010a2@gmail.com>
Date: Sat, 22 Jul 2023 15:11:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] pegasos2 fixes for 8.1
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <cover.1689725688.git.balaton@eik.bme.hu>
 <e3eee7ac-a6f8-4643-4600-845d6718e1d4@gmail.com>
 <960ab00b-23b9-e1ee-4929-db87fab43e46@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <960ab00b-23b9-e1ee-4929-db87fab43e46@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 7/21/23 19:17, BALATON Zoltan wrote:
> On Fri, 21 Jul 2023, Daniel Henrique Barboza wrote:
>> On 7/18/23 21:32, BALATON Zoltan wrote:
>>> These are some small fixes when using pegasos2 with the QEMU built in
>>> VOF instead of the non-free board firmware that fix bugs in the
>>> generated device tree and matches the board firmware in the reset
>>> state of on-board USB devices. This fixes booting AmigaOS with VOF and
>>> only touches parts that are used with VOF only so I'd like these to be
>>> merged for 8.1.
>>
>> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>
>>
>> And pushed to ppc-next. Thanks,
> 
> Thank you. I've just sent another similar one I've found later so was missed from this series but I hope this can still get in. This should be the last one from me for 8.1 now, sorry for sending it so late.

It's fine. It's still a good time to push this kind of fixes. I'll take
a look at that one.


Daniel

> 
> Regards,
> BALATON Zoltan
> 
>> Daniel
>>
>>>
>>> Regards,
>>>
>>> BALATON Zoltan (3):
>>>    ppc/pegasos2: Fix reset state of USB functions
>>>    ppc/pegasos2: Fix reg property of ROM BARs
>>>    ppc/pegasos2: Fix naming of device tree nodes
>>>
>>>   hw/ppc/pegasos2.c | 18 +++++++++++++++++-
>>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>
>>


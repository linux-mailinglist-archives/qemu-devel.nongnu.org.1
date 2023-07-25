Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E9B76191B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:00:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHd8-0004Cf-RM; Tue, 25 Jul 2023 08:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHd0-0004Bf-UE
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:59:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHcy-0007yg-32
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:59:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso45338995e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690289938; x=1690894738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vJPGB3AV5yoZuguJAzSCy1WoCDOdY+bQF3RyHqPh/zA=;
 b=rsW06PAd5MBKLkDachoc9NNHrfvwGq0dMONjdK9/XH0+TjeRo9fxD0zbOLsPD3oNdV
 m31ok7BT432GS1UPJZBJFZN3degOZvvuDARLc5ifbJAG0/n7AUDMMq3QizMQP3RTJGbq
 E5RVgkO1b5ANNNI+LUOD5pj9RQR0iW5XUFYHdpBlvp1HzU7KsIgyZN/1tDfyPU93g2Yo
 PKSGJBRB+0bi7DY1SbTN28y7z9zqGv+fml/vd2QJUPubUKt5tntS7o4Dd/hewJOLUNAl
 UWcy+aChBXfCC3WTF7B+BynLDPAfyJx6badPC4rR7iwv3M9vic4A5dtE6QYj2z7HjcTB
 V+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690289938; x=1690894738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJPGB3AV5yoZuguJAzSCy1WoCDOdY+bQF3RyHqPh/zA=;
 b=EPMDUvUo80LCdGfSgiZcP0oA26uXmKUjOv9qbntQ2oMm/fsIiOsTvTLhoiKRiUqijh
 MGmBe8z0i/hSz3P4ca3mMpaf5wiXaGKVUCMyOj1wf49Edd7Pgd9hJk+vTG+5W6mNmGHg
 iAULh3LvJ2CFZLbgVCeh/FRPbwz/iAsS+wf3hz+/+sjbTYm1ZL+Prq5OEDhnQhiey7JO
 08EMLex42VwK8tgw6Ucdk1LUEyyC3+4m8vNNdK3kqMF0bkQJX+x4SBnRN3tZ0k6cjCbD
 lO/sEM7+d956VLq0HsJ+KYfcEHBGPgQcfnuwzCSKMMCeuS7iCHfh2jqmDGTYSut8Akwf
 sY9g==
X-Gm-Message-State: ABy/qLahE8RURMit8Y5+0tjPbTBxAJMogYjzZxB2mB17VXzZTXMsegQ4
 ff1KJtjfr7O7xqWfPpLF1U7bWA==
X-Google-Smtp-Source: APBJJlEGjYEFj3lfz8rp4OL+lfZs/JDXteDhCVbrZTgsFZGoq8SbYDlJ1gFwieHN6yRyo95KaV8CLg==
X-Received: by 2002:a1c:f30b:0:b0:3f7:e3dd:8a47 with SMTP id
 q11-20020a1cf30b000000b003f7e3dd8a47mr9324357wmq.11.1690289938131; 
 Tue, 25 Jul 2023 05:58:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adff70f000000b003143ba62cf4sm16154807wrp.86.2023.07.25.05.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 05:58:57 -0700 (PDT)
Message-ID: <b58779ed-cecb-824b-019e-bc34e6b2258a@linaro.org>
Date: Tue, 25 Jul 2023 14:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/8] misc AHCI cleanups
Content-Language: en-US
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
References: <20230609140844.202795-1-nks@flawful.org>
 <ZLe/VG5d6TEdp/MT@x1-carbon>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZLe/VG5d6TEdp/MT@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Niklas, John, Paolo, Kevin,

On 19/7/23 12:47, Niklas Cassel wrote:

>> Niklas Cassel (8):
>>    hw/ide/ahci: remove stray backslash
>>    hw/ide/core: set ERR_STAT in unsupported command completion
>>    hw/ide/ahci: write D2H FIS when processing NCQ command
>>    hw/ide/ahci: simplify and document PxCI handling
>>    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>>    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>>    hw/ide/ahci: fix ahci_write_fis_sdb()
>>    hw/ide/ahci: fix broken SError handling
>>
>>   hw/ide/ahci.c             | 112 +++++++++++++++++++++++++++-----------
>>   hw/ide/core.c             |   2 +-
>>   tests/qtest/libqos/ahci.c | 106 +++++++++++++++++++++++++++---------
>>   tests/qtest/libqos/ahci.h |   8 +--
>>   4 files changed, 164 insertions(+), 64 deletions(-)
>>
>> -- 
>> 2.40.1
>>
>>
> 
> Hello Philippe,
> 
> Considering that you picked up my patch,
> "hw/ide/ahci: remove stray backslash" (patch 1/8 in this series),
> and since John seems to have gone silent for 40+ days,
> could you please consider taking this series through your misc tree?

(First patch was a cleanup)

Niklas, I don't feel confident enough :/

John, Paolo, Kevin, do you Ack?

Regards,

Phil.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B137DBA81
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:20:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSAr-0005Hk-1y; Mon, 30 Oct 2023 09:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxSAp-0005HA-4f
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:19:19 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxSAn-0002Jc-H2
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:19:18 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507c8316abcso6236198e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698671955; x=1699276755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RyyPuK+FAJdGXmTlaXtkH2FOXEs442gdHVrmmw4EflQ=;
 b=HUT/ZDlIM3YwHuFJv0ncwiT7r6whl8z5bfPV68ohY2kezlXYrnw76Cz4vWIycC7DU0
 GE4aikad2OuTnzrhE7DfNBnnIGRkxX+Ed/bBOOJjk3yRbHF1hUjYuSTaWB4mshr04Saj
 nAt65nhQtt7iCfQOgW2op1PEXOfl99gaJpK9+7XIXhJpr6ZM5wxobmirNNRMNivspDY6
 B4bkzvCYMPZwoLn00q/HE+fVopQKmbbb8aCVVvX2ZZnr60ZooOryXGcQhzNTJJToAwvy
 N9/wCG/FhmbnUHQJqTybQ4jBoMO4vZZ20g2XVEoylfbegWKI8XVV9hbAaM5+74Hrpl15
 EnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698671955; x=1699276755;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RyyPuK+FAJdGXmTlaXtkH2FOXEs442gdHVrmmw4EflQ=;
 b=H0mIRXUUaoQb8fJUWwnpICqkqgufuZWMJkA2RY5X0lIN+A+h933uc9AH5Y4/SG9Z+9
 fmtSSWrZ1qBsmWGIK7S2W04ytLtjOl68nYHQTFDpps3nUVyVKUdULZ5GwuJ92UjCkgsw
 9FNupn7HHJDQzpQ+/TP/knEyPKLvzHSxFRjoUNbrpgFKG3iultzxU77+ySv3bhLngA9z
 Cf6gzyGIcHMFSbpShQp6QHtgEYCVnX8U21c3BPCIxf9WHsIBR+ZLEMpFB0gbaa82rAHP
 Uv5+Y9S5wLAsZzXcX1BYE2J/YYPu2ZYtQn+yfb0ZPk886j1AHuP65J86cb07L2jhS4Rl
 La4Q==
X-Gm-Message-State: AOJu0YwJVYiN2ZQfjkeBJGZUS72lWKg+wbPn/zc3Yd1PQAfHTJZsJpHD
 Us18fxXYLOuigqj5BeAPzSfo5w==
X-Google-Smtp-Source: AGHT+IG6KTQPO2GxKZtQetsQ3qMotIcTKCFjamFBdW8sEH8SjVG6FI1Vv+5ja+bRcZ/Bo/Inc0GZgQ==
X-Received: by 2002:ac2:53ab:0:b0:507:ce2f:8f0c with SMTP id
 j11-20020ac253ab000000b00507ce2f8f0cmr7251488lfh.35.1698671955347; 
 Mon, 30 Oct 2023 06:19:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 x11-20020adfffcb000000b003258934a4bcsm8258001wrs.42.2023.10.30.06.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 06:19:14 -0700 (PDT)
Message-ID: <10dd79ff-e5d3-cf91-d7f5-acddfe99b1f6@linaro.org>
Date: Mon, 30 Oct 2023 14:19:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] arm/stellaris: convert gamepad input device to qdev
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <f9bdd29e-208c-3df1-d377-ce2619655d68@linaro.org>
 <CAFEAcA8bt310iLHT_A2zKLc7+mJ=uHwYQR9Fn7r3ZEX+bPW3Hg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8bt310iLHT_A2zKLc7+mJ=uHwYQR9Fn7r3ZEX+bPW3Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.441,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/10/23 12:29, Peter Maydell wrote:
> On Mon, 30 Oct 2023 at 10:39, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 17/10/23 14:22, Peter Maydell wrote:
>>> (I had this all ready to go before I went off on holiday two
>>> weeks ago, except I forgot to actually *send* the emails...)
>>>
>>> This patchseries converts the stellaris board's gamepad input device
>>> to qdev. This isn't a very important bit of conversion (I was just
>>> looking for a small tail-end-of-the-week task), but it does reduce by
>>> one the number of users of a couple of legacy APIs: vmstate_register()
>>> and qemu_add_kbd_event_handler().
>>>
>>> I've included Kevin's qdev_prop_set_array() patch here, because I
>>> wanted an array property and it doesn't seem sensible to write it the
>>> old way and have another thing that needs converting. I'm assuming
>>> that by the time this patchset gets reviewed and committed that
>>> one will already be upstream.
>>>
>>> thanks
>>> -- PMM
>>>
>>> Kevin Wolf (1):
>>>     qdev: Add qdev_prop_set_array()
>>>
>>> Peter Maydell (5):
>>>     hw/input/stellaris_input: Rename to stellaris_gamepad
>>>     hw/input/stellaris_gamepad: Rename structs to our usual convention
>>>     hw/input/stellaris_gamepad: Remove StellarisGamepadButton struct
>>>     hw/input/stellaris_input: Convert to qdev
>>>     hw/input/stellaris_gamepad: Convert to qemu_input_handler_register()
>>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks. I actually have a v2 of this ready but am waiting on a decision
> about whether the qdev_prop_set_array() API is OK before I send it.

Oh we just crossed then :)

I'm happy with qdev_prop_set_array() for our needs but I don't think
you are waiting for my particular input there, rather Kevin / Markus.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9B37CC406
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjow-00076D-W3; Tue, 17 Oct 2023 09:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjot-000711-2w
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:09:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjor-0005bv-G5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:09:10 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d9552d765so4445701f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697548147; x=1698152947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OdHpVOBGqtyjj6N6slLJ8VS4WGBxvZvhkhBf9bBth5c=;
 b=eb1GMh6nrHAvugzrUT7hVQVrfOPuiJc767FD7BQKdUwOazyclj3S7rg2bcCr5tyUg+
 xxCzNukjsP0sFr+XiB4rcgO3r4rYBLKd7bKZefHUMGwoNEQi8IilUqLgDeBVwLhqbV5M
 6x/CvleLEPKMWFhMFwX5H3+gHVU2w/y3+gZJgRPMnRjNP0WvI2ZrxNZwG5WYEQpK+Jir
 EbK/WeGxh1B+I1In1WK3N2aocpN5srlE9Qh+YYLWDbiKm11oAkeCriSFjCZ1TryxmLVk
 CVKiLIudbmnjGc0eTjQeE+BPtH0TandAmyXn4aOAwUM4ffiYGScztbT2j2Btw0Q4UEhi
 E4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697548147; x=1698152947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OdHpVOBGqtyjj6N6slLJ8VS4WGBxvZvhkhBf9bBth5c=;
 b=jRa0xcqByjN0kDsrnusk4Fk3D0e6NMh0OD6ePuYNlKFUxI2AqVLkXMhQGD8TX0G6GT
 TBaJPkiMvb15uFhykGSNWG/gD/kEf0G2C9xpE/AN7TOlrCRAwklHxJCYYPcbhWlMp0YT
 e0q/6KkxfWnN4E89vDssunVLP3Iaa7p0RvR0msbUpO4fMaRKYAMUk+6JIYMgATz4AXeq
 /FwyNKRRiZb0AkbeE0rYzEIu6Xc+oVanq4j3emFyZZQT3dD4o7So2w6KlTd2lMCZd5wo
 GaSWra9hEfzrxAcrBBOSilYuyzqp3mHeUiboZbaLKnIZQ5ng0apIvoIxuwbM+xEx7quQ
 xF4g==
X-Gm-Message-State: AOJu0YzCs2Xm+qjEsuAR4cVQT61aswYhRpWE1LWfBPF2Cy7dpU/ZjSmD
 dBlv58OaijJRa8gPhXle3LF3DRGjHvfEkKBFlUTHSg==
X-Google-Smtp-Source: AGHT+IFjwAt2wt+6PuENTkQeyo+RUnAFP72dVO8Wu4e7SH5iBOtqA4JyCq0HXmV6NGzpzXRW7vhmCA==
X-Received: by 2002:a5d:4e45:0:b0:32d:b411:4667 with SMTP id
 r5-20020a5d4e45000000b0032db4114667mr1761638wrt.30.1697548147408; 
 Tue, 17 Oct 2023 06:09:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 o6-20020a5d4a86000000b003271be8440csm1645124wrq.101.2023.10.17.06.09.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 06:09:07 -0700 (PDT)
Message-ID: <ae8c8832-4d67-a0dc-5dc9-2a7da560f2c9@linaro.org>
Date: Tue, 17 Oct 2023 15:09:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] hw/input/stellaris_gamepad: Remove
 StellarisGamepadButton struct
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-5-peter.maydell@linaro.org>
 <c61b98d3-cafd-862b-09ad-818a5e2f051d@linaro.org>
 <CAFEAcA8OfRyVnP-tdMWz0g9HvYJtQb6xDha1zO05Dp855_SMfw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8OfRyVnP-tdMWz0g9HvYJtQb6xDha1zO05Dp855_SMfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 17/10/23 14:52, Peter Maydell wrote:
> On Tue, 17 Oct 2023 at 13:44, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 17/10/23 14:23, Peter Maydell wrote:
>>> Currently for each button on the device we have a
>>> StellarisGamepadButton struct which has the irq, keycode and pressed
>>> state for it.  When we convert to qdev, the qdev property and GPIO
>>> APIs are going to require that we have separate arrays for the irqs
>>> and keycodes.  Convert from array-of-structs to three separate arrays
>>> in preparation.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>    hw/input/stellaris_gamepad.c | 43 ++++++++++++------------------------
>>>    1 file changed, 14 insertions(+), 29 deletions(-)
>>
>>
>>> -static const VMStateDescription vmstate_stellaris_button = {
>>> -    .name = "stellaris_button",
>>> -    .version_id = 0,
>>> -    .minimum_version_id = 0,
>>> -    .fields = (VMStateField[]) {
>>> -        VMSTATE_UINT8(pressed, StellarisGamepadButton),
>>> -        VMSTATE_END_OF_LIST()
>>> -    }
>>> -};
>>> -
>>>    static const VMStateDescription vmstate_stellaris_gamepad = {
>>>        .name = "stellaris_gamepad",
>>>        .version_id = 2,
>>>        .minimum_version_id = 2,
>>>        .fields = (VMStateField[]) {
>>>            VMSTATE_INT32(extension, StellarisGamepad),
>>> -        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, StellarisGamepad,
>>> -                                            num_buttons,
>>> -                                            vmstate_stellaris_button,
>>> -                                            StellarisGamepadButton),
>>> +        VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
>>> +                              0, vmstate_info_uint8, uint8_t),
>>
>> Don't this break the migration stream?
> 
> Yes; this is OK because we don't care about migration compat
> for this board. But I forgot to mention it in the commit
> message, and we should bump the version_id fields too.

OK, this is what I thought (I'm still trying to correctly understand
that myself). With that updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




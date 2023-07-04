Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CEB7474B6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:03:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhYV-0006mP-Gt; Tue, 04 Jul 2023 11:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhYS-0006m1-SZ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:03:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhYR-0005vy-D9
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:03:00 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso55476325e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482978; x=1691074978;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h0E5LcvshblEZkZOGtWibRlrxqxfepp9qdUntBDY3Os=;
 b=cCWefyVmLaxUdQE/nPyQaHQPam52IIjZ+NFMZo9vmTVap2ULs8s15jjG1PFKqtMOXC
 6xjBz5QHb/aOVqqXCBcga1yrbIdxpFyC8yLbCWM3X8MUp8UaBmlORJq+/DgFXjAqqx12
 FwElWcZ0X1DnBuVnVahtfav+J4D83wT9l6XCortI4aWWb8KGZgth2E3s9xJMzWJkyc+A
 OjFDGcKpkh9OFnVww0Likb7Fe1vWE/CG2Asgpj7d/Hnn00GvA5s3yA/JppbYK3m9Pm8U
 D+hI1UPAsciAWOz9cs98A8i5leUSKXVjTnKxssgszkZhjJdV5biNFDSyO2bDPqUHWQ1c
 zG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482978; x=1691074978;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h0E5LcvshblEZkZOGtWibRlrxqxfepp9qdUntBDY3Os=;
 b=XdYlrgqO0W1qwMV3cRukIPDKz6Ego3l2FiR45CATBPdtmJ0xPXZNzzrHxe46ZTRTmv
 2Hyq+7AdoAQZ/Z8e/jPc7xhlVPBfe94Bh6VkgdrKtdxzpv95QJvpL6djfE2y2YkBY8lf
 7LJ0khSCjVjh67VhvvY4RQgGbTdAcCLr+AtdAaRVC8Ukgg/qrJIbtLgLptU8igoXoH2V
 1ag2u2IJsaIO+xgbOBOGCF60UnYXRuMIBODEQ4bl8eeRW1k3q8WTIM8mxM718iJKvUvr
 h0UYplRhDfbXaUdeZkFoJApGPGBwx/PO6729Vy7R1Me/gKcxEvUDVdBzM8FoTvN1yQuz
 z5Kw==
X-Gm-Message-State: AC+VfDxtkh0m4LwJLOaDjrm+xULqgq/7rgj3KmIQ1rOqnyc2bG2FJDHO
 RaeYhU+TunFyoSp8t26q+zZ+akcYA+e/wPjjYfI=
X-Google-Smtp-Source: ACHHUZ4iIOFM5CILhzMObPjzv0UBQnyH9q3J3kun/Du488iLWVLz0Vz3iICBh7NaI0AQyfiW0dmi/g==
X-Received: by 2002:a7b:ce94:0:b0:3f9:b87c:10db with SMTP id
 q20-20020a7bce94000000b003f9b87c10dbmr11023850wmj.3.1688482977874; 
 Tue, 04 Jul 2023 08:02:57 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a1c7417000000b003fbdd9c72aasm3849142wmc.21.2023.07.04.08.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:02:57 -0700 (PDT)
Message-ID: <9f34a0e5-4537-4868-53aa-d34f1acf1b47@linaro.org>
Date: Tue, 4 Jul 2023 17:02:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] target/arm: Implement Cortex Neoverse-V1
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <81e6bf97-b6c6-e09d-51b5-445bdc3a47bb@linaro.org>
 <488ca2a9-8e1a-3a62-8487-fefaed69ca8b@linaro.org>
 <2182ab07-ca32-22ae-8c5a-5d23bfcec5cb@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <2182ab07-ca32-22ae-8c5a-5d23bfcec5cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 17:00, Marcin Juszkiewicz wrote:
> W dniu 4.07.2023 o 16:54, Philippe Mathieu-Daudé pisze:
>> On 4/7/23 15:35, Marcin Juszkiewicz wrote:
>>> W dniu 4.07.2023 o 15:06, Peter Maydell pisze:
>>>
>>>> This patchset implements the Cortex Neoverse-V1 CPU type, as a
>>>> representative Armv8.3 (+ some extras from 8.4) CPU matching real
>>>> hardware.  The main thing we were waiting for to be able to define
>>>> this was FEAT_LSE2, and that is now supported.
>>>
>>> Now I can add "reach SBSA level 4" to todo list as it requires v8.3 
>>> cpu (I do not count 'max' cpu type).
>>
>> Do we need to introduce machine variants, such sbsa-lvl3-ref and
>> sbsa-lvl4-ref? Or simply sbsa-level3/sbsa-level4?
> 
> No such combinations. The plan for sbsa-ref is to have only one platform.
> 
> Version of platform is exported in DeviceTree already. TF-A reads it and 
> exports via SMC call to EDK2. What changes between versions is present 
> in documentation.

Great! I like simplicity :)



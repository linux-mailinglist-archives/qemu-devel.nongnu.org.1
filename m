Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B91798399
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 09:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWJR-0002hr-Qd; Fri, 08 Sep 2023 03:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeWJM-0002h4-Gu
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:53:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeWJI-0006NI-UT
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 03:53:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso1579645f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 00:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694159627; x=1694764427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyXU8P0k53i+C0zRlw3lZE7NGx7S1tE8CQvxQID4Ld0=;
 b=Yw8rzefxF00s9yt05OHVWZJJthi2TDsbBUmx8fQmxeQFkyssA4oM0Cvbw/CtiqpIx1
 oh7ivjhEC/f8AEXj8eCj0ZicXZU3iUSQ3GjCmeESSSw5GCNjC1bXHLSeirwh90EgBcWI
 csvKEsu1HNdOYxL7qHP97QczBJvfPdT4PI8nJcFooLnfZklWKawcUQ1s95PA7G1gAsWk
 qhHwC0a3QJ6wuRDSDwLBPWAFuq86hC1ZtV3fAyN3vbnBCJcocag+iRhBWplr9XIdH2gL
 7vfaQBzFCbfpq7kDDpnb0NMM5h6JstO56FkPmciAmXruWdNn/BW97ztilIxqTIhTrqoC
 IwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694159627; x=1694764427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dyXU8P0k53i+C0zRlw3lZE7NGx7S1tE8CQvxQID4Ld0=;
 b=jff+5EdsysoF5n7WWBMK31FCbwzLj1G3UjtAu/bXOiQNkFuExWdnHwAHlSx3Fm9E9W
 NDWutS1tc4zqUH1XoST951tvaKg0qPhwvTV0EDrUa0oAlUZDYGKUXumas2GWyFkxYadm
 1tud00nOLYF9DQ2yfkSWs1YFsTkRaNSG6volHVywVaGJF9IzlrVwUQwWTwg1CTHbYCEL
 rSorqX7DBfk0bSds2OVcGUnAoTFdRa+RgpNxj/A+M8+dIKK2RrKX58l66CQMlUUyQokk
 k65Pl7vWyVQrT1cpa42Jnuf/sALtJFcu3bB+CZO5cGC7NrQQAQpIDQjasz1jdcH0kBOd
 zlyA==
X-Gm-Message-State: AOJu0YzWXuU2RAgLAvqoSleQPFDGLAVdq2RohnoUsMR+sGMGIGo+w5Bv
 fgEjm3TFh6GXiRGy4ESoZ/X1WQ==
X-Google-Smtp-Source: AGHT+IESKDt6UYpzMh/3oI3J9MmqfSYppLBD/0HBIWcpx8Uzdt1/78V6+FoRWmC4U7h8pVlwlN6lhQ==
X-Received: by 2002:a5d:6412:0:b0:31a:d773:51a5 with SMTP id
 z18-20020a5d6412000000b0031ad77351a5mr1240156wru.27.1694159626994; 
 Fri, 08 Sep 2023 00:53:46 -0700 (PDT)
Received: from [192.168.69.115]
 (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr. [176.173.167.175])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a5d4bc9000000b003180027d67asm1381718wrt.19.2023.09.08.00.53.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 00:53:46 -0700 (PDT)
Message-ID: <528c14dc-329f-f51a-cb8d-350a7a5cb7ee@linaro.org>
Date: Fri, 8 Sep 2023 09:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PULL for-6.2 0/7] Ide patches
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Niklas Cassel <niklas.cassel@wdc.com>
References: <20230907034228.4054839-1-jsnow@redhat.com>
 <7ef011cd-09e7-c5f9-dc9d-173ff8f431c8@tls.msk.ru>
 <CAFn=p-aueHBXMFHgw=Y8XYyeaFZKFRc8vJHQ6PQ8gNSqPcii8Q@mail.gmail.com>
 <d5ff2d54-70bb-00e0-d25a-56d1096bed73@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d5ff2d54-70bb-00e0-d25a-56d1096bed73@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 20:16, Michael Tokarev wrote:
> 07.09.2023 19:54, John Snow wrote:
> ..
>>      > ----------------------------------------------------------------
>>      >
>>      > Niklas Cassel (7):
>>      >    hw/ide/core: set ERR_STAT in unsupported command completion
>>      >    hw/ide/ahci: write D2H FIS when processing NCQ command
>>      >    hw/ide/ahci: simplify and document PxCI handling
>>      >    hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is 
>> cleared
>>      >    hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>>      >    hw/ide/ahci: fix ahci_write_fis_sdb()
>>      >    hw/ide/ahci: fix broken SError handling
>>
>>     Is anything here stable-worthy?
>>
>> Yes, assuming it doesn't break anything.
> 
> Hmm. I was thinking maybe one or two of the above.
> Are you suggesting the *whole* lot?

Yes :/



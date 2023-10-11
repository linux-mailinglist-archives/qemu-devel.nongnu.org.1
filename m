Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 775527C493A
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 07:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqRov-0003pl-W4; Wed, 11 Oct 2023 01:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqRop-0003pK-N2
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:31:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqRon-0001Y1-RU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 01:31:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32615eaa312so5837837f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 22:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697002296; x=1697607096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RVdecpp0YQrxiqXC4p23iWC78YBeQd5h42krIZqV67A=;
 b=NHvIoz9ZAx+P+LZgdZ4BTKnMEyktjhgi23Mte6EGaOjepWtaWRCC0/7ukeqH8BMMYY
 2qrfYIlZoH/NJRvrMSkM24YMLWcIULes3H5Qxogxy0Or2GpTgesvJ5o+tM0g207EEGZS
 zvAYHFCFEGAiNa+532bFTEGlw/qSdWrD/b8Gla/YLafwrtDJvr0vandxGqdi2xMoKYA+
 lMXKG26lOY/jIeZ6c5ykRygIMG1y+d8dZTUNnrMiL5OKiCTcTz6y7EnIsoZxelog5PwQ
 QKpOs6+21+6sMbo/eBxyCU5hJKKyF8V5SuLlUshIqZKNLsK6waY33vD7J16BtH7KojFb
 ZVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697002296; x=1697607096;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RVdecpp0YQrxiqXC4p23iWC78YBeQd5h42krIZqV67A=;
 b=bFG2OA85JmHguZBIWyLbvr/yWzaHLOCUVV5kyzuwK6lzKeqshR7U8w3hhQmULsySIi
 gf2nqoOCTozWNr/k26cdkGdg8vGqyusJMyMK5w0lRTuE9TLrAUjjSUHTkukDG4d3LlOm
 LYnangEpD2WQGBBj3gs/NoNOgVrr9U2dZV4mssZ3VOZflj/pacZ4oj4jJDzIuU+/84/W
 e2N1Ft6J+8OmfS/YzV7AahfshoOdNOkXUsSm/mqKtrC4gt189q31zIBC1t91eXMbd9Ms
 56neB1XFULACjXZQOqbsDNzvtaDO6F3N7+GF2O12vvPArUGPPr6ZHHuALW+UaK3/0izq
 6Y9g==
X-Gm-Message-State: AOJu0YzFBqrui7Kw+WaJreXhn2Du8e18dcgyFugBiIuzEHx3cm+WvmKW
 SsMKQk7r3r1i8Y1Uj3sJa5gfOg==
X-Google-Smtp-Source: AGHT+IHFi3Ea/h2PApLs9eeeGfP4Jqm8rUpT6ynWo+xgSg0pmjCht/V0zgixLFtf8qCVdoYxGsimLQ==
X-Received: by 2002:adf:cf0a:0:b0:321:6bed:1646 with SMTP id
 o10-20020adfcf0a000000b003216bed1646mr17435656wrj.14.1697002295317; 
 Tue, 10 Oct 2023 22:31:35 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 a9-20020adfe5c9000000b003142e438e8csm14252878wrn.26.2023.10.10.22.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 22:31:34 -0700 (PDT)
Message-ID: <3b745e06-d037-f1b7-0fec-373959598a15@linaro.org>
Date: Wed, 11 Oct 2023 07:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] target/riscv: Use env_archcpu() in [check_]nanbox()
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-3-philmd@linaro.org>
 <8e8b6cef-efbf-42ac-975c-b523dc24a531@linux.alibaba.com>
 <58838379-60bf-4af4-980b-cff8ee49bfc2@linaro.org>
 <4a7e39f4-4302-4dfd-9112-4deea5c7403f@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4a7e39f4-4302-4dfd-9112-4deea5c7403f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 11/10/23 05:25, LIU Zhiwei wrote:
> 
> On 2023/10/11 1:04, Richard Henderson wrote:
>> On 10/9/23 05:42, LIU Zhiwei wrote:
>>>
>>> On 2023/10/9 19:02, Philippe Mathieu-Daudé wrote:
>>>> When CPUArchState* is available (here CPURISCVState*), we
>>>> can use the fast env_archcpu() macro to get ArchCPU* (here
>>>> RISCVCPU*). The QOM cast RISCV_CPU() macro will be slower
>>>> when building with --enable-qom-cast-debug.


>>> If so, maybe we have to do this qom cast somewhere.
>>
>> No, I don't think so.  Or at least not in these places.
> 
> Yes.  Perhaps, we should remove all RISCV_CPU macros using after the qom 
> objects realized.
> 
> Do you think we should remove the RISCV_CPU using in 
> riscv_cpu_exec_interrupt? Although it  is not so hot. I think there is 
> no reason to use it there.

I have some note in my TODO to check replacing CPUState by ArchCPU in
TCGCPUOps (like the cpu_exec_interrupt handler you mentioned). However
I'm running out of time, so feel free to try it.

Using ArchCPU avoids the cast in target code.

> Except this, there are many other places in hw/ and target/riscv using 
> the RISCV_CPU macro.

If a method is exposed as API, we need to check the type. After that
for internal calls this is pointless.

> If we know whether we should remove the RISCV_CPU macro use in these 
> places, we can do it in another patch.
> 
> Thanks,
> Zhiwei
> 
>>
>>
>> r~



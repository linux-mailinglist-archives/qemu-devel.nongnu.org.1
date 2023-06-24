Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A68373CC12
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7BH-0004Rz-T7; Sat, 24 Jun 2023 13:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7BG-0004RU-5j
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:36:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7BE-00050V-AN
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:36:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f96so22579565e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628170; x=1690220170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhpHbFudMkeMeL5ABLFV8K3ZpIKOcpmqDKumUJnakQo=;
 b=iHZDudCm+6Lkz6SMlioiaWU3ZPrAVeeGWydDo5XpuHV/O83QDieJ2MW8sBwc0RnJ6n
 LCyc81zygqlx89kqYh6y73/3CFk7tQWmRPaEg0IWMGey5OqegmHYQ884T0up8Qih6qtw
 X91F/O84ZOuvkgqRnEXbb0eSlQvy+5Gun1bFmcC96S2uKTlpsxgRhLma5RxvpNjRGq+2
 eDO6513hnE4ZqdmdJjRuKKPa5ge9tgFASVn2oo+300iSfP5maJ62wBUynRf7i9NYTjc6
 xdYlov0lRWMIvUULtV6NAO9JsfOyDTaiIaPiJgFXnYEpiaqfkMjDaWpUqrHvp89eWXy7
 ObVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628170; x=1690220170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhpHbFudMkeMeL5ABLFV8K3ZpIKOcpmqDKumUJnakQo=;
 b=ZHtd6qgMGOhP3xt3nQJxpX6vJ0cPL17IiKa4MW7yppKf+3u8iZdnvseNBXkLYusTEo
 jz00Kxb/n2rCUSaToW39XLCMHaH1HfL7FVZn+dB3zmdBgE1criXbHU8THDu4R3dx4bBy
 vIGgHK4Xg9itNe+kUvepkdQAz2P2kjcRwXzOrOKXQQSKekHZFYpyIVAOppBVmNFx3qjA
 4GM0+YaSAnpwbMPAZzGeth1WkoTMee88T30ey8X/q6NDEgyvpJ3Trp8jOSJx+poVJrlj
 zGIDku6oFAtwuxpT/YgPbulqbLyIeQZW7LsHBVKdsrIy5f4d88wkdGIJhcAQUYx3K4iM
 8pMg==
X-Gm-Message-State: AC+VfDzupXEVMCyYP1QeIVXK9+Rf6ifCi993fNMpluijw/F/1kV+zZqY
 nEMLLhZmW2yYavYaN9muPKWBkQ==
X-Google-Smtp-Source: ACHHUZ45/pSKUwN9ZWRuO9SdxWU1+R6/cc+TpuFjaseh8imD+9izPUxpPl+Hji/hbynVqoq/U2/WFA==
X-Received: by 2002:a1c:e90d:0:b0:3f8:fc2a:c7eb with SMTP id
 q13-20020a1ce90d000000b003f8fc2ac7ebmr17083071wmc.5.1687628170299; 
 Sat, 24 Jun 2023 10:36:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a5d6dc9000000b0030ae53550f5sm2590762wrz.51.2023.06.24.10.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jun 2023 10:36:09 -0700 (PDT)
Message-ID: <c52475f6-253f-05cf-186f-5b9e17da1dac@linaro.org>
Date: Sat, 24 Jun 2023 19:36:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 07/16] accel: Rename HAX 'struct hax_vcpu_state' ->
 AccelCPUState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Durrant <paul@xen.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
References: <20230622160823.71851-1-philmd@linaro.org>
 <20230622160823.71851-8-philmd@linaro.org>
 <2c0a97af-be7e-6d83-5176-ef9980c2faf0@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <2c0a97af-be7e-6d83-5176-ef9980c2faf0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/6/23 19:46, Richard Henderson wrote:
> On 6/22/23 18:08, Philippe Mathieu-Daudé wrote:
>> |+ struct AccelvCPUState *accel;|
> ...
>> +typedef struct AccelCPUState {
>>      hax_fd fd;
>>      int vcpu_id;
>>      struct hax_tunnel *tunnel;
>>      unsigned char *iobuf;
>> -};
>> +} hax_vcpu_state;
> 
> 
> Discussed face to face, but for the record:
> 
> Put the typedef in qemu/typedefs.h, so that we can use it immediately in 
> core/cpu.h and not need to re-declare it in each accelerator.
> 
> Drop hax_vcpu_state typedef and just use AccelCPUState (since you have 
> to change all of those lines anyway.  Which will eventually allow
> 
>> +++ b/target/i386/whpx/whpx-all.c
>> @@ -2258,7 +2258,7 @@ int whpx_init_vcpu(CPUState *cpu)
>>
>>      vcpu->interruptable = true;
>>      cpu->vcpu_dirty = true;
>> -    cpu->accel = (struct hax_vcpu_state *)vcpu;
>> +    cpu->accel = (struct AccelCPUState *)vcpu;
> 
> this cast to go away.

Indeed, thanks :)



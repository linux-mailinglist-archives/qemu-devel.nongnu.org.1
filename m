Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6D47B6B03
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:05:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qng17-0007GL-3M; Tue, 03 Oct 2023 10:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qng0U-00074G-Ue
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:04:16 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qng0S-0001r4-BN
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:04:14 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-69101d33315so772240b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696341843; x=1696946643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PGhYHTVvUZAkku9032I5Cj12kC+c5Sm175YoL6Kui2A=;
 b=d5TAaNN439EBNDM8haWMjwOIXAJbqQljcZaNQWdbD6UPQA9wTt+sVR0v+d0CndjT++
 piuhVAxAtSY2wZw7I7AEf7EeEsIj/FCMSw9+NymlMrAtLZCr2xI6InMN/Vd7E6ileWIf
 fA0uIkx+uQZBecBQs3BIwwp5z23Ni8qWNrvb/zq92DWNT7qxRA1FGN/gux2Ds9wdiFPY
 D3L8C8j0sskafGFI/VXIO4auvQJv0TMFbdKVUClVSbHhFTZKlvKrXm8CLgww1eL7ts+O
 AC22fO5LiVKnGd7yNhzb/ZsBEITLya7ZyD5z98wNqoFrmw/S/0WcD8leY1FxGmmt/r/D
 AtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696341843; x=1696946643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PGhYHTVvUZAkku9032I5Cj12kC+c5Sm175YoL6Kui2A=;
 b=IxCPKZvvSbjbFk/fWrVg64ul8T1I8FxlFxc1MqSIjMfEBqy5c5H8ehoCM4pTaf0eoB
 YSbj0ALYt6b76SWnvm8Tokj17YoFTM2E9HCwGJGYpXytTRXo3dhul6DqH2kMX1IQnD84
 AqY/mwrRW8gvo/OYBiYE/UTYLFGIkGPzvGnvmalgPkcLWgOf2P1k+CWzpuDbpAqNMTSq
 X3D/9ByLssxPBXUhVWFG+sR1r+LY2PlUsjtPUJLvRmqKkHSk0+8ZrTpgRooxl/cu8zz+
 hV/5NVLYKOQZbxdGbunqZJrDZurQT74IWTBV88D+VbegQ1AOWFy8NmonROJsVvKazxY6
 smcA==
X-Gm-Message-State: AOJu0YyUl/ob611bZGShr9c9vOvzOU/G4XDhOVrbpqsBwHye6mofv9/Y
 mEcQnDn8O/8vqR8lSclZKTRngg==
X-Google-Smtp-Source: AGHT+IHbsC8bIzjKyXDvYfAdfaCcEVwebd0JAM2/o3vR3hGxDCXzAkhavBCserikXogG1mN2b9A0xA==
X-Received: by 2002:a05:6a00:130b:b0:690:d620:7801 with SMTP id
 j11-20020a056a00130b00b00690d6207801mr12959180pfu.11.1696341843634; 
 Tue, 03 Oct 2023 07:04:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 c13-20020aa7880d000000b0068e4c5a4f3esm1389122pfo.71.2023.10.03.07.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:04:03 -0700 (PDT)
Message-ID: <96a726c8-186c-3f09-9d9b-d17d7f5289e2@linaro.org>
Date: Tue, 3 Oct 2023 07:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/5] accel: Restrict tcg_exec_[un]realizefn() to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
 <87e1be19-c1c6-73fb-3569-7dbf186662f7@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87e1be19-c1c6-73fb-3569-7dbf186662f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 10/2/23 23:44, Philippe Mathieu-Daudé wrote:
> On 15/9/23 21:00, Philippe Mathieu-Daudé wrote:
>> - Add missing accel_cpu_unrealize()
>> - Add AccelClass::[un]realize_cpu handlers
>> - Use tcg_exec_[un]realizefn as AccelClass handlers
>>
>> Philippe Mathieu-Daudé (5):
>>    accel: Rename accel_cpu_realizefn() ->  accel_cpu_realize()
>>    accel: Introduce accel_cpu_unrealize() stub
>>    accel: Declare AccelClass::[un]realize_cpu() handlers
>>    accel/tcg: Have tcg_exec_realizefn() return a boolean
>>    accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
> 
> Ping?
> 

I have this series queued for the next tcg pull.

r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D81A777661
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3OD-0000LL-4c; Thu, 10 Aug 2023 06:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3OA-0000L6-Cx
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:59:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3O8-00037I-2P
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:59:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-317dcdae365so712278f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691665170; x=1692269970;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HvHCP70ZHroKOL6EwLKWvMZd+U+3ZMYzGi0DXS7wFM=;
 b=Q377VuwZ/wWM+jdBkTgV98fdZAZp5YvodZLphvBMkKSF1ss0bqTCVYDz3n6aYrdqVL
 EPBrzR/9FbiZvpeEeVlZ3pcUDn7/NTnWtxRA/KClNy/4oNd7JIVRGknNQ7yX4+bGg5yh
 guOKnAHdqnCOnm77Wf00v4/GcD+C/0oBFzQUW9nudEN7EDptyReWTVn7vrlNS0PEXLlk
 +72dqA0y/JXyKLpEgVXgataG5/Dw0RjuLPVVLP414d454sSvz4yKCQCdZPmNKy5apEtk
 9q/hyOFOVvCsVkLEaZNq3lRGNBDj9sirpSdK96X/FsyjgcGtNIBHIFb7VV0SW7oFn4I7
 aIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691665170; x=1692269970;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2HvHCP70ZHroKOL6EwLKWvMZd+U+3ZMYzGi0DXS7wFM=;
 b=K+YPO1IeNukaNcu8uAEIdHlJvlLVR25fVI2C64HQWdvp6RHbBW4p4aByna6VnyAh8/
 ObRJPiHcEWkGQwIBLxNKcZJMXF+MFOHQQVM5C1G7X7+FFT6fDdsndXGnmP556c2H1fHl
 J0AcGBCymJc9fMCW06X582LlpeRmfmfX7g5s+AnUpoDB8nzrhe6U/PEqvKXv6ft+DI69
 s3FZ53ulWiTwfw3Ek6yINnfyF7TG0X2r1oNdRVsI9nEK0Jak+pxPC3kppAzFaoRp5hdS
 vsp4DD6j0Y7FQpxsCtAvYzmXmyE9RtfUN9qjnQnIJvmtn3nzYNyXOrmKGqZtq0tv2Apy
 adwg==
X-Gm-Message-State: AOJu0YwieJzZSZgaayLcAtWv7Qm3h1K4Wjt28aL0IEC9HdQDwqXsPmwY
 /kV3U9bwjp+j1iKB0thZ7BPEWfnCKczUSOIJQUQ=
X-Google-Smtp-Source: AGHT+IFWbfY0XhDgZxv91Mz/b9gzUqHht1jv83opgM0TyXcEvS/V6MrGrPJ7vV6aK1rNaMGBcOMSyQ==
X-Received: by 2002:a5d:6889:0:b0:317:ef6:89a7 with SMTP id
 h9-20020a5d6889000000b003170ef689a7mr1679131wru.27.1691665170536; 
 Thu, 10 Aug 2023 03:59:30 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 k7-20020adfe3c7000000b003176c6e87b1sm1797361wrm.81.2023.08.10.03.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 03:59:30 -0700 (PDT)
Message-ID: <f64d5006-ae77-cc10-270a-0c0fc6e3a0ef@linaro.org>
Date: Thu, 10 Aug 2023 12:59:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: CXL volatile memory is not listed
Content-Language: en-US
To: Maverickk 78 <maverickk1778@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

Hi,

Cc'ing Igor and David.

On 9/8/23 00:51, Maverickk 78 wrote:
> Hello,
> 
> I am running qemu-system-x86_64
> 
> qemu-system-x86_64 --version
> QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> 
> qemu-system-x86_64 \
> -m 2G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G
> 
> 
> I was expecting the CXL memory to be listed in "System Ram", the lsmem
> shows only 2G memory which is System RAM, it's not listing the CXL
> memory.

Sounds like a bug. Do you mind reporting at
https://gitlab.com/qemu-project/qemu/-/issues?

Thanks,

Phil.

> Do I need to pass any particular parameter in the kernel command line?
> 
> Is there any documentation available? I followed the inputs provided in
> 
> https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> 
> Is there any documentation/blog listed?
> 



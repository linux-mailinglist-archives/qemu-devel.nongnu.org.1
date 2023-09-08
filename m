Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C8D7987E2
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebXv-0001nF-N3; Fri, 08 Sep 2023 09:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qebXt-0001mV-Di
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:29:13 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qebXq-0002Ij-1P
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:29:13 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bcb0b973a5so34067071fa.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694179747; x=1694784547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=34b1/6ju2nskn1koj2zs3PETJRXP3G6EuWnCGesLV3M=;
 b=LcBGjZfkE5NruQaNGHPYFSe/tF97asyjkDTMzIVT8N5Frc/8Cqzw847PE2mJbj43bS
 PuYxV+IGP3VoG7QAEmqhhgqtaZFcRmkLEUeD65AxmNSllhhHnCSD4X587tbV6TueJznr
 PA+AzUG2Fw3aw9K4AwU5E6upSmXuWGoR9eo8P74F1Wski5wJvOwejhz8Xdg6vypyCVXQ
 aKTJrkpvUKVVeNwDu+Dd/5U418RYDlMJX/LEDLTSoeJua2NhEBEPI9ipWInS9EEv0CGd
 vivIo/TyjV4dePVmXe5SiZpsPV5fpAreS0DIo528TKHNTviW+YfS06vG7hD3IbqiVLRv
 zN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694179747; x=1694784547;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=34b1/6ju2nskn1koj2zs3PETJRXP3G6EuWnCGesLV3M=;
 b=RkREy2NM4wbci+Z4LG0ZzfG9t2vC09WE49kB9tqcyGdFByvs+Sc0JCNoKAEo8t6M9l
 T5qufsyc/yI3NJSrin+1v+81AgCzNy3j1Vxn/fvXlIFokjMgCUgTmj43yeNYUJJF9UtW
 Bb+5mDmIX4mBKgTZETuqElYyl5YgFzOiH/MZNgtMjjfndu0pPVjjRjY+OjdD2jCBjeh0
 BKL3hNvoli4K2gBkJVmGXPqLaE2bHPbBGu2qt3xSPWC2mgdWfzyf4eQySnheVa1fLm31
 wjKYVrZN8uR/FimDF6C9tSS5RhNHhT6pbUz8CM3bVLs7rSgQJUhPkbwE8mJyR8fkOyGN
 kjig==
X-Gm-Message-State: AOJu0Yz03/9IeN1UnTshdGe7o7hTKLE2bvk107LSaKNZpn3dUCUL2OPx
 agc1s7h2aS+94NfAAPG1SBphuQ==
X-Google-Smtp-Source: AGHT+IHaHCts7qxUD7fAm6hBn+AaEu8HMrwyfTDqJzHXR0JGDlnjO3x9mCJkBe0/oMn5EbCfKFxHqw==
X-Received: by 2002:a05:6512:1112:b0:500:78ee:4cd7 with SMTP id
 l18-20020a056512111200b0050078ee4cd7mr2247450lfg.23.1694179747289; 
 Fri, 08 Sep 2023 06:29:07 -0700 (PDT)
Received: from [192.168.200.206] (83.21.94.247.ipv4.supernova.orange.pl.
 [83.21.94.247]) by smtp.gmail.com with ESMTPSA id
 z13-20020a19f70d000000b005007fc9cccasm290455lfe.94.2023.09.08.06.29.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Sep 2023 06:29:06 -0700 (PDT)
Message-ID: <42e00aaf-2399-4ba9-bef6-8627b8e0718e@linaro.org>
Date: Fri, 8 Sep 2023 15:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: SLT must be RO
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
 <9cebce70-59fc-e7bb-5973-3091680b72ea@linaro.org>
Content-Language: pl-PL, en-GB, en-HK
Organization: Linaro
In-Reply-To: <9cebce70-59fc-e7bb-5973-3091680b72ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

W dniu 31.08.2023 o 12:05, Marcin Juszkiewicz pisze:
> W dniu 30.08.2023 o 23:48, Michael S. Tsirkin pisze:
>> current code sets PCI_SEC_LATENCY_TIMER to WO, but for
>> pcie to pcie bridges it must be RO 0 according to
>> pci express spec which says:
>>      This register does not apply to PCI Express. It must be read-only
>>      and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, refer 
>> to the
>>      [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
>>
>> also, fix typo in comment where it's make writeable - this typo
>> is likely what prevented us noticing we violate this requirement
>> in the 1st place.
>>
>> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
> 
>> Marcin, could you pls test this patch with virt-8.1 and latest?
>> Thanks a lot!
> 
> Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> 
> sbsa-ref: PASS
> virt:     PASS
> virt-8.1: FAIL (as expected)
> virt-8.0: FAIL (as expected)

Can we get this patch refreshed and merged?



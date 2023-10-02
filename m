Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCB7B4B56
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnC9r-0006aJ-Hv; Mon, 02 Oct 2023 02:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnC9k-0006Zs-Mz
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:11:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnC9i-0004gC-UO
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:11:48 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so143803575e9.1
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696227105; x=1696831905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2X73YWi5k52gQOV92nqQELEwk4ksn8Z61zU2nAH7OKE=;
 b=h5fbkSHsqKK8fyp7/0NBxhFYiMKhM+kqbR3PiVOB5fr2FREKMOhivoHlQReHXOXUq/
 jhsBbbgirAfvbTHYXRTAy608fSpdzGHMOlVGfoeOdgq9TNM/TRfVp0K/90NsW1Qgh64e
 b3QtE6ytnZOeScz59OoObhMqCg+XCus5A6RjMyZUZOnAnd1qL4nPYJM6VwaZNPToayc7
 2PuYxri+usgMnUhrzz1nTkrzyMXhzD26iTUpMxddi7sYYu7JTLSLkrR4AFFaSFfKD6H+
 kboA5mAwyedqUgGn5H581jfmo75KFt2o8eC/zIQDd1NPanOFhOrMxjZyhwt1XdmYT/UX
 WG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696227105; x=1696831905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2X73YWi5k52gQOV92nqQELEwk4ksn8Z61zU2nAH7OKE=;
 b=LeRzN24cIXvutebkjw3LxBHidsvp3vD+5p65QeUpVeJztFYAQFcbzNSrYe77mQuenm
 WCTta/WZUuCalM4NOnJq4DBcLLc+QMiyGvu/9VlvKAheIKPdZhaPhtGWkxFbZ+1yo4kQ
 QNcu2N8KloKfkBW4CMX9qDDqFos7aAufBOrEhuTLveHiJMH+ff3Tyvv/peSqtAzZT7F9
 NSTKjwfSDdrYvSHwCqq+efPb9BGlIRYHEmVcv0+GEh57IQfiR32pnn/1EUR+T2w6dkOZ
 hGGyhzuCySSYLmtSZNMrLWJlkXsrFzcHNjudRkqT8F0IDC11T/nehqQhTYiopmq8SxzC
 XOKQ==
X-Gm-Message-State: AOJu0YzWQXh7ZP9gnC90kNBMkOGxp0nl9huOh0XiD+qs/8J7/MG/gnCs
 7ktKEkoPlIJe9Pmj2QeKLoxqGw==
X-Google-Smtp-Source: AGHT+IHYJI99Z9n+uRPXyyIg5Wlg1N46dODTpnWFyaSFemwGy9LD5/pkzuouaFYH1qF5iW6g69n0vA==
X-Received: by 2002:a5d:6782:0:b0:320:82d:59a8 with SMTP id
 v2-20020a5d6782000000b00320082d59a8mr8800904wru.62.1696227105139; 
 Sun, 01 Oct 2023 23:11:45 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 t6-20020a5d6906000000b00321773bb933sm8644815wru.77.2023.10.01.23.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Oct 2023 23:11:44 -0700 (PDT)
Message-ID: <d94e2f52-0bf4-1d97-e9d0-8f14efb3426a@linaro.org>
Date: Mon, 2 Oct 2023 08:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/9] hw/acpi: Add ACPI CPU hotplug init stub
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
References: <20230929124304.13672-1-salil.mehta@huawei.com>
 <20230929124304.13672-4-salil.mehta@huawei.com> <87y1gpnjf9.fsf@linaro.org>
 <00cb5ebaa2a246529a9095b5f7d185b4@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <00cb5ebaa2a246529a9095b5f7d185b4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.058,
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

Hi Salil,

On 29/9/23 17:47, Salil Mehta wrote:
>> From: Alex Bennée <alex.bennee@linaro.org>
>> Sent: Friday, September 29, 2023 3:27 PM
>> To: Salil Mehta <salil.mehta@huawei.com>
>> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org; jean-
>> philippe@linaro.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> lpieralisi@kernel.org; peter.maydell@linaro.org;
>> richard.henderson@linaro.org; imammedo@redhat.com; andrew.jones@linux.dev;
>> david@redhat.com; philmd@linaro.org; eric.auger@redhat.com;
>> oliver.upton@linux.dev; pbonzini@redhat.com; mst@redhat.com;
>> will@kernel.org; gshan@redhat.com; rafael@kernel.org;
>> linux@armlinux.org.uk; darren@os.amperecomputing.com;
>> ilkka@os.amperecomputing.com; vishnu@os.amperecomputing.com;
>> karl.heubaum@oracle.com; miguel.luis@oracle.com; salil.mehta@opnsrc.net;
>> zhukeqian <zhukeqian1@huawei.com>; wangxiongfeng (C)
>> <wangxiongfeng2@huawei.com>; wangyanan (Y) <wangyanan55@huawei.com>;
>> jiakernel2@gmail.com; maobibo@loongson.cn; lixianglai@loongson.cn; Linuxarm
>> <linuxarm@huawei.com>
>> Subject: Re: [PATCH 3/9] hw/acpi: Add ACPI CPU hotplug init stub
>>
>>
>> Salil Mehta <salil.mehta@huawei.com> writes:
>>
>>> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
>>> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
>>> stub to avoid compilation break.
>>
>> When does the compilation break? It's usually ok to include stubs with
>> that commit.
> 
> 
> To be specific. it is not a compilation break but linking error.
> 
> Support of ACPI_CPU_HOTPLUG is optional. This flag is defined in architecture
> specific Kconfig. Function cpu_hotplug_hw_init() is part of the hw/acpi/cpu.c
> which gets compiled only when a particular architecture defines ACPI_CPU_HOTPLUG
> flag.
> 
> ACPI GED framework support for CPU Hotplug is not specific to any architecture.
> acpi_ged_initfn() calls cpu_hotplug_hw_init() when GED device gets created.
> This functions gets called irrespective of the fact CPU Hotplug is supported or
> not. If ACPI_CPU_HOTPLUG is not enabled then presence of cpu_hotplug_hw_init()
> will cause linking error without the presence of stub.

We can extract the common pattern in both
- ich9_pm_set_cpu_hotplug_legacy()
- piix4_set_cpu_hotplug_legacy()
to take (AcpiCpuHotplug, CPUHotplugState) params,
then guard the cpu_hotplug_hw_init() call within
CONFIG_ACPI_CPU_HOTPLUG ifdef'ry. Doing so we can
also remove the acpi_switch_to_modern_cphp() stub.

Regards,

Phil.

>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> ---
>>>   hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)



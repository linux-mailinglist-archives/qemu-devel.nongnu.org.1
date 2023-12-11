Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05E80DA8E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 20:05:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClaA-00067Y-E2; Mon, 11 Dec 2023 14:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCla4-00066D-D7
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:04:40 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCla2-0004J0-Mf
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 14:04:40 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-54cc60f3613so6302104a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702321476; x=1702926276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M7B+qkKRt1OJsh4vhgJsZyqN07oZBgLdn5Sw6VNrjMs=;
 b=tmTVq/QsOk8e1RWnQF/sAgDISGW7cHo5AmiqC5BjlOOYeCBNkX3FvKGt1xtplJhoZV
 wrcxZYQn+xzn3iWbgtqkkw35BFBL6qZ9vA+jfbI81ZxNNG9feDeWflzQqCmHw4+BPd2A
 kZsRpWG6ZbkSIlOVMqwIYZ4IrOo4PZwoqkCg8aggdZmJA0qMHvm2mJdcr3QF84dhXqyU
 RPL+MsZAxxo//4OwwjS9bRlBvVeb7xSc3MOKOZFm+Hq6mkIgvsndloU1ogl+zFCA5lpp
 ta6QK5AhHOcu/AEHuJr6PTwvcnqfLuv0ZCdvfJ88aY8ouj0cZpGlxrlrB4hBBAWl0rBR
 oFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702321476; x=1702926276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M7B+qkKRt1OJsh4vhgJsZyqN07oZBgLdn5Sw6VNrjMs=;
 b=vjjy77Ge81pweBBUtS9DCD5OvaWS3Ib3oLy3mcndNw4CrNZnyCahwtyi+jFfL6VuDs
 dVt7Cwt3jnV70wRLJb9w0CCylEE+E54rapnVXfgIwpeAV6g/JMSSvSHcbOTHVHvIkKhX
 yoyFGKilQfXurmJe+KiNmUciF7uzaQbzmecQyDBLwdVQr5YXYIjSp8P01eFIsCPrJmiw
 OndbyQDTMfIKq+kRSagfIEGGXvLAulK11fZhHUv9eaJjojRnq+dcXoqYsuE3Nq1aqhHq
 XIBCWxUnt+9JrHiwpD9ppnlFlgWaS5bDw3+LYwDKdeGEnu99MEfhvlISp1D6WsECeJQR
 0rvA==
X-Gm-Message-State: AOJu0Yx+/mzYM5+r42swwxOPiY7atO2pb3ch36KlGSTHMjtLTKLpuY4r
 1zp/h+GOpiPadfSzdn/kpQmERg==
X-Google-Smtp-Source: AGHT+IHSFjrgEK7d3ZkSvy8Q25jmx8kpiQzWWXBKpLiP0KNvRNcw/WFfP3aPxjiaOZR0Yoz9qIji8w==
X-Received: by 2002:aa7:c654:0:b0:54d:b67:c48d with SMTP id
 z20-20020aa7c654000000b0054d0b67c48dmr2521254edr.75.1702321475962; 
 Mon, 11 Dec 2023 11:04:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a50c94d000000b0054dc979e31fsm3933703edh.2.2023.12.11.11.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 11:04:35 -0800 (PST)
Message-ID: <e2462fb5-228a-443d-93ce-7069998128b0@linaro.org>
Date: Mon, 11 Dec 2023 20:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU developers fortnightly conference call for agenda for
 2023-12-12
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, Juan Quintela <juan.quintela@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: afaerber@suse.de, ale@rev.ng, anjo@rev.ng, bbauman@redhat.com,
 chao.p.peng@linux.intel.com, cjia@nvidia.com, cw@f00f.org,
 eblake@redhat.com, edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com,
 eric.auger@redhat.com, f4bug@amsat.org,
 "felipe@nutanix.com" <felipe.franciosi@nutanix.com>,
 "iggy@theiggy.com" <iggy@kws1.com>, "imp@bsdimp.com" <wlosh@bsdimp.com>,
 jan.kiszka@web.de, jgg@nvidia.com, jidong.xiao@gmail.com,
 jjherne@linux.vnet.ibm.com, joao.m.martins@oracle.com,
 konrad.wilk@oracle.com, mburton@qti.qualcomm.com, mdean@redhat.com,
 mimu@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 quintela@redhat.com, richard.henderson@linaro.org,
 shameerali.kolothum.thodi@huawei.com, stefanha@gmail.com,
 wei.w.wang@intel.com, z.huo@139.com, zwu.kernel@gmail.com,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
References: <calendar-98548e19-3517-40fa-a2ae-1c384aa3f98f@google.com>
 <ZXcOtAIMqLjOheIa@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZXcOtAIMqLjOheIa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Zhao,

On 11/12/23 14:29, Zhao Liu wrote:
> Hi Juan,
> 
> On Tue, Dec 05, 2023 at 01:47:52PM +0000, Juan Quintela wrote:
>> Date: Tue, 05 Dec 2023 13:47:52 +0000
>> From: Juan Quintela <juan.quintela@gmail.com>
>> Subject: QEMU developers fortnightly conference call for agenda for
>>   2023-12-12
>>
>> Hi If you have any topics for the last qemu conference call of the year,
>> feel free to answer to this email. Later, Juan.
>>
>> QEMU developers fortnightly conference call
>> Tuesday 2023-12-12 ⋅ 15:00 – 16:00
>> Central European Time - Madrid
>>
>> Location
>> https://meet.jit.si/kvmcallmeeting	
>> https://www.google.com/url?q=https%3A%2F%2Fmeet.jit.si%2Fkvmcallmeeting&sa=D&ust=1702216020000000&usg=AOvVaw1xrpPSmMRu9niy1trqCKrA
>>
> 
> I want to talk about the RFC about QOM topology:
> https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.liu@linux.intel.com/
> 
> We would like to receive the initial feedback from the community on this
> direction to see if we are on the right track.

FYI I have your series tagged for review (for generic QOM /
machine [*]) but we need feedback from the x86 maintainers too,
and eventually from riscv/arm too, since they might end up
using your API.

[*] That said, I unlikely will have time the next 2 weeks.

Regards,

Phil.

> Thanks,
> Zhao



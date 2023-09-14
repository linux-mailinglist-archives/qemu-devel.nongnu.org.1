Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B7679FD5F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggyq-0006IM-Vo; Thu, 14 Sep 2023 03:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qggyo-0006G4-5I
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:41:38 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qggyl-00073x-72
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:41:36 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-502984f5018so1035104e87.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694677293; x=1695282093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hoacnYyPfsZkUVG3DUSeirmGTlliWMovYowd8cRwrQw=;
 b=GYOyQ4UJxWjzBouy5cNLCQUfq8wBOTWa3K9taK4EQco+HCMOcEv2nkt3c9YXcLZ8x8
 J+6rKpuFwVxccQsGZ+xJ9Z1IiKVkjsjxB/S6yAEZvLrWbXnbXgv4u8JaThthdnhUr6vZ
 gq09fEr0Xhj8t59R/Bk2zDpyH2YFbZeveTw4Pmac/XL7xQltcSQjMCoFL16mOCSz4npo
 zdEn9Hn1tveJo0P5MBMGZyVM8LLrUNI2le2i7u5pFMdums2TH3KBG7dcnsH5yZ0FjMhi
 F68Tm+ipI8lqRJO3bQCyC6KGRXDWjG0Y7FC1q7jpZwj4XaweF+mtdzz2L28lxroa5duR
 FrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694677293; x=1695282093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hoacnYyPfsZkUVG3DUSeirmGTlliWMovYowd8cRwrQw=;
 b=J/60sEEMlIh/n+YvgUwvpEN2BJkx0twAaCQUXQLz1+Zwg//pQkCyYsNEQhrocR1adG
 hyjKv7X83QqiGBuPcYkG8lqcRQ0U5N6XeYWHk5KBY1/Jrfzdv3iIb0lOeAunYsED6dQF
 b1c66LlVRYrh4X9I4ObsSgDwyANlNwuhopm7lvbrTZb360zouG6JoUw9KzH30+RHn6r9
 uc7KPUHoL95MCfuKGSejqxKztT3u5QVTp9qqfNJQh8PwEO3xas4bLRhyP4dYJKuC4P5Y
 ION8Dse2Sn/4rYCKHcHi3RrcpSGedUo4uiJfC4TJo2/swEchXt9o4r9mWyJxE4t3L57A
 SdsQ==
X-Gm-Message-State: AOJu0YyHPYwJlX9UX4H2VTNd2Pv8Dw1q00D5A0GX0xzzDhQM7AFMrK+I
 j9n1Yrn/wrGtjVqD2654q2BseQ==
X-Google-Smtp-Source: AGHT+IEtFuZ3O84gAkborwTw/bhyspsZdiM0BBSNCbdmoHbzaSxqkx1BUBYjlQ21TF8TtUaUS+2FdQ==
X-Received: by 2002:a05:6512:202a:b0:500:b2be:61e1 with SMTP id
 s10-20020a056512202a00b00500b2be61e1mr3427622lfs.58.1694677293202; 
 Thu, 14 Sep 2023 00:41:33 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 t18-20020a056402021200b0052fdfd8870bsm548764edv.89.2023.09.14.00.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:41:32 -0700 (PDT)
Message-ID: <75ea5477-ca1b-7016-273c-abd6c36f4be4@linaro.org>
Date: Thu, 14 Sep 2023 09:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 21/21] i386: Add new property to control L2 cache topo
 in CPUID.04H
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-22-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914072159.1177582-22-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 09:21, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The property x-l2-cache-topo will be used to change the L2 cache
> topology in CPUID.04H.
> 
> Now it allows user to set the L2 cache is shared in core level or
> cluster level.
> 
> If user passes "-cpu x-l2-cache-topo=[core|cluster]" then older L2 cache
> topology will be overrode by the new topology setting.
> 
> Here we expose to user "cluster" instead of "module", to be consistent
> with "cluster-id" naming.
> 
> Since CPUID.04H is used by intel CPUs, this property is available on
> intel CPUs as for now.
> 
> When necessary, it can be extended to CPUID.8000001DH for AMD CPUs.
> 
> (Tested the cache topology in CPUID[0x04] leaf with "x-l2-cache-topo=[
> core|cluster]", and tested the live migration between the QEMUs w/ &
> w/o this patch series.)
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> ---
> Changes since v3:
>   * Add description about test for live migration compatibility. (Babu)
> 
> Changes since v1:
>   * Rename MODULE branch to CPU_TOPO_LEVEL_MODULE to match the previous
>     renaming changes.
> ---
>   target/i386/cpu.c | 34 +++++++++++++++++++++++++++++++++-
>   target/i386/cpu.h |  2 ++
>   2 files changed, 35 insertions(+), 1 deletion(-)


> @@ -8079,6 +8110,7 @@ static Property x86_cpu_properties[] = {
>                        false),
>       DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
>                        true),
> +    DEFINE_PROP_STRING("x-l2-cache-topo", X86CPU, l2_cache_topo_level),

We use the 'x-' prefix for unstable features, is it the case here?

>       DEFINE_PROP_END_OF_LIST()
>   };



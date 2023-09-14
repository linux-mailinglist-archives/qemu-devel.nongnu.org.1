Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 271AA79FD4A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggqC-0000C2-AB; Thu, 14 Sep 2023 03:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qggq6-0008Sk-NV
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:32:39 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qggq4-0004i1-SL
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:32:38 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-986d8332f50so90074266b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694676754; x=1695281554; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sQkQg+WQaNXU/YUTIcWsqOCq+YZdIsih/0uurCVxt4s=;
 b=XeO0RTcSxNyloPJBGiC6EOB+jt/8nOahIDLgBz+tnIYjAiVhZjw6yBxNf28VXQRUu/
 4bjNgDlwp4PS5GR+13MC34sA4lSsgM8MAty/ujs9VC9b2RhpVI8qVONH3xB/DBf7e20G
 z8RhX4YqBi0+cxNyeXfGQCrpVYPsk59XxB4mabmaD2NaD9++KYVSsxUK/iiF7xazEQUg
 FflR6YIaAosQHGGqIYWLjPWjBVfJe1tukhu1nAUSSmqWEsG0lLNpdTkMDkCLDr7mt+gn
 N7zhNiP8QsPmDgS0w6fIfcAqGSRMneQgZL7ih08raIA+0rjhqgADKzSXEUB18+Cx+URI
 pmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694676754; x=1695281554;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQkQg+WQaNXU/YUTIcWsqOCq+YZdIsih/0uurCVxt4s=;
 b=FPC1zFsdGS592nTvwPeyVy03aaLV3SY9ylUjBiz5p5z9kcQMKU6ZybLVYodYzd7fM1
 P6ijvByAxXc5bmCxe9JCwNIby+hyZvX+oxGiQsmwLp5wcD8HpGw6vIHM7o9brYoUDfx/
 Kj73IMnAuo9lX0ST1XzJBf8opamVLnJwnCBN9jayJ5iLjZqj8vaDzQOPCNqzTy3bhPdf
 xnsZxRsWlEXltYiB2Oco+V+Q4ZOHzxVZTrjm62h2a90F63PIpfiG733qptTIvzihZ3Ef
 77rnUYGRhVITW1NJDrcJgsP8MxwkQXw0K5pYFWUmimdVrEBwcgDUqGNwMkH65Utitbzc
 TVdA==
X-Gm-Message-State: AOJu0YwxHnIFuQTV91lrDgBsJGh8gh2M9ZKFWLX7dB4ikrVyq9HkoGzu
 binNjTisQ0GQ4f0r+Grot/QrnA==
X-Google-Smtp-Source: AGHT+IGeWwXoWJSbO2YdWy2as/ETl2V4vZASu++SBccQOJdbtPyR5u0tZ2aeQz9fCh0jk10OCJzMCQ==
X-Received: by 2002:a17:906:1db2:b0:9a9:e3be:1310 with SMTP id
 u18-20020a1709061db200b009a9e3be1310mr3714790ejh.53.1694676754136; 
 Thu, 14 Sep 2023 00:32:34 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 w26-20020a17090633da00b00988be3c1d87sm590078eja.116.2023.09.14.00.32.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 00:32:33 -0700 (PDT)
Message-ID: <b6acd6c8-fffe-2826-bc02-0968af0236a1@linaro.org>
Date: Thu, 14 Sep 2023 09:32:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 04/21] hw/cpu: Update the comments of nr_cores and
 nr_dies
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
 <20230914072159.1177582-5-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914072159.1177582-5-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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
> In the nr_threads' comment, specify it represents the
> number of threads in the "core" to avoid confusion.
> 
> Also add comment for nr_dies in CPUX86State.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Changes since v3:
>   * The new patch split out of CPUSTATE.nr_cores' fix. (Xiaoyao)
> ---
>   include/hw/core/cpu.h | 2 +-
>   target/i386/cpu.h     | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



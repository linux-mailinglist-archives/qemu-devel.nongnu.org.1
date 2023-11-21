Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C67F285A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:07:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Mi5-0005iC-E7; Tue, 21 Nov 2023 04:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r5Mi1-0005hP-6X
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1r5Mhx-0005on-HJ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700557565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4Du3Ez0Zda862ORNrhEGOC6WRkRrWqRP1m9LddZkdg=;
 b=KCC0UnWb9j5R6Yj06UvkSz8KstpostJo1/vU9vfqZPRnjBat/8Ze0O6j+EyewBXhPi1YUF
 jdhfDvpEX7ldFvf4Mu3RjG8L9/Ox+cJhmt6vQrAtNgMHuEWIbqUStuI91zoYaXB2A+k6XY
 nxjPXRTjwhcBniDh96he08E3QeYiDQs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-XlK0OSAOM1OZaVRL8eZFXg-1; Tue, 21 Nov 2023 04:06:04 -0500
X-MC-Unique: XlK0OSAOM1OZaVRL8eZFXg-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6d664911ccfso1263267a34.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 01:06:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700557563; x=1701162363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4Du3Ez0Zda862ORNrhEGOC6WRkRrWqRP1m9LddZkdg=;
 b=sQNfNQCzVOP6yABS1gNhJmtXoomwejaWinJKCAVTVccC1Cm323aa0WHe34KN2gn1cs
 aeA2dXUwgV1S8LIGcxlTolKX8iK0lV8/uuPhi0TyyESvJNmVw7CDdjuAG8QGRElHL42U
 Qubd3ycdbyGx0aCM3La9FNNlzBtu5I1QfYNvejEndRx5NWS4UhPM4wXJ6UL8lESBNyi7
 Ng26D3FUgO0AeAsN0LMm159bivbVAJGueX3ce5W6YWw2lIcQGv8C9dgjEnZ6Y6aTejKT
 y5WbFjSMuCY0+g+qdn42SXX9vdxt7C8vSj8CXUa1xfq4dg4O5kRZCEhmSMhrFpFpF7h9
 hidg==
X-Gm-Message-State: AOJu0YxqyAlNjer2ZnlrTKJibEob6B2gBVaU2y6YeUp7Pj0yx2QI6K1j
 HbSnG3MGPrBNuxjbVp4+z4fAozegHReg8oAbML9jZuWTpO1AdSsA/gAmLUo0HYcD7QQTvn0rw5v
 k510SJTEvBzNBRL0=
X-Received: by 2002:a05:6830:6811:b0:6d6:b24e:72a8 with SMTP id
 cu17-20020a056830681100b006d6b24e72a8mr10227297otb.3.1700557563408; 
 Tue, 21 Nov 2023 01:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTb4Z0+/AwNUEmtEtawQMGDfVYM3FNwi3wwkQXY6Pd1m4oKWJHGfWI/8CNH6W3fKjlWFGoIA==
X-Received: by 2002:a05:6830:6811:b0:6d6:b24e:72a8 with SMTP id
 cu17-20020a056830681100b006d6b24e72a8mr10227255otb.3.1700557563183; 
 Tue, 21 Nov 2023 01:06:03 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a656710000000b005b83bc255fbsm6338717pgf.71.2023.11.21.01.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 01:06:02 -0800 (PST)
Message-ID: <139cc093-8469-0a8f-69dd-e1d8471030a3@redhat.com>
Date: Tue, 21 Nov 2023 17:05:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V7 8/8] docs/specs/acpi_hw_reduced_hotplug: Add the CPU
 Hotplug Event Bit
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-9-salil.mehta@huawei.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231113201236.30668-9-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.009, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 11/14/23 04:12, Salil Mehta via wrote:
> GED interface is used by many hotplug events like memory hotplug, NVDIMM hotplug
> and non-hotplug events like system power down event. Each of these can be
> selected using a bit in the 32 bit GED IO interface. A bit has been reserved for
> the CPU hotplug event.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   docs/specs/acpi_hw_reduced_hotplug.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/specs/acpi_hw_reduced_hotplug.rst b/docs/specs/acpi_hw_reduced_hotplug.rst
> index 0bd3f9399f..3acd6fcd8b 100644
> --- a/docs/specs/acpi_hw_reduced_hotplug.rst
> +++ b/docs/specs/acpi_hw_reduced_hotplug.rst
> @@ -64,7 +64,8 @@ GED IO interface (4 byte access)
>          0: Memory hotplug event
>          1: System power down event
>          2: NVDIMM hotplug event
> -    3-31: Reserved
> +       3: CPU hotplug event
> +    4-31: Reserved
>   
>   **write_access:**
>   

-- 
Shaoqin



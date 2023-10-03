Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4D7B5DFE
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 02:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnT1L-0002pa-Nl; Mon, 02 Oct 2023 20:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnT1J-0002pN-Oa
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnT1C-00008h-HT
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696291925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOalhfNb/eZqIOQ/CLiocaKQNVnKGkw2Uypd4hV8Y80=;
 b=a4MIKHyRuvGE9lg+8wnd6NyOL48Y9CYXWaSmHkWD9E5lgW8p7kJImgsHHk8R/gyhk6f0Kz
 Z806ybgm9+zCLqZQ0Cvsf1QzDMIkTF+i+c2sZyidsYGSsOoracEBwTVGrJNJihT7C8ThYs
 yfxMBpnSuarjlJQwJa9Tbd2ThGUzkkY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-rY34z3grMKKvFF-LbuoyUQ-1; Mon, 02 Oct 2023 20:11:54 -0400
X-MC-Unique: rY34z3grMKKvFF-LbuoyUQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-690bb524a97so335301b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 17:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696291913; x=1696896713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vOalhfNb/eZqIOQ/CLiocaKQNVnKGkw2Uypd4hV8Y80=;
 b=I81kXu+/F8yJl1VK0FR2dXbBCpopVcFnrDHMbxEru0oQEJo1792V4cjBso3gaVGLeZ
 MtKIURMKhmyeKiboJnokuxO1c9hbLVpuuj4Cy7OPnEUAAZPi5Y1ogwEwZe+hbmVRD00i
 WLqxENX/RT3buQhdwV9dt9eluHdYa1THykAF8vZS0UnLdlrKzYwwB88SDufbXnCi1jKO
 xAshWYnENGf88mJI0o3nLE4We2NATrzYVFvZmPSY2TOWYKummqR2j0XDuxlAva8I8G/G
 ax7U5/xZg8REMJlvmk94MNj60jkWYZ7s7m73CaVHA1P5rUxI/Y9+HHAlxFZ7FOGodz7c
 BX6g==
X-Gm-Message-State: AOJu0Yz6WVEAwV9t6pQxM7eZbpmjylIUVEyMRcegsz6WOE9PWlYfuXGQ
 eTZf4mNdrmpvDTcpUbiZbrLqf0aqCN8MSMo4FhPlEz77hBRjadaF1fT09ANn9RVYUQ6lH7+piOA
 fKuQsH4OwUC3dWiw=
X-Received: by 2002:a05:6a00:1393:b0:68e:3d83:e501 with SMTP id
 t19-20020a056a00139300b0068e3d83e501mr16145939pfg.13.1696291913628; 
 Mon, 02 Oct 2023 17:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI2ajdr1Xftqn8qtjxZj640Tqob8MVk/8QE5lNFlwsGy4f9x6ElB76KcAm7XD7YIeggJX8kg==
X-Received: by 2002:a05:6a00:1393:b0:68e:3d83:e501 with SMTP id
 t19-20020a056a00139300b0068e3d83e501mr16145914pfg.13.1696291913373; 
 Mon, 02 Oct 2023 17:11:53 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 e26-20020aa78c5a000000b00693390caf39sm72190pfd.113.2023.10.02.17.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 17:11:53 -0700 (PDT)
Message-ID: <4134b7ab-7a76-77b9-e8c0-7e6d75e0ad50@redhat.com>
Date: Tue, 3 Oct 2023 10:11:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 07/10] hw/acpi: Update ACPI GED framework to support
 vCPU Hotplug
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-8-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-8-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/30/23 10:19, Salil Mehta wrote:
> ACPI GED shall be used to convey to the guest kernel about any CPU hot-(un)plug
> events. Therefore, existing ACPI GED framework inside QEMU needs to be enhanced
> to support CPU hotplug state and events.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/generic_event_device.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



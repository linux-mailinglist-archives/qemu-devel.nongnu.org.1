Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 675AB7B5DBB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:29:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSLk-00066H-2m; Mon, 02 Oct 2023 19:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSLh-00065r-F4
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:29:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSLg-00016o-0D
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696289351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdb0u2mZD7engjCM6+bzo8+dGWnLDDh0vZKGl79Muy8=;
 b=DtDjYIXESi3P/opxXcInIK6ZhyQKCSSN1hgPOaVRbAqAbJ03Ydnib6hkLeIEYKJDOZpHar
 oFRkgxYq9zBfXomhuC2CL+c8MtM5Cxg279MeQKoDMiLJkctJzRBx3r44F917rpf+LwWZIo
 eTMROlMw8dh2XQcmAukTezJM7gmZKeE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-v_D_wJBsPdKicAYYiJ3oWg-1; Mon, 02 Oct 2023 19:29:08 -0400
X-MC-Unique: v_D_wJBsPdKicAYYiJ3oWg-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1c61aafab45so3261705ad.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 16:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696289347; x=1696894147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdb0u2mZD7engjCM6+bzo8+dGWnLDDh0vZKGl79Muy8=;
 b=HXGIrxWk50u6vrMV4E5SRrKmxP8BycJVQ7lsOlAmtOFKIAIMDr4itSyiiw4R5OcYP/
 5MNFYz7/CPQ/vEon3ehABIa4j0LVyqKNcA/f0izdtt2/buEIHr7dD1IkoVfLDDn+0NGs
 fGgD7yqN641rR1GRuYzSegRR/CkiA3gFmjyCGKra8McLqo13O7k6QuEFveRDaRMZOF0a
 jiAHMUkUy2SLN11fh1ISn8+dD+KS0vhepoFKKo1Ii6YLjqheIEFV57A3QQ/2EC/WD8OW
 jpxsNFiQaMj+BkIDZQnVqo73YSUlr8YRFu5tgWr2eGZgwDOwwEIkUxJM62MjfUNsiRZE
 etkA==
X-Gm-Message-State: AOJu0YyzIibIgycxL2uzdvmi8el7R/SmE3qe844uEn2xf8QAIj+16cLs
 Fnxpm1/KcTMBJeg+fjmFDID0gKXOaySwctO8Fpvnqt2KT7+5UPldP+7yu1JjDyh+BMtS7wa5D/8
 902ulLRl5p/V0of8=
X-Received: by 2002:a17:902:b58c:b0:1c3:3347:996e with SMTP id
 a12-20020a170902b58c00b001c33347996emr9815307pls.23.1696289347582; 
 Mon, 02 Oct 2023 16:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD/cqepNhy4Zs+AKTsabuQ+Lg2FxlzYaNUaucTM+dYNhMQ/RDrv46GGWzD0/VdUIu63v/Efw==
X-Received: by 2002:a17:902:b58c:b0:1c3:3347:996e with SMTP id
 a12-20020a170902b58c00b001c33347996emr9815290pls.23.1696289347311; 
 Mon, 02 Oct 2023 16:29:07 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170902ed1300b001c0ce518e98sm1118pld.224.2023.10.02.16.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 16:29:07 -0700 (PDT)
Message-ID: <2e4705a5-3c24-ae6a-e030-b3d5f4f2e37a@redhat.com>
Date: Tue, 3 Oct 2023 09:28:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 04/10] hw/acpi: Init GED framework with cpu hotplug
 events
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
 <20230930001933.2660-5-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-5-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/30/23 10:19, Salil Mehta wrote:
> ACPI GED(as described in the ACPI 6.2 spec) can be used to generate ACPI events
> when OSPM/guest receives an interrupt listed in the _CRS object of GED. OSPM
> then maps or demultiplexes the event by evaluating _EVT method.
> 
> This change adds the support of cpu hotplug event initialization in the
> existing GED framework.
> 
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/generic_event_device.c         | 8 ++++++++
>   include/hw/acpi/generic_event_device.h | 5 +++++
>   2 files changed, 13 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



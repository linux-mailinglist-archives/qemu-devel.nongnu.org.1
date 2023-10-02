Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C23C7B5DA7
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSCh-0002lC-Ef; Mon, 02 Oct 2023 19:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSCe-0002kC-Ux
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSCd-0007Vw-JI
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696288791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Vs0EGAymtTvEBv2kg8ycVMlwZ6qOaMg/mXgYFFPxHE=;
 b=FZjE3L7hieXKTKiGTee/UPemgZXGU1455pqp2r5QCn4QCA66AWHsNnilw7EAoKhOdAMEub
 M1EqDyBn7zgGtDPDYQEX2JzgvXT6ZJNL8cpobogzhdnAoQUnuEAMphG4WlMMoIoOB/okcz
 LYovdo625ui7+bYcvar+V5Iqm1qM634=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-i2sea5avNkyCJgyKhSz0DA-1; Mon, 02 Oct 2023 19:19:49 -0400
X-MC-Unique: i2sea5avNkyCJgyKhSz0DA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-692a9b68f1aso201966b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 16:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696288788; x=1696893588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Vs0EGAymtTvEBv2kg8ycVMlwZ6qOaMg/mXgYFFPxHE=;
 b=A5zl6AFr/JfCcUK/NDCgLPvnJphSHl9u6Nkis/5+9bRmzZi7qazdXHzTVux0Q/Z+7m
 PAVjEI3Wih2wpFwiOM44f07ub7YJmfuI07F3IaISFSfAuUOtTGBL+qb0kZeB3A+LTBfY
 WNuCDmme8XV6ckh41E4omWSIbSfuOZdImv6XQ6WJY0NlXi7uQjJnybRSImW4na4SlpR0
 m7JUyW8mDvmRaF3jWCFWJ28kkn2xbRbI+FwR4PDopnfvQpwdwgU0CDoa00zlzc3jipSg
 iEO3szbZg1j4AtytaKHcyTlzwVvh6nUhCPwPwcGmxrmqnfoqNRq17t3I/VUa8OCAFegg
 qJqg==
X-Gm-Message-State: AOJu0Yx08HKNES++rsP37sVEcndTRPT/cLLrEbKyRg2rvSbgiF/RTT6p
 rY5JelfpK7u7wUPYU9y+bL5Kg194yGMweNWO8TRCXlGLeqgTAkyt76O1auwew9vCDOv4BioGa+C
 ZP3zFItRM3xaHQlk=
X-Received: by 2002:a05:6a00:188d:b0:68b:a137:373d with SMTP id
 x13-20020a056a00188d00b0068ba137373dmr1917697pfh.17.1696288788297; 
 Mon, 02 Oct 2023 16:19:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEetRydvEVhlIKQpEha3xBVXc6HN4ZBQ6leqkrlfooSCMs/7V1Jm0Mdr0LMBlgra157PxwcJQ==
X-Received: by 2002:a05:6a00:188d:b0:68b:a137:373d with SMTP id
 x13-20020a056a00188d00b0068ba137373dmr1917664pfh.17.1696288787917; 
 Mon, 02 Oct 2023 16:19:47 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 x27-20020a056a00271b00b006884844dfcdsm37163pfv.55.2023.10.02.16.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 16:19:47 -0700 (PDT)
Message-ID: <64ecbf50-2287-6bd4-d2bd-e37a793ed6a9@redhat.com>
Date: Tue, 3 Oct 2023 09:19:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
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
 <20230930001933.2660-3-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-3-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/acpi/cpu.c                 | 2 +-
>   include/hw/acpi/cpu_hotplug.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



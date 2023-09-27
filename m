Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0287AFB1C
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 08:31:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlO4F-0006Ke-BL; Wed, 27 Sep 2023 02:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlO4A-0006DA-Cp
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlO48-0001fW-SL
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 02:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695796232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwpqGyZbXBaIK7l/zifkXJjTSF/FIiPZ4s+Omj0Z/Zw=;
 b=D2vz3CWEy82bODzFg/Em0oCp8pu/X53YspWyLxBpNP3e2EDzjVHhAs5dY4TSX+Rauu7ndx
 NRqRMCZ52X9JX1zLMswEV6pdLlIGwjpP3ZhuZoCogfPcnW/C0tBhImUpGSBSlbkn3a/h9Z
 IegQlb6splPvx7uVV4J71Qkv49MmKQs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-z-5Dw3T3MOCp0C_q75Dm3g-1; Wed, 27 Sep 2023 02:30:30 -0400
X-MC-Unique: z-5Dw3T3MOCp0C_q75Dm3g-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-692a9b68f1aso11742587b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 23:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695796229; x=1696401029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GwpqGyZbXBaIK7l/zifkXJjTSF/FIiPZ4s+Omj0Z/Zw=;
 b=DFMzvjEZEwZn+enX55t7YWh2IN/YF85u2egrl13quKMcTR1ZQ9nqvim0+/nivGkNcR
 REZFvkQMnu/MitK/qd1DCRdZBhhoWuDWzWMwxt40FoqQ+goUsjmzu69xBNl+7eGigyCf
 l+fk1J3Umrl4jFSRyGl3K70MOkajd9us6PwCPdV/zNSdKJ/d+3zwuNx0zEu44I3fnY92
 NHj7X5ClBABh7iRgu+esb6UH62UIP17UbGvecLfheraRQ94/yWuO0gyZCn6fHRmbC9Mm
 hkY5sBBvufay+9cSNQzl7j1Iux7wJ7j2ucFPQ9T6ZfiKcYHnq4WBGXaeUgCeMuC7mLlP
 6l7g==
X-Gm-Message-State: AOJu0YzSbLqskbvfK6YmSKoYqfyZNvLpzsbrxoqIepm8iRbmqtc8Q/XX
 Bh3vcLBLX6xTvlN/G594WgBecdkFiqLUKxqKu+1odnHPkQFJxdLcU2NrKJ6f2PsBQNBf22fsIse
 4JBFzYwdIkZfxa48=
X-Received: by 2002:a05:6a00:813:b0:68a:6018:a66f with SMTP id
 m19-20020a056a00081300b0068a6018a66fmr2144653pfk.2.1695796229523; 
 Tue, 26 Sep 2023 23:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1ha3saRy5KYCnV49eLMs7cCXBU0WLooX83DEg/cnans0UGvDHmw67pV7kBXV+VGnZSRgpA==
X-Received: by 2002:a05:6a00:813:b0:68a:6018:a66f with SMTP id
 m19-20020a056a00081300b0068a6018a66fmr2144601pfk.2.1695796229216; 
 Tue, 26 Sep 2023 23:30:29 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a639303000000b005706b9813afsm10515080pge.90.2023.09.26.23.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 23:30:28 -0700 (PDT)
Message-ID: <41003807-062f-1121-956e-72e0444e048f@redhat.com>
Date: Wed, 27 Sep 2023 16:30:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 04/37] arm/virt,target/arm: Machine init time
 change common to vCPU {cold|hot}-plug
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-5-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-5-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 9/26/23 20:04, Salil Mehta wrote:
> Refactor and introduce the common logic required during the initialization of
> both cold and hot plugged vCPUs. Also initialize the *disabled* state of the
> vCPUs which shall be used further during init phases of various other components
> like GIC, PMU, ACPI etc as part of the virt machine initialization.
> 
> KVM vCPUs corresponding to unplugged/yet-to-be-plugged QOM CPUs are kept in
> powered-off state in the KVM Host and do not run the guest code. Plugged vCPUs
> are also kept in powered-off state but vCPU threads exist and is kept sleeping.
> 
> TBD:
> For the cold booted vCPUs, this change also exists in the arm_load_kernel()
> in boot.c but for the hotplugged CPUs this change should still remain part of
> the pre-plug phase. We are duplicating the powering-off of the cold booted CPUs.
> Shall we remove the duplicate change from boot.c?
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Reported-by: Gavin Shan <gavin.shan@redhat.com>
                            ^^^^^^^^^^^^^^^^^^^^^

                            <gshan@redhat.com>

> [GS: pointed the assertion due to wrong range check]
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c      | 149 ++++++++++++++++++++++++++++++++++++++++-----
>   target/arm/cpu.c   |   7 +++
>   target/arm/cpu64.c |  14 +++++
>   3 files changed, 156 insertions(+), 14 deletions(-)
> 



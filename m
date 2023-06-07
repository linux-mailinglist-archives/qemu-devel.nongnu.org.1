Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B40725795
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oVZ-0007Xf-V0; Wed, 07 Jun 2023 04:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6oVX-0007XE-6j
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:27:07 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6oVV-00027o-F9
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:27:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3094910b150so7119904f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686126422; x=1688718422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ov8DVkqk0/GnlLHPSdfwgUckan2NH6QZZ/WO4z/5BIE=;
 b=fGItJxrtCktROD5HM1NGyT4RvtpNmZY1dNgHqmlgPCeV76sUvk3rUopkj0yABjDJMo
 i+HAdAfTpVL826rWMifhrktW4y5tTxnNdJLmF/hQM8XXdWKeAH27Pv+HpzbaOIOL2pfW
 vFhGStGPf61HZ/TD5GZRnxK6qSdLy4Ei2TZZvO++/gSdWjx5tMQmNnC9Ts+iJEDjZfJW
 mJOyghaRVoN1e+5HEfdX7ZG1P8rDXR0mCHuQ8hwKbtNnSZz/qgmlzWMNNo1Hu9mSETXs
 riYcMgQH3xpBOLL4g2Z6wNYKjx/me0qUQKBinva1jFml0LP8hyl2KfpXttZgTBeMptXk
 8biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686126422; x=1688718422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ov8DVkqk0/GnlLHPSdfwgUckan2NH6QZZ/WO4z/5BIE=;
 b=N2HbQohJvatCOvUxjK9rNvpmIcIfCy287IqL780aP5Snxy0xHSYQnsv6Bkl+Qtn7T6
 QikmjxoFsE5RLPEPbeTrXlrdEF/AeGXv7WOPQ7gCjCYVeA5AHrGw/TIEzf7R5+m4Whaf
 muvFN047280vol+RxxrKn5t1oaRbmgsZceqrIaACSAAahCgRa7jpmrl6JI1hBa4nm8OY
 7XwFcx18STJGhm6nzO8+19doQWnPBPTd6Jq2R+YNwZIxpAVKgsvoSPvW55yp/cdWCmfP
 MYVK5j8Lhh0vr69ldVHDs/QlCYU0SukCT26UEe8xCCPgPg3elCSNq909yNT1SXIEiWPe
 TofQ==
X-Gm-Message-State: AC+VfDxohMJB/rogSLtLj+VbHKWyb9H6+Fsnt9iJ3K9Z4RKtfpYaOU6F
 Gzz7aabwiorGAKXMJWhHAC0IKQ==
X-Google-Smtp-Source: ACHHUZ6yz41Uuq01pPBjnKkI4pnEqk50LoGsjciKHW3kZDSAT2ZMP5A8evVazR2nrO43hc0C2HxMCA==
X-Received: by 2002:adf:f20b:0:b0:30a:d8f3:3e41 with SMTP id
 p11-20020adff20b000000b0030ad8f33e41mr3855529wro.7.1686126422369; 
 Wed, 07 Jun 2023 01:27:02 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 o10-20020a056000010a00b002e5f6f8fc4fsm14692824wrx.100.2023.06.07.01.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 01:27:01 -0700 (PDT)
Message-ID: <81b16f60-87d6-3043-3f1c-d77f1bf8a1c4@linaro.org>
Date: Wed, 7 Jun 2023 10:26:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v5 3/3] pc: q35: Bump max_cpus to 1024
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, imammedo@redhat.com,
 berrange@redhat.com, jusual@redhat.com, dfaggioli@suse.com,
 joao.m.martins@oracle.com, jon.grimm@amd.com, santosh.Shukla@amd.com
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/6/23 04:49, Suravee Suthikulpanit wrote:
> Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
> 
> In case KVM could not support the specified number of vcpus, QEMU would
> return the following error message:
> 
>    qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid argument

Odd, we already check the upper limit with KVM_CAP_NR_VCPUS.
See in kvm_init():

     /* check the vcpu limits */
     soft_vcpus_limit = kvm_recommended_vcpus(s);
     hard_vcpus_limit = kvm_max_vcpus(s);

When testing your series I get:

qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested 
(1024) exceeds the recommended cpus supported by KVM (710)

$ uname -srvp
Linux 5.15.0-71-generic #78-Ubuntu SMP Tue Apr 18 09:00:29 UTC 2023 x86_64

> Also, keep max_cpus at 288 for machine version 8.0 and older.
> 
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   hw/i386/pc_q35.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)



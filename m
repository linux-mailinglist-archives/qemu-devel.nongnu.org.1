Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A365A7B5FA3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 05:56:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnWUl-00066r-Fb; Mon, 02 Oct 2023 23:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnWUj-00066e-WD
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 23:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnWUi-0004Lp-Ik
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 23:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696305287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrYrDxi+S+gVlha9sRw3YPioUlNo4RlyvOryR9oApwo=;
 b=YirC2qbk9+ZtYCFUaMBN4QCfKA9clzuh+KOwDwsa/PrBeD9BqoSa5VVSRjLApplmmF5K3h
 tSj3yuSr9tqfx5KrwMetDSY9DiApHypPCfC36ID0cj7xIHzVsrNAgFjq4YY7lDhH7viQnM
 x8iOtRbHpx9LM802QEXmSg7Lc5GNQ9k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-5fztAiAZOBe3v0Mjn1pnjw-1; Mon, 02 Oct 2023 23:54:31 -0400
X-MC-Unique: 5fztAiAZOBe3v0Mjn1pnjw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-279353904a9so369618a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 20:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696305270; x=1696910070;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hrYrDxi+S+gVlha9sRw3YPioUlNo4RlyvOryR9oApwo=;
 b=HDX5SWvzUxT61FAaxshUgxa3HB53cwwgxsf9mZ2uljQgEGauh/lWen4QffLtL+8nUR
 NEIBvfVd1n2WGroOHdwDnlnCbU8p7LTvYg6NlXhMH5ae7i+kti7rCuFdx/jK+CFo/l56
 wtQ3yddvwyHg+UFYysuc7/5P9jBjdpM708nBRF1X6N6oW3/T5DvVtqtNBTfQNPr5eg/6
 FLDbaOZa/50ad5rOP+Vw8uTEfepnIK6cd3FP+ANfUrvn0LKMNIaqDy013NeMU15Gt724
 LvLIBwO33lyCsGWgmfZqy/mWuvNnHWccF7NdhvYXvmAWc7JQ8J0EUjLh3qui6kYHWZRh
 5SKg==
X-Gm-Message-State: AOJu0YxL70fdkNneGtNjYpGpZJG1TbLBWTBGTNt7udjeKdy7e7YDmDpC
 rNr9TfSsSJLpQUCKkiJeUmxh5+B5o3uIRnVjXQG9wLOewxHxu3QCij7q7945DE3iaqxzATr3gCZ
 WB/mASFejGDsQTu8=
X-Received: by 2002:a17:90a:bf93:b0:26d:2b1d:1982 with SMTP id
 d19-20020a17090abf9300b0026d2b1d1982mr10022961pjs.24.1696305270158; 
 Mon, 02 Oct 2023 20:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrLgLeQfpEPih1/cqxszlR2ty8zHRUwROX71tWZgKV+nGG5BuEcjhLB6ACot7w9PYxxQw5dA==
X-Received: by 2002:a17:90a:bf93:b0:26d:2b1d:1982 with SMTP id
 d19-20020a17090abf9300b0026d2b1d1982mr10022925pjs.24.1696305269814; 
 Mon, 02 Oct 2023 20:54:29 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a17090acc1500b0026b6d0a68c5sm248072pju.18.2023.10.02.20.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 20:54:29 -0700 (PDT)
Message-ID: <17e7d901-be4f-bb62-0c05-9e2c432335e5@redhat.com>
Date: Tue, 3 Oct 2023 13:54:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 10/10] target/arm/kvm: Write CPU state back to KVM on
 reset
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
 <20230930001933.2660-11-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-11-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> When a KVM vCPU is reset following a PSCI CPU_ON call, its power state
> is not synchronized with KVM at the moment. Because the vCPU is not
> marked dirty, we miss the call to kvm_arch_put_registers() that writes
> to KVM's MP_STATE. Force mp_state synchronization.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/kvm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399667BE49C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 17:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qps4r-0003tg-1F; Mon, 09 Oct 2023 11:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qps4o-0003tC-TJ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qps4n-0002Yw-Jg
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 11:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696864905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDJrEpCSBJJB1M5Nf7IS/ukbAEF1qbAyaYsHfFthvwM=;
 b=jFBeIFRrer6rZK+PgVgeVOX3gtNsXHvNc6ctIg+1RZRaAWA5TqSuhTMzlwogUVspwerqmX
 hJvusDK8oUanQsNMVkbWmyqJ/ApHFWoED5ABsLyQvAbAok/4L1O5p9UePp0KEGVFuZ4PKN
 lHAnOc35MVXsm8jo9YQ0cqrh1H403xM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-cnixwVnONDKoMHqFiDZkFw-1; Mon, 09 Oct 2023 11:21:32 -0400
X-MC-Unique: cnixwVnONDKoMHqFiDZkFw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31fd48da316so3025349f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 08:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696864891; x=1697469691;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SDJrEpCSBJJB1M5Nf7IS/ukbAEF1qbAyaYsHfFthvwM=;
 b=Z2hUn4udwxeVu+HvIeHXz7Xe+QCYU6oFLR2HQSuvlqWG2/RTp0yWjiy9pMfH/l5UfG
 njHeX6H9TMTOGOgooGKNnFaw08zhBnOtEbTjdMXGB4XsZEz37E0Eao4Gfd8snaoD8RKB
 4IzqcQSOrQqsIpc6xPoUeRnYI7EV910AE305b4QCB3BCv/cOVD/RZlBtLK1/WP+WNZBN
 VzBmtLHf1jBM/iYvGudYnk/FRheCVVNmVlASRun0kL4c5V7i7wXxmEuwveGK5v/LKfDQ
 nMm+nLtiYkRBJKezoy1EO8U4TIg8lnM0/jjqwC6cURFXQkFB+DPOJsvpK5dRJ+8pU7SK
 FXfg==
X-Gm-Message-State: AOJu0YwAeu6zMzOy3IppEIwlUuVVAudxNdKMXSqoF8mQAWUSj3ao3KKw
 VNMKZXKT1b67ON2c3FGwureT3PeUy5HNI+WLKvT2n1vi83q8YwHm/YJHg0kX24o4ZU02F8lHg+R
 zA7bU6zGD/TK8Rxs=
X-Received: by 2002:adf:e3ca:0:b0:317:6a07:83a7 with SMTP id
 k10-20020adfe3ca000000b003176a0783a7mr13789202wrm.38.1696864891560; 
 Mon, 09 Oct 2023 08:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZTfeuHekvbrLadDKpQP+OXRWydKZjWD/eykvhI7e7GS5lZG2t/t2vr9WTPoxSv+Zoq738sQ==
X-Received: by 2002:adf:e3ca:0:b0:317:6a07:83a7 with SMTP id
 k10-20020adfe3ca000000b003176a0783a7mr13789115wrm.38.1696864890057; 
 Mon, 09 Oct 2023 08:21:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a5d4ace000000b00327cd5e5ac1sm9951674wrs.1.2023.10.09.08.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 08:21:29 -0700 (PDT)
Message-ID: <792f9f38-6031-1269-109e-941d2ecaddf9@redhat.com>
Date: Mon, 9 Oct 2023 17:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 01/10] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-2-salil.mehta@huawei.com>
 <a02eae26-6018-6f5c-1b82-e6061544022b@redhat.com>
 <63f8e47efcd045b1b8481f6fd427c4b1@huawei.com>
 <ae2e0fc1-7967-2bae-e4fa-b4d886ba4671@redhat.com>
 <0c972e213f9a46c3a595dc7f933046aa@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0c972e213f9a46c3a595dc7f933046aa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

> 
>>
>> kvm_precreate_vcpu
> 
> pre-creation is very much specific to ARM right now. I am not sure
> if it is right to have an API with this name in the code which is
> common to other architectures.

I don't like exposing the concept of "parking" CPUs externally, which is 
so far handled completely internally.

[...]

> 
> 
>> kvm_create_vcpu
>> kvm_destroy_vcpu
>>
>> One could even make kvm_create_vcpu() fail on ARM if the VCPU hasn't
>> been pre-created.
> 
> Right now, we abort the CPU initialization process if this happens. I
> am planning to change abort() into 'fatal_error' in RFC V3 though.
> 
> 
> 
>>
>> Or did I get it all wrong? :)
> 
> I won't say that it is just another point of view which is absolutely
> fine. But I would like to stick to current APIs.

No really strong opinion, I wouldn't do it that way. I'll let others 
chime in if they have an opinion.

-- 
Cheers,

David / dhildenb



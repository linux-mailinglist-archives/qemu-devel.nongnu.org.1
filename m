Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D173F0E3
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 04:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDyXc-0007me-Ow; Mon, 26 Jun 2023 22:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qDyXX-0007mE-Ir
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qDyXW-0006Wc-0t
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687833284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wu4+qGRzze9rNAF/oBI8QT0UDNN6zhdjUkN+ApOnm6A=;
 b=On6sbPQZFXZ/2FBwM9y4LTr5erS/FaJBqMreL8Rguh4E+5kjL5Pcet/oNzSw7fgsrM6y2H
 Y+rH/3xTntGr+gfEYYhUpuXMsr+hGVRz4eJASD0E7OVQnlW5PGfVMoEYke0hYcwtuPtVlF
 obl0LR7/4A2cWRY7JxQDfvVOMOsuadk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-llgPsn54MZaGPPtLyrv7Jw-1; Mon, 26 Jun 2023 22:34:41 -0400
X-MC-Unique: llgPsn54MZaGPPtLyrv7Jw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b80c4ca6c5so1278575ad.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 19:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687833280; x=1690425280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wu4+qGRzze9rNAF/oBI8QT0UDNN6zhdjUkN+ApOnm6A=;
 b=PDVB0MxkyJnBsVSSMZupKL66BMV1qwWH8BINSvZ2ttAwPh7yKnTi3YEpF2JB9J246w
 f0b8WgsTA69wgbWseYJFDT3ZYEYTMd2N16izqpPRgXl2p6loO9aA+ywaU05eE17C4uXN
 JpkFigS0A9krsKJYK7wmu5PItwATYnqgh1oczkboBQpUjmR6yhNwsDrOmzNAWhFKLP4L
 XC8BxMWZaywEIRsLtenAoF0Bv6JXND3mHtRHhj9ODjKBFGtyjuMDwkPomOiN4eFvq8df
 lYGUNi8BkHzCQxVqlEFQMXZ6ZzQKDAWkrq8D/AiGgnY57R/JqRB4kFoPqoJuWrim3XIn
 5dig==
X-Gm-Message-State: AC+VfDzIJP3YBjJ/gWyO7ApmgUp/oPBKR/p+pas7BNa2jjnHk4fMQ7Tt
 dEKCkvFw362J2CoDGdAKGhF7Sbsz6sK04hCqb/EfKemxfhpB2qyCsnlxD4yV1XGzDcTnn8ZoVpd
 yJah3kc0O1lPnbvo=
X-Received: by 2002:a17:903:1ca:b0:1b5:32ec:df97 with SMTP id
 e10-20020a17090301ca00b001b532ecdf97mr36654234plh.5.1687833280754; 
 Mon, 26 Jun 2023 19:34:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6yE6lyZOsSy5asQLEIJAm4foiQaPUY/FsSOYw03E80E6jiejKP5iLw6DKgjFN0Ijz8VV/FTg==
X-Received: by 2002:a17:903:1ca:b0:1b5:32ec:df97 with SMTP id
 e10-20020a17090301ca00b001b532ecdf97mr36654214plh.5.1687833280521; 
 Mon, 26 Jun 2023 19:34:40 -0700 (PDT)
Received: from [10.66.61.39] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 jn22-20020a170903051600b001b3eed9cf24sm4821765plb.54.2023.06.26.19.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 19:34:40 -0700 (PDT)
Message-ID: <fb5e8d4d-2388-3ab0-aaac-a1dd91e74b08@redhat.com>
Date: Tue, 27 Jun 2023 10:34:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 0/5] target/arm: Handle psci calls in userspace
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "gshan@redhat.com" <gshan@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@opnsrc.net>
References: <20230626064910.1787255-1-shahuang@redhat.com>
 <9df973ede74e4757b510f26cd5786036@huawei.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <9df973ede74e4757b510f26cd5786036@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Salil,

On 6/26/23 21:42, Salil Mehta wrote:
>> From: Shaoqin Huang <shahuang@redhat.com>
>> Sent: Monday, June 26, 2023 7:49 AM
>> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: oliver.upton@linux.dev; Salil Mehta <salil.mehta@huawei.com>;
>> james.morse@arm.com; gshan@redhat.com; Shaoqin Huang <shahuang@redhat.com>;
>> Cornelia Huck <cohuck@redhat.com>; kvm@vger.kernel.org; Michael S. Tsirkin
>> <mst@redhat.com>; Paolo Bonzini <pbonzini@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>
>> Subject: [PATCH v1 0/5] target/arm: Handle psci calls in userspace
>>
>> The userspace SMCCC call filtering[1] provides the ability to forward the SMCCC
>> calls to the userspace. The vCPU hotplug[2] would be the first legitimate use
>> case to handle the psci calls in userspace, thus the vCPU hotplug can deny the
>> PSCI_ON call if the vCPU is not present now.
>>
>> This series try to enable the userspace SMCCC call filtering, thus can handle
>> the SMCCC call in userspace. The first enabled SMCCC call is psci call, by using
>> the new added option 'user-smccc', we can enable handle psci calls in userspace.
>>
>> qemu-system-aarch64 -machine virt,user-smccc=on
>>
>> This series reuse the qemu implementation of the psci handling, thus the
>> handling process is very simple. But when handling psci in userspace when using
>> kvm, the reset vcpu process need to be taking care, the detail is included in
>> the patch05.
> 
> This change in intended for VCPU Hotplug and we are duplicating the code
> we are working on. Unless this change is also intended for any other
> feature I would request you to defer this.

Thanks for sharing me the information. I'm not intended for merging this 
series, but discuss something about the VCPU Hotplug, since I'm also 
following the work of vCPU Hotplug.

Just curious, what is your plan to update a new version of VCPU Hotplug 
which is based on the userspace SMCCC filtering?

Thanks,
Shaoqin

> 
> 
> Thanks
> Salil
> 

-- 
Shaoqin



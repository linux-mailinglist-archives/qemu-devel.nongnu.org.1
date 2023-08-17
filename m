Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5577FAB4
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWesz-0001nD-39; Thu, 17 Aug 2023 11:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWesr-0001mx-P9
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWesp-0006NU-9Y
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692285958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rUqUWR8rzrD927CGxX3V6wwLNeZ9JiTIjHUnTTsexmw=;
 b=N5dBCPmvFqglsPqBEw4RJMKOVnT4SdaFQahj0j1qn0Geu9GDiBfpjTvZNWR0GLMQP0MzBy
 x/qjlyHvdh7GbDD7zAOiWOJhmmle3/ydLkMFZl9pUZ6Jw4Xnsem1K98fDbMXf+AMrI+X1Z
 xP67ArJXUUw4aMFxSG4iDKbs455S93o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-cgw2eodCOhuQuGXg_NrxoA-1; Thu, 17 Aug 2023 11:25:56 -0400
X-MC-Unique: cgw2eodCOhuQuGXg_NrxoA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-317a3951296so4694218f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285955; x=1692890755;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rUqUWR8rzrD927CGxX3V6wwLNeZ9JiTIjHUnTTsexmw=;
 b=YcnFSHXkikgWwKpV+F/T/BNS1M1GutbMLCtlMhgRHP/N9mYDK0u6lLjbEYiyQ4uw3K
 fK/vu7gHinFJOFcE45Kzadrf1/rCuF4vEwhJRsRQnfQwvd/ku62hAKkZOTdmNmtwS7aH
 pievqpuaazEkL+1M7Q1+I35Uo9CtntrmGZEJIqEH3ZbWa1i2EdqoJ/mGJpobpTmLx74H
 Iqh1PmJbcgTDKxdV9dvfD1utND9r7MMM7N+UjWDIxgyrIUa/ix+Jj3bk880Kbmg1ofx0
 qHyIMI3v7vWUPmfLxIZjlEx7sHvqHn60GzC1pxJtthP3q3fsZZpOBWqy98p7P5ptMjUe
 qxxA==
X-Gm-Message-State: AOJu0YzAuz61/aHXt/Q3xuTH8gCdiJgMKgHbx5jFSREsJK2IWJ7k1Rdn
 L70vU8C0+dsUYSlhfVYA0IXW3+atwpuCH7MY1RRpgmJ9Pp0TSmMcEtCJC5log+KSc7XYeeIQLX6
 L+h4qzoa1vsV+JJk=
X-Received: by 2002:a5d:4536:0:b0:319:6ae0:cae5 with SMTP id
 j22-20020a5d4536000000b003196ae0cae5mr4048236wra.70.1692285955569; 
 Thu, 17 Aug 2023 08:25:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlUHmaHz50PcdreR04bHnCn8g70W7EmK7uRZng/k9pnp1qBYFold/HhlS2gWF4bhT5ZHPeaw==
X-Received: by 2002:a5d:4536:0:b0:319:6ae0:cae5 with SMTP id
 j22-20020a5d4536000000b003196ae0cae5mr4048218wra.70.1692285955215; 
 Thu, 17 Aug 2023 08:25:55 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a5d4690000000b00313de682eb3sm24885551wrq.65.2023.08.17.08.25.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 08:25:54 -0700 (PDT)
Message-ID: <f2a35c8f-d486-1398-e098-3aadab3078e9@redhat.com>
Date: Thu, 17 Aug 2023 17:25:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com> <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <CAJSP0QVjxNQ=sMjzEFzbyhJ0e+O5bGBiXkHMgWiB2GOVw4NqHQ@mail.gmail.com>
 <9b2b884e-095c-7cd5-380b-b3b0c5aad9b6@redhat.com>
Organization: Red Hat
In-Reply-To: <9b2b884e-095c-7cd5-380b-b3b0c5aad9b6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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


>> Commit 86635aa4e9d627d5142b81c57a33dd1f36627d07 mentions that we don't
>> want guests to be able to dirty pages on the host. The change you're
>> proposing would not protect against guests that dirty the memory.
> 
> The guest could write memory but not modify the file. Only with
> "share=off,readonly=on" of course, not with "share=on,readonly=on".
> 
>>
>> I don't know how important that requirement was (that commit was a
>> request from Kata Containers).
> 
> Let me take a look if Kata passes "share=on,readonly=on" or
> "share=off,readonly=off".
> 

At least their R/O DIMM test generates:

-device nvdimm,id=nv0,memdev=mem0,unarmed=on -object 
memory-backend-file,id=mem0,mem-path=/root,size=65536,readonly=on

So they are assuming readonly with implied share=off creates ROM. If 
only they would have specified share=on ...

One way would be letting the R/O nvdimm set the MR container to 
readonly. Then that guest also shouldn't be able to modify that memory. 
Let me think about that.

-- 
Cheers,

David / dhildenb



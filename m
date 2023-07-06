Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD974963B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 09:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHJHX-00006t-KE; Thu, 06 Jul 2023 03:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJHU-00005y-Hr
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHJHR-0007yL-JF
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 03:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688627995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxgodwLyofDC1QSD76qnGKtHNOI4pE1XJNzl4MR/H9g=;
 b=AQwgFFBWLw0wdPFWT5YsGzjJJuPhf+wO+X0XqCMa5laCwfzdy0BMovFwAZM19FG1xEqX3A
 Kdi0lfzo70HnrTd7IWXFcqnsJsrvDx6jl7Ua4mPjgiL7rLmYdXLX3HPX3EY3aJeCKYrso2
 X909YqCohmbhyZk6vKUeTbpYIp9pNOY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-LXAJ_PqcM7aaW7KQ7w5Rzg-1; Thu, 06 Jul 2023 03:19:54 -0400
X-MC-Unique: LXAJ_PqcM7aaW7KQ7w5Rzg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3faabd8fd33so2506505e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 00:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688627993; x=1691219993;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxgodwLyofDC1QSD76qnGKtHNOI4pE1XJNzl4MR/H9g=;
 b=L5lzACREamPDwM+e/v21as/RHMDOc9rI5PkE6o+AxWCEb3yvOAb8WMLGKB59ZsrqKK
 TvgYAmHlCO3O/3B6wj2s0GEsfWgldZKEmp/aiW5dSrvJrGa3FRggiOvrltjUrv+wTCki
 d9H7VcfnBIMD6lTwV5OXv8/FozMpHnoxRfLSC5NsSx2gTtmUr6H3xFBi4fp3DPPOFd/7
 /Uj7JgDcQQP1iw6nXb61z4nfKf39YgoNK9ljRvqd9LuEUwhkMQu9LmpJQK4YRMSCZOuf
 UHkFxaTa+QA+ZMFmEjhwRCAYay+b4U7W9yFgyoYauowBuRNhaADHkUa3LJSfK3jOG2Bl
 EoCg==
X-Gm-Message-State: ABy/qLaePDPBE+QHIY+hfhdBUoV9l5vRwbpIL1VvvBQEV7Ezi/arAhMK
 anwBDH/gzAAcLhDJKUz+LWNpuSBxJhPRMF+XDE183EUGVQixSg+Hnoaz1rvfgBqjOyNRk6yrqd1
 ETWjfu3lR1kdXib4=
X-Received: by 2002:a05:600c:214e:b0:3f8:fc2a:c7eb with SMTP id
 v14-20020a05600c214e00b003f8fc2ac7ebmr615428wml.5.1688627993414; 
 Thu, 06 Jul 2023 00:19:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9PotvMf/lHIclT2560wNBGZWW/iNa4l7jiyMOy59rYdeyOjxME27gVPieehoS3wQzDOEI+A==
X-Received: by 2002:a05:600c:214e:b0:3f8:fc2a:c7eb with SMTP id
 v14-20020a05600c214e00b003f8fc2ac7ebmr615416wml.5.1688627993094; 
 Thu, 06 Jul 2023 00:19:53 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adff789000000b00313e2abfb8dsm1034195wrp.92.2023.07.06.00.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 00:19:52 -0700 (PDT)
Message-ID: <1b20090d-69dc-ae85-3f3d-59ba352e7ed5@redhat.com>
Date: Thu, 6 Jul 2023 09:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/4] virtio-mem: Support "x-ignore-shared" migration
To: Mario Casquero <mcasquer@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
References: <20230620130354.322180-1-david@redhat.com>
 <CAMXpfWs5cz2xqkPLwkuCz1NLV+0rKv3wafRtBCQqcyPzvWhGOg@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMXpfWs5cz2xqkPLwkuCz1NLV+0rKv3wafRtBCQqcyPzvWhGOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 06.07.23 07:59, Mario Casquero wrote:
> This series has been tested successfully by QE. Start a VM with a 8G
> virtio-mem device and start memtester on it. Enable x-ignore-shared
> capability and then do migration. Migration was successful and
> virtio-mem can be resized as usual.
> 
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> 

Thanks a lot Mario!

-- 
Cheers,

David / dhildenb



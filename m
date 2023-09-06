Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C3793618
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 09:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdmnN-000798-06; Wed, 06 Sep 2023 03:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdmnJ-00078D-EF
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 03:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdmnG-00009t-T6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 03:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693984661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRJrPmom2QK04NrHrucVV1tBYurvl/zY3Sr0T3ioW8Q=;
 b=HENDR/LYh6rQ59APmWfmkMEjrEczSD+S1q8PQ5QMzmnrmdVjQHdooUR6I2RhhPwtp40POc
 +p7X3QMB1i/S2qxOKD7MZB+AGljdJla3NFcRjYydb51yqXZf7kMZMyLb8qWF80DV8dqWVl
 BFus936qPmkyXqK8o9oIH4T9dNSg8BM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-SdIE2v-8OeKHxJ_MD6qhiw-1; Wed, 06 Sep 2023 03:17:39 -0400
X-MC-Unique: SdIE2v-8OeKHxJ_MD6qhiw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-402d63aeea0so11608065e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 00:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693984658; x=1694589458;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRJrPmom2QK04NrHrucVV1tBYurvl/zY3Sr0T3ioW8Q=;
 b=YbP89+54I4HmoVOX+dMhz7KE4Q8ZwJsZpQbpwPfO9cD7TaKw5g/86F9CKUeml+3ir7
 rx1pQr3VRgFTScgZsfF24kQdytMBmgNfqpamBIxoyplNk5/kQRiGk6WwCXJLb4PFPsvm
 Ko5KqWfvQXITYwckIEaOFXdF4sQ6xtWfgAQn5NAW0U/cxYLIJZOdlh+BhY5rHo6kJfel
 PFmnjsalFYd70Ai6rN5iH64OewuzR+alkqJlR4/Y0bcnbVlwLtecnobwi9Et49c1gfsE
 jbNVkzKjpgFYQyqcl6dQYZHKek7hOTpzf+1KN77//dOVSTNImXhml6w0Crbopl6mt7Nk
 +mBw==
X-Gm-Message-State: AOJu0Yw1n8DWEyxR1MjR0PJ248U5b1EXlTtR+Fvr5hAXlOH7RGv/Tjhm
 K45no+c6kIYCm88VgMs88rT168clrOZW6pcOisS00DvWtvuffODvTqm+HA9sV9L5SDGbPotOJxN
 bGMq+5jFdU0kguRk=
X-Received: by 2002:a05:600c:2488:b0:3fe:228a:e782 with SMTP id
 8-20020a05600c248800b003fe228ae782mr1536193wms.37.1693984658747; 
 Wed, 06 Sep 2023 00:17:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEFMZkLda1nAUTo/K+z+iCV6WKug2QHIDBjvmUP6xJ9bYU9fDcX33lzvsiqAHMlWzl3vZcQg==
X-Received: by 2002:a05:600c:2488:b0:3fe:228a:e782 with SMTP id
 8-20020a05600c248800b003fe228ae782mr1536173wms.37.1693984658318; 
 Wed, 06 Sep 2023 00:17:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853?
 (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de.
 [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a7bcbd1000000b003fee777fd84sm18997157wmi.41.2023.09.06.00.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 00:17:37 -0700 (PDT)
Message-ID: <ebc93bb8-41c4-d983-b7ae-4d56e66c2e91@redhat.com>
Date: Wed, 6 Sep 2023 09:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] memory: Let ReservedRegion use Range
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-2-eric.auger@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230904080451.424731-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 04.09.23 10:03, Eric Auger wrote:
> A reserved region is a range tagged with a type. Let's directly use
> the Range type in the prospect to reuse some of the library helpers
> shipped with the Range type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/exec/memory.h            | 4 ++--
>   hw/core/qdev-properties-system.c | 9 ++++++---
>   hw/virtio/virtio-iommu.c         | 6 +++---
>   3 files changed, 11 insertions(+), 8 deletions(-)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



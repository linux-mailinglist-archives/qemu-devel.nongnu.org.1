Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A472E1AC
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90TL-0004ru-0Q; Tue, 13 Jun 2023 05:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q90TI-0004rl-PM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:37:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1q90TB-0005Nr-HG
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686649058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpf529JTb9EpeupuMoAMGwL6PxHv7OJjqDQtQEFNyfM=;
 b=dJz0i88s539r6/KF/nPycgqyF8wH0DAGoKaZH53uJK/cm7n0gD8sBV0fscXHlN1DdvrLFD
 vX+dzI4oXYHwHLnHcdjC2OwNO4B11/N6w2UqjklNDC+7+GaEES77UuzfU5LJdZN0UVSHN+
 YimDeWv08OXb/E8kaWPi7OuzAjmFEA8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-u0_CIyG7O4CGUENtiwmaOw-1; Tue, 13 Jun 2023 05:37:37 -0400
X-MC-Unique: u0_CIyG7O4CGUENtiwmaOw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-75d4223b16aso123833085a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649057; x=1689241057;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpf529JTb9EpeupuMoAMGwL6PxHv7OJjqDQtQEFNyfM=;
 b=al6xju6ragqYoK7pQkWVrcTegFbJIJiKXcpaZe3BdNYzSgvmlRf36H50fVNTJ+ftRe
 KyYzZ+ns1LS5wbq1DyGVKaMzhIJ3R8Tjj5z1DSJed2QkgKyx1zUC+0xVs3LluhyLhD4c
 iqQY9tvoAQTfb0a4TUWOSj5bGf9DfnPnPGiu6DTQJWD8orGL0qkuIpM5qr1UtOW0PHVY
 ghI8PVjYLxJXdWvYr1XWTluBcLnOCZnlJx6nxNCEL92ma/g8ZaGGBP1uUfEYk8x1cNTI
 39MQYZR4o2xhBBD5f5RiRcLRo4UCBqQGNSnst4r0P0c2DKo4IRDRj4J+BkmC9FFeeUci
 7M+A==
X-Gm-Message-State: AC+VfDxPJjvGZrUI3WZhCmbCkcxMXPXGpKHfi+EEXM3jFLXounp/4siF
 8HpqA9OK/sjw2NwpJtms+zXLuiSb1eC9SnIAjFZepGdU0IVuvmGWs+V1SVpl3NXwqemzgvL1RVE
 J2rCdEICtHznNI38=
X-Received: by 2002:a05:620a:2948:b0:75d:560f:2048 with SMTP id
 n8-20020a05620a294800b0075d560f2048mr15969619qkp.74.1686649056885; 
 Tue, 13 Jun 2023 02:37:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dWndYoaZrhTnR0jYLmwgJEy/YO3wLKLdR5MotvtMBZ+JRdB6SJo/5TPpAvc11aeslacx9aQ==
X-Received: by 2002:a05:620a:2948:b0:75d:560f:2048 with SMTP id
 n8-20020a05620a294800b0075d560f2048mr15969604qkp.74.1686649056646; 
 Tue, 13 Jun 2023 02:37:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a05620a128900b0075954005b46sm3465631qki.48.2023.06.13.02.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:37:36 -0700 (PDT)
Message-ID: <79b5565b-1d44-f6e5-6c55-66ff403353b6@redhat.com>
Date: Tue, 13 Jun 2023 11:37:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/2] hw/vfio: Improve vfio_get_dirty_bitmap() tracepoint
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Avihai Horon <avihaih@nvidia.com>
References: <20230530180556.24441-1-joao.m.martins@oracle.com>
 <a043b593-c576-5dd2-8ac7-63ecad5533af@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a043b593-c576-5dd2-8ac7-63ecad5533af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/13/23 11:34, Philippe Mathieu-Daudé wrote:
> On 30/5/23 20:05, Joao Martins wrote:
> 
>> Joao Martins (2):
>>    exec/ram_addr: return number of dirty pages in
>>      cpu_physical_memory_set_dirty_lebitmap()
>>    hw/vfio: Add number of dirty pages to vfio_get_dirty_bitmap tracepoint
> 
> Queued, thanks.
> 

I had taken it into my vfio-next branch. As you wish.

Thanks,

C.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AECBE823DB1
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 09:43:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLJIf-0007oq-Mq; Thu, 04 Jan 2024 03:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rLJId-0007oU-L2
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 03:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rLJIb-0000FA-20
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 03:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704357714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=apOZxuhCzLHgrtX5zmWi/5YqD6eEbxYqATpxP+JpYfM=;
 b=i3EPJJNYzRHp7wNCaM0COuEgkGCxH8gSpMoHy1haBbl5onm+BO2bcuHsh18883cBBZLfsQ
 QsT75yufwqBOKKyy/iiebl28FU7IbKlLJED4r1huuGwJ3G85y3LD32Ko/04NcJou8GMh05
 JOmAr+ebU1fVFKauvuSbYdA17/E4qMU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hclTqWtDOUCh7_sagsEDdg-1; Thu, 04 Jan 2024 03:41:52 -0500
X-MC-Unique: hclTqWtDOUCh7_sagsEDdg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d5aef0b1fso1975375e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 00:41:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704357711; x=1704962511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=apOZxuhCzLHgrtX5zmWi/5YqD6eEbxYqATpxP+JpYfM=;
 b=By8EMYheYPQ+jN0l7z15vLSCNtqrfS8hd0PTnZGks7tb9VplDZp+Zv/9iE6dFH0lOK
 OFORWxhxczRNpHG2MGA7OgyPWbLLKTuz4NXcVytOD0kWJiH1BmP6S13a4M5Kqfy+CO3C
 pS37RCdSJ2i60PLbes7LXQ6A2OYUF5uMR5qdyUu8jPktQXyT/O6bNHVG33M6b5/ybsp9
 hf/heTS481licTM0ulDPsOkIgUecmXcC8qadqFh7bpV+Wj0b8ZFSLGluU8UP9RfYZb5T
 OHz6ncg0OpNQUZ9LJu27rQI8Mk3snxLxNLRBZptjdC1FLBDzSJE4lr8eWefFyK9bHVKu
 934g==
X-Gm-Message-State: AOJu0YzoO1dPkaTvaCZ0SZP/MPv89kt+XCnUbMe7gWF8syllMHIlMG3e
 7o/jfOBzIpHVliZGQGHGidedpN+gI0BZytyMWhM3SL9WwZcWE2UH5KJpayTw9at6Zbo6F82RUfi
 JDSllZKMHG8c7rw5krebH8fO8zQTx5OdzaOJU1OU/WzE/V9+jb1gcB1C8hQCCP1AqcAMmSQFGHD
 C7
X-Received: by 2002:a05:600c:244:b0:40d:8944:657c with SMTP id
 4-20020a05600c024400b0040d8944657cmr146635wmj.71.1704357711119; 
 Thu, 04 Jan 2024 00:41:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGmTLy5yGLJeDBXeEav3aLrG1ttIEDSfDOH6w2HxAGUa7FPAFv3vvyYZxOQpRnlsOKYu+PQQ==
X-Received: by 2002:a05:600c:244:b0:40d:8944:657c with SMTP id
 4-20020a05600c024400b0040d8944657cmr146624wmj.71.1704357710660; 
 Thu, 04 Jan 2024 00:41:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 fc11-20020a05600c524b00b0040e354e2a61sm13911wmb.43.2024.01.04.00.41.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 00:41:50 -0800 (PST)
Message-ID: <9d1ace89-82a8-4355-8a57-8c883b8aecb2@redhat.com>
Date: Thu, 4 Jan 2024 09:41:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] backends/iommufd: Remove mutex
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240102123210.1184293-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240102123210.1184293-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/2/24 13:32, Cédric Le Goater wrote:
> Hello !
> 
> Coverity has some reports regarding the IOMMUFDBackend mutex. Since
> the IOMMUFDBackend routines are called from the QEMU main thread, this
> series simply suggests removing the mutex and rely on the BQL to
> handle concurrent access.
> 
> Thanks,
> 
> C.
> 
> Cédric Le Goater (2):
>    backends/iommufd: Remove check on number of backend users
>    backends/iommufd: Remove mutex
> 
>   include/sysemu/iommufd.h |  2 --
>   backends/iommufd.c       | 12 ------------
>   2 files changed, 14 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.




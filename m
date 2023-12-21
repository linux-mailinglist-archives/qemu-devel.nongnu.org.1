Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C3081AFE5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:01:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDyE-0007O8-JY; Thu, 21 Dec 2023 02:59:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGDyC-0007Nr-Lr
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:59:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rGDy9-0008Re-V2
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703145586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+z1hHxFrBfYvlLyV/BSXVBKjOerIvI5wDxxwtnXo1Xc=;
 b=UZwcppm7+13yUK/T/+0neXjBdTYP13aGMX0q6lfTrylg52clME9c55o7rNPDjiv3AVvovU
 XTLi1nPWUyulhAqIvjdVyCCz+br2PPrRqjVmxSv859ldozowHmw1dZXwN5w5SodGF/airU
 ZnjRX0aQ8i7fKA5sCS0I+TqZah4S9O0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-pJzpOKytMhilMHW3zTWiHg-1; Thu, 21 Dec 2023 02:59:44 -0500
X-MC-Unique: pJzpOKytMhilMHW3zTWiHg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77f55466facso89085485a.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 23:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703145584; x=1703750384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+z1hHxFrBfYvlLyV/BSXVBKjOerIvI5wDxxwtnXo1Xc=;
 b=KZdvb9nqUszCL78emAkIyZrxZpAHRDJUF24pnyE8iYg6apczS4dpv1fra7aLG5gghu
 tf1raOeVutoX2TygVr4cLLnQQ58fy02SgyBz8lEyR93Qk6bEQIIpsoaLZFeBrQHSzbQn
 zFu/XAYT66t9XGzfJFsyQ/lbC4lDyi1O5GpKXLmRvUORLZ275LRG+RS55d83KN+Zd6Ve
 xJhZSOjjPqf9EQi8A+6psw0YDaO6sQU2i8X8xsQ4Gncf/nMUaE/1kXarDj+/KaG53e3W
 Bh1MNqX3M7qoHYF9Zer+qTY6NMspdbxIx6d6wqfQZMV5wEzs/InAUvhihyVz+fRTmVia
 VKiQ==
X-Gm-Message-State: AOJu0Yw62FmvaIxAAT24g5w5ikvaqvWiej0RJVR7/iYacVfkoTIMRGNL
 jGEItJgPyxVUYE06FyQm0ZStCtLG+aI9kFXFKt2c1o899/y1GjDtzeDv97ZOUkEWql/xVZ1jQ3k
 r1oOL0We8PpRbnCw=
X-Received: by 2002:a05:620a:10b3:b0:77e:fba3:3e6c with SMTP id
 h19-20020a05620a10b300b0077efba33e6cmr444739qkk.53.1703145584272; 
 Wed, 20 Dec 2023 23:59:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq/2Lysn0HE43JsweObPw/cOcxBT9FWaNTVi/K1skbjVVUCeklvM5BXkxeUgsn3/cuJFSEWw==
X-Received: by 2002:a05:620a:10b3:b0:77e:fba3:3e6c with SMTP id
 h19-20020a05620a10b300b0077efba33e6cmr444729qkk.53.1703145583989; 
 Wed, 20 Dec 2023 23:59:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 qs10-20020a05620a394a00b0077589913a8bsm471749qkn.132.2023.12.20.23.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 23:59:43 -0800 (PST)
Message-ID: <79d175d1-1acd-4558-a30a-57c3376c9504@redhat.com>
Date: Thu, 21 Dec 2023 08:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 v2 00/10] vfio: Introduce a VFIOIOMMUClass
To: Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231219065825.613767-1-clg@redhat.com>
 <e215169f5504649cd3b8ec5ce66c988a8b5ba439.camel@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <e215169f5504649cd3b8ec5ce66c988a8b5ba439.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/20/23 21:35, Eric Farman wrote:
> On Tue, 2023-12-19 at 07:58 +0100, Cédric Le Goater wrote:
>> Hello,
>>
>> The VFIO object hierarchy has some constraints because each VFIO type
>> has a dual nature: a VFIO nature for passthrough support and a bus
>> nature (PCI, AP, CCW, Platform) for its initial presentation.
> 
> The above caught my attention, so I kicked the tires on this series a
> little bit both with an iommufd-enabled host kernel and without, so I
> don't lose track of it over the holidays.

I don't plan to send a vfio PR in the current weeks. iommufd support is
upstream and still very warm and we should let it cool down during the
holidays.

> Tested-by: Eric Farman <farman@linux.ibm.com>

Thanks !

C.



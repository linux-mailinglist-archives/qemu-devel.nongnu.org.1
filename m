Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6508BDE662
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 14:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90Hk-0008Qh-6S; Wed, 15 Oct 2025 08:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v90HY-0008PL-Qy
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v90HK-0000pO-V0
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760530004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3LRDq/MhDA+f1/fb4SGA1Sw4egGUiRfntQ32K2NdHNY=;
 b=JZ5GW4GSte12nHfqMZHviwmGcDL+MaL6dMTXqNGncp7vzc72jkkNMRaKm/60aWmsFLcNIm
 Pmuq/M7o/4jpgteTdO7fqxMqzyn28CfK1wMvVcjNKbVXEUnjsB7A1rVRkiqKzvKRvLLTcO
 3l6aNV0eKF0NpM7WJmgQJdp9j3nBUHs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-K9qQRnRwPOmtH0NRNuQ_dQ-1; Wed, 15 Oct 2025 08:06:43 -0400
X-MC-Unique: K9qQRnRwPOmtH0NRNuQ_dQ-1
X-Mimecast-MFC-AGG-ID: K9qQRnRwPOmtH0NRNuQ_dQ_1760530002
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-470ffd40c16so1868825e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 05:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760530002; x=1761134802;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3LRDq/MhDA+f1/fb4SGA1Sw4egGUiRfntQ32K2NdHNY=;
 b=xI2KkybWhSR1nS1lVaMF7xAIu9Jj+hs9xOWyCfrPEMRW8sVqDtxbnPKQ7X+QBp9i0L
 5cYf5BlcDQPxcELHxzMBw0Umf1rxgTMYFaqZU6qTwDVwilcJ4GDpueANyP+enex97Rzj
 W70FRYkaAMNW7knf16N0VRVBfLj0zZzoq9mSnV/tQq6ax7yyAcXXUh8ynPsbY0w3XeIs
 Y6fWmTJMTwXranVHvlcfesOXdKO6gOTWDQDbTpALhdmBLcB1x6N1QHzbJBYHQHLmbY8X
 x52yjDGvFIv2ebULIfKZePfSZsx+Z5SghMeWT67ptRphqS1xm3sXWUHwTztzUSi0POxb
 iOAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1/4XKDDB8DX6DFV/TpxwPCwaKpKFk7G8rz8ED6qhtJzfTli81IY0XWJnqKKEsdUiQAs24UgfpYXZv@nongnu.org
X-Gm-Message-State: AOJu0YxLl5A9ydLC9fzx++RfMvTEVPh0DxbKB4Q5Dqq5Jep91fbd54jc
 1ec8YE9U45CWtXUkfOSi0sB6PwhVoem0mscZaxPSSgkQPp9GQf1WxF0DXcqrtQ8PdsFG6yn5Mb0
 +tOB8mSQZbinAttB/B/p022kJ6YbQYtqfHRXayzarxpbYMdd/zKLvkORl
X-Gm-Gg: ASbGncsn88oZRS/twb5e9/KLqzKUi64Gajwa6zWmf0ZpPFccgdxseCPMEIBjujjM6FE
 Uh/Cyofycp1tH68CLN0y4XFpYendW9wuu+zClUI/2czToITHExHxlvZqIml2o1dPckCSisKwQqp
 MkIzgmGAbC+pfWakHYhEg1LuXelaXZFZTioEjE6c/X9tJppAsl0+QMy2BKIa/oKTymu5vFpUi8n
 0V/0/6vMBDUvCEY4NBoRYhv76s/O/8Kd+RKb2ys09TA58VuZiqcYc0p3oHAmYiexD+nJO7LcZ4V
 xpqsh1AzFU+sS1vHeVpt1kuofMCkLJwngOsI4gR3J1IUBhWQJwURmhN9ggIoLGdyEwxcAuAe30a
 iKGU=
X-Received: by 2002:a05:600c:4690:b0:46e:31c3:1442 with SMTP id
 5b1f17b1804b1-46fa9af9811mr194236205e9.18.1760530002282; 
 Wed, 15 Oct 2025 05:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnMb8zTAhuLvXcXH+FU5C4vZ/SOBrVSjL8T3OlUPstT44rXqcXnFMjalr2JlfUkT/M00kVwQ==
X-Received: by 2002:a05:600c:4690:b0:46e:31c3:1442 with SMTP id
 5b1f17b1804b1-46fa9af9811mr194235955e9.18.1760530001854; 
 Wed, 15 Oct 2025 05:06:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab36a773sm184237775e9.0.2025.10.15.05.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 05:06:41 -0700 (PDT)
Message-ID: <1c3c13c6-cb2d-4254-b4c4-a69e44dfd89a@redhat.com>
Date: Wed, 15 Oct 2025 14:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fixes for vfio region cache
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org, qemu-s390x@nongnu.org,
 Mario Casquero <mcasquer@redhat.com>
References: <20251014151227.2298892-1-john.levon@nutanix.com>
 <07ac3b8f-c6d0-43e4-a41d-23a6abbe296d@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <07ac3b8f-c6d0-43e4-a41d-23a6abbe296d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/14/25 21:20, Cédric Le Goater wrote:
> + Mario
> 
> On 10/14/25 17:12, John Levon wrote:
>>
>>
>> John Levon (2):
>>    vfio: rename field to "num_initial_regions"
>>    vfio: only check region info cache for initial regions
>>
>>   include/hw/vfio/vfio-device.h |  2 +-
>>   hw/vfio-user/device.c         |  2 +-
>>   hw/vfio/ccw.c                 |  4 ++--
>>   hw/vfio/device.c              | 39 ++++++++++++++++++++++-------------
>>   hw/vfio/iommufd.c             |  3 ++-
>>   hw/vfio/pci.c                 |  4 ++--
>>   6 files changed, 33 insertions(+), 21 deletions(-)
>>
> 
> That was quick ! Thanks John. I will build a version based
> on upstream for internal testing.
All good. Thanks to Mario.

Applied to vfio-next.

C.




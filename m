Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB6A7D4D8
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 09:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gSA-0005Qe-P7; Mon, 07 Apr 2025 02:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gS4-0005O8-9H
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:59:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gS0-0005Dg-Fg
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744009145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IMORzDEuy11HaWXSmSxEjMpJLg8pqS60Gm0GkPSbBSY=;
 b=O71DAqF5IdDaeohbPsUyqqeEFbYLx5X2vKaRSTZNAFV5CQLhSPPk2cwjaFD/327ZyvyDIu
 ViKAy1ZsWu6bD+SHQPVN5k6SJrGJIkYZFebYhCfUTGTVCFU5NrSP/vPLgS5os3R6aZEtUq
 6BOdXZbDupI4rZY6mSETBA/1xc2jQqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-CStlCQCbNrCqua6YcLhddw-1; Mon, 07 Apr 2025 02:59:02 -0400
X-MC-Unique: CStlCQCbNrCqua6YcLhddw-1
X-Mimecast-MFC-AGG-ID: CStlCQCbNrCqua6YcLhddw_1744009141
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so7969535e9.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 23:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744009141; x=1744613941;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMORzDEuy11HaWXSmSxEjMpJLg8pqS60Gm0GkPSbBSY=;
 b=suPIsh2cvk3wOe4hcFr209t9qM/T9QOsruMxQPiJsx0W1cqA+6cAimhkLIflCVRj0x
 SfeLYVlNJa3Yay/j3ZLPyjgOSrD0GKVMSfWWRoecDSMgl3fjUvp+/77fCuLJ5hGUPt3E
 HAz64Urvw9TxlR5KWayNUIeKzQqPRtlCOCQeqjOiUEtwthmkAN4x316SN3Q3OVXz/Edb
 fZ3zJngI3ZGAzJAmID7eL4xu8Q+g2dO7zINPvY5ZqCX6uKvdVgHLmoG2gHvOJrbO3SiW
 O9gE/tKXXaGKv2C0KkAX3UQX770d0P57ugbRDLQQVltZ1qfoWQkqMVyz68g9PaxuXFsu
 hxnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4D/izr1oAsOnc64fuHiIS7JYkbQc1jiPBF39rv0/iaJ6Um76ejHb6cvHjGvAYpWzKQQC/W00mDL7H@nongnu.org
X-Gm-Message-State: AOJu0YwXxZ3NbyU9s0SYe/FspcmjCQKq7PVzc7ut5bqmus1MBjLV7uZM
 YkjxiggXNIiT1NxHSFkBSRaDy6Vdog60dgR5htdjkt9iP1Ud94H80HHFrr8fDLvopnmxo62poYV
 oMaU2iZPo+UQeG35ePFXdJ2SSpNXvQ4u74OOSX2E6KOdqGI2aETsI
X-Gm-Gg: ASbGncuT3ii936owd3B/Jl6ZxcKTUC2YU0ZHCq6aafldyj4Hd9mB0dn6Quou0aI+R96
 RHxiRlLh16y3ZcLpwQamYb9WHmUsCUwml5ezMSVOT6IFiU05nzgNCCUCzsBYocRmFHrVMKIsatI
 TCIcgnaF4e5ZLXnWjToAYFZ8/7kDdQbCuLK/tXlpepDnSKidLfVkAkwJ9urZcTM2xd2GPMeoC6Q
 1k8UIhfGSJvHn0Duh+R6dd4oe/eGnDDN0eU6C8KNEC4MIzsiJkuijK1ZEeb16g9S2dKY1Zi+DNM
 kj3+twISOUaBkTqbGEEQvAqGT8nEhC7Pyyd/x6zzIIcSrfjAdBmSpg==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr131286705e9.30.1744009141481; 
 Sun, 06 Apr 2025 23:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlJWv2Q1LuIzAnn+XvsyFDItGC4/p8JKyxIAZVazzYPf4E5Lx33WX9BRpccEL9+u23mdm2w==
X-Received: by 2002:a05:600c:c1a:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43ecfa06fd2mr131286535e9.30.1744009141168; 
 Sun, 06 Apr 2025 23:59:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d938sm11284047f8f.65.2025.04.06.23.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 23:59:00 -0700 (PDT)
Message-ID: <701694bb-12ec-42de-a35f-75642f2ad7d4@redhat.com>
Date: Mon, 7 Apr 2025 08:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 26/37] vfio: Move dirty tracking related
 services into container-base.c
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-27-clg@redhat.com>
 <336d0630-6661-4e4b-8376-7288bf899d7e@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <336d0630-6661-4e4b-8376-7288bf899d7e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/2/25 14:35, Avihai Horon wrote:
> 
> On 26/03/2025 9:51, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Routines of common.c :
>>
>>   vfio_devices_all_dirty_tracking_started
>>   vfio_devices_all_device_dirty_tracking
>>   vfio_devices_query_dirty_bitmap
>>   vfio_get_dirty_bitmap
>>
>> are all related to dirty page tracking directly at the container level
>> or at the container device level. Naming is a bit confusing. We will
>> propose new names in the following changes.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Yes, this seems like a suitable place for these.
> Too bad we separate device DPT start/stop from query, but start/stop are indeed related to memory listener.
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 

Since lore didn't receive the email :

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Thanks,

C.




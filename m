Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22786A6B8AD
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Mar 2025 11:21:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvZTz-0002b3-84; Fri, 21 Mar 2025 06:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvZTw-0002ah-07
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvZTn-000372-UZ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 06:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742552394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GhFb5M2hOr6rXGAtnNvo9nkgnrnPTljukB9Hxc0pV/w=;
 b=D8mx3nj40KRagXyjsT4SjIiMl2KuGwLdX1xd8VGGuA17EH8xjReAkJ1GnE3QR0QYi5DoX0
 CyqppbxJGBXG5OEbe27nMbF89aOzaL0OsS8D3E2IrFetJJQTuG+SPXF421W0nzj08sb8Vs
 VIwWLRUK9joV6kD+wGSzsSsmx2RRo7U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-tLf-rMjTO8ukmh4_g5Kpow-1; Fri, 21 Mar 2025 06:19:52 -0400
X-MC-Unique: tLf-rMjTO8ukmh4_g5Kpow-1
X-Mimecast-MFC-AGG-ID: tLf-rMjTO8ukmh4_g5Kpow_1742552391
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d4d15058dso11173435e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 03:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742552391; x=1743157191;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhFb5M2hOr6rXGAtnNvo9nkgnrnPTljukB9Hxc0pV/w=;
 b=SmVHzIX8LOYtw0b9q80PpHRmgMSO/ssKAVSmCPuxwpzErs18ELEN7qxEuijpuBonI0
 LLm4+vEUZ4HyPHyOQk00Z2S1qd1h6U1ZHLchc3JDlNBgv7Qoay83Ih+2jb9AjOoM3qaY
 C56Lz8VdNEoeDSkBn8JHNKaIRTFVLGFAn2mBKvjhrdbdbnt+VpOzmsw1NXFSkXLirwRf
 UmmeJnIVfCoR8rawKWsbz1a8Q77nG/PUVGJTVDDBWU4q2mtdp8PXupEED268zXRyh3QV
 wc3J4fQjtBRLpL3mkU/NAG2c7za5TLfrdpKXiNGm7wiVMaqqMc7AZ0JTgB+h2QgsplsB
 344A==
X-Gm-Message-State: AOJu0Yw31QftjPLFAAyX+90dk/uE+nXEEOpfvamLnXXwTUU83+VWFnWR
 UlUsL/DcsLi97v+R88mjV50tgV0fiavMizrCpQEeH66JGqF3luXasHqDelBJO42wrLc11bgM04h
 BFcXPX2pUAQZgM7HtQxXbzlKfzQmZfAZI8+sWRbBvPntExYM/jAdC
X-Gm-Gg: ASbGncuiMdai0dVXjMmb0/ICbzMJ6eN1XEL7hZ1vXCqcOGjKytNn2/swX/J7Iv8NlZI
 UhFw/gN3m9fgiYFDJp3oNc8ucNMnKzEIX/f+wZ0MrwjnUZa2D9gGnvRQmuAhHeOJ82JLYRzDaEC
 rX/I6C1x8hgXy/XzFlYADsHPc7N+CpmCyyxO7KRLRn9h9UcNE0N86TlyY4x3EIplTxt8d2U5K3w
 6HKS+mZP7bRHjlgdIpNKDDBj/TrORnIFPn3+eX/LSN50GP/eyMRWK+17prC6OD4CuW0HHruqJPK
 DwxC4iDMKqkTumSNqJz71ELxQ9A7Bg0emL4wbB7WMz/V4FdYbjBoYQ==
X-Received: by 2002:a05:600c:5742:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-43d510fff60mr15834835e9.19.1742552391091; 
 Fri, 21 Mar 2025 03:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQyLtq4VF1Cqtq2Y+FYk1tD6mxWxBTeB6EgqpbW/5zZPLvAonAUMvxP0/m/P62Q6rvCRsWPw==
X-Received: by 2002:a05:600c:5742:b0:43c:e70d:44f0 with SMTP id
 5b1f17b1804b1-43d510fff60mr15834535e9.19.1742552390576; 
 Fri, 21 Mar 2025 03:19:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4b8sm72698245e9.35.2025.03.21.03.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 03:19:50 -0700 (PDT)
Message-ID: <d64ecace-2a6a-4d5b-8689-5182cd770bb7@redhat.com>
Date: Fri, 21 Mar 2025 11:19:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 25/32] vfio: Move vfio_set_migration_error() into
 migration.c
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-26-clg@redhat.com>
 <CAE8KmOyBghHqFSmW-vbQfe1zvDkDJ8Dkq1FgUdZHXt4dGO9vLA@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAE8KmOyBghHqFSmW-vbQfe1zvDkDJ8Dkq1FgUdZHXt4dGO9vLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


>> +void vfio_migration_set_error(int ret)
>> +{
>> +    if (migration_is_running()) {
>> +        migration_file_set_error(ret, NULL);
>> +    }
>> +}
>> --
> 
> * The change looks okay. But with the 'Error *err = NULL' parameter,
> the error (ret) is also not passed on. Could we call
> migration_file_set_error(ret, errp), instead of defining
> 'vfio_migration_set_error'? 

So you mean open coding :
  
     if (migration_is_running()) {
         migration_file_set_error(ret, errp);
     }

?

Yes. I think it is a good idea to limit proliferation of this wrapper.
Ideally, we wouldn't need to use migration_file_set_error() at all but
we still have some callback routines not taking an Error **parameter
unfortunately.

IOMMU notifiers :

   vfio_iommu_map_notify
   vfio_iommu_map_dirty_notify


MemoryListener handlers :

   vfio_listener_log_global_stop
   vfio_listener_log_sync


I will send a series removing vfio_migration_set_error() to improve
error reporting in the dirty tracking handlers. This makes sense,
thanks for reminding me.

C.





> Because currently it accepts only one
> 'ret' parameter, later adding *errp to it would entail changing all
> call sites.
> 
> Thank you.
> ---
>    - Prasad
> 



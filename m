Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C48FB9AC27
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 17:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RdP-0000Iy-7f; Wed, 24 Sep 2025 11:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RdK-0000H7-HE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RdF-0000Uc-0Q
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758728528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P/VFB0a7pxZMlrp442eHikRqKty2cJmBiZZOo6iJF18=;
 b=QMtjCS/UzyXnz26zF6nbxkOHupKAg3HenReNG/AyU+YHjUqx0K9inEkDqyUMgYmwQiA2vl
 NhBjtM82q/zyofodnfKygsOe1y7TJUg/msLb1IiYltL236RvmfS2G/qNyL6Eanlh5Vj3i/
 UtO2ot/RmAPyRkUMimKnqrSF+xxfbSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-94t82PZ6PFu18QyhYBQr3w-1; Wed, 24 Sep 2025 11:42:07 -0400
X-MC-Unique: 94t82PZ6PFu18QyhYBQr3w-1
X-Mimecast-MFC-AGG-ID: 94t82PZ6PFu18QyhYBQr3w_1758728526
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b986a7b8aso46236065e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758728526; x=1759333326;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/VFB0a7pxZMlrp442eHikRqKty2cJmBiZZOo6iJF18=;
 b=eekytA/GMCjRBh7eozKGJP5z6KTdn0r1QeR1s9YcSFMLhY+83gL3BDT6J607UM+TZK
 bfkf9ImMGtQlfeDsRoBYeMsbX3BySG7uEnDxg89xDVMHOnkUHmxVU2tCeypD3SfdOpul
 tD69693VQoO0xfLdeOs50BF/P76ZU13J+RQECef+apJ4WdAMHsHWKSJcVO3X0EQoa4Z3
 wWe62MhBfBx5B0M0zxLoQFEcUkbKDWXRbwNmGUuZ5x6EGK3nUsHioXPvMPy4gb0wtapM
 m3W7lk6wHlDKS2M5jtb5/w7f/gqf2zb1SH6OPCcTAEy7Qz9yCgRvuUtXo/FAeixLl0nV
 wIjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOWVCpAd1eCkIBC+4oUiIzXoDDPg11lsaJLf106bY3IjopXvxE94A/eM/WGPLU29ucHJ8bctKSNjYK@nongnu.org
X-Gm-Message-State: AOJu0YzzHmL600xKKTnMERLbv9XRimNBxuJ50y0p3ZiNswAVDFoq2ejF
 K4sfgK6niUbIXJrFPV1bgyDDnXpYdkS3GF/56pmz7OyxSBCzaJFib0hdWY0AxgS1eCvZuwOme9P
 vJf1+VV3kjYSACyaTNs7Sep+G4h1TbmVB7Z1nzXv6s0b9fAfC7QYMbFu1
X-Gm-Gg: ASbGncuvYpsJQl86h8Je0Ama3ybBCzcXszJJ8d/mkFtQRsYaLHW35OexRITUbm7VMJr
 1pdLcideAn7SKsWV3QxVmGmIi5YE1QPJTC0y8vJL7meGnr/JNz3mNgtB3qvOhIM+QlfFkHx53i7
 5nEG8wr5ovSG4yVkXnp+VEKi1C585JRehBDv4CSvrnoYcHxKth+iimPqn0vhQ43uAiqhKlM2J5H
 tywGwm2sm3bVcVqBGA/feIJFG9JAkw7QlytF4DhC0lRu3D49ERmm+n9AElPClVznJscVRYmahDY
 ZWI67g5rEuo9TQXcQzbx7R2dCNCn/unrF6vuMktkr1QyGvw9TiAAwTGp5feE3R3ic51bMxZoN/C
 a6kU=
X-Received: by 2002:a05:600c:37cd:b0:46d:fe0b:d55a with SMTP id
 5b1f17b1804b1-46e32a0dc96mr3194285e9.33.1758728525560; 
 Wed, 24 Sep 2025 08:42:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXkqEhSFxDCgY0sQfGJ1LRWyzQV3nBuQxEc+FgXFc0rD2aHCObHZvu2RKufLv8T5YLYvlB0w==
X-Received: by 2002:a05:600c:37cd:b0:46d:fe0b:d55a with SMTP id
 5b1f17b1804b1-46e32a0dc96mr3193905e9.33.1758728525107; 
 Wed, 24 Sep 2025 08:42:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbc7107sm29836100f8f.30.2025.09.24.08.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:42:04 -0700 (PDT)
Message-ID: <fba1accb-b279-44d4-ad06-2d50e005e651@redhat.com>
Date: Wed, 24 Sep 2025 17:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] include/hw/vfio/vfio-container.h: rename file to
 vfio-container-legacy.h
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-4-mark.caveayland@nutanix.com>
 <b4d724c3-321e-480a-a17a-3755c383e8af@redhat.com>
 <908641fe-1c42-4cbe-bb28-8beb236616ac@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <908641fe-1c42-4cbe-bb28-8beb236616ac@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/24/25 17:30, Mark Cave-Ayland wrote:
> On 24/09/2025 14:54, Cédric Le Goater wrote:
> 
>> On 9/23/25 15:53, Mark Cave-Ayland wrote:
>>> With the rename of VFIOContainer to VFIOLegacyContainer, the vfio- container.h
>>> header file containing the struct definition is misleading. Rename it from
>>> vfio-container.h to vfio-container-legacy.h accordingly.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks for the series reviews! Whilst looking at some other vfio bits and pieces today, I noticed that for this patch and the following one, the #ifdef ... #endif guard names now no longer match the name of the header file.
> 
> Would you like me to submit updates to these patches with the guard names also updated?
> 
Sure. Please send a v2. I will queue it.


Thanks,

C.




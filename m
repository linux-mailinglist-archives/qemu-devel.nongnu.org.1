Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35640A7D472
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Apr 2025 08:45:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1gCv-0001kj-Cq; Mon, 07 Apr 2025 02:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gCj-0001ic-8U
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u1gCh-0003VO-HA
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 02:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744008208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2N9EBUPfB72aOT18m8ZX2la+W/R4vK8QCjlKOmLrqhY=;
 b=PhudApVbr5kVCxB8RYC6g478O3VGzuyr47RD9tFYXX25XZ62LHFLfOjmtyuBbPrb8BG/Sb
 fbkjLyZ3jUBVtqisgRnFY775b+FXVX+2usaz/pFsg2nBjDXaMMrFkbf3+aNYXFwh3l7RCk
 bYw1U19t/RFKa9yekg2YZULU8oyhhB8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-ZKEXlSDXMAOzcZlajkzcwQ-1; Mon, 07 Apr 2025 02:43:24 -0400
X-MC-Unique: ZKEXlSDXMAOzcZlajkzcwQ-1
X-Mimecast-MFC-AGG-ID: ZKEXlSDXMAOzcZlajkzcwQ_1744008203
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d22c304adso22534305e9.0
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 23:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744008203; x=1744613003;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2N9EBUPfB72aOT18m8ZX2la+W/R4vK8QCjlKOmLrqhY=;
 b=ZJWBjIHtJODJQOVo49yvGhTo+V1nfOcn3vIATPkWrBO3y0UhXd3ohkJwBlzjWYJg1W
 X/Qqq+0NsEw11oRFADXCiX/X9Bn0qXEtDb0sSCjRcjkEUs21xg8BQYBWynMFPhDNU1uj
 zBObp+HObHjWTjWGHB0o2P6RYW59rm3KMZekZZRZgKkiAbTpO2/Zl2RbICO+btlHLaFp
 yG/gb78kFX9Fs6ZyNdTslBtbcE5+PIiDfQU6G2yoHwpr0wuo1ZL2okfzMRG4hl4/Tga7
 pqEiFY98yQldmW2jo1WWnGLja5/PKqeLsBtZLvbNqUwfBQwaYzb39x+fiXVmUY7tCN6x
 YLhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOuktLU39fx7pj4VUSExD8Ur4ADsX7/PVADt5LpndmGxFtIQEqfOabIewfKS+OyrRh3bmpyOGpLWxL@nongnu.org
X-Gm-Message-State: AOJu0Yw017wEg/g8bBCOxiR9SU7ZxXqrOA+wlCaThtymmQWq8CraK2VI
 Pxwec9hXx8592X1bcO3ofHAUqt21yDTAbRrMrqGglJp7F/UxNgS/+BAtrCi8Ps0NP++++I3a3gU
 bpIzOkxQhn176+mImegWLzUrubabxTOI/t1QdczL7vuMcTbeF8EiS
X-Gm-Gg: ASbGncv/5b0yC7Uk5KRkVApHyGehEGKwiei6nV1nc32H86TAaPBui4tni9ussPy29a/
 2u0hh5lMak274IGWj3Ta0vX8W8WMa6LXKrw/WtEfvBF0xrSP838DokwMn8nwiJQpjwhVcLAaFfR
 QWHX5SA8MIYuVJRROmIoMSCSpiNDsx6o6JDQ2mUbyOgF54fvm+07jEsCN6+rwfCk2TUMaPfsHkL
 SMDEbKmJqirmloj3NldxI1FGHXUO2qMzwP7ipzdw+qZCuz+BBzIsXn+Q9QgH5FK9Dv35y4yGi/D
 JbrDwaKHEpYw3c8q3SrXlnONKdYa8L6gV+KwfghcwvMoYJYS4+mSlQ==
X-Received: by 2002:a05:6000:22c5:b0:39c:2c0b:8db4 with SMTP id
 ffacd0b85a97d-39c2e610ac9mr12760734f8f.10.1744008203264; 
 Sun, 06 Apr 2025 23:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGagUG6Ez4b2NPzdcrk3/IyIEiPlLM3yxc3YGfZajvX9Dj0AKsXx64N3QUiksdWd5yO4aLo6w==
X-Received: by 2002:a05:6000:22c5:b0:39c:2c0b:8db4 with SMTP id
 ffacd0b85a97d-39c2e610ac9mr12760713f8f.10.1744008202920; 
 Sun, 06 Apr 2025 23:43:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30095ea8sm11037505f8f.20.2025.04.06.23.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Apr 2025 23:43:22 -0700 (PDT)
Message-ID: <8a4a0b4d-fe97-440c-a475-31808bcfd257@redhat.com>
Date: Mon, 7 Apr 2025 08:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 v2 06/37] vfio: Introduce a new header file for
 internal migration services
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins
 <joao.m.martins@oracle.com>, Kirti Wankhede <kwankhede@nvidia.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-7-clg@redhat.com>
 <8667eb45-f908-4442-983f-fb1a9ac08e2f@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8667eb45-f908-4442-983f-fb1a9ac08e2f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 3/31/25 14:23, Avihai Horon wrote:
> 
> On 26/03/2025 9:50, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Gather all VFIO migration related declarations into
>> "vfio-migration-internal.h" to reduce exposure of VFIO internals in
>> "hw/vfio/vfio-common.h".
>>
>> Cc: Kirti Wankhede <kwankhede@nvidia.com>
>> Cc: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> 

Since lore didn't receive the email :

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


Thanks,

C.




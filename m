Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8DAAF6444
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Jul 2025 23:42:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Dt-0008UC-Oj; Wed, 02 Jul 2025 17:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uX5Dc-0008LJ-Bn
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uX5DV-0003Sa-VL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751492526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZulZ51oz2QKBwq+2UCTcBXDVPybOj2oGFEduz4DKgTg=;
 b=X06bEAc0pUM6BQW04CsEINfgJGSZnbWRP7JcR7mS0D4a+HJv6YDJ71JT7jAG0XMj0nFMnN
 3mHj5gcQzHDb3QhBXc0Zd9HcY6qW6gdCQfy3M6FUOYOj2shzSAG3KTohnkvWZ9Yh38oyZ9
 0UXpV52nuGNN0V48ZIYtZfL4wtOyAtM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-UtGeS3bPNmGQHv9Gyy4bsA-1; Wed, 02 Jul 2025 17:42:05 -0400
X-MC-Unique: UtGeS3bPNmGQHv9Gyy4bsA-1
X-Mimecast-MFC-AGG-ID: UtGeS3bPNmGQHv9Gyy4bsA_1751492524
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f85f31d9so3066028f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751492524; x=1752097324;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZulZ51oz2QKBwq+2UCTcBXDVPybOj2oGFEduz4DKgTg=;
 b=lJw9O4m3KQKk+mYD5S6U8PYqoXbrx5dBa2lhOsfGa2K4Hr/kB7eCRJx+cYqZhIImAY
 dDOMu90SSKLESUcl/48oYWhmkgUZd2BLGkr2VVYz0TereFXWHf1ZSsenoiPJdM08mPpB
 wv1STEO6ClNS/DltSXIe9B5Um/pjWDFWZax6rOLlaHdhxbll9dk6Jv7ZR4eCehUSXCSo
 tatHla0DTtAJsvYnHQRMaYgkLKcgzT+SHWjWC1q2UUwqA4Xiyudnxpp398uchFjNxIf+
 IC4YF0N3uMVcOLgEE0P49VjZKTxtf9DESKG0wNdpBkG2oD3egSevlCb9HWZRj/8TssYx
 HcUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZG9OMzpNv/xomUWz245ya6CYambyxyzQkSvOoXtC46vrI6KDbXi+JuXyioS/FjP/ZGcXgz28x8Kjb@nongnu.org
X-Gm-Message-State: AOJu0Yw3IslA8T5i7QSbCrzekp/4JMAcyBSTIgbGLHdnBHR7IOcK/jdA
 P9Sa2wYjQ63ucpZ2ngBG7HDkIelQQ4MMG1k9pU077enyenymwH1oHiP+8Em9+7J5SlisklVxisa
 zsH1Vf/7UOavgrkolD7Gu3U5mR39KsjJy9hldR/PIbOH18hLQcILaGF98
X-Gm-Gg: ASbGnct4/R1b57W92Ft7n000CuXDgVI/OYTeVKd8ZF24jtke1ld4E6Yvkk75C77grKX
 xueyn5YOG1utdyQu1YboTWJ7d5PCwG4+RfjbVQOvdy40TQpjXCyc28YASggtx3KszckB9G2fPWP
 Zcf0ensTGCruyOY6a8G5nWhEzP3xfy2DTsSM6P4O/zdwefLkbLWRnVjpGyLVVJZiT32Zb0rtZYm
 8ytjun85SAS/UFuCXO0QcrKaGObw6gcA2F/S3Vckf4jS813L2oQ8V2Cm0GP1yfdI+TYqN7TuZcf
 6LpjOzVFL+pOZvN2HaDp48ZDs5KukptKeXPE3q/VIL8zxwSXaJBgO4DVGOBj
X-Received: by 2002:a05:6000:651:b0:3a5:51a3:3a2 with SMTP id
 ffacd0b85a97d-3b32f383792mr522706f8f.45.1751492524193; 
 Wed, 02 Jul 2025 14:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqmw/Z44uLcqEbH34cmHA1F8gyGykODgePjJRCIZMczU6nrOwzqze40KVnfT7dIzX7Oze04A==
X-Received: by 2002:a05:6000:651:b0:3a5:51a3:3a2 with SMTP id
 ffacd0b85a97d-3b32f383792mr522699f8f.45.1751492523760; 
 Wed, 02 Jul 2025 14:42:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f842sm16652801f8f.86.2025.07.02.14.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:42:03 -0700 (PDT)
Message-ID: <85a81af2-fe92-4f74-b1fe-4ba030e32129@redhat.com>
Date: Wed, 2 Jul 2025 23:42:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] b4: Drop linktrailermask
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250630172301.519848-1-clg@redhat.com>
 <23065936-513e-4240-afaf-3d25de747dcd@linaro.org>
 <257986c3-54b6-4ae7-8176-8c4c74e0b8db@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <257986c3-54b6-4ae7-8176-8c4c74e0b8db@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/1/25 14:16, Cédric Le Goater wrote:
> On 7/1/25 12:04, Philippe Mathieu-Daudé wrote:
>> On 30/6/25 19:23, Cédric Le Goater wrote:
>>>
>>> When grabbing a patch series, the link trailer is replaced with a
>>> Message-ID, which is not useful compared to an URL. Fix that by
>>> dropping the linktrailermask config.
>>>
>>> Cc: Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Hmm :)
> 
> Copy&paste error from 838cf72b5d2c. Sorry ...
> 
> Who maintains .b4-config  ?

if no one objects, I will add it the vfio queue with the Cc: fix.

Thanks,

C.

  



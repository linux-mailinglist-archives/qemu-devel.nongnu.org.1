Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B44309D840A
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Nov 2024 12:06:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFWur-0000rB-Az; Mon, 25 Nov 2024 06:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tFWuo-0000qv-Hi
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:06:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tFWum-00082q-RJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732532759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Qd0sz8A6KLDNMREOmAFBsCGBHTB6+OUOxeqYJC1n6Fw=;
 b=Cg8HEmcLawWNzsGNnexyF5u6FRr4W9rAEg8dIP4bI8Ot9R9MbhPgQTBYER5oFNNyTsR61M
 G0tc+9CVxvj6bCR3OD9ljzSSCcNFUhgObz1FPFyAxeVU74BJfYihQOp4/wDPtq/WgRyP2T
 Q1Cn+Yuj9i3BZigT5ztKVev8CjmiG2w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-ALIq7hO_Mvaa0kK18kp3ng-1; Mon, 25 Nov 2024 06:05:58 -0500
X-MC-Unique: ALIq7hO_Mvaa0kK18kp3ng-1
X-Mimecast-MFC-AGG-ID: ALIq7hO_Mvaa0kK18kp3ng
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43164f21063so30623455e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732532757; x=1733137557;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qd0sz8A6KLDNMREOmAFBsCGBHTB6+OUOxeqYJC1n6Fw=;
 b=SfWc8vib6rKSE9fggYPAn9v7c/oDNdAa3iK/bnQjDKVOPqZ4te0V2uFGJKKrpcq3jz
 ZP2FZBjbQj588R4cTU4FxADl7lmq86bSaJM1K0IfKVFl7mz0sDjFx/+LBAtZywJFtBFP
 R39hHQT3PSNmYSjxvyXn3TiM27HJtxc50aZRtniKZQKT+u/qjz4xuGp+GU+Z5FQn2PFi
 w2ZSXVL+fsfwa9bX4g9PT7uMJ8+cbTCuhJJyei/3AxOlSzvjPKzfudHCfp2zjA8M6xIN
 VbyFWnDP7XkDCgNDeE2nnFZ60EbZBlWjK9cMMOhCZkRj6X11/7diHXpVqCHd6rds+/yH
 nR1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYuqB1CkkSDf9GY3UPklP6ugmCILB4zFgsNzqsibRT9tszXoDJMUhGvbq5POw2UP7RYYTsyPMCm0TH@nongnu.org
X-Gm-Message-State: AOJu0Yy61hHGyhaeftI686PJ//9QNhgDyiGAchIwSP0Mjj075yhwAlHj
 jvUnlN+02Mxh7g+GKFkEV87e68gk7X0K78Fpked4YnwKP1ucRsByOCQUyXYY+kizW8qw4nY7O2G
 1LpXQdCRc+sHQzhK2aiaNV0N7DR6MN+Rmuh9JZif3c8SKeNe5pdAZ
X-Gm-Gg: ASbGnctJPi1WJS/qvUg5KCkESu4KjcPQibnsRQLE0Z+rwPOqN0iJiRHtnbw1ooFlKpw
 htY70F0ymTpBbt+11XhAdFztvdXTZwl/q2B5dq0Z5at8NJyYg60EaTHsBiDF65K11VkdpnCLdRA
 NV0dMybJ7PYKzTU6fDCk/GxmDIPy1rnNEa1qvcIXS0UuJ6NS5xoPwYLo+TZkQiXWVrEv44Si9Xe
 AfgP58frNy/3cP2ZToUrfUopS+W+CnVWBIPPJzTd4FY9zxvAGzgQgVjR5DDo/pCEdAK1roPcS5K
 TXwfPIjWs+CG
X-Received: by 2002:a05:600c:384f:b0:434:a0fd:f9d1 with SMTP id
 5b1f17b1804b1-434a0fdfd64mr11578275e9.20.1732532756793; 
 Mon, 25 Nov 2024 03:05:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9+G6uGcWkpkb5rHzko34ehEViM8uNY2rNHIiTbWhb/1OwfMizOUyBi8Z9shoi1PEJFAwsFA==
X-Received: by 2002:a05:600c:384f:b0:434:a0fd:f9d1 with SMTP id
 5b1f17b1804b1-434a0fdfd64mr11578105e9.20.1732532756418; 
 Mon, 25 Nov 2024 03:05:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bdb61sm187697915e9.16.2024.11.25.03.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 03:05:55 -0800 (PST)
Message-ID: <c8d00883-2fd6-419b-836d-4bcc81065112@redhat.com>
Date: Mon, 25 Nov 2024 12:05:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] Net patches
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
References: <20241125060809.15543-1-jasowang@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20241125060809.15543-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Jason,

"[PATCH] virtio-net: Add queues before loading them" is missing from this PR.

Thanks,
Laurent

On 25/11/2024 07:08, Jason Wang wrote:
> The following changes since commit 6b99bb046dd36a6dd5525b8f88c2dcddae49222a:
> 
>    Merge tag 'pull-lu-20241122' of https://gitlab.com/rth7680/qemu into staging (2024-11-24 13:39:06 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/jasowang/qemu.git tags/net-pull-request
> 
> for you to fetch changes up to 7987d2be5a8bc3a502f89ba8cf3ac3e09f64d1ce:
> 
>    virtio-net: Copy received header to buffer (2024-11-25 14:00:51 +0800)
> 
> ----------------------------------------------------------------
> -----BEGIN PGP SIGNATURE-----
> 
> iQEzBAABCAAdFiEEIV1G9IJGaJ7HfzVi7wSWWzmNYhEFAmdEEtgACgkQ7wSWWzmN
> YhH5qAgAlKdcx/gFt4EBXtjVq/qbPluEGOQxvcRYLlN90rPLHPgCjAoT5ly3fIv1
> 4kCgcVZyG8SdGu1n0TzTTS9kg5tL7weQ9xEWwF0oyyuZABgAB7w/wpC8MHSkJFOn
> 2Tv+2Iab0dJ+e1pw71OMpE/YR5X2xq5vopsSHRtnyGWfRPGswJFwka+f8FS5DSiq
> 2CeNxADgTkPxJgDmOrNSsAPz8Rns77FAZdvDMqFjx1Lrqm8kPv9jzwOMO+a/2LpC
> t6OkpFzGjiiskPjSnSn/tzo4TfWYoABjJaI7b3vEqmNEJSTAaxltZNtSXZucctEt
> 1ihnFdjr/wPwGK/5Wu+qGnfDbFNxBw==
> =W4y1
> -----END PGP SIGNATURE-----
> 
> ----------------------------------------------------------------
> Akihiko Odaki (6):
>        net: checksum: Convert data to void *
>        virtio-net: Fix size check in dhclient workaround
>        virtio-net: Do not check for the queue before RSS
>        virtio-net: Fix hash reporting when the queue changes
>        virtio-net: Initialize hash reporting values
>        virtio-net: Copy received header to buffer
> 
>   hw/net/virtio-net.c    | 108 +++++++++++++++++++++++++++----------------------
>   include/net/checksum.h |   2 +-
>   net/checksum.c         |   4 +-
>   3 files changed, 63 insertions(+), 51 deletions(-)
> 
> 



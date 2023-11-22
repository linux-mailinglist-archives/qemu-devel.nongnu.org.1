Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 492177F4DD0
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 18:06:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qfa-0004qk-FW; Wed, 22 Nov 2023 12:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qfM-0004XI-IF; Wed, 22 Nov 2023 12:05:34 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qfH-0004Du-K8; Wed, 22 Nov 2023 12:05:30 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b34563987so113385e9.1; 
 Wed, 22 Nov 2023 09:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700672725; x=1701277525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I0J5fqyt8wQQyv6C5hr9LFPK+QBnNAlvdW52k/8SMic=;
 b=GObVSdvYnYWP6mueXuDTCZBRXf0NbeS9k3oY2RO2HIpM2XyBVu8KbQgX3wc2JTHS0r
 nFW0wVUJOBRA2YYM8unlAWfsebIK/Ss5ie0QP1sTso9d+oj7SqUiV2s3C+WSL+H1TJKo
 GiCxi9dH+S3AeUIv+16kPkGznJEM0alsDqIg+CrvfawC3xMW/KVbNV+klSVA+SZicTsL
 fwv2tvgcw6K5oj8yP2rAskedJxQ+4MH/0HAY9HafiFWj9+tXOXrW9cXAuRLcCruwrk8P
 O52Nd0eFJjo/rwezm6whpJq91tEgMT53VZeWOmbwD8pkn+GJFxkC5rTZu6nU7ruMVimd
 S66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700672725; x=1701277525;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0J5fqyt8wQQyv6C5hr9LFPK+QBnNAlvdW52k/8SMic=;
 b=ncq74OSJiSdOwqIkOCSe04gSCetOO6Q3vJLFTZv889GMA/gDaOHBsIUmtvmYclvd0p
 xhp93MB2Te4r3BphWve1fgYYTqDGs8lsRKl4iUj/ye0LNDsoUG0LYvFLE/HLOmAk9Itm
 oVNDvaCx4G4XkEUCvFZLFaYGau8yP0mykSlJ3iaejrvu9lVKPfXpbWPgzLmAUUYzKX1S
 YpQGyIaxanBSAL1CjIskfk/lAoUPBl4Ss0mHvFA78vEOEt8/Q0lBYgZKte3qdx1r43/x
 LbHjWiUxZxcSoD4igZ5w8c8m4Q3dYPWAWyh7YG9jFJRa7M4HQn+WHIEGiVeBqylcIFQB
 uLLg==
X-Gm-Message-State: AOJu0YzPkr6z/zNYc31tEOWVQKg9dqSdNnecg5dIFH7ZZ2IrMkinq7gA
 bQxfnX3tYaQn29M30igk0tk=
X-Google-Smtp-Source: AGHT+IEekpdm4N30KUcOe9rHlR/EVEZelxqqJbkx9shFbPTurKDYLNG5QWTqQ/mqdsgflEk5QYRwpw==
X-Received: by 2002:a05:600c:1d12:b0:40b:2a62:a2b6 with SMTP id
 l18-20020a05600c1d1200b0040b2a62a2b6mr85353wms.1.1700672724957; 
 Wed, 22 Nov 2023 09:05:24 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 je19-20020a05600c1f9300b004090798d29csm41802wmb.15.2023.11.22.09.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 09:05:24 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <e1663064-247d-41e3-9a36-16f81303fb94@xen.org>
Date: Wed, 22 Nov 2023 17:05:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/xen: Set XenBackendInstance in the XenDevice
 before realizing it
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-2-volodymyr_babchuk@epam.com>
Organization: Xen Project
In-Reply-To: <20231121221023.419901-2-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 21/11/2023 22:10, Volodymyr Babchuk wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This allows a XenDevice implementation to know whether it was created
> by QEMU, or merely discovered in XenStore after the toolstack created
> it. This will allow us to create frontend/backend nodes only when we
> should, rather than unconditionally attempting to overwrite them from
> a driver domain which doesn't have privileges to do so.
> 
> As an added benefit, it also means we no longer have to call the
> xen_backend_set_device() function from the device models immediately
> after calling qdev_realize_and_unref(). Even though we could make
> the argument that it's safe to do so, and the pointer to the unreffed
> device *will* actually still be valid, it still made my skin itch to
> look at it.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/block/xen-block.c         | 3 +--
>   hw/char/xen_console.c        | 2 +-
>   hw/net/xen_nic.c             | 2 +-
>   hw/xen/xen-bus.c             | 4 ++++
>   include/hw/xen/xen-backend.h | 2 --
>   include/hw/xen/xen-bus.h     | 2 ++
>   6 files changed, 9 insertions(+), 6 deletions(-)
> 

Actually, I think you should probably update 
xen_backend_try_device_destroy() in this patch too. It currently uses 
xen_backend_list_find() to check whether the specified XenDevice has an 
associated XenBackendInstance.

   Paul



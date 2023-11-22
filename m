Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6667F4BB5
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 16:56:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5pYn-00030Q-Vf; Wed, 22 Nov 2023 10:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5pYl-000308-UN; Wed, 22 Nov 2023 10:54:39 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5pYj-000703-Dz; Wed, 22 Nov 2023 10:54:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so32366405e9.0; 
 Wed, 22 Nov 2023 07:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700668475; x=1701273275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oNuaujgkfiBu0D3cBBFv01kMivKccYiWE/OU0x8Hvjg=;
 b=Vy4cAnaSvZnZnh+IGaN0wFq/XVEic9tB5r9uRafmib2E3d6CS73cYtysu69xMuOftE
 JM2OrQoNQ8JXDlG+uIBEuzuijHhpTb2ZFj/25AcOi6oo2ZNYXTuai8FRqkm+gz2Rn1oU
 6bJ3NOBoWPjIRfwmta4BHtfx9DGqXgkAzU45cTO5bjhoDY89aSJ6F1Wz3pc9UJN5NGX8
 TMVaI/Vv16PFiR8I1mxl3vGMUNV80XXm76qrDSjrC/oSFzZr8v1/HTIC+b1My0rwqdto
 U9Isgww8Ioj2uPmD9LgK5YIS6cdfFavTERQfGPvf9PDyjSRq90kMfnoyWvCASuykByfZ
 jtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700668475; x=1701273275;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oNuaujgkfiBu0D3cBBFv01kMivKccYiWE/OU0x8Hvjg=;
 b=vUnK/UqwMvEtU+iW4N9E9UoZOUnSaPlqXo4Xp3uBo9zwfB/JMPZnKiTZwZ1bfxEmzC
 FyOflTaS+EkHROhqnYZj9+O+SNJAPUH5HipQ7UXyJXRCZ5HJVPXhOPCRS5O7aqgqjDsM
 Hilx7wBdhvimuHtgO136qpuBuaFsw+f+QQ0XkQwqIrX76fMLOwrtw+s2hOeZKae/KJy5
 VUnXnl+XGOHCQQkkhpRWo778kaxwzHAZ6+P/ggSstgnuMC+6rZbgFS1BfUiysSiYUOEd
 p/nnNcn72ms5TLgoOvV1XNGWYWALu//qYLfDV/hNwVpJhJEE4CXK+qf5GJBDmheFgkc0
 zEmQ==
X-Gm-Message-State: AOJu0Yyj/bujb3sOCdDmkxvzTeC2iayh6Z2Wh1tNGoMvLfIeRfj4r1e7
 7+mGJDdScH3+CBdObtglUbE=
X-Google-Smtp-Source: AGHT+IF+NU9imeSVoGdzlL8QTTPC502lMgEP/qmUPOwdJnpB0DB0k1UIS4J7qULNnyd+Cqp0H3sq3w==
X-Received: by 2002:a05:600c:a43:b0:401:a0b1:aef6 with SMTP id
 c3-20020a05600c0a4300b00401a0b1aef6mr2594869wmq.2.1700668474803; 
 Wed, 22 Nov 2023 07:54:34 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a05600c4f4300b0040b297fce5fsm2622058wmq.10.2023.11.22.07.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 07:54:34 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <dcb3f2ef-e05b-4636-8a85-d9864cf619d4@xen.org>
Date: Wed, 22 Nov 2023 15:54:33 +0000
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
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x332.google.com
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

Reviewed-by: Paul Durrant <paul@xen.org>



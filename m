Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CB67F4DF4
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 18:12:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5qlY-0008CC-Lz; Wed, 22 Nov 2023 12:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qlT-0008Bx-U0
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 12:11:52 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r5qlS-0005hh-B7
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 12:11:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b344101f2so294265e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 09:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700673109; x=1701277909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wD1Osv68moY2wmNYERX6SE0aq7IXfRHUNiLz0dpPw9w=;
 b=HmSptVgmqmroHvQHMrJD0yFL2D3M8+A6G66RjufySaDqPzuP7HyW8JZ+3z7Cqn/uUR
 qv0HWN/UCYnMoM5WpGGyMu4IN930sgPbc5SWzc0v2iKm+jryrMTOLa5O82HAB2i5JVnV
 PNb2IbZOAqKoiVGHn4Xw3LxfrWDMwCBJnyVTuIpKmCyCh2cYAxkxvYCKHAGeubBptvt/
 WL42nOqe9RDQgejwbsjd7a9qPDpeBkUisdZrCzDhcJB4D0IM9fJjWCRyyjrIE6q7gyci
 2pPeBHMerI+US+tuTpLVLmLj6T1tV0MhUV/gipQM9HpXS7nJ+6X/FA72PCeYVhbTAWQJ
 OCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700673109; x=1701277909;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wD1Osv68moY2wmNYERX6SE0aq7IXfRHUNiLz0dpPw9w=;
 b=GZYVdyuiGvpc+/FdQvU4UYkw8z9VqBMjKRmT6CFWgYjFupy+tVBhE4Y7ug6kdm2eit
 C5RSttcvdnzUrJRHOWUzd43Lj+DYEMJGIMjkP3aFHmnw5vQV4488VunG+Hyp7xHEAw5I
 dxS69KNV/rtUVFEgdjzneU2fKfu5/qdGqrEjBuqEWlenucdOhThEQd4ikaldBlR+0cHY
 Lco33LLqaee84cA/3l0V4HkC1FNKf9l1M77HeLxAeDTkDrEgJsCKd7z5+CarPAOPAG09
 6rVpqWV/VpmU67O97/E83f4r+t/WVRc5fZ8G2zyLG+jac9rY8NdAqmzQCuHEjSQ+ikTZ
 NpYg==
X-Gm-Message-State: AOJu0Yw3Kx/+0mABM+hhFIvLS+TjFVZdNJg41VBp5z35qfJm00m/XQJE
 KHd2/+g7WE9L/ip7uqYvuJCExOhg+1NHKA==
X-Google-Smtp-Source: AGHT+IHlFn1oy68B82kGrutJ1vBhDlOH4mto5RqdBz1ZBta1MhC8vRAp0CKHAUcgl2mg05DpKVubbA==
X-Received: by 2002:a05:600c:1c9f:b0:40b:2a08:c45e with SMTP id
 k31-20020a05600c1c9f00b0040b2a08c45emr104751wms.3.1700673108689; 
 Wed, 22 Nov 2023 09:11:48 -0800 (PST)
Received: from [10.95.134.92] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 i16-20020a05600c355000b003fc0505be19sm44748wmq.37.2023.11.22.09.11.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 09:11:48 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
Date: Wed, 22 Nov 2023 17:11:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] xen_pvdev: Do not assume Dom0 when creating a
 directory
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
Organization: Xen Project
In-Reply-To: <20231121221023.419901-5-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x329.google.com
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
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Instead of forcing the owner to domid 0, use XS_PRESERVE_OWNER to
> inherit the owner of the directory.

Ah... so that's why the previous patch is there.

This is not the right way to fix it. The QEMU Xen support is *assuming* 
that QEMU is either running in, or emulating, dom0. In the emulation 
case this is probably fine, but the 'real Xen' case it should be using 
the correct domid for node creation. I guess this could either be 
supplied on the command line or discerned by reading the local domain 
'domid' node.

> 
> Note that for other than Dom0 domain (non toolstack domain) the
> "driver_domain" property should be set in domain config file for the
> toolstack to create required directories in advance.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>   hw/xen/xen_pvdev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
> index c5ad71e8dc..42bdd4f6c8 100644
> --- a/hw/xen/xen_pvdev.c
> +++ b/hw/xen/xen_pvdev.c
> @@ -60,7 +60,8 @@ void xen_config_cleanup(void)
>   
>   int xenstore_mkdir(char *path, int p)
>   {
> -    if (!qemu_xen_xs_create(xenstore, 0, 0, xen_domid, p, path)) {
> +    if (!qemu_xen_xs_create(xenstore, 0, XS_PRESERVE_OWNER,
> +                            xen_domid, p, path)) {
>           xen_pv_printf(NULL, 0, "xs_mkdir %s: failed\n", path);
>           return -1;
>       }



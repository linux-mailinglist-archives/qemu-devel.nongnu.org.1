Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B5080CFA0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:34:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCiIL-0002ql-I5; Mon, 11 Dec 2023 10:34:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1rCiIH-0002qW-LT
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:34:05 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roger.pau@cloud.com>)
 id 1rCiIF-0006fv-Uq
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:34:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c3f68b79aso23374405e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 07:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1702308840; x=1702913640; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+rCAEtkjC3HUaAf6Tu6nFfjQarIcejRK8RObA6IV88Y=;
 b=s3GSwMyQZRnv2PuiF975e4U9obl2nhEttCwg3bkyVIM0KjJt+Q/b9Q+MxVPr7QMVpg
 I59nFWpRRLUHTqnRunW6lhPoeOkp9uUmsfBp2CBfCy+q8B97+bl7nr4h4mxLCpEw8uih
 qDMMzWnw4Ztino65qqe0JUwd6iQ7Bg32xc8pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702308840; x=1702913640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rCAEtkjC3HUaAf6Tu6nFfjQarIcejRK8RObA6IV88Y=;
 b=loj4DwnBjcX0yPUjiHHV9QQhXIuaXl99yHqShAw7mG/qvO7dEEkFHWJgka883ONS8X
 glgulEfF+phLEt73L+0SCzH9eziM5cdrv9Rh/xgmQj50ddPKNhDv4cG2W3HYVq3yeOYc
 ebsmZWn+Vtu6of8xo2cL9fEg9kux4Eyc9qOu4MbTJ3niBv2bxZ+l2hfemdqURH5akAws
 mpuvnxpUYhZpeum7q7DyP5sv7+p0TGrsH5yMLfZULJc0fIV04WqhiQsdJarssgMUSSn0
 AQkUt6cc5OomqodAmnc9KPhoWVTbkMdQzCW5ikZIfYk+3YWQOTwjfieNvJTeToIQf7o6
 oGcQ==
X-Gm-Message-State: AOJu0YzygtJp9AKnyJ/mguaL3qqszFoPlEEBgtUw3HQJoHksXoutesMO
 gGcSPy5Yg6m2vBINE7nTv2MtqA==
X-Google-Smtp-Source: AGHT+IFAQs+DMCXrumDmAH9uw/y1g0aNk95EuxaFkJFlLVu4MJZejlRuz1WTaTu1aRicZzj4fSW8PQ==
X-Received: by 2002:a7b:cb89:0:b0:409:19a0:d247 with SMTP id
 m9-20020a7bcb89000000b0040919a0d247mr2276592wmi.18.1702308839878; 
 Mon, 11 Dec 2023 07:33:59 -0800 (PST)
Received: from localhost ([213.195.113.99]) by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c510500b0040b3e26872dsm15680589wms.8.2023.12.11.07.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 07:33:59 -0800 (PST)
Date: Mon, 11 Dec 2023 16:33:58 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>, Huang Rui <Ray.Huang@amd.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>
Subject: Re: [RFC QEMU PATCH v3 1/1] xen: Use gsi instead of irq for mapping
 pirq
Message-ID: <ZXcr5v43dsJAx8aK@macbook>
References: <20231210165240.1551450-1-Jiqian.Chen@amd.com>
 <20231210165240.1551450-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231210165240.1551450-2-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=roger.pau@cloud.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Dec 11, 2023 at 12:52:40AM +0800, Jiqian Chen wrote:
> In PVH dom0, it uses the linux local interrupt mechanism,
> when it allocs irq for a gsi, it is dynamic, and follow
> the principle of applying first, distributing first. And
> the irq number is alloced from small to large, but the
> applying gsi number is not, may gsi 38 comes before gsi
> 28, that causes the irq number is not equal with the gsi
> number. And when passthrough a device, qemu wants to use
> gsi to map pirq, xen_pt_realize->xc_physdev_map_pirq, but
> the gsi number is got from file
> /sys/bus/pci/devices/<sbdf>/irq in current code, so it
> will fail when mapping.
> 
> Use real gsi number read from gsi sysfs.
> 
> Co-developed-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  hw/xen/xen-host-pci-device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716..e270ac2631 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -364,7 +364,7 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
>      }
>      d->device_id = v;
>  
> -    xen_host_pci_get_dec_value(d, "irq", &v, errp);
> +    xen_host_pci_get_dec_value(d, "gsi", &v, errp);

Don't you need to fallthrough to use the irq number on failure?
Otherwise passthrough won't work on older Linux versions that don't
expose the gsi node.

Thanks, Roger.


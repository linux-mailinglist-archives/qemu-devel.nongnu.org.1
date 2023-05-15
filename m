Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D6C7030F2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:05:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZkE-000544-TR; Mon, 15 May 2023 11:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=492829998=anthony.perard@citrix.com>)
 id 1pyZkC-00050a-1a
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:04:12 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=492829998=anthony.perard@citrix.com>)
 id 1pyZk8-0004ld-Vt
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1684163048;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bQrXqaeJcD+jm1ccN670onl+ctwTMzM6NSMGay6Q+zI=;
 b=WYEmuYHDI/Pz+ZqvIRp1vm85CjeKAqPPamuUhDbyQl1sMKqdQT8CdFvs
 o3M4kvJfixVXvoUJ2p82orbYxQet9gv/c0piFBf/GPpuK2gIfF+s0/P/t
 FHjMykRiHryZLKZDvCRA6R3SEUJtc2beGKb/QjEf934jCBI6Utx44CvSK g=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 108418728
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:li/UNq6hV1ZED69X2GkIewxRtM7HchMFZxGqfqrLsTDasY5as4F+v
 jQYUW2Obv+JNmbxe98gbonk9xkEucPWzNc1QQs/qSszHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9VU+7ZwehBtC5gZlPa0S4QeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m9
 9gxCm0EShq5pueKmoqiF6pXl+V+BZy+VG8fkikIITDxCP8nRdbIQrnQ5M8e1zA17ixMNa+AP
 YxDM2MpNUmeJUQVYT/7C7pn9AusrnD5bz1frkPTvact6nLf5AdwzKLsIJzefdniqcB9xx7I+
 juWoD6pav0cHNWOwzeUyGuJuu2VlBL3f4Y3T4KoyuE/1TV/wURMUUZLBDNXu8KRj0ekXttFJ
 k88+ywwrLMz/kimUtn8WRKjpHeO+BUbXrJ4CuA/9USBx7TZ5y6fAW4LSCMHb8Yp3Oc/XTEw3
 0WFt8/oDzdo9raSTBq15rqS6D+/JyURBWsDfjMfCxsI5cH5p4M+hQ6JScxseIa3h9v5AyDtw
 BiFqSE/g/MYistj/76g4VnNjjaop57IZg04/APaWiSi9AwRTJaseoiA+VXdq/FaI+6kokKp5
 SZe3ZLEtaZXUM/LzXbWKAkQIF23z/ShGR+BiHplJbgky26V4iPgRpFxvRgrcS+FLf04UTPuZ
 UbSvyZY65lSIGamYMdLXm6hNyg55fO+TIq4D5g4evILO8EsL1HfoEmCcGbKhwjQfF4QfbbT0
 HtxWeKlFj4kBKtu11JarM9NgOZwlkjSKY4+LK0XLihLM5LEPhZ5qp9fajNii9zVC4vayDg5C
 /4Fa6O3J+x3CYUSmBX//48JNkwtJnMmH53woME/XrfdclY+SDB7VKSBmutJl2lZc0N9x4/1E
 oyVABcEmDITe1WdQel1VpyTQOy2BssuxZ7KFSctIUypyxAeXGpb149GL8FfVeB+pIReIQtcE
 6FtlzOoXq4eFVwqOl01MfHAkWCVXE721FPTYXD0PGBXklwJb1Whx+IItzDHrEEmZhdbf+Nny
 1F8/ms3maY+ejk=
IronPort-HdrOrdr: A9a23:v0sOLqzlO1N3/Ee+W/DGKrPw8L1zdoMgy1knxilNoH1uA7elfq
 WV98jzuiWbtN98YhwdcJO7Sc29qArnlKKduLNwAV7AZniFhILLFvAb0WKK+VSJcREWkNQtsJ
 uIGJIQNDSfNzRHZInBkW6F+nsbsb+62bHtr933i11qSRhua6lm5Qs8MACGCUd7LTM2ZqbRUK
 Dsn/Z6mw==
X-Talos-CUID: 9a23:cdAeUmAjf/2nCvr6EytD3WxJE+QvSFzY8C3oOhL7MndIFZTAHA==
X-Talos-MUID: 9a23:wQwRawsYw9+IUEQAfs2njSBoOdZS+oGSChoEoJkhv+zfCjxMJGLI
X-IronPort-AV: E=Sophos;i="5.99,277,1677560400"; d="scan'208";a="108418728"
Date: Mon, 15 May 2023 16:03:55 +0100
To: Jason Andryuk <jandryuk@gmail.com>
CC: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, 
 <xen-devel@lists.xenproject.org>, Marek
 =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] xen: Fix host pci for stubdom
Message-ID: <48c55d33-aa16-4867-a477-f6df45c7d9d9@perard>
References: <20230320000554.8219-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230320000554.8219-1-jandryuk@gmail.com>
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=492829998=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun, Mar 19, 2023 at 08:05:54PM -0400, Jason Andryuk wrote:
> diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
> index 8c6e9a1716..51a72b432d 100644
> --- a/hw/xen/xen-host-pci-device.c
> +++ b/hw/xen/xen-host-pci-device.c
> @@ -33,13 +34,101 @@
>  #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
>  #define IORESOURCE_MEM_64       0x00100000
>  
> +/*
> + * Non-passthrough (dom0) accesses are local PCI devices and use the given BDF
> + * Passthough (stubdom) accesses are through PV frontend PCI device.  Those
> + * either have a BDF identical to the backend's BFD (xen-backend.passthrough=1)
> + * or a local virtual BDF (xen-backend.passthrough=0)
> + *
> + * We are always given the backend's BDF and need to lookup the appropriate
> + * local BDF for sysfs access.
> + */
> +static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **errp)
> +{
> +    unsigned int num_devs, len, i;
> +    unsigned int domain, bus, dev, func;
> +    char *be_path;
> +    char path[80];
> +    char *msg;
> +
> +    be_path = qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", &len);
> +    if (!be_path) {
> +        /*
> +         * be_path doesn't exist, so we are dealing with a local
> +         * (non-passthough) device.
> +         */
> +        d->local_domain = d->domain;
> +        d->local_bus = d->bus;
> +        d->local_dev = d->dev;
> +        d->local_func = d->func;
> +
> +        return;
> +    }
> +
> +    snprintf(path, sizeof(path), "%s/num_devs", be_path);

Is 80 bytes for `path` enough?
What if the path is truncated due to the limit?


There's xs_node_scanf() which might be useful. It does the error
handling and call scanf(). But I'm not sure if it can be used here, in
this file.

> +    msg = qemu_xen_xs_read(xenstore, 0, path, &len);
> +    if (!msg) {
> +        goto err_out;
> +    }
> +
> +    if (sscanf(msg, "%u", &num_devs) != 1) {

libxl writes `num_devs` as "%d". So I think qemu should read a %d.


> +        error_setg(errp, "Failed to parse %s (%s)", msg, path);
> +        goto err_out;
> +    }
> +    free(msg);
> +
> +    for (i = 0; i < num_devs; i++) {
> +        snprintf(path, sizeof(path), "%s/dev-%u", be_path, i);

Same here, the path is written with a %d, even if that doesn't change the
result.


Thanks,

-- 
Anthony PERARD


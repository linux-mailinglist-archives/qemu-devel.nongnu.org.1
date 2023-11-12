Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850E7E929B
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 21:30:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2H5A-0000BG-Ac; Sun, 12 Nov 2023 15:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r2H58-0000Ah-9S; Sun, 12 Nov 2023 15:29:22 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r2H4y-0001bl-JW; Sun, 12 Nov 2023 15:29:22 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32fb190bf9bso2804365f8f.1; 
 Sun, 12 Nov 2023 12:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699820949; x=1700425749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/jNU331KITmkVsASw63ZPNUrO3e5vY6PR21jPlzvpZI=;
 b=FunPw+fENrQ6hGZHxG1Ll9DvxCqkzVSBf0XXlz+QfeOXqG30lcfq3mYTLPpd4LyBk5
 kch1crLGkhISisjV+wSxZgJYdi36Dvgkja4OFkCbsRuWRJQZAOr3S4lHJUexvrSpTdyF
 7dsS0pz7T84vjj9zMoObLJ+iZOTFURW59uc9e6vuyG+7gu+20xqagVV1RZP7EYDoK9Gz
 RrjUlNZVe+CgugSsOvlbbgCQXA9kZvvia7OlGbB22BB8xPxLoTWf1A6TRzOcYDidrXgr
 bwod7J1N5ek5VwYX/x0+mn362wMrqlANap1cQRPUyLmcomdL6lhpKaCrXB1FpD0zGOud
 A5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699820949; x=1700425749;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jNU331KITmkVsASw63ZPNUrO3e5vY6PR21jPlzvpZI=;
 b=AkrE/7i6mbu7t8emvGJ09qOZnJwsB3aNzMlgLDb/C64BOllV2nTcGsIPht72Nly2WN
 6YmNu481xT3fmsUuHuJRd70sJ0VgPXhGRDgwPdwwNUJu6BA1tGUDMvxrjWravK/oa9i8
 C/Wy34i/iOb/LcuSwDZhZFNSf1ayKPgW+AQ11rfQPDo7R8sZyy73Bxd+JMyRon5ofWWu
 c7sAscowJ7/C8IMRBBUyyH1Zq+Ef5JqF4h6JVp/KFEdGlazVfPfotyZkFosZWClbt/iC
 x5WKEff+nNml6ZPSnRM0RWMzm72IRHIUvnJ5gj4wK1aUrVJGRZG0QPaedknFXXh60NWZ
 sdVQ==
X-Gm-Message-State: AOJu0Yy90XfxGJJBKZeJNv9OUV4eE29lW7y7CCvH3OtTm1HLwiezxNh1
 Tr4iZ5YpBQ0BsL8d3HeN2K0=
X-Google-Smtp-Source: AGHT+IHOKXokV7EvaxoktV/LuS2AMerDvb5WvSP7RrTRcuvvQ0GFkNLwrvplBq2qwQ+GgfBFMpcYdQ==
X-Received: by 2002:a5d:64ae:0:b0:32d:d2aa:ed21 with SMTP id
 m14-20020a5d64ae000000b0032dd2aaed21mr8254274wrp.28.1699820949407; 
 Sun, 12 Nov 2023 12:29:09 -0800 (PST)
Received: from [192.168.199.91] (54-240-197-234.amazon.com. [54.240.197.234])
 by smtp.gmail.com with ESMTPSA id
 l35-20020a05600c1d2300b0040839fcb217sm5902154wms.8.2023.11.12.12.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 12:29:08 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ac83b5b0-1def-47b5-9466-7fe42dba7ccd@xen.org>
Date: Sun, 12 Nov 2023 15:29:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] xen-block: Do not write frontend nodes
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20231110204207.2927514-1-volodymyr_babchuk@epam.com>
 <20231110204207.2927514-2-volodymyr_babchuk@epam.com>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20231110204207.2927514-2-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/11/2023 15:42, Volodymyr Babchuk wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> The PV backend running in other than Dom0 domain (non toolstack domain)
> is not allowed to write frontend nodes. The more, the backend does not
> need to do that at all, this is purely toolstack/xl devd business.
> 
> I do not know for what reason the backend does that here, this is not really
> needed, probably it is just a leftover and all xen_device_frontend_printf()
> instances should go away completely.
>

It is not a leftover and it is needed in the case that QEMU is 
instantiating the backend unilaterally... i.e. without the involvement 
of any Xen toolstack.
Agreed that, if QEMU, is running in a deprivileged context, that is not 
an option. The correct way to determined this though is whether the 
device is being created via the QEMU command line or whether is being 
created because XenStore nodes written by a toolstack were discovered.
In the latter case there should be a XenBackendInstance that corresponds 
to the XenDevice whereas in the former case there should not be. For 
example, see xen_backend_try_device_destroy()

   Paul


> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>   hw/block/xen-block.c | 11 +++++++----
>   hw/xen/xen-bus.c     |  2 +-
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index a07cd7eb5d..dc4d477c22 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -221,6 +221,7 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
>       XenBlockVdev *vdev = &blockdev->props.vdev;
>       BlockConf *conf = &blockdev->props.conf;
>       BlockBackend *blk = conf->blk;
> +    XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
>   
>       if (vdev->type == XEN_BLOCK_VDEV_TYPE_INVALID) {
>           error_setg(errp, "vdev property not set");
> @@ -280,10 +281,12 @@ static void xen_block_realize(XenDevice *xendev, Error **errp)
>   
>       xen_device_backend_printf(xendev, "info", "%u", blockdev->info);
>   
> -    xen_device_frontend_printf(xendev, "virtual-device", "%lu",
> -                               vdev->number);
> -    xen_device_frontend_printf(xendev, "device-type", "%s",
> -                               blockdev->device_type);
> +    if (xenbus->backend_id == 0) {
> +        xen_device_frontend_printf(xendev, "virtual-device", "%lu",
> +                                   vdev->number);
> +        xen_device_frontend_printf(xendev, "device-type", "%s",
> +                                   blockdev->device_type);
> +    }
>   
>       xen_device_backend_printf(xendev, "sector-size", "%u",
>                                 conf->logical_block_size);
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index ece8ec40cd..06d5192aca 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -1048,7 +1048,7 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
>       xen_device_backend_set_online(xendev, true);
>       xen_device_backend_set_state(xendev, XenbusStateInitWait);
>   
> -    if (!xen_device_frontend_exists(xendev)) {
> +    if (!xen_device_frontend_exists(xendev) && xenbus->backend_id == 0) {
>           xen_device_frontend_printf(xendev, "backend", "%s",
>                                      xendev->backend_path);
>           xen_device_frontend_printf(xendev, "backend-id", "%u",



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7F8803AE5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:52:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACA2-0003Pw-7I; Mon, 04 Dec 2023 11:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAC9w-0003PT-2o
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:51:04 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAC9r-0007hW-OV
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:51:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c0a11a914so13584955e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 08:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701708657; x=1702313457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FN86E7BxTnD/WgcQgwGZOUK1scAadtT+ASiMeR0AfXE=;
 b=R+RyHRWX4GcZLIPkQWdTU/5fzy7f+WJ+Ex7U66Rbq9MBPwttxGL3k9tV32RsTW75gX
 ME/+H4FB50psIeMwW+mMbUV7WBn8S+WpWw2UFu57G/V7LPVZhNpo3C+FvJGCx5tFWQ8X
 LF4D4LixeyXYaM6O0OI5S2oPuGDMI6znzPQ4N2w0E/bYZ+ETvMmKlRmD2HEYKDhNNcon
 OTKfMVw/uVSaCoLw9+WrY3tbeA6yx8isCCRLi/gadBWIUaxzjQUmyKef2V6vVATEj9kk
 hZjkks5nK5m8hitABVdZwy1snDyBLeWs/buOW89UxjO3AR/2pSJ8HbD+fmqURw1biP00
 +u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701708657; x=1702313457;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FN86E7BxTnD/WgcQgwGZOUK1scAadtT+ASiMeR0AfXE=;
 b=GTu1ywW8pd1vwEolDIDYxIkfGXPclJYGjHSZM+mPkwVoOcJkAAMicg56DYQmJm5L/T
 zr7YjmtuKP5h9UdncFdsiqIX9RAYLOQVIIxVc11F82vZ3TR13gtQqgxTKgYV7gXg0z7M
 MBk5yxqCgPMGjU2WBm4q78R4CwuXDh3Fa2+O5HS8DMWOcLizDYj6Und94Vzcn7JluQV7
 h7RHmm74sXMK7PHH91vEQE205yl8mp/KqfJEkke//z1S6M/gNmVGEc5BhTJBdYH8Nd9w
 8X+0axtV1yrWnTswCPRCBX/DdndwPYbbNLk7QqcHuYW9GoC+sL3TqUpolyNW0gMV5Bu4
 pJ3g==
X-Gm-Message-State: AOJu0YyY6e3I6my0VyX0mg860wqM635ZdIeDekSD+PtuiybhfkJOD3S3
 zObSluGyH8wt521XYO2EMWvs4w==
X-Google-Smtp-Source: AGHT+IH3klwe2XxXEXb9jvfuvqEJNjCc7/f+coKEQcSJAw0jWDlpEkUsLRbdhbyB+wArdWQhG/ycNA==
X-Received: by 2002:a05:600c:a43:b0:40b:5e21:cc35 with SMTP id
 c3-20020a05600c0a4300b0040b5e21cc35mr2581687wmq.96.1701708657453; 
 Mon, 04 Dec 2023 08:50:57 -0800 (PST)
Received: from [192.168.69.100] ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c470900b004063cd8105csm19304450wmo.22.2023.12.04.08.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 08:50:56 -0800 (PST)
Message-ID: <1f537ae8-c3e6-4213-b2c7-b9398b8e1f64@linaro.org>
Date: Mon, 4 Dec 2023 17:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2?] hw/ufs: avoid generating the same ID string for
 different LU devices
Content-Language: en-US
To: Akinobu Mita <akinobu.mita@gmail.com>, qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block <qemu-block@nongnu.org>
References: <20231204150543.48252-1-akinobu.mita@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231204150543.48252-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 4/12/23 16:05, Akinobu Mita wrote:
> QEMU would not start when trying to create two UFS host controllers and
> a UFS logical unit for each with the following options:
> 
> -device ufs,id=bus0 \
> -device ufs-lu,drive=drive1,bus=bus0,lun=0 \
> -device ufs,id=bus1 \
> -device ufs-lu,drive=drive2,bus=bus1,lun=0 \
> 
> This is because the same ID string ("0:0:0/scsi-disk") is generated
> for both UFS logical units.
> 
> To fix this issue, prepend the parent pci device's path to make
> the ID string unique.
> ("0000:00:03.0/0:0:0/scsi-disk" and "0000:00:04.0/0:0:0/scsi-disk")
> 
> Fixes: 096434fea13a ("hw/ufs: Modify lu.c to share codes with SCSI subsystem")
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/ufs/ufs.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index 68c5f1f6c9..eccdb852a0 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -1323,9 +1323,17 @@ static bool ufs_bus_check_address(BusState *qbus, DeviceState *qdev,
>       return true;
>   }
>   
> +static char *ufs_bus_get_dev_path(DeviceState *dev)
> +{
> +    BusState *bus = qdev_get_parent_bus(dev);
> +
> +    return qdev_get_dev_path(bus->parent);
> +}
> +
>   static void ufs_bus_class_init(ObjectClass *class, void *data)
>   {
>       BusClass *bc = BUS_CLASS(class);
> +    bc->get_dev_path = ufs_bus_get_dev_path;
>       bc->check_address = ufs_bus_check_address;
>   }
>   



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC980E896
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:06:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzdB-0002bO-2l; Tue, 12 Dec 2023 05:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzd7-0002Yi-Dt
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:04:45 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzd1-00018a-S9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:04:45 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1e35c2807fso724014166b.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702375478; x=1702980278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgpI/VlyRO0uGf9itJVWEXR3I8xyOuRFezS1IzRpXvA=;
 b=Xo8F4Bln5ljz2xIJtJHaD/YZ9GaqloP1xJSg5pJh5r6aaCtKMGmXYLFDWdkJJ8gt8r
 Oq/6hBVN4a6iQbhZTLqJgukwGmROUwM7Fem2/LpnmBTkBpAI1yOjNM6/y7hSxDfpCR4F
 VcDtBt/AzVnoRrQkcj0BhmWQ3vIXo1Rsz9jyQok1h2BvnwtPq3xxjVTMgrFY0ftUoJbg
 znTWsfkdHGMJKWN1DaNpNTzUWjYkeortUxOhDsFvCxHUYDvWE5GN0O+/aWvls+bPjioU
 vQZFvJS6GXYQIg2NHb3BmvmyYC2DdUbZekQG2MS6hBjU6MSEOHqT8Wpq5dg4lNIVbCjo
 a5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702375478; x=1702980278;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DgpI/VlyRO0uGf9itJVWEXR3I8xyOuRFezS1IzRpXvA=;
 b=qnQ6IwrZIJ1KefrnM5waiTEkTBHtWcK700F5//awU5YAJRpVqbbWB4TQJnQJINW2kr
 N3NYZD5+T6Etkv//i4bj8KqYCD17syhYJFYNMB8B6sjj5lKtk05qaqslL/BbesZLvE0A
 7Ep5T0jHqbpwDqdjRYoLzpx0vMYOH7LB1D3DnSWuE+ia1bK3oIJhbj3Z9EO4GsJ1FPwO
 11DN4JGmNoU88UHax4ne7Zor+fKll18T5/EiH5+Amylx0R/4oNHqovTzIScqyzeMbOo+
 ALxryJ0cLMMTkntTXI14o3P0SZVHp6yq+YxsVCcbG1NMh/X0jc0NDZvNlR4mmkMOA+Am
 uo3g==
X-Gm-Message-State: AOJu0YzXxLg9Be8L2LmtauPw6eSAfguwuILMoAbn7Ecx1GvrjMBPeFsi
 kqzVnfsKJcgJ6tsiUGKa727Ztw==
X-Google-Smtp-Source: AGHT+IEsgcizs/XJoPAQLV0/I62qhM65YQzukKfmC4ychzDIGO42XqdZ+P7D74U7Mro2IMSG5ArMGg==
X-Received: by 2002:a17:906:73cd:b0:a19:d66d:dc60 with SMTP id
 n13-20020a17090673cd00b00a19d66ddc60mr3163081ejl.67.1702375478086; 
 Tue, 12 Dec 2023 02:04:38 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 fj8-20020a1709069c8800b00a1d5c342674sm5951303ejc.27.2023.12.12.02.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 02:04:37 -0800 (PST)
Message-ID: <b2a8fe53-e432-4c61-8cc3-f39c6b650cd7@linaro.org>
Date: Tue, 12 Dec 2023 11:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 05/12] hw/qdev: Remove opts member
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yui Washizu <yui.washidu@gmail.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
 <20231210-sriov-v2-5-b959e8a6dfaf@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231210-sriov-v2-5-b959e8a6dfaf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 10/12/23 05:05, Akihiko Odaki wrote:
> It is no longer used.

Since commit f3558b1b76 ("qdev: Base object creation on QDict rather
than QemuOpts")?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/qdev-core.h |  4 ----
>   hw/core/qdev.c         |  1 -
>   system/qdev-monitor.c  | 12 +++++++-----
>   3 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 151d968238..6befbca311 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -237,10 +237,6 @@ struct DeviceState {
>        * @pending_deleted_expires_ms: optional timeout for deletion events
>        */
>       int64_t pending_deleted_expires_ms;
> -    /**
> -     * @opts: QDict of options for the device
> -     */
> -    QDict *opts;
>       /**
>        * @hotplugged: was device added after PHASE_MACHINE_READY?
>        */
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 43d863b0c5..c98691a90d 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -706,7 +706,6 @@ static void device_finalize(Object *obj)
>           dev->canonical_path = NULL;
>       }
>   
> -    qobject_unref(dev->opts);
>       g_free(dev->id);
>   }
>   
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index a13db763e5..71c00f62ee 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -625,6 +625,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>       char *id;
>       DeviceState *dev = NULL;
>       BusState *bus = NULL;
> +    QDict *properties;
>   
>       driver = qdict_get_try_str(opts, "driver");
>       if (!driver) {
> @@ -705,13 +706,14 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
>       }
>   
>       /* set properties */
> -    dev->opts = qdict_clone_shallow(opts);
> -    qdict_del(dev->opts, "driver");
> -    qdict_del(dev->opts, "bus");
> -    qdict_del(dev->opts, "id");
> +    properties = qdict_clone_shallow(opts);
> +    qdict_del(properties, "driver");
> +    qdict_del(properties, "bus");
> +    qdict_del(properties, "id");
>   
> -    object_set_properties_from_keyval(&dev->parent_obj, dev->opts, from_json,
> +    object_set_properties_from_keyval(&dev->parent_obj, properties, from_json,
>                                         errp);
> +    qobject_unref(properties);
>       if (*errp) {
>           goto err_del_dev;
>       }
> 



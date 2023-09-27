Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A1A7B0235
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:52:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlS9a-00049k-3a; Wed, 27 Sep 2023 06:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlS9Y-00049c-SX
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qlS9X-0006hc-6G
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695811941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UfBKbYZJYwjDzRsTFWT8dhcE5AchdeikEi3N+xpzZDA=;
 b=gte4ZaBCGJQHmM9y0cNTWcwLuFyxqXhZAh7fcRl8PSQYBnjuQmLwJm6OYcdv0blPZTEqU+
 hbS/dM/oI/rYUSpAR7g+qJzkO8HjwWKPTwZvuokRwvU9r1PbLTZMjV+Nw7b8RFOJia+zr5
 Sg8xrFThiEhaFdmCwhGLrQLRvVXfNNM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153--6ggK3d9MTmK1JEO5yV-bA-1; Wed, 27 Sep 2023 06:52:20 -0400
X-MC-Unique: -6ggK3d9MTmK1JEO5yV-bA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3233a13b47eso2408803f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695811939; x=1696416739;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfBKbYZJYwjDzRsTFWT8dhcE5AchdeikEi3N+xpzZDA=;
 b=bczDUxslInsios22XErpB0rwjkP3wx0BwuQ9OXd26uU4mbfJosm65LnbZyIoSOU3q7
 RhbRbEEp0B6eK5s6V3oRR8Ep0scmJAmkNNk33DaQe2JaYehK1bL5iq1KORePA+PKWdAe
 PPqU115CnH/yg9wLH9miHApZqvIKnSrlBetoLE17b0f9SztyxcHBH52+Y6kQTLpcQJfT
 1S0qiR+wRivHdRuaZtXKxJuUBvQoCAwQkdP6SyavrNnaLnaFESR3U8JdbdH/LoT/ZmeD
 4bUb99jHlet18O2YQ8XzNknyxESIhwlx44hAKGgB3C+VVT5jatiXL3KP+w+5MCnkC7zC
 XK9Q==
X-Gm-Message-State: AOJu0Yxq22o2D5yp/hdD9T6iKRU3ntCsru+nXsUNjWU8W9IX7kgPo71I
 u7gm7sSgtZ5FC1WYNeKUI4LJZnJekPYXe51nh/MmokYF6ma0g0X/09LR4IIJVzRWYNxF1D0bi7L
 a773D1i2c8ddlHbgmV/ezxI0=
X-Received: by 2002:adf:e241:0:b0:31f:d95d:20a6 with SMTP id
 bl1-20020adfe241000000b0031fd95d20a6mr1375199wrb.12.1695811939166; 
 Wed, 27 Sep 2023 03:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIm4BEhu1B3/shxhxpQmaT6Q+354YoIXAMLYPvqTo6Fn7hUtqixcBydEnxE23Gp20fKs+jPA==
X-Received: by 2002:adf:e241:0:b0:31f:d95d:20a6 with SMTP id
 bl1-20020adfe241000000b0031fd95d20a6mr1375182wrb.12.1695811938712; 
 Wed, 27 Sep 2023 03:52:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c749:6900:3a06:bd5:2f7b:e6eb?
 (p200300cbc74969003a060bd52f7be6eb.dip0.t-ipconnect.de.
 [2003:cb:c749:6900:3a06:bd5:2f7b:e6eb])
 by smtp.gmail.com with ESMTPSA id
 d12-20020adf9b8c000000b003233a8b425esm3008540wrc.115.2023.09.27.03.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:52:18 -0700 (PDT)
Message-ID: <1de1dcaf-7419-96f8-8ac5-eee5f1e336c4@redhat.com>
Date: Wed, 27 Sep 2023 12:52:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 5/7] qapi: Add query-memory-devices support to
 hv-balloon
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1693240836.git.maciej.szmigiero@oracle.com>
 <a9f908446234de087ab5857f53a9449173f809dc.1693240836.git.maciej.szmigiero@oracle.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <a9f908446234de087ab5857f53a9449173f809dc.1693240836.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.08.23 18:48, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Used by the driver to report its provided memory state information.
> 
> Co-developed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
>   hw/hyperv/hv-balloon.c     | 27 +++++++++++++++++++++++++-
>   qapi/machine.json          | 39 ++++++++++++++++++++++++++++++++++++--
>   3 files changed, 78 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c3e55ef9e9cd..7b06ed35decb 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -247,6 +247,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>       MemoryDeviceInfo *value;
>       PCDIMMDeviceInfo *di;
>       SgxEPCDeviceInfo *se;
> +    HvBalloonDeviceInfo *hi;
>   
>       for (info = info_list; info; info = info->next) {
>           value = info->value;
> @@ -304,6 +305,20 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                   monitor_printf(mon, "  node: %" PRId64 "\n", se->node);
>                   monitor_printf(mon, "  memdev: %s\n", se->memdev);
>                   break;
> +            case MEMORY_DEVICE_INFO_KIND_HV_BALLOON:
> +                hi = value->u.hv_balloon.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               hi->id ? hi->id : "");
> +                if (hi->has_memaddr) {
> +                    monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n",
> +                                   hi->memaddr);
> +                }
> +                monitor_printf(mon, "  max-size: %" PRIu64 "\n", hi->max_size);
> +                if (hi->memdev) {
> +                    monitor_printf(mon, "  memdev: %s\n", hi->memdev);
> +                }
> +                break;
>               default:
>                   g_assert_not_reached();
>               }
> diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
> index 4d87f99375b5..c384f23a3b5e 100644
> --- a/hw/hyperv/hv-balloon.c
> +++ b/hw/hyperv/hv-balloon.c
> @@ -1622,6 +1622,31 @@ static MemoryRegion *hv_balloon_md_get_memory_region(MemoryDeviceState *md,
>       return balloon->mr;
>   }
>   
> +static void hv_balloon_md_fill_device_info(const MemoryDeviceState *md,
> +                                           MemoryDeviceInfo *info)
> +{
> +    HvBalloonDeviceInfo *hi = g_new0(HvBalloonDeviceInfo, 1);
> +    const HvBalloon *balloon = HV_BALLOON(md);
> +    DeviceState *dev = DEVICE(md);
> +
> +    if (dev->id) {
> +        hi->id = g_strdup(dev->id);
> +    }
> +
> +    if (balloon->hostmem) {
> +        hi->memdev = object_get_canonical_path(OBJECT(balloon->hostmem));
> +        hi->memaddr = balloon->addr;
> +        hi->has_memaddr = true;
> +        hi->max_size = memory_region_size(balloon->mr);
> +        /* TODO: expose current provided size or something else? */
> +    } else {
> +        hi->max_size = 0;
> +    }
> +
> +    info->u.hv_balloon.data = hi;
> +    info->type = MEMORY_DEVICE_INFO_KIND_HV_BALLOON;
> +}
> +
>   static void hv_balloon_decide_memslots(MemoryDeviceState *md,
>                                          unsigned int limit)
>   {
> @@ -1709,5 +1734,5 @@ static void hv_balloon_class_init(ObjectClass *klass, void *data)
>       mdc->get_memory_region = hv_balloon_md_get_memory_region;
>       mdc->decide_memslots = hv_balloon_decide_memslots;
>       mdc->get_memslots = hv_balloon_get_memslots;
> -    /* implement fill_device_info */
> +    mdc->fill_device_info = hv_balloon_md_fill_device_info;
>   }
> diff --git a/qapi/machine.json b/qapi/machine.json
> index a08b6576cac6..5ede977cf2bc 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1265,6 +1265,29 @@
>             }
>   }
>   
> +##
> +# @HvBalloonDeviceInfo:
> +#
> +# hv-balloon provided memory state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @max-size: the maximum size of memory that the device can provide
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'HvBalloonDeviceInfo',
> +  'data': { '*id': 'str',
> +            '*memaddr': 'size',
> +            'max-size': 'size',
> +            '*memdev': 'str'
> +          }
> +}
> +
>   ##
>   # @MemoryDeviceInfoKind:
>   #
> @@ -1276,10 +1299,13 @@
>   #
>   # @sgx-epc: since 6.2.
>   #
> +# @hv-balloon: since 8.2.
> +#
>   # Since: 2.1
>   ##
>   { 'enum': 'MemoryDeviceInfoKind',
> -  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc' ] }
> +  'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
> +            'hv-balloon' ] }
>   
>   ##
>   # @PCDIMMDeviceInfoWrapper:
> @@ -1313,6 +1339,14 @@
>   { 'struct': 'SgxEPCDeviceInfoWrapper',
>     'data': { 'data': 'SgxEPCDeviceInfo' } }
>   
> +##
> +# @HvBalloonDeviceInfoWrapper:
> +#
> +# Since: 8.2
> +##
> +{ 'struct': 'HvBalloonDeviceInfoWrapper',
> +  'data': { 'data': 'HvBalloonDeviceInfo' } }
> +
>   ##
>   # @MemoryDeviceInfo:
>   #
> @@ -1327,7 +1361,8 @@
>               'nvdimm': 'PCDIMMDeviceInfoWrapper',
>               'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
>               'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
> -            'sgx-epc': 'SgxEPCDeviceInfoWrapper'
> +            'sgx-epc': 'SgxEPCDeviceInfoWrapper',
> +            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
>             }
>   }
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151667A49C3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDRJ-00019Q-OF; Mon, 18 Sep 2023 08:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiDRG-000199-W0
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiDRB-0007UJ-RO
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695040392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coBfqFpb/wyZXdS6QqkGdg1gDXZjIlpUGhl0nSH9DK0=;
 b=G226CmAz7zYjbflDMIl5j7TsDGIcjVNNdsQpibP/ZxqYFaqvpCHDT4ZH3qobUAMPkTyBTi
 0lkcx9tatm7WsZS/c/nA4xJgsZVjTW7O3G8MR9M6tc2VDnQFuOm+JypZmVcYOx62c6YDPl
 WTs462QxdCdemtFJJGc6TwFIS+eSvTw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-xikWoa_gMB2qo9TuKeWFkw-1; Mon, 18 Sep 2023 08:33:11 -0400
X-MC-Unique: xikWoa_gMB2qo9TuKeWFkw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401bdff6bc5so34427805e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 05:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695040390; x=1695645190;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=coBfqFpb/wyZXdS6QqkGdg1gDXZjIlpUGhl0nSH9DK0=;
 b=LV5fLkLNOVC54mWhO/yXVNo7RiKyR3agxpsJEwr0tqqEhdHjEBmpHxP79wqVnApIGF
 9oupyPdQXl3kgRess05A7/SNY7ue7q4zO+n2Xb2Z0/ZFm5Xd5CceFpUyR5SB9KaENpdw
 IZIrTenD18BkF00zCYtYAZnPQzBjOyf9XEiBB4TxbM8uewcn8nZCAZ0klr3w1bgeDyS7
 I3bZELavvZs9ut4Z59wvlGifa8++msRwbyLl/903h5KZuVlVLcrlvJ+5a0TKRpixM0yn
 8j45IrjI3SY9crVeiHZtWvkOTNsvRUWUlDnd2yLtm3Mlkd3LScFdevtIRiwHBKAHqP5D
 Gn2w==
X-Gm-Message-State: AOJu0YxhXy2WUrehJVOTsqRibAslqvNvY5n+U8bAUzP1r32JMCvEztia
 NL/ivolziioBDRGEJBEDZVkVPP3+If9OwuG8VxOtGMeyupAiCzHR2bFsYOSDBAxbFGRCFsyAoZr
 2m/QaG9lSGs7Tf9I=
X-Received: by 2002:a5d:62c6:0:b0:31c:6420:fff with SMTP id
 o6-20020a5d62c6000000b0031c64200fffmr7396191wrv.62.1695040390261; 
 Mon, 18 Sep 2023 05:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD2P2BOV8swT5NqgKUM7ukPnqT6Lw5yhuc2qSplvEKAcB1ptTGcysHmpiONsvPY8kCubbpcQ==
X-Received: by 2002:a5d:62c6:0:b0:31c:6420:fff with SMTP id
 o6-20020a5d62c6000000b0031c64200fffmr7396166wrv.62.1695040389872; 
 Mon, 18 Sep 2023 05:33:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee?
 (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de.
 [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d5444000000b0031f3b04e7cdsm12367500wrv.109.2023.09.18.05.33.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 05:33:09 -0700 (PDT)
Message-ID: <43d310b6-e4aa-da33-c845-49e606a947fe@redhat.com>
Date: Mon, 18 Sep 2023 14:33:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
References: <20230908142136.403541-1-david@redhat.com>
 <20230908142136.403541-13-david@redhat.com>
 <75866f2e-13c3-220e-cea8-bebc983b8cf7@maciej.szmigiero.name>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 12/16] memory-device, vhost: Support automatic decision
 on the number of memslots
In-Reply-To: <75866f2e-13c3-220e-cea8-bebc983b8cf7@maciej.szmigiero.name>
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

On 17.09.23 12:46, Maciej S. Szmigiero wrote:
> On 8.09.2023 16:21, David Hildenbrand wrote:
>> We want to support memory devices that can automatically decide how many
>> memslots they will use. In the worst case, they have to use a single
>> memslot.
>>
>> The target use cases are virtio-mem and the hyper-v balloon.
>>
>> Let's calculate a reasonable limit such a memory device may use, and
>> instruct the device to make a decision based on that limit. Use a simple
>> heuristic that considers:
>> * A memslot soft-limit for all memory devices of 256; also, to not
>>     consume too many memslots -- which could harm performance.
>> * Actually still free and unreserved memslots
>> * The percentage of the remaining device memory region that memory device
>>     will occupy.
>>
>> Further, while we properly check before plugging a memory device whether
>> there still is are free memslots, we have other memslot consumers (such as
>> boot memory, PCI BARs) that don't perform any checks and might dynamically
>> consume memslots without any prior reservation. So we might succeed in
>> plugging a memory device, but once we dynamically map a PCI BAR we would
>> be in trouble. Doing accounting / reservation / checks for all such
>> users is problematic (e.g., sometimes we might temporarily split boot
>> memory into two memslots, triggered by the BIOS).
>>
>> We use the historic magic memslot number of 509 as orientation to when
>> supporting 256 memory devices -> memslots (leaving 253 for boot memory and
>> other devices) has been proven to work reliable. We'll fallback to
>> suggesting a single memslot if we don't have at least 509 total memslots.
>>
>> Plugging vhost devices with less than 509 memslots available while we
>> have memory devices plugged that consume multiple memslots due to
>> automatic decisions can be problematic. Most configurations might just fail
>> due to "limit < used + reserved", however, it can also happen that these
>> memory devices would suddenly consume memslots that would actually be
>> required by other memslot consumers (boot, PCI BARs) later. Note that this
>> has always been sketchy with vhost devices that support only a small number
>> of memslots; but we don't want to make it any worse.So let's keep it simple
>> and simply reject plugging such vhost devices in such a configuration.
>>
>> Eventually, all vhost devices that want to be fully compatible with such
>> memory devices should support a decent number of memslots (>= 509).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
> 
> Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Thanks!

> 
> I would be nice to ultimately allow raising the 509 memslot limit,
> considering that KVM had supported 32k memslots for more than two years
> now and had a much more scalable implementation since early 2022.

It's all tricky due to vhost (and hotplug of such devices) and the QEMU 
internal address translation (which isn't that scalable).

I was thinking about having a parameter to configure the number of 
memslots for memory devices, such that one could manually raise the 
"256" limit for memory devices.

But for now I kept it simple, because it all turned out to become way to 
complicated.

-- 
Cheers,

David / dhildenb



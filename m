Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE737BB43C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoh9Q-0003SH-7h; Fri, 06 Oct 2023 05:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qoh9J-00037s-Bn
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qoh9H-0006Xm-EQ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696584568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vvA1lHKzQGxfWAWbwTOmAmPDMRdiZLc1hXad/9hlzkk=;
 b=AFF49I9kxhFab+L1JadhymjH7va4TdFXwqffAumyDSW0kxUlxTeuV0FK1Exr2s8lrN869r
 8QjjoZ06yxk7C2/AA+XEV5m0fNaq4gjiLk1jZ0g17BqB4HJ09wktWoIfPZLQBq7eHLcHVk
 C2Lq+lye2wtG5plAzfCabt1eV1cNolU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-ewPvP5xCNhS8z0s18OVtXg-1; Fri, 06 Oct 2023 05:29:22 -0400
X-MC-Unique: ewPvP5xCNhS8z0s18OVtXg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so12585025e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696584561; x=1697189361;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vvA1lHKzQGxfWAWbwTOmAmPDMRdiZLc1hXad/9hlzkk=;
 b=t5OO1b+n8+sMxmJm1zjhLWOK1A/lnBeum1Jte87L/Qj79dgKABkoPZoYEwww49Rpuf
 XDrbJ3t7c7dMofNy5LbB67eimoif9bDHH5wwCXV4wtlyp40QvTk7izvbVVcNjEpdDscx
 mCnoS+lWLn1zVkpVI9IQCBC65s258FsOOY59XSZXOhpjvl1s5ELWSrT/fRKp4vWio9Jo
 LWmUQ/psY8kXOUkouU5v23VYSsH6qHH1MCv/j/oJ/F1vHuoa6P+SphhccbiJrxXSi3WC
 rQDsDFAGKRRTdkphEx/T2Ghdy2+UbKM0+AxtFQYNE4l+i2PwKH3KApSR2UVI8rukOvSo
 ug2Q==
X-Gm-Message-State: AOJu0Yw73qGIlWoNnu48Oiur1OpD7/r1JzXacJ+ARrhCBINqnY//waKx
 ZEdoDxUtYP12CWFi/mYc7wDW9WBppF91ElZ0nR0JOw1KAXroJcp/LCLCq9H1ktzdoAVAktq9MQa
 dw7uefLWTICWsX/w=
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id
 z25-20020a05600c221900b004051c19b747mr6694341wml.15.1696584560733; 
 Fri, 06 Oct 2023 02:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHupXihKRAP5qBZjCaoRVmVkV+yniUqhncS+SA6+IhjXmDvvug/kRNA1LTItXRR2oraHZDzDg==
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id
 z25-20020a05600c221900b004051c19b747mr6694318wml.15.1696584560060; 
 Fri, 06 Oct 2023 02:29:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:ee00:4e24:cf8e:3de0:8819?
 (p200300cbc715ee004e24cf8e3de08819.dip0.t-ipconnect.de.
 [2003:cb:c715:ee00:4e24:cf8e:3de0:8819])
 by smtp.gmail.com with ESMTPSA id
 4-20020a05600c248400b004060f0a0fd5sm3316313wms.13.2023.10.06.02.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 02:29:19 -0700 (PDT)
Message-ID: <edf56572-1e7a-be30-d331-635493785d8c@redhat.com>
Date: Fri, 6 Oct 2023 11:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230926185738.277351-1-david@redhat.com>
 <20231003093802-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 00/18] virtio-mem: Expose device memory through
 multiple memslots
In-Reply-To: <20231003093802-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 03.10.23 15:39, Michael S. Tsirkin wrote:
> On Tue, Sep 26, 2023 at 08:57:20PM +0200, David Hildenbrand wrote:
>> Quoting from patch #16:
>>
>>      Having large virtio-mem devices that only expose little memory to a VM
>>      is currently a problem: we map the whole sparse memory region into the
>>      guest using a single memslot, resulting in one gigantic memslot in KVM.
>>      KVM allocates metadata for the whole memslot, which can result in quite
>>      some memory waste.
>>
>>      Assuming we have a 1 TiB virtio-mem device and only expose little (e.g.,
>>      1 GiB) memory, we would create a single 1 TiB memslot and KVM has to
>>      allocate metadata for that 1 TiB memslot: on x86, this implies allocating
>>      a significant amount of memory for metadata:
>>
>>      (1) RMAP: 8 bytes per 4 KiB, 8 bytes per 2 MiB, 8 bytes per 1 GiB
>>          -> For 1 TiB: 2147483648 + 4194304 + 8192 = ~ 2 GiB (0.2 %)
>>
>>          With the TDP MMU (cat /sys/module/kvm/parameters/tdp_mmu) this gets
>>          allocated lazily when required for nested VMs
>>      (2) gfn_track: 2 bytes per 4 KiB
>>          -> For 1 TiB: 536870912 = ~512 MiB (0.05 %)
>>      (3) lpage_info: 4 bytes per 2 MiB, 4 bytes per 1 GiB
>>          -> For 1 TiB: 2097152 + 4096 = ~2 MiB (0.0002 %)
>>      (4) 2x dirty bitmaps for tracking: 2x 1 bit per 4 KiB page
>>          -> For 1 TiB: 536870912 = 64 MiB (0.006 %)
>>
>>      So we primarily care about (1) and (2). The bad thing is, that the
>>      memory consumption doubles once SMM is enabled, because we create the
>>      memslot once for !SMM and once for SMM.
>>
>>      Having a 1 TiB memslot without the TDP MMU consumes around:
>>      * With SMM: 5 GiB
>>      * Without SMM: 2.5 GiB
>>      Having a 1 TiB memslot with the TDP MMU consumes around:
>>      * With SMM: 1 GiB
>>      * Without SMM: 512 MiB
>>
>>      ... and that's really something we want to optimize, to be able to just
>>      start a VM with small boot memory (e.g., 4 GiB) and a virtio-mem device
>>      that can grow very large (e.g., 1 TiB).
>>
>>      Consequently, using multiple memslots and only mapping the memslots we
>>      really need can significantly reduce memory waste and speed up
>>      memslot-related operations. Let's expose the sparse RAM memory region using
>>      multiple memslots, mapping only the memslots we currently need into our
>>      device memory region container.
>>
>> The hyper-v balloon driver has similar demands [1].
>>
>> For virtio-mem, this has to be turned manually on ("dynamic-memslots=on"),
>> due to the interaction with vhost (below).
>>
>> If we have less than 509 memslots available, we always default to a single
>> memslot. Otherwise, we automatically decide how many memslots to use
>> based on a simple heuristic (see patch #12), and try not to use more than
>> 256 memslots across all memory devices: our historical DIMM limit.
>>
>> As soon as any memory devices automatically decided on using more than
>> one memslot, vhost devices that support less than 509 memslots (e.g.,
>> currently most vhost-user devices like with virtiofsd) can no longer be
>> plugged as a precaution.
>>
>> Quoting from patch #12:
>>
>>      Plugging vhost devices with less than 509 memslots available while we
>>      have memory devices plugged that consume multiple memslots due to
>>      automatic decisions can be problematic. Most configurations might just fail
>>      due to "limit < used + reserved", however, it can also happen that these
>>      memory devices would suddenly consume memslots that would actually be
>>      required by other memslot consumers (boot, PCI BARs) later. Note that this
>>      has always been sketchy with vhost devices that support only a small number
>>      of memslots; but we don't want to make it any worse.So let's keep it simple
>>      and simply reject plugging such vhost devices in such a configuration.
>>
>>      Eventually, all vhost devices that want to be fully compatible with such
>>      memory devices should support a decent number of memslots (>= 509).
>>
>>
>> The recommendation is to plug such vhost devices before the virtio-mem
>> decides, or to not set "dynamic-memslots=on". As soon as these devices
>> support a reasonable number of memslots (>= 509), this will start working
>> automatically.
>>
>> I run some tests on x86_64, now also including vfio and migration tests.
>> Seems to work as expected, even when multiple memslots are used.
>>
>>
>> Patch #1 -- #3 are from [2] that were not picked up yet.
>>
>> Patch #4 -- #12 add handling of multiple memslots to memory devices
>>
>> Patch #13 -- #16 add "dynamic-memslots=on" support to virtio-mem
>>
>> Patch #15 -- #16 make sure that virtio-mem memslots can be enabled/disable
>>               atomically
> 
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> pls feel free to merge.

Thanks!

Queued to

https://github.com/davidhildenbrand/qemu.git mem-next

-- 
Cheers,

David / dhildenb



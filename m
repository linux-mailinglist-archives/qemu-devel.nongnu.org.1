Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F807B4E6E
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEll-0003gg-06; Mon, 02 Oct 2023 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qnEle-0003Kt-H9
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 04:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qnElc-0003aH-DA
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 04:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696237143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wxgm+8Bfp8FIpwJp0F8Lsnx34gN58d0JfUtgLpCGQBE=;
 b=HPy4oX8dnURPEtxVHTVhGP1PExgRktKF5wyjC5axGUo97rifXQ/8Loq7tYOpCX7zPO5iLu
 hvNkReEY3BtaQX3g47KEZ3+RVmE/yw4/kEacrmRC9FcoSH9za3i6Vd1BKC/lgkLXQr6owO
 MhUpddyg+3jILeZZfFW8Rn+cqRNevQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-PJH0fziYMfmpQivHwagJew-1; Mon, 02 Oct 2023 04:58:56 -0400
X-MC-Unique: PJH0fziYMfmpQivHwagJew-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso142057075e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 01:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696237136; x=1696841936;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wxgm+8Bfp8FIpwJp0F8Lsnx34gN58d0JfUtgLpCGQBE=;
 b=KCiBFvOpEP/LGRU5sI93YejJSHF1aYzEJGvRnjMPnKDNm8irDtWavU7DPVNMXYyvMj
 Yf6JVxTZbG2hGXkRb8R80XW21H3aiKAb9Ln0nMRx5+u7FcHmFFFdUrNM4DFFO5Xwp6vF
 abbLEdxa5ZvmMdmn7FssPrQNHEFiJVHze0LzXddD4h0sdK6tYXTi2wd+cqGXVFcghC52
 Ab+2gFqK4FfUTJj4DaNmFvKINC+sQUqCGbb8HgsDMnX5FYR4PxlcAQ2iMz4Xhmx2DHqS
 ZZKfNOi05GrJXWr8i5G8XnAKUTJCbJeIDQaOMbtJkTo+UGLnSYC96sM/44adnu2aH+7+
 ewtA==
X-Gm-Message-State: AOJu0Yx24pVMmOKqWC0B+RqYaX9Fz3qYwraoyqzR7pwmV4nM+mRGEG70
 vqB4LQyyh1CAB93uqeakxvGA6eWLcyMYkC9JQQ3q7y5mVwCLVH8kiTX3VWjqnjE9lNL6WIgvGHB
 t3PXuVsvFWgX3SRCTE/bNww9QQzNZFDx2b0dSGfE878V64cKCyZVYMU+bNFjos+iLOocBRe8=
X-Received: by 2002:adf:fc81:0:b0:323:37a3:8d1e with SMTP id
 g1-20020adffc81000000b0032337a38d1emr8808150wrr.0.1696237135768; 
 Mon, 02 Oct 2023 01:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfCMXfIIwkIEgnzxGA3HJaP/BwimwF8mHAu3w+YCG8lwk09csa41Lgg8LzF3B0mOFWm6kLjg==
X-Received: by 2002:adf:fc81:0:b0:323:37a3:8d1e with SMTP id
 g1-20020adffc81000000b0032337a38d1emr8808120wrr.0.1696237135274; 
 Mon, 02 Oct 2023 01:58:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446?
 (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de.
 [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d50c1000000b003142e438e8csm27549025wrt.26.2023.10.02.01.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 01:58:54 -0700 (PDT)
Message-ID: <de10b63e-0142-d9c5-8c7a-acf2c58e78cb@redhat.com>
Date: Mon, 2 Oct 2023 10:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 00/18] virtio-mem: Expose device memory through
 multiple memslots
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230926185738.277351-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230926185738.277351-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.058, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 26.09.23 20:57, David Hildenbrand wrote:
> Quoting from patch #16:
> 
>      Having large virtio-mem devices that only expose little memory to a VM
>      is currently a problem: we map the whole sparse memory region into the
>      guest using a single memslot, resulting in one gigantic memslot in KVM.
>      KVM allocates metadata for the whole memslot, which can result in quite
>      some memory waste.
> 
>      Assuming we have a 1 TiB virtio-mem device and only expose little (e.g.,
>      1 GiB) memory, we would create a single 1 TiB memslot and KVM has to
>      allocate metadata for that 1 TiB memslot: on x86, this implies allocating
>      a significant amount of memory for metadata:
> 
>      (1) RMAP: 8 bytes per 4 KiB, 8 bytes per 2 MiB, 8 bytes per 1 GiB
>          -> For 1 TiB: 2147483648 + 4194304 + 8192 = ~ 2 GiB (0.2 %)
> 
>          With the TDP MMU (cat /sys/module/kvm/parameters/tdp_mmu) this gets
>          allocated lazily when required for nested VMs
>      (2) gfn_track: 2 bytes per 4 KiB
>          -> For 1 TiB: 536870912 = ~512 MiB (0.05 %)
>      (3) lpage_info: 4 bytes per 2 MiB, 4 bytes per 1 GiB
>          -> For 1 TiB: 2097152 + 4096 = ~2 MiB (0.0002 %)
>      (4) 2x dirty bitmaps for tracking: 2x 1 bit per 4 KiB page
>          -> For 1 TiB: 536870912 = 64 MiB (0.006 %)
> 
>      So we primarily care about (1) and (2). The bad thing is, that the
>      memory consumption doubles once SMM is enabled, because we create the
>      memslot once for !SMM and once for SMM.
> 
>      Having a 1 TiB memslot without the TDP MMU consumes around:
>      * With SMM: 5 GiB
>      * Without SMM: 2.5 GiB
>      Having a 1 TiB memslot with the TDP MMU consumes around:
>      * With SMM: 1 GiB
>      * Without SMM: 512 MiB
> 
>      ... and that's really something we want to optimize, to be able to just
>      start a VM with small boot memory (e.g., 4 GiB) and a virtio-mem device
>      that can grow very large (e.g., 1 TiB).
> 
>      Consequently, using multiple memslots and only mapping the memslots we
>      really need can significantly reduce memory waste and speed up
>      memslot-related operations. Let's expose the sparse RAM memory region using
>      multiple memslots, mapping only the memslots we currently need into our
>      device memory region container.
> 
> The hyper-v balloon driver has similar demands [1].
> 
> For virtio-mem, this has to be turned manually on ("dynamic-memslots=on"),
> due to the interaction with vhost (below).
> 
> If we have less than 509 memslots available, we always default to a single
> memslot. Otherwise, we automatically decide how many memslots to use
> based on a simple heuristic (see patch #12), and try not to use more than
> 256 memslots across all memory devices: our historical DIMM limit.
> 
> As soon as any memory devices automatically decided on using more than
> one memslot, vhost devices that support less than 509 memslots (e.g.,
> currently most vhost-user devices like with virtiofsd) can no longer be
> plugged as a precaution.
> 
> Quoting from patch #12:
> 
>      Plugging vhost devices with less than 509 memslots available while we
>      have memory devices plugged that consume multiple memslots due to
>      automatic decisions can be problematic. Most configurations might just fail
>      due to "limit < used + reserved", however, it can also happen that these
>      memory devices would suddenly consume memslots that would actually be
>      required by other memslot consumers (boot, PCI BARs) later. Note that this
>      has always been sketchy with vhost devices that support only a small number
>      of memslots; but we don't want to make it any worse.So let's keep it simple
>      and simply reject plugging such vhost devices in such a configuration.
> 
>      Eventually, all vhost devices that want to be fully compatible with such
>      memory devices should support a decent number of memslots (>= 509).
> 
> 
> The recommendation is to plug such vhost devices before the virtio-mem
> decides, or to not set "dynamic-memslots=on". As soon as these devices
> support a reasonable number of memslots (>= 509), this will start working
> automatically.
> 
> I run some tests on x86_64, now also including vfio and migration tests.
> Seems to work as expected, even when multiple memslots are used.
> 
> 
> Patch #1 -- #3 are from [2] that were not picked up yet.
> 
> Patch #4 -- #12 add handling of multiple memslots to memory devices
> 
> Patch #13 -- #16 add "dynamic-memslots=on" support to virtio-mem
> 
> Patch #15 -- #16 make sure that virtio-mem memslots can be enabled/disable
>               atomically


If there is no further feedback until the end of the week, I'll queue 
this to mem-next.

-- 
Cheers,

David / dhildenb



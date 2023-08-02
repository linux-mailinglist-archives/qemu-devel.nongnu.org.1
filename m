Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E2876D234
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 17:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRDuI-0005l2-Vg; Wed, 02 Aug 2023 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRDu9-0005k8-SW
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qRDu7-0001MV-HJ
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 11:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690990610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rMzQUIlj/5yrlMHvd8vMgHmPVLy0RvZ10kYeMfyApm8=;
 b=a4PuH+WIdBtn2V8SG6Ync+Ra9FfnzkGGxDmhgOkuu7ISprKR1HQ7kmXEFMD24ZXX/T1H++
 EwLVhVD4nDPE5RHesHLqK8aE7Tf90KnXb8LznkD0pzVKi8xfV3oSg69SGRQD72M3GwQ5Vu
 O2Kwf+VN2ZsPxXIJLyi8OZ/urZJsE78=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-PpvGo-fvNiSv04xguJNZlg-1; Wed, 02 Aug 2023 11:36:48 -0400
X-MC-Unique: PpvGo-fvNiSv04xguJNZlg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76c8e07cbe9so130735685a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 08:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690990608; x=1691595408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMzQUIlj/5yrlMHvd8vMgHmPVLy0RvZ10kYeMfyApm8=;
 b=PU2VIonrj3uR630WCrTapeeJviSl91jwPJHqGSqAVZofvG0EAyRx17yaCNGEdLFaTv
 pkHkAJewt5AGu0eY1UAkn5dHoM6QBSu/BJwZxnc9CPhZZ88fmZpTU0H/1qc3vcKqstkD
 k5p6HHwh8T0tScRubHTzU+gtxdAXHSSy/pvevFbGsfKjcPhn9SDB7gg6AuM2UqtkUFgf
 OqLEt9KsZpyGNk6uEQpt7lI+W0W5JB2C+6kQ6uM/JUJrnLpN+OyIVOxGMncp7WKaMHAP
 ygJLnRzyV5KtSx0MQMYcvVWHtU/wAnGSdll3SXIV92SKS6z1974+slC9wy/Tdi0E9xUW
 qu3A==
X-Gm-Message-State: ABy/qLYXLC+y55Jr58D5oRbCNbrBiDzWL1j0Ky58I2XWeofUgNdS0yQj
 HAargAvX8mxmO9Dqa8ryXj4DYkMnPjEJl1l3jcpkwBs8BqaT3TWPofiMXHZU4JMckcm/wCwz2fp
 XFOsqbgF6REKflo1FeccPCVo=
X-Received: by 2002:a05:620a:1987:b0:76c:a9eb:90bf with SMTP id
 bm7-20020a05620a198700b0076ca9eb90bfmr12561960qkb.3.1690990607816; 
 Wed, 02 Aug 2023 08:36:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEOHEh7QbeY3C3lEpePvf7kgwbYecnVpitHegZTLvXBfvSQUuVRYFuT+9c6kgTuQHgrs/WGJw==
X-Received: by 2002:a05:620a:1987:b0:76c:a9eb:90bf with SMTP id
 bm7-20020a05620a198700b0076ca9eb90bfmr12561946qkb.3.1690990607453; 
 Wed, 02 Aug 2023 08:36:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a15-20020a05620a16cf00b0076c94030a2esm4095823qkn.114.2023.08.02.08.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 08:36:47 -0700 (PDT)
Date: Wed, 2 Aug 2023 11:36:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH for-8.1 0/6] Fix endianness issues in the intel-iommu
 device
Message-ID: <ZMp4DcfOhfp1Rh96@x1n>
References: <20230802135723.178083-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802135723.178083-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 02, 2023 at 03:57:17PM +0200, Thomas Huth wrote:
> The intel-iommu device is currently unusable on big endian hosts.
> When doing something like this on a s390x host:
> 
>  wget https://download.fedoraproject.org/pub/fedora/linux/releases/38/Server/x86_64/images/Fedora-Server-KVM-38-1.6.x86_64.qcow2
>  ./qemu-system-x86_64 -M q35 -device intel-iommu -m 2G \
>         -hda ~/Fedora-Server-KVM-38-1.6.x86_64.qcow2 -trace "vtd_*"
> 
> ... the guest kernel crashes during boot, complaining about some
> problems with the iommu, and you can see clearly in the traces that
> some values are wrong when compared to running this on a x86 host.
> 
> After spending quite some time hunting down the problems one by one,
> I think I now found them all - at least I can successfully boot the
> above kernel after I applied these patches.
> 
> Thomas Huth (6):
>   hw/i386/intel_iommu: Fix trivial endianness problems
>   hw/i386/intel_iommu: Fix endianness problems related to
>     VTD_IR_TableEntry
>   hw/i386/intel_iommu: Fix struct VTDInvDescIEC on big endian hosts
>   hw/i386/intel_iommu: Fix index calculation in
>     vtd_interrupt_remap_msi()
>   hw/i386/x86-iommu: Fix endianness issue in
>     x86_iommu_irq_to_msi_message()
>   include/hw/i386/x86-iommu: Fix struct X86IOMMU_MSIMessage for big
>     endian hosts

All look right here. This was the 1st project I did after I worked on QEMU,
thanks again for fixing the issues for years!

Reviewed-by: Peter Xu <peterx@redhat.com>

This will need to be 8.2 material though, am I right?

Thanks,

-- 
Peter Xu



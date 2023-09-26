Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9A7AE5CB
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1Uz-0000P4-Hr; Tue, 26 Sep 2023 02:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ql1Ux-0000Oh-8j
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ql1Us-0005Iu-4r
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695709476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qbi+w93m5dgn77Xh0zUez4WbWBwJLY4gy86b/gaLV1M=;
 b=Z3/bKK2QyeQ4ctiBbTddURjBIpMxST/9OktPP/zoEjU95o47C/lYXvHu2l384Di7/Px4ly
 El+wdtC0ilP5B9lsU9D9uMrYiTtHzRoJ0WyX/AELfpWFpuMp+4vVV59iTm/qjbAnSHPvRx
 XGTPd9oDHjv8dltX+wvZ1I6MvGNXZtA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-8mTTbcnhMCOksQuwUBiWIw-1; Tue, 26 Sep 2023 02:24:34 -0400
X-MC-Unique: 8mTTbcnhMCOksQuwUBiWIw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65afb9c405aso72238586d6.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 23:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695709474; x=1696314274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qbi+w93m5dgn77Xh0zUez4WbWBwJLY4gy86b/gaLV1M=;
 b=NvzU3LQRPNdtSjv+DNWec8VK4rq5WruJ5Rom1yNZZFfcLoIoW7u90T/tMmC2RneAcJ
 nPj2OfJk5LfGftXikYugDRE3sVWb+4+o47o+qmaz3rWYDrCxN2Sfwu8TkvBbcvbGHMky
 oXQOi6Csq4jSyGtOpPZQVFkko7Rpx72QwQ4OpN8unfAxdBZtoqFyqsBVF4sw1SxuBucq
 im5UcaOzzTmKYqhdWPRut9ZG5eTHToUWk4KeOnS2VLI7UbPMehLfAU6PTlq58a9iKGMi
 XMlGoazSGQ7h7j7BnEq/ORFGU6fNhfiio9p3MP/m6ZO2AezkZdCmD6KSfYMPly1M925v
 FBAw==
X-Gm-Message-State: AOJu0Yznyjpw0BzMzwt623W1whrXndd+X8uPcP1BqJlPyvqOEPST2t/i
 fJVO7xw6Ul9OXjaka56gan6g1GSmDh3p9QzhmWm/fphG6/xieLUj0Fyesert1cyrkKgB1B8POp4
 Nr+GwP6kJ2p7LSl0=
X-Received: by 2002:a0c:f508:0:b0:65b:177b:a430 with SMTP id
 j8-20020a0cf508000000b0065b177ba430mr3903861qvm.47.1695709474010; 
 Mon, 25 Sep 2023 23:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHzWuXzv2kh6U5cfMy0DBNiQoCmCvjkngIkSxcmai8dS2Pb6F4LwtLjhWF4xXtCzk6qoR2aA==
X-Received: by 2002:a0c:f508:0:b0:65b:177b:a430 with SMTP id
 j8-20020a0cf508000000b0065b177ba430mr3903846qvm.47.1695709473639; 
 Mon, 25 Sep 2023 23:24:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 op34-20020a05620a536200b00772662b7804sm4459213qkn.100.2023.09.25.23.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Sep 2023 23:24:33 -0700 (PDT)
Message-ID: <c82daea8-ee63-4172-cbd8-34ee2e5b3d99@redhat.com>
Date: Tue, 26 Sep 2023 08:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/4] Support dynamic MSI-X allocation
To: Jing Liu <jing2.liu@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, kevin.tian@intel.com,
 reinette.chatre@intel.com, jing2.liu@linux.intel.com
References: <20230926021407.580305-1-jing2.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230926021407.580305-1-jing2.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/26/23 04:14, Jing Liu wrote:
> Changes since v2:
> - v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg989852.html
> - Use a bool type to test (vdev->nr_vectors < nr + 1). (Alex)
> - Revise comments. (Alex)
> - Apply Cédric's and Alex's Reviewed-by.
> 
> Changes since v1:
> - v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg982842.html
> - Revise Qemu to QEMU. (Cédric)
> - Add g_free when failure of getting MSI-X irq info. (Cédric)
> - Apply Cédric's Reviewed-by. (Cédric)
> - Use g_autofree to automatically release. (Cédric)
> - Remove the failure message in vfio_enable_msix_no_vec(). (Cédric)
> 
> Changes since RFC v1:
> - RFC v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg978637.html
> - Revise the comments. (Alex)
> - Report error of getting irq info and remove the trace of failure
>    case. (Alex, Cédric)
> - Only store dynamic allocation flag as a bool type and test
>    accordingly. (Alex)
> - Move dynamic allocation detection to vfio_msix_early_setup(). (Alex)
> - Change the condition logic in vfio_msix_vector_do_use() that moving
>    the defer_kvm_irq_routing test out and create a common place to update
>    nr_vectors. (Alex)
> - Consolidate the way of MSI-X enabling during device initialization and
>    interrupt restoring that uses fd = -1 trick. Create a function doing
>    that. (Alex)
> 
> Before kernel v6.5, dynamic allocation of MSI-X interrupts was not
> supported. QEMU therefore when allocating a new interrupt, should first
> release all previously allocated interrupts (including disable of MSI-X)
> and re-allocate all interrupts that includes the new one.
> 
> The kernel series [1] adds the support of dynamic MSI-X allocation to
> vfio-pci and uses the existing flag VFIO_IRQ_INFO_NORESIZE to guide user
> space, that when dynamic MSI-X is supported the flag is cleared.
> 
> This series makes the behavior for VFIO PCI devices when dynamic MSI-X
> allocation is supported. When guest unmasks an interrupt, QEMU can
> directly allocate an interrupt on host for this and has nothing to do
> with the previously allocated ones. Therefore, host only allocates
> interrupts for those unmasked (enabled) interrupts inside guest when
> dynamic MSI-X allocation is supported by device.
> 
> When guests enable MSI-X with all of the vectors masked, QEMU need match
> the state to enable MSI-X with no vector enabled. During migration
> restore, QEMU also need enable MSI-X first in dynamic allocation mode,
> to avoid the guest unused vectors being allocated on host. To
> consolidate them, we use vector 0 with an invalid fd to get MSI-X
> enabled and create a common function for this. This is cleaner than
> setting userspace triggering and immediately release.
> 
> Any feedback is appreciated.
> 
> Jing
> 
> [1] https://lwn.net/Articles/931679/
> 
> Jing Liu (4):
>    vfio/pci: detect the support of dynamic MSI-X allocation
>    vfio/pci: enable vector on dynamic MSI-X allocation
>    vfio/pci: use an invalid fd to enable MSI-X
>    vfio/pci: enable MSI-X in interrupt restoring on dynamic allocation
> 
>   hw/vfio/pci.c        | 123 +++++++++++++++++++++++++++++++++----------
>   hw/vfio/pci.h        |   1 +
>   hw/vfio/trace-events |   2 +-
>   3 files changed, 97 insertions(+), 29 deletions(-)
> 

Applied to vfio-next.

Thanks,

C.




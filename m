Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBAA3E663
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Feb 2025 22:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlDrs-0007zs-6F; Thu, 20 Feb 2025 16:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlDrq-0007zh-7P
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 16:13:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlDrn-0003qA-QN
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 16:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740086034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOYuHVpn2qnddkWXhC48IVHt9eBwm7/YaB7gfVfQtRw=;
 b=Ll2ZPcSQAejKhQA/hnwoe38Q1VOtUwtbu5QTS+Akqo0igmJ7F1FhqwTiq+hgK0HlDBqGI3
 SbsaPEH/ajfyo57DsSVn2C6YDNe9N+nRcbX/gRtqxqKCSFsabsnJfhYix/061do7ib9o4v
 rjhgZ0Jecij6Pi3Pztnd+oeDRGi77LU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-O6Ox61lDOk2Q1yqVJONZvg-1; Thu, 20 Feb 2025 16:13:52 -0500
X-MC-Unique: O6Ox61lDOk2Q1yqVJONZvg-1
X-Mimecast-MFC-AGG-ID: O6Ox61lDOk2Q1yqVJONZvg_1740086031
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so175762566b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 13:13:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740086031; x=1740690831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xOYuHVpn2qnddkWXhC48IVHt9eBwm7/YaB7gfVfQtRw=;
 b=SLb37Z3mQ1cjHrjD+HyfcidqQpYFt/bq6dVCB6h3X1AkEMbrjefWmPPMevJ3o41TNp
 b0vGKbM/vqGE70ofJz2tLwi89LTVw7craeZqIHvdK9auT4dBIeeVL7FzdH/QID3+7Rc2
 ZfdyUvIE9XOAqBXO9TO/FuhawSdiPs9ityy7ES902KkInIyAgUbRMaKon/c4t1iX2WL+
 P4SvbleMdRr6YZEq9ce45AdeNG5V69q0OldH6jDxkE6cbL1oAltsMsZKF1zMmdfgymx3
 MdkyG8Gx8YFjk1jbbRpDIuNxY4vpGQS+C8ys3nYPv1kIMy7UbFT0QwLKXk4ZI7o8yGuv
 PlRQ==
X-Gm-Message-State: AOJu0YwrUCduvOq8vhiW9jlIUkZu0zRe9W1yT04bTLIxK70yJNIcGaq8
 qyzfEIHWtSKNZUp71CtkcfrmZHAgEivE2rcUgpQ9hykJYLJWqEfGbPZh9YdrOMwyStS+JgWmQkR
 ReR3iXWoJTu8Rk8C/jJ7zxmjC85Y9WY9RmdCKUqob/tKn3qcG7WjA
X-Gm-Gg: ASbGncvq5ELo4sUwzzsnJlkJj2ey4oD5cXMhqWCk4Wa2oHjo7yfCFVCXxZ4z69vL6pm
 bERTT7/6RHIOjVJOLO0+fkGE9dVPPCYsbl/65fUeCztMqhtD9ubqBZvmSUUqtbOV4/8QSZi+oru
 IvNWPRB7JWnbfG6V/Ou0/WvfTchNpvT0Ymfn5LK+zHjbkVpQ13nNHg5AOi1Td7Qq2RXSPaKHGtH
 GmXW47EOlJLUyEaufpKQiTXrxB4M9x88P8XVh0gzqY2B/u1revb+nppMcrB9Tmy4sxtUw==
X-Received: by 2002:a17:907:3f09:b0:ab6:53fb:9683 with SMTP id
 a640c23a62f3a-abc09d37a86mr79879166b.54.1740086031274; 
 Thu, 20 Feb 2025 13:13:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlM24MeWTTP26WUi4Dr35Cy35KJgCDDRSGTpwX0ZOrQ49l5NcSt4t1DK51+45paukZWcE0iQ==
X-Received: by 2002:a17:907:3f09:b0:ab6:53fb:9683 with SMTP id
 a640c23a62f3a-abc09d37a86mr79875766b.54.1740086030804; 
 Thu, 20 Feb 2025 13:13:50 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532802a1sm1523392966b.76.2025.02.20.13.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 13:13:50 -0800 (PST)
Date: Thu, 20 Feb 2025 16:13:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>
Subject: Re: [PATCH v2 00/19] intel_iommu: Add ATS support
Message-ID: <20250220153757-mutt-send-email-mst@kernel.org>
References: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120174033.308518-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 20, 2025 at 05:41:32PM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> This patch set belongs to a list of series that add SVM support for VT-d.
> 
> Here we focus on implementing ATS support in the IOMMU and adding a
> PCI-level API to be used by virtual devices.
> 
> This work is based on the VT-d specification version 4.1 (March 2023).
> 
> Here is a link to our GitHub repository where you can find the following elements:
>     - Qemu with all the patches for SVM
>         - ATS
>         - PRI
>         - Device IOTLB invalidations
>         - Requests with already pre-translated addresses
>     - A demo device
>     - A simple driver for the demo device
>     - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo


Fails build:

https://gitlab.com/mstredhat/qemu/-/jobs/9200372388

In function ‘vtd_iommu_ats_do_translate’,
    inlined from ‘vtd_iommu_ats_request_translation’ at ../hw/i386/intel_iommu.c:4778:17:
../hw/i386/intel_iommu.c:4758:12: error: ‘entry.target_as’ may be used uninitialized [-Werror=maybe-uninitialized]
 4758 |     return entry;
      |            ^~~~~
../hw/i386/intel_iommu.c: In function ‘vtd_iommu_ats_request_translation’:
../hw/i386/intel_iommu.c:4745:19: note: ‘entry’ declared here
 4745 |     IOMMUTLBEntry entry;
      |                   ^~~~~
cc1: all warnings being treated as errors




> ===============
> 
> Context and design notes
> ''''''''''''''''''''''''
> 
> The main purpose of this work is to enable vVT-d users to make
> translation requests to the vIOMMU as described in the PCIe Gen 5.0
> specification (section 10). Moreover, we aim to implement a
> PCI/Memory-level framework that could be used by other vIOMMUs
> to implement the same features.
> 
> What is ATS?
> ''''''''''''
> 
> ATS (Address Translation Service) is a PCIe-level protocol that
> enables PCIe devices to query an IOMMU for virtual to physical
> address translations in a specific address space (such as a userland
> process address space). When a device receives translation responses
> from an IOMMU, it may decide to store them in an internal cache,
> often known as "ATC" (Address Translation Cache) or "Device IOTLB".
> To keep page tables and caches consistent, the IOMMU is allowed to 
> send asynchronous invalidation requests to its client devices.
> 
> To avoid introducing an unnecessarily complex API, this series simply
> exposes 3 functions. The first 2 are a pair of setup functions that
> are called to install and remove the ATS invalidation callback during
> the initialization phase of a process. The third one will be
> used to request translations. The callback setup API introduced in
> this series calls the IOMMUNotifier API under the hood.
> 
> API design
> ''''''''''
> 
> - int pci_register_iommu_tlb_event_notifier(PCIDevice *dev,
>                                             uint32_t pasid,
>                                             IOMMUNotifier *n);
> 
> - int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
>                                               IOMMUNotifier *n);
> 
> - ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
>                                             bool priv_req, bool exec_req,
>                                             hwaddr addr, size_t length,
>                                             bool no_write,
>                                             IOMMUTLBEntry *result,
>                                             size_t result_length,
>                                             uint32_t *err_count);
> 
> Although device developers may want to implement custom ATC for
> testing or performance measurement purposes, we provide a generic
> implementation as a utility module.
> 
> Overview
> ''''''''
> 
> Here are the interactions between an ATS-capable PCIe device and the vVT-d:
> 
>                                                                                           
>                                                                                           
>   ┌───────────┐                 ┌────────────┐                                            
>   │Device     │                 │PCI / Memory│                                            
>   │           │ pci_ats_request_│abstraction │ iommu_ats_                                 
>   │           │ translation_    │            │ request_                                   
>   │┌─────────┐│ pasid           │ AS lookup  │ translation                                
>   ││Logic    ││────────────────>│╶╶╶╶╶╶╶╶╶╶╶>│──────┐                                     
>   │└─────────┘│<────────────────│<╶╶╶╶╶╶╶╶╶╶╶│<──┐  │                                     
>   │┌─────────┐│                 │            │   │  │                                     
>   ││inv func ││<───────┐        │            │   │  │                                     
>   │└─────────┘│        │        │            │   │  │                                     
>   │    │      │        │        │            │   │  │                                     
>   │    ∨      │        │        │            │   │  │                                     
>   │┌─────────┐│        │        │            │   │  │                                     
>   ││ATC      ││        │        │            │   │  │                                     
>   │└─────────┘│        │        │            │   │  │                                     
>   └───────────┘        │        └────────────┘   │  │                                     
>                        │                         │  │                                     
>                        │                         │  │                                     
>                        │                         │  │                                     
>                        │                         │  │                                     
>                        │    ┌────────────────────┼──┼─┐                                   
>                        │    │vVT-d               │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  ∨ │                                   
>                        │    │┌───────────────────────┐│                                   
>                        │    ││Translation logic      ││                                   
>                        │    │└───────────────────────┘│                                   
>                        └────┼────────────┐            │                                   
>                             │            │            │                                   
>                             │┌───────────────────────┐│                                   
>                             ││  Invalidation queue   ││                                   
>                             │└───────────∧───────────┘│                                   
>                             └────────────┼────────────┘                                   
>                                          │                                                
>                                          │                                                
>                                          │                                                
>                              ┌────────────────────────┐                                   
>                              │Kernel driver           │                                   
>                              │                        │                                   
>                              └────────────────────────┘
> 
> v2
>     Rebase on master after merge of Zhenzhong's FLTS series
>     Rename the series as it is now based on master.
>     
>     Changes after review by Michael:
>     	- Split long lines in memory.h
>     	- Change patch encoding (no UTF-8)
>     
>     Changes after review by Zhenzhong:
>     	- Rework "Fill the PASID field when creating an IOMMUTLBEntry"
> 
> 
> 
> Clement Mathieu--Drif (19):
>   memory: Add permissions in IOMMUAccessFlags
>   intel_iommu: Declare supported PASID size
>   memory: Allow to store the PASID in IOMMUTLBEntry
>   intel_iommu: Fill the PASID field when creating an IOMMUTLBEntry
>   pcie: Add helper to declare PASID capability for a pcie device
>   pcie: Helper functions to check if PASID is enabled
>   pcie: Helper function to check if ATS is enabled
>   pci: Cache the bus mastering status in the device
>   pci: Add IOMMU operations to get memory regions with PASID
>   intel_iommu: Implement the get_memory_region_pasid iommu operation
>   memory: Store user data pointer in the IOMMU notifiers
>   pci: Add a pci-level initialization function for iommu notifiers
>   atc: Generic ATC that can be used by PCIe devices that support SVM
>   atc: Add unit tests
>   memory: Add an API for ATS support
>   pci: Add a pci-level API for ATS
>   intel_iommu: Set address mask when a translation fails and adjust W
>     permission
>   intel_iommu: Return page walk level even when the translation fails
>   intel_iommu: Add support for ATS
> 
>  hw/i386/intel_iommu.c          | 122 ++++++--
>  hw/i386/intel_iommu_internal.h |   2 +
>  hw/pci/pci.c                   | 111 ++++++-
>  hw/pci/pcie.c                  |  42 +++
>  include/exec/memory.h          |  51 +++-
>  include/hw/i386/intel_iommu.h  |   2 +-
>  include/hw/pci/pci.h           |  83 ++++++
>  include/hw/pci/pci_device.h    |   1 +
>  include/hw/pci/pcie.h          |   9 +-
>  include/hw/pci/pcie_regs.h     |   5 +
>  system/memory.c                |  21 ++
>  tests/unit/meson.build         |   1 +
>  tests/unit/test-atc.c          | 527 +++++++++++++++++++++++++++++++++
>  util/atc.c                     | 211 +++++++++++++
>  util/atc.h                     | 117 ++++++++
>  util/meson.build               |   1 +
>  16 files changed, 1275 insertions(+), 31 deletions(-)
>  create mode 100644 tests/unit/test-atc.c
>  create mode 100644 util/atc.c
>  create mode 100644 util/atc.h
> 
> -- 
> 2.47.1



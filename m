Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A737D9DBD
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 18:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPIp-00079c-6E; Fri, 27 Oct 2023 12:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qwPIn-00076K-IC
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qwPIk-00058H-W6
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 12:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=idwB6AAFANV7SWmApPXSUkInmIeJJIAYxUPXNWjTHKM=;
 b=NsT6+FG4Ct+JZqmFt915Qx+MgVczNIa4UzWzC0aB2RHJxHn0gMRjlWqbtl3uQgoN++9Eyo
 HYsmG1+/Sj9cT1Pb4t2bc8DCXLHzyytO0P7XNvgcReQZh5Oe6ocd1fRQOSM5H0j7wUr/5S
 J2zyC1VQ3DCGFRPlhw8//7vvSdqZ3ek=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-kvw3OzQtM06PsHort-sXDQ-1; Fri, 27 Oct 2023 12:02:49 -0400
X-MC-Unique: kvw3OzQtM06PsHort-sXDQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7789a2b35f1so45156885a.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 09:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698422568; x=1699027368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idwB6AAFANV7SWmApPXSUkInmIeJJIAYxUPXNWjTHKM=;
 b=GJR2ah3PB7FFdXiBbLKUB0kzgI6OHCoyf/vfqf/8c3McghiXNk+FtfXMQgX7LAmUWH
 WeBL/4XiHlgm1zAhLt//qj6g3iUvw9spSX0//QtJ9xfmeFfyrF7/LiGKL/SZzl4Qdg6V
 ZnGCUNlYV7pTxX1HNKuS31bxtH4ngR+NMc5kDauMhX8PYaMUpyGEqY/XZR9RFYUrIrBS
 Z0lo7+eM1OGKhbz2jHOuzOpKmldiCFWa16U6XdwxuKs2TTc6ttTlDtPNE2/4RpKES0cA
 L+URXVRwbH5y5g7rinsRKZELZzZc/uy0+RyKRsyM1UrQvzQc2hrJ3Ph//t5CFCY6ripj
 whYw==
X-Gm-Message-State: AOJu0YwazkJGOfE5+IMOcpLlNUtwm8XUlnhsQMlcwlofFeH+/g2avcUf
 EsY5M1hxlRE3lxAa7AviPotffT4Qxwea/WoDDorg/nGbSHYERy07K4JZvgl87WweEQsxU4/2apc
 JHbkREq182Lul1oY=
X-Received: by 2002:a05:620a:1929:b0:775:8fab:8c6d with SMTP id
 bj41-20020a05620a192900b007758fab8c6dmr3495208qkb.1.1698422568572; 
 Fri, 27 Oct 2023 09:02:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt/vLuc0a36WebS6zncK4zKQjwd1dkz9HxpVOYHRc1LWymCUshrgp2daA/msI88kTvdXp3Mg==
X-Received: by 2002:a05:620a:1929:b0:775:8fab:8c6d with SMTP id
 bj41-20020a05620a192900b007758fab8c6dmr3495144qkb.1.1698422567959; 
 Fri, 27 Oct 2023 09:02:47 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 de26-20020a05620a371a00b0077263636a95sm655134qkb.93.2023.10.27.09.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 09:02:47 -0700 (PDT)
Date: Fri, 27 Oct 2023 12:02:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Ethan Chen <ethan84@andestech.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZTvfECmO4JFZ/aIp@x1n>
References: <ZTkw4itrYANXm4qR@x1n>
 <ZTsuZLMOLsehgzoc@ethan84-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTsuZLMOLsehgzoc@ethan84-VirtualBox>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Oct 27, 2023 at 11:28:36AM +0800, Ethan Chen wrote:
> On Thu, Oct 26, 2023 at 10:20:41AM -0400, Peter Xu wrote:
> > Could you elaborate why is that important?  In what use case?
> I was not involved in the formulation of the IOPMP specification, but I'll try
> to explain my perspective. IOPMP use the same the idea as PMP. "The matching 
> PMP entry must match all bytes of an access, or the access fails."
> 
> > 
> > Consider IOVA mapped for address range iova=[0, 4K] only, here we have a
> > DMA request with range=[0, 8K].  Now my understanding is what you want to
> > achieve is don't trigger the DMA to [0, 4K] and fail the whole [0, 8K]
> > request.
> > 
> > Can we just fail at the latter DMA [4K, 8K] when it happens?  After all,
> > IIUC a device can split the 0-8K DMA into two smaller DMAs, then the 1st
> > chunk can succeed then if it falls in 0-4K.  Some further explanation of
> > the failure use case could be helpful.
> 
> IOPMP can only detect partially hit in an access. DMA device will split a 
> large DMA transfer to small DMA transfers base on target and DMA transfer 
> width, so partially hit error only happens when an access cross the boundary.
> But to ensure that an access is only within one entry is still important. 
> For example, an entry may mean permission of a device memory region. We do 
> not want to see one DMA transfer can access mutilple devices, although DMA 
> have permissions from multiple entries.

I was expecting a DMA request can be fulfilled successfully as long as the
DMA translations are valid for the whole range of the request, even if the
requested range may include two separate translated targets or more, each
point to different places (either RAM, or other devicie's MMIO regions).

AFAIK currently QEMU memory model will automatically split that large
request into two or more smaller requests, and fulfill them separately by
two/more IOMMU translations, with its memory access dispatched to the
specific memory regions.

The example you provided doesn't seem to be RISCV specific.  Do you mean it
is a generic requirement from PCI/PCIe POV, or is it only a restriction of
IOPMP?  If it's a valid PCI restriction, does it mean that all the rest
IOMMU implementations in QEMU currently are broken?

[copy Michael and Igor]

Thanks,

-- 
Peter Xu



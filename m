Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A387D8D6D
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 05:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwDWz-0001w4-G5; Thu, 26 Oct 2023 23:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qwDWv-0001vg-PD
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:29:01 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qwDWs-0002En-G4
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:29:01 -0400
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39R3SifO029915;
 Fri, 27 Oct 2023 11:28:44 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Fri, 27 Oct 2023
 11:28:41 +0800
Date: Fri, 27 Oct 2023 11:28:36 +0800
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size
 function if it is implemented
Message-ID: <ZTsuZLMOLsehgzoc@ethan84-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTkw4itrYANXm4qR@x1n>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39R3SifO029915
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, FAKE_REPLY_C=1.486,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Oct 26, 2023 at 10:20:41AM -0400, Peter Xu wrote:
> Could you elaborate why is that important?  In what use case?
I was not involved in the formulation of the IOPMP specification, but I'll try
to explain my perspective. IOPMP use the same the idea as PMP. "The matching 
PMP entry must match all bytes of an access, or the access fails."

> 
> Consider IOVA mapped for address range iova=[0, 4K] only, here we have a
> DMA request with range=[0, 8K].  Now my understanding is what you want to
> achieve is don't trigger the DMA to [0, 4K] and fail the whole [0, 8K]
> request.
> 
> Can we just fail at the latter DMA [4K, 8K] when it happens?  After all,
> IIUC a device can split the 0-8K DMA into two smaller DMAs, then the 1st
> chunk can succeed then if it falls in 0-4K.  Some further explanation of
> the failure use case could be helpful.

IOPMP can only detect partially hit in an access. DMA device will split a 
large DMA transfer to small DMA transfers base on target and DMA transfer 
width, so partially hit error only happens when an access cross the boundary.
But to ensure that an access is only within one entry is still important. 
For example, an entry may mean permission of a device memory region. We do 
not want to see one DMA transfer can access mutilple devices, although DMA 
have permissions from multiple entries.

Thanks,
Ethan Chen


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1D3AB5662
	for <lists+qemu-devel@lfdr.de>; Tue, 13 May 2025 15:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpuP-0006K7-Jt; Tue, 13 May 2025 09:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEpuM-0006JT-5f
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:42:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEpuF-0000YV-Dy
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:42:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AD5CC55BC03;
 Tue, 13 May 2025 15:42:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id y-ITAtu91qKk; Tue, 13 May 2025 15:42:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A136155BC02; Tue, 13 May 2025 15:42:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9EA9E745682;
 Tue, 13 May 2025 15:42:45 +0200 (CEST)
Date: Tue, 13 May 2025 15:42:45 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
cc: "Kim, Dongwon" <dongwon.kim@intel.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 8/9] ui/gtk-gl-area: Render guest content with padding
 in fixed-scale mode
In-Reply-To: <014499c850a828e2e8b0b55376c36b9f8e7a7c1e.camel@gmail.com>
Message-ID: <508f7281-9657-7db6-2778-b85f8c8cca2e@eik.bme.hu>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-9-weifeng.liu.z@gmail.com>
 <PH8PR11MB6879607C14D7E5BB7FCDAAD1FA96A@PH8PR11MB6879.namprd11.prod.outlook.com>
 <ffa687c30c11429767d48c9d1358c729d1e49e8f.camel@gmail.com> 
 <66a308eb-6ab3-c51c-bcdb-fe5c79811914@eik.bme.hu>
 <014499c850a828e2e8b0b55376c36b9f8e7a7c1e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1732745282-1747143765=:27020"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1732745282-1747143765=:27020
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 May 2025, Weifeng Liu wrote:
> Hi,
>
> On Tue, 2025-05-13 at 11:52 +0200, BALATON Zoltan wrote:
>> On Tue, 13 May 2025, Weifeng Liu wrote:
>>> Hi,
>>>
>>> On Tue, 2025-05-13 at 00:37 +0000, Kim, Dongwon wrote:
>>>> Hi,
>>>>
>>>>> Subject: [PATCH 8/9] ui/gtk-gl-area: Render guest content with
>>>>> padding in
>>>>> fixed-scale mode
>>>>>
>>>>> In fixed-scale mode (zoom-to-fit=false), we expect that scale
>>>>> should not
>>>>> change, meaning that if window size is larger than guest surface,
>>>>> padding is
>>>>
>>>> # @zoom-to-fit: Zoom guest display to fit into the host window.  When
>>>> #     turned off the host window will be resized instead.  In case
>>>> the
>>>> #     display device can notify the guest on window resizes
>>>> #     (virtio-gpu) this will default to "on", assuming the guest will
>>>> #     resize the display to match the window size then.  Otherwise it
>>>> #     defaults to "off".  (Since 3.1)
>>>>
>>>> Current definition says the host window should be resized to fit the
>>>> size of the guest surface instead. Wouldn't padding accommodate this?
>>>>
>>>
>>> Yeah, window will be resized to fit the size of guest surface in fixed-
>>> scale mode. However, users are still allowed to resize the window to a
>>> larger size and this is case where padding is required, otherwise the
>>> fixed-scale assumption is broken. In fact, gl=off mode employs padding
>>> to preserve scale already but gl=on mode doesn't follow this behavior,
>>> which, IMO, is a defect that this patch is trying to correct.
>>
>> I think current set of switches is not enough to describe all possible
>> configs and this leads to inconsistency between display backends. Each
>> display backend has different idea on how zoom-to-fit should work now.
>> Maybe we need a new keep-aspect=off or similar option to make it explicit
>> then these can be set independently to decide if a full-screen zoom-to-fit
>> window should be stretched or padded. Currently it behaves differently
>> depending on display backend or even options of one display backend as you
>> say above. Fixing just one place won't solve the problem with other
>> backends so maybe separating this option into a new one would end this
>> inconsistency. I got requests from people for both padded or stretched
>> behaviour so it seems some prefer one or the other and just zoom-to-fit
>> can't set both.
>>
>
> Thank you for pointing out the demand for both stretched and padded
> behavior — allowing users to choose their preferred display makes a lot
> of sense. With the changes in this patch set, we can at least ensure
> that all GTK-based backends behave consistently with regard to aspect
> ratio. I’ll follow up with a separate patch set to introduce the new
> keep-aspect=off (or similar) option you suggested.
>
> By the way, I’ve also been working on a “scale” option to let users
> specify an exact zoom level. I deliberately left it out of this patch
> set because I wanted to keep its scope narrowly focused on refactoring.
> Once this set is merged, I’ll submit the new patch set with these
> changes.

A scale option would be a welcome change as well. I thought about that too 
but did not try to implement it. One problem left may be that different 
backends may be still inconsistent so if you only fix gtk others may need 
to be adapted as well at some point (not necessarily by you but if you can 
look at that and keep it consistent when making changes that would be 
nice).

Regards,
BALATON Zoltan
--3866299591-1732745282-1747143765=:27020--


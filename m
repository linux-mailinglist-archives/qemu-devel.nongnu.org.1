Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A4C1FA7F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Oct 2025 11:54:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEQHt-0004mZ-Lv; Thu, 30 Oct 2025 06:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEQHo-0004mH-Hf; Thu, 30 Oct 2025 06:53:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vEQHj-0000LG-Bw; Thu, 30 Oct 2025 06:53:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AA1425972EB;
 Thu, 30 Oct 2025 11:53:31 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id oi6NGn00718q; Thu, 30 Oct 2025 11:53:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9FB5C5972E8; Thu, 30 Oct 2025 11:53:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9D3495972E3;
 Thu, 30 Oct 2025 11:53:29 +0100 (CET)
Date: Thu, 30 Oct 2025 11:53:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
In-Reply-To: <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
Message-ID: <ec2d5518-80b4-e92d-498b-10380b02997c@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu>
 <aQJpDE6FvkIF6GgE@x1.local> <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 30 Oct 2025, Paolo Bonzini wrote:
> On 10/29/25 20:20, Peter Xu wrote:
>> On Wed, Oct 29, 2025 at 11:30:10AM +0100, BALATON Zoltan wrote:
>>>> memory_region_new_* will work, but I don't think removing unnecessary
>>>> but harmless fields from a device state structure does not sufficiently
>>>> motivates adding them.
>>> 
>>> I haven't given up on this yet, that's why I alternatively proposed
>>> 
>>> object_alloc (same as object_new without object_initialize)
>>> memory_region_init
>>> 
>>> which is just a small change but should also work without adding
>>> memory_region_new convenience functions. Then only object_alloc needs to 
>>> be
>>> added.
>> 
>> IMHO if this will ever happen, memory_region_new*() is better, unless
>> object_alloc() can be used anywhere besides MemoryRegion..

Objective-C (*step/macOS and derivatives) have two methods for creating 
objects: alloc then init. It also has "new" to combine both but exposing 
alloc is sometimes useful especially when having different init methods. I 
was thinking doing it that way which should be familiar to at least to 
some people. I'll explore that in a proposed series.

>> It seems to me, MemoryRegion is the only one I'm aware of that may need
>> such tweak, rather than using object_new() directly.
>
> Yes, pretty much.  Anyhow, leaking on purpose with g_new is not a good idea.

It does not leak in this case. This object is a host bridge created once 
and start and never removed and is not user creatable being a sysbus 
device. It's still theoretically incorrect but this patch did not 
introduce any new problems just made it clearer by moving it from board to 
device.

Regards,
BALATON Zoltan


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A571283D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:31:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YSx-0004YO-DL; Fri, 26 May 2023 10:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q2YSu-0004YG-S4
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:30:49 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q2YSs-0000qq-8C
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:30:48 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f])
 by apollo.dupie.be (Postfix) with ESMTPSA id A85401520F03;
 Fri, 26 May 2023 16:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1685111440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MFw1+zUSFptioAZ+zKHfkw+2rMN46Jp0UiDKWVS87FY=;
 b=ClPQ6/5x8kZL5U8UB7UONnrRxk1S2ZrCUKeGZmaHzEpjit6hm8kr7I0kwn1RlpjqR1wDN2
 JQBgIPkAqMsVc5HZdUFU2xKMN37F2wUO2bD0x/lX69BOCcmzJfI68GQW2YODJPcGYSgA70
 CdX6+0vm3PZCWcSoXlF6qHDJQ3+IMm9Cp4GpdttWwnwbUd8pZWoySMJQMYVRXxHp/tX6s4
 k+ymZV2NhdD6CGpKBCakn/7MrrZYqh3STK4O+2YoO2jT/OewTsKjwo3MxjvWFP8AiszlPa
 aZ6FvkRn+OQir/RBuByeHo02+d54fNO2gwW6xBqXQ/ZNuuyezYqfah6qYce2ow==
Message-ID: <065a97d8-f1e5-d87b-06ef-989910b033ee@dupond.be>
Date: Fri, 26 May 2023 16:30:38 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] qcow2: add discard-no-unref option
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
 <592e1caf-851a-7af0-2182-b70a62b6f826@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <592e1caf-851a-7af0-2182-b70a62b6f826@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/05/2023 15:31, Hanna Czenczek wrote:
> On 15.05.23 09:36, Jean-Louis Dupond wrote:
>> When we for example have a sparse qcow2 image and discard: unmap is 
>> enabled,
>> there can be a lot of fragmentation in the image after some time. 
>> Surely on VM's
>> that do a lot of writes/deletes.
>> This causes the qcow2 image to grow even over 110% of its virtual size,
>> because the free gaps in the image get to small to allocate new
>> continuous clusters. So it allocates new space as the end of the image.
>>
>> Disabling discard is not an option, as discard is needed to keep the
>> incremental backup size as low as possible. Without discard, the
>> incremental backups would become large, as qemu thinks it's just dirty
>> blocks but it doesn't know the blocks are empty/useless.
>> So we need to avoid fragmentation but also 'empty' the useless blocks in
>> the image to have a small incremental backup.
>>
>> Next to that we also want to send the discards futher down the stack, so
>> the underlying blocks are still discarded.
>>
>> Therefor we introduce a new qcow2 option "discard-no-unref". When
>> setting this option to true (defaults to false), the discard requests
>> will still be executed, but it will keep the offset of the cluster. And
>> it will also pass the discard request further down the stack (if
>> discard:unmap is enabled).
>> This will avoid fragmentation and for example on a fully preallocated
>> qcow2 image, this will make sure the image is perfectly continuous.
>
> I don’t follow how this patch is cleaner than the “block: Add zeroes 
> discard option” patch.  That patch’s diff stat is +14/-5, this one’s 
> is 120+/57-.
Multiple reasons :)
- It's made for this use-case only, as there might be no other use-cases 
except this one so the scope for discard=zeroes might be to big
- This one still handles the discards and passes it to the lower layer, 
which might be an important reason for the fact you enable discards
- The diffstat is mostly bigger because of indention changes in 
update_refcount
>
> As for better, I don’t want to discount that, but at the same time I 
> don’t know the reasoning for it.  As far as I understand, this patch 
> makes qcow2 retain the cluster mapping as-is, and only discards on the 
> lower layer.  So effectively, instead of marking the cluster as zero 
> on the qcow2 level, we do so on the filesystem level.  I’m not sure I 
> see all the implications of that difference.
We want to keep the cluster mapping to avoid creating holes in the qcow2 
cluster.
But we still want to do discards for 2 reasons:
- Mark the cluster as ZERO, so that incremental backups using dirty 
bitmaps can just skip this block
- Discard the data on the lower layer for efficiency reasons (for 
example if the lower layer has some dedup/compression/whatever), we 
still want the lower layer to know the block has been emptied
>
> The advantage I see is that this free up disk space, which the 
> discard=zeroes wouldn’t do.  I wonder whether that couldn’t be solved 
> with an orthogonal qcow2-only option, though, which would have the 
> qcow2 driver always discard zeroed clusters.
This is an option also indeed. But we will end up with a similar patch 
(also in size).
>
> On the other hand, one thing to note is that we’ve had performance 
> problems in the past with holes in the filesystem level (on tmpfs at 
> least).  qemu generally can get the information on which clusters are 
> zero quicker from qcow2 than from the filesystem, which suggests that 
> even if we want to discard something on the filesystem layer, we 
> probably also want to mark it as zero on the qcow2 layer.
This is what we do in discard_in_l2_slice, we mark the entry as 
QCOW_OFLAG_ZERO when we receive a discard request.
>
> I also have a small concern about fragmentation on the filesystem 
> layer – if you use these options to prevent fragmentation, with this 
> patch, you’re only doing so on the qcow2 layer.  Because the cluster 
> is then discarded in the filesystem, it’s possible to get 
> fragmentation there, which might not be desirable.  I don’t think 
> that’s too important, but I think it’d just be nice to have a 
> configuration in which the guest can tell qemu what areas it doesn’t 
> care about, qemu marks these as zero, so that backups are more 
> efficient; but at the same time, everything stays allocated, so no 
> fragmentatoin is introduced.
That would be an additional option/improvement indeed. But it's not that 
this patch makes the fragmentation worse then it's already the case when 
you enable discard.
If you really want this you might even want your lower level storage to 
just ignore discards instead of fixing it in qcow2.
>
> Hanna
>

Thanks for your review
Jean-Louis



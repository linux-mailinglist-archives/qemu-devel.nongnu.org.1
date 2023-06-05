Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE3072215C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:48:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65sZ-0001TT-24; Mon, 05 Jun 2023 04:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q65sW-0001RE-Ar
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:47:52 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q65sQ-0002V2-9j
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:47:52 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f])
 by apollo.dupie.be (Postfix) with ESMTPSA id 1EC4E1520DD7;
 Mon,  5 Jun 2023 10:47:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1685954864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg6rEd7+eMFhKzTwCUBZAc5+HHvbm6c0fSk98Tv1XDA=;
 b=BjUV++M7bl0LqTUW6ukqH+C5fZ0omy/xvaksjXgko0bNjWKfhsk5gEx8KdLKi4wINrvODC
 F6XCO7BPItl4Pg3Z7Qfx6bUFV9CzrFcU2tM94sXNaliLkI+hnXsdFwI+MQT7a2ZJqQQpoo
 uT2ndhjXOYKiazg72bDB4uQF+B3GAArnvwRnaJmM/1WjQ1MMdnls1wcLgrDPT35X5cRol8
 8RtXGoywLG7OW6VfuF76qH0CFqCHqBTwSpg3pVHJ/Ntvq1s2fYTDqVVIhKbT61oeIQ94VD
 FYsoiJg2cxRTkv1JqNIKntvuhmC5u9u0i7ihsBZ0vIvrHWmOQFhFRMjFAOHgCg==
Message-ID: <d012533d-0fd5-6ab7-16e7-4f3dc0872ab5@dupond.be>
Date: Mon, 5 Jun 2023 10:47:43 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH v2] qcow2: add discard-no-unref option
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20230602124747.1544077-1-jean-louis@dupond.be>
 <11d5e450-f24f-a52c-e143-9889ccf724ef@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <11d5e450-f24f-a52c-e143-9889ccf724ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
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


On 2/06/2023 17:28, Hanna Czenczek wrote:
> On 02.06.23 14:47, Jean-Louis Dupond wrote:
>> When we for example have a sparse qcow2 image and discard: unmap is 
>> enabled,
>> there can be a lot of fragmentation in the image after some time. 
>> Especially on VM's
>> that do a lot of writes/deletes.
>> This causes the qcow2 image to grow even over 110% of its virtual size,
>> because the free gaps in the image get too small to allocate new
>> continuous clusters. So it allocates new space at the end of the image.
>>
>> Disabling discard is not an option, as discard is needed to keep the
>> incremental backup size as low as possible. Without discard, the
>> incremental backups would become large, as qemu thinks it's just dirty
>> blocks but it doesn't know the blocks are unneeded.
>> So we need to avoid fragmentation but also 'empty' the unneeded 
>> blocks in
>> the image to have a small incremental backup.
>>
>> In addition, we also want to send the discards further down the 
>> stack, so
>> the underlying blocks are still discarded.
>>
>> Therefor we introduce a new qcow2 option "discard-no-unref".
>> When setting this option to true, discards will no longer have the qcow2
>> driver relinquish cluster allocations. Other than that, the request is
>> handled as normal: All clusters in range are marked as zero, and, if
>> pass-discard-request is true, it is passed further down the stack.
>> The only difference is that the now-zero clusters are preallocated
>> instead of being unallocated.
>> This will avoid fragmentation on the qcow2 image.
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2-cluster.c | 32 ++++++++++++++++++++++++++++----
>>   block/qcow2.c         | 18 ++++++++++++++++++
>>   block/qcow2.h         |  3 +++
>>   qapi/block-core.json  | 12 ++++++++++++
>>   qemu-options.hx       | 12 ++++++++++++
>>   5 files changed, 73 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 39cda7f907..1f130c6ab9 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -1894,6 +1894,7 @@ again:
>>       return 0;
>>   }
>>   +
>>   /*
>>    * This discards as many clusters of nb_clusters as possible at 
>> once (i.e.
>>    * all clusters in the same L2 slice) and returns the number of 
>> discarded
>
> Was adding this empty line intentional?  (If not, I’d drop it.)
Dropped
>
>> @@ -1925,6 +1926,9 @@ static int discard_in_l2_slice(BlockDriverState 
>> *bs, uint64_t offset,
>>           uint64_t new_l2_bitmap = old_l2_bitmap;
>>           QCow2ClusterType cluster_type =
>>               qcow2_get_cluster_type(bs, old_l2_entry);
>> +        bool keep_reference = (cluster_type != 
>> QCOW2_CLUSTER_COMPRESSED) &&
>> +                              (s->discard_no_unref &&
>> +                               type == QCOW2_DISCARD_REQUEST);
>
> (Sorry I didn’t notice before :/) I think there’s a condition missing 
> here, namely `full_discard` (i.e. `&& !full_discard`).  We must set 
> `keep_reference` only if we will actually keep the reference, which 
> won’t happen when `full_discard` is set.  (Same could be said for 
> s->qcow_version < 3, but in that case, `s->discard_no_unref` can’t be 
> true.)
>
> (Not a problem in practice because `type == QCOW2_DISCARD_REQUEST` 
> never happens together with `full_discard`, but better be safe than 
> sorry.)
Fixed!
>
> Alternatively...
>
>>           /*
>>            * If full_discard is true, the cluster should not read 
>> back as zeroes,
>
> [...]
>
>> @@ -1960,8 +1976,16 @@ static int 
>> discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>>           if (has_subclusters(s)) {
>>               set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
>>           }
>> -        /* Then decrease the refcount */
>> -        qcow2_free_any_cluster(bs, old_l2_entry, type);
>> +        if (!keep_reference) {
>
> ...we could explicitly check here whether the new L2 entry is still 
> allocated or not, like
>
> ```
> QCow2ClusterType new_cluster_type =
>     qcow2_get_cluster_type(bs, new_l2_entry);
>
> if (!qcow2_cluster_is_allocated(new_cluster_type)) {
>     /* Decrease the refcount if the cluster has been deallocated */
>     qcow2_free_any_cluster(...);
> } else if (s->discard_passthrough[type] &&
>            qcow2_cluster_is_allocated(cluster_type)) {
>     /* If we keep the reference, pass on the discard still */
>
>     /* Discard must always produce zero-reading clusters */
>     assert(new_cluster_type == QCOW2_CLUSTER_ZERO_ALLOC);
>     /* Compressed clusters will never remain allocated */
>     assert(cluster_type != QCOW2_CLUSTER_COMPRESSED);
>
>     bdrv_pdiscard(...);
> }
> ```
>
> Just an idea, though, I understand if you’d rather not modify the 
> patch further.
>
>> +            /* Then decrease the refcount */
>> +            qcow2_free_any_cluster(bs, old_l2_entry, type);
>> +        } else if (s->discard_passthrough[type] &&
>> +                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
>> +                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
>> +            /* If we keep the reference, pass on the discard still */
>> +            bdrv_pdiscard(s->data_file, new_l2_entry & L2E_OFFSET_MASK,
>> +                          s->cluster_size);
>
> I mentioned this briefly on IRC, might have gone under the radar; I 
> think using `old_l2_entry` is better than `new_l2_entry`.  In 
> practice, there shouldn’t be a difference, but I think it’s slightly 
> cleaner to free based on the old entry than have this be based on the 
> new one.
Was caused by undoing to much :) Fixed.
>
> (Also, in case we did mess up, like in the hypothetical case above 
> where `keep_reference` is true while `full_discard` is also true, 
> using `old_l2_entry` means we’ll just accidentally discard the old 
> cluster (the accident is merely to discard the cluster instead of 
> decrementing its refcount), instead of discarding a completely wrong 
> cluster (the image header, with `new_l2_entry = 0`).)
>
> Rest looks good to me!
Posted v3 patch to the ML
>
> Hanna
>

Thanks
Jean-Louis



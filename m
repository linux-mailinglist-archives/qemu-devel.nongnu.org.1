Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B7719CCA
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:57:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hrX-0003jO-Nb; Thu, 01 Jun 2023 08:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q4hrV-0003iD-BQ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:57:05 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q4hrS-00071n-5J
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:57:05 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f])
 by apollo.dupie.be (Postfix) with ESMTPSA id CFB2B1520DD7;
 Thu,  1 Jun 2023 14:56:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1685624213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FN1IK2LlSXs5bsgUJYUAdKJDXcmL9dInPgc6boi4F48=;
 b=SEUJ0qt9CacXGbeP0oSFW+qQv99fO5tdlr0GMndNAGVVOTK0wzkq6WVZEv5/eXlZF+wox1
 0OPo7MYi3oBXKVOkyLxRNGJl4khlv8HQz6Hw+bDuFJmXnDaQ6OfeGRa6TvKjPVuGj2ekE/
 B6SQxRsK+kp4wCh4CdpYFvIquLvR2O6Jd4MVkzHCsVVDWf1H/iDUlIO7/01Tetp09VM1GO
 NsOHcc7PFXtGUDzoPqDmrfh6796OkMERkDuIP35LD61qj0kGcHpHkJfmzyeR/HFelrv3Wq
 dcqFiiXlwp8iH14YCriR+HwT2iRYqOXKEyBZItv8CmK1ZALkJUw/d+bnX6Xd7Q==
Message-ID: <08a88b12-ec0a-110a-ad64-2116712065e8@dupond.be>
Date: Thu, 1 Jun 2023 14:56:53 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] qcow2: add discard-no-unref option
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
 <5cc0ec56-8a13-c651-0b4e-da644c9f6900@redhat.com>
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <5cc0ec56-8a13-c651-0b4e-da644c9f6900@redhat.com>
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

On 31/05/2023 17:05, Hanna Czenczek wrote:
> On 15.05.23 09:36, Jean-Louis Dupond wrote:
>> When we for example have a sparse qcow2 image and discard: unmap is 
>> enabled,
>> there can be a lot of fragmentation in the image after some time. 
>> Surely on VM's
>
> s/. Surely/, especially/
>
>> that do a lot of writes/deletes.
>> This causes the qcow2 image to grow even over 110% of its virtual size,
>> because the free gaps in the image get to small to allocate new
>
> s/to small/too small/
>
>> continuous clusters. So it allocates new space as the end of the image.
>
> s/as/at/
>
>> Disabling discard is not an option, as discard is needed to keep the
>> incremental backup size as low as possible. Without discard, the
>> incremental backups would become large, as qemu thinks it's just dirty
>> blocks but it doesn't know the blocks are empty/useless.
>> So we need to avoid fragmentation but also 'empty' the useless blocks in
>
> s/useless/unneeded/ in both lines?
>
>> the image to have a small incremental backup.
>>
>> Next to that we also want to send the discards futher down the stack, so
>
> s/Next to that/In addition/, s/futher/further/
>
>> the underlying blocks are still discarded.
>>
>> Therefor we introduce a new qcow2 option "discard-no-unref". When
>> setting this option to true (defaults to false), the discard requests
>> will still be executed, but it will keep the offset of the cluster. And
>> it will also pass the discard request further down the stack (if
>> discard:unmap is enabled).
>
> I think this could be more explicit, e.g. “When setting this option to 
> true, discards will no longer have the qcow2 driver relinquish cluster 
> allocations. Other than that, the request is handled as normal: All 
> clusters in range are marked as zero, and, if pass-discard-request is 
> true, it is passed further down the stack. The only difference is that 
> the now-zero clusters are preallocated instead of being unallocated.”
>
>> This will avoid fragmentation and for example on a fully preallocated
>> qcow2 image, this will make sure the image is perfectly continuous.
>
> Well, on the qcow2 layer, yes.
All above -> Fixed :)
>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2-cluster.c  |  16 ++++-
>>   block/qcow2-refcount.c | 136 ++++++++++++++++++++++++-----------------
>>   block/qcow2.c          |  12 ++++
>>   block/qcow2.h          |   3 +
>>   qapi/block-core.json   |   4 ++
>>   qemu-options.hx        |   6 ++
>>   6 files changed, 120 insertions(+), 57 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 39cda7f907..88da70db5e 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -1943,10 +1943,22 @@ static int 
>> discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>>               new_l2_entry = new_l2_bitmap = 0;
>>           } else if (bs->backing || 
>> qcow2_cluster_is_allocated(cluster_type)) {
>>               if (has_subclusters(s)) {
>> -                new_l2_entry = 0;
>> +                if (s->discard_no_unref && (type & 
>> QCOW2_DISCARD_REQUEST)) {
>
> As far as I understand the discard type is just a plain enum, not a 
> bit field.  So I think this should be `type == QCOW2_DISCARD_REQUEST`, 
> not an `&`.  (Same below.)
>
Ack
>> +                    new_l2_entry = old_l2_entry;
>> +                } else {
>> +                    new_l2_entry = 0;
>> +                }
>>                   new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
>>               } else {
>> -                new_l2_entry = s->qcow_version >= 3 ? 
>> QCOW_OFLAG_ZERO : 0;
>> +                if (s->qcow_version >= 3) {
>> +                    if (s->discard_no_unref && (type & 
>> QCOW2_DISCARD_REQUEST)) {
>> +                        new_l2_entry |= QCOW_OFLAG_ZERO;
>> +                    } else {
>> +                        new_l2_entry = QCOW_OFLAG_ZERO;
>> +                    }
>> +                } else {
>> +                    new_l2_entry = 0;
>> +                }
>>               }
>>           }
>
> Context below:
>
>         if (old_l2_entry == new_l2_entry && old_l2_bitmap == 
> new_l2_bitmap) {
>             continue;
>         }
>
>         /* First remove L2 entries */
>         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>         set_l2_entry(s, l2_slice, l2_index + i, new_l2_entry);
>         if (has_subclusters(s)) {
>             set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
>         }
>         /* Then decrease the refcount */
>         qcow2_free_any_cluster(bs, old_l2_entry, type);
>
> If we keep the allocation, I don’t see why we would call 
> qcow2_free_any_cluster().  If we simply skip the call (if 
> `qcow2_is_allocated(qcow2_get_cluster_type(bs, new_l2_entry))`), I 
> think you could drop the modification to update_refcount().
>
If we don't call qcow2_free_any_cluster, the discard will not get passed 
to the lower layer.
We also call it in zero_in_l2_slice for example to discard lower layer.
> [...]
>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 5bde3b8401..9dde2ac1a5 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>
> [...]
>
>> @@ -725,6 +726,11 @@ static QemuOptsList qcow2_runtime_opts = {
>>               .type = QEMU_OPT_BOOL,
>>               .help = "Generate discard requests when other clusters 
>> are freed",
>>           },
>> +        {
>> +            .name = QCOW2_OPT_DISCARD_NO_UNREF,
>> +            .type = QEMU_OPT_BOOL,
>> +            .help = "Do not dereference discarded clusters",
>
> I wouldn’t call it “dereference” because of the overloaded meaning in 
> C, but “unreference” instead.
>
ack
>> +        },
>>           {
>>               .name = QCOW2_OPT_OVERLAP,
>>               .type = QEMU_OPT_STRING,
>
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 187e35d473..63aa792e9c 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3432,6 +3432,9 @@
>>   # @pass-discard-other: whether discard requests for the data source
>>   #     should be issued on other occasions where a cluster gets freed
>>   #
>> +# @discard-no-unref: don't dereference the cluster when we do a discard
>> +#     this to avoid fragmentation of the qcow2 image (since 8.1)
>
> Because this comment is used to build different documentation than 
> qemu-options.hx is, I would duplicate the full comment you put into 
> qemu-options.hx here (to provide the best documentation possible).
>
ack
>> +#
>>   # @overlap-check: which overlap checks to perform for writes to the
>>   #     image, defaults to 'cached' (since 2.2)
>>   #
>> @@ -3470,6 +3473,7 @@
>>               '*pass-discard-request': 'bool',
>>               '*pass-discard-snapshot': 'bool',
>>               '*pass-discard-other': 'bool',
>> +            '*discard-no-unref': 'bool',
>>               '*overlap-check': 'Qcow2OverlapChecks',
>>               '*cache-size': 'int',
>>               '*l2-cache-size': 'int',
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 42b9094c10..17ac701d0d 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1431,6 +1431,12 @@ SRST
>>               issued on other occasions where a cluster gets freed
>>               (on/off; default: off)
>>   +        ``discard-no-unref``
>> +            When enabled, a discard in the guest does not cause the
>> +            cluster inside the qcow2 image to be dereferenced. This
>
> Like above, I’d prefer “unreferenced”, or “the cluster’s allocation 
> […] to be relinquished”.
>
ack
>> +            was added to avoid qcow2 fragmentation whithin the image.
>> +            (on/off; default: off)
>
> I wouldn’t describe history here, but instead what this is for. E.g.: 
> “When enabled, discards from the guest will not cause cluster 
> allocations to be relinquished. This prevents qcow2 fragmentation that 
> would be caused by such discards. Besides potential performance 
> degradation, such fragmentation can lead to increased allocation of 
> clusters past the end of the image file, resulting in image files 
> whose file length can grow much larger than their guest disk size 
> would suggest. If image file length is of concern (e.g. when storing 
> qcow2 images directly on block devices), you should consider enabling 
> this option.”
ack
>
> What do you think?

Let me know your opinion on the qcow2_free_any_cluster call, and then 
I'll post a new patch version.

>
> Hanna
>

Jean-Louis



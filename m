Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A7A719D17
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:15:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4i76-00028P-RD; Thu, 01 Jun 2023 09:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q4i74-00028B-3f
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:13:10 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1q4i71-0001nS-NN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:13:09 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:cc6b:6666:e19c:b63f])
 by apollo.dupie.be (Postfix) with ESMTPSA id 94CD21520DD7;
 Thu,  1 Jun 2023 15:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1685625183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93PrNSE89goW6sR7hYBRjSTinep5uECnBBeIzdgPN70=;
 b=PU0xqxIvbyCmLwWHka82+jnYE0aHziwc86K8TRo1sfvca6UUQFgJt2yG+/CmkUJQcPqQEt
 ss2Xld1/+k6S0u9f2ODtsWcApl1bo/bCcK+wL3V3Qy8oVOIQM8w1cYM66HcL55uul6VHpi
 yFLRyZWu2DAcmqT/kQlWvIxdTM9z8ITluN9U8TfqIenFqht+Mhl04cNu5gYsp0OPOSzoex
 e/4J4zSDihBHo4qb+6dRilUVitER6Zq9ejzLam5wKLdyjJrfXvZJBssDVUyIYslg3D5BeD
 oS90+C/ZBxF3JrQVKNqH83vZc4EDKYwbhaDV5HMfINLxOe1QV9xB23EkQpp4SQ==
Message-ID: <fd7d81af-c69a-e5fb-0ebd-ce0124517626@dupond.be>
Date: Thu, 1 Jun 2023 15:13:03 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] qcow2: add discard-no-unref option
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
 <aa75a5a7-c643-0ef0-bf1f-cb2bfecbecb0@redhat.com>
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <aa75a5a7-c643-0ef0-bf1f-cb2bfecbecb0@redhat.com>
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


On 31/05/2023 17:16, Hanna Czenczek wrote:
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
>>
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
> Forgot to note something: So this option only works for qcow2 v3. Can 
> we have qcow2_update_options_prepare() return an error if 
> s->qcow_version < 3 and discard_no_unref is set?
Added :)
>
> Hanna
>


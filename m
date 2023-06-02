Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F271FB7E
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 10:03:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zjD-0007Uj-1e; Fri, 02 Jun 2023 04:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4zj9-0007U1-1R
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 04:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q4zj5-0008G5-KQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 04:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685692868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMmorHrVSe+6n+KIgdNMoQw4A94q6ZcE36qSDBDIbhg=;
 b=h7rVXXPfo0C8nX6tvRgbV3XkU37+w1CkYlotEHn4AKGm4TH4mV4lG4jGtg3G8W7ME6LTlB
 d19J054IqOkF2AOGYUrnTC1jI2vkq75GZStsRxfcDWg3102HNT8bVIstEo5rShoA4vCp5M
 J/L7I8VnYGc3Dz5Uaqq5SihF0kAG0C0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-D2vIgjM3Ox2AL1BC-LoN-Q-1; Fri, 02 Jun 2023 04:01:05 -0400
X-MC-Unique: D2vIgjM3Ox2AL1BC-LoN-Q-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51496307313so1271601a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 01:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685692863; x=1688284863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMmorHrVSe+6n+KIgdNMoQw4A94q6ZcE36qSDBDIbhg=;
 b=W+WO8zOI3IdFnnuRMdibFx1VvgmDqCFGy7u4Pmd1H3kUsSS3aP+ySyGu51P/DLSOte
 Ceym3XFSs1F/nA3yL9LMqjI2Ph98AzijoTEO532OthYAFRrgNo8LraNTGzSrA0drYeZj
 G9KwiEMcriCyhPNIMG3a3d2OA72lxbgvNJWNeaCKxCDDIqZmKwtupliCECKDsVbxyeR5
 T5QnfgvNPKrDwjFq7oeLVJqOUcM5G9CJfaGkDoBhTX12fwhQ2fJhjauMCYEOvVRmacCD
 ooeRqhcViIxxFHhYV5qSU+c2aQiT+DeQwMFRDZk7GMVT8phfpf7x26DZDG0vDnR+HfvQ
 eGNA==
X-Gm-Message-State: AC+VfDxeN4ubc1w0DVysvUQhgrwelIz6BGpLomh3p3N5MQAMSko1spfo
 7uZQD7SLz0f4p8p20zTHmDY7knbLJxlKN7A5w01BPgGZVZLbBAiFoSOXQvGHrtC7rhCSG2JK1Tx
 EHBHsvRaoXWKYz0x8q9iyQd0=
X-Received: by 2002:aa7:cd51:0:b0:50b:d755:8acc with SMTP id
 v17-20020aa7cd51000000b0050bd7558accmr1538134edw.34.1685692863276; 
 Fri, 02 Jun 2023 01:01:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55ylDRsTiGyfPkXJRLtWRWPT08RalTxZ9kvDfTVLCO2o3PgngIliRaEjY1d0INdT3P8u5JLw==
X-Received: by 2002:aa7:cd51:0:b0:50b:d755:8acc with SMTP id
 v17-20020aa7cd51000000b0050bd7558accmr1538111edw.34.1685692862859; 
 Fri, 02 Jun 2023 01:01:02 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a05640202cb00b005147f604965sm392778edx.24.2023.06.02.01.01.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 01:01:01 -0700 (PDT)
Message-ID: <624b6d8c-492c-02cc-7a13-f86af572dcf5@redhat.com>
Date: Fri, 2 Jun 2023 10:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qcow2: add discard-no-unref option
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org,
 kwolf@redhat.com
References: <20230515073644.166677-1-jean-louis@dupond.be>
 <5cc0ec56-8a13-c651-0b4e-da644c9f6900@redhat.com>
 <08a88b12-ec0a-110a-ad64-2116712065e8@dupond.be>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <08a88b12-ec0a-110a-ad64-2116712065e8@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 01.06.23 14:56, Jean-Louis Dupond wrote:
> On 31/05/2023 17:05, Hanna Czenczek wrote:
>> On 15.05.23 09:36, Jean-Louis Dupond wrote:
>>> When we for example have a sparse qcow2 image and discard: unmap is 
>>> enabled,
>>> there can be a lot of fragmentation in the image after some time. 
>>> Surely on VM's
>>
>> s/. Surely/, especially/
>>
>>> that do a lot of writes/deletes.
>>> This causes the qcow2 image to grow even over 110% of its virtual size,
>>> because the free gaps in the image get to small to allocate new
>>
>> s/to small/too small/
>>
>>> continuous clusters. So it allocates new space as the end of the image.
>>
>> s/as/at/
>>
>>> Disabling discard is not an option, as discard is needed to keep the
>>> incremental backup size as low as possible. Without discard, the
>>> incremental backups would become large, as qemu thinks it's just dirty
>>> blocks but it doesn't know the blocks are empty/useless.
>>> So we need to avoid fragmentation but also 'empty' the useless 
>>> blocks in
>>
>> s/useless/unneeded/ in both lines?
>>
>>> the image to have a small incremental backup.
>>>
>>> Next to that we also want to send the discards futher down the 
>>> stack, so
>>
>> s/Next to that/In addition/, s/futher/further/
>>
>>> the underlying blocks are still discarded.
>>>
>>> Therefor we introduce a new qcow2 option "discard-no-unref". When
>>> setting this option to true (defaults to false), the discard requests
>>> will still be executed, but it will keep the offset of the cluster. And
>>> it will also pass the discard request further down the stack (if
>>> discard:unmap is enabled).
>>
>> I think this could be more explicit, e.g. “When setting this option 
>> to true, discards will no longer have the qcow2 driver relinquish 
>> cluster allocations. Other than that, the request is handled as 
>> normal: All clusters in range are marked as zero, and, if 
>> pass-discard-request is true, it is passed further down the stack. 
>> The only difference is that the now-zero clusters are preallocated 
>> instead of being unallocated.”
>>
>>> This will avoid fragmentation and for example on a fully preallocated
>>> qcow2 image, this will make sure the image is perfectly continuous.
>>
>> Well, on the qcow2 layer, yes.
> All above -> Fixed :)
>>
>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>>> ---
>>>   block/qcow2-cluster.c  |  16 ++++-
>>>   block/qcow2-refcount.c | 136 
>>> ++++++++++++++++++++++++-----------------
>>>   block/qcow2.c          |  12 ++++
>>>   block/qcow2.h          |   3 +
>>>   qapi/block-core.json   |   4 ++
>>>   qemu-options.hx        |   6 ++
>>>   6 files changed, 120 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>>> index 39cda7f907..88da70db5e 100644
>>> --- a/block/qcow2-cluster.c
>>> +++ b/block/qcow2-cluster.c
>>> @@ -1943,10 +1943,22 @@ static int 
>>> discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>>>               new_l2_entry = new_l2_bitmap = 0;
>>>           } else if (bs->backing || 
>>> qcow2_cluster_is_allocated(cluster_type)) {
>>>               if (has_subclusters(s)) {
>>> -                new_l2_entry = 0;
>>> +                if (s->discard_no_unref && (type & 
>>> QCOW2_DISCARD_REQUEST)) {
>>
>> As far as I understand the discard type is just a plain enum, not a 
>> bit field.  So I think this should be `type == 
>> QCOW2_DISCARD_REQUEST`, not an `&`.  (Same below.)
>>
> Ack
>>> +                    new_l2_entry = old_l2_entry;
>>> +                } else {
>>> +                    new_l2_entry = 0;
>>> +                }
>>>                   new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
>>>               } else {
>>> -                new_l2_entry = s->qcow_version >= 3 ? 
>>> QCOW_OFLAG_ZERO : 0;
>>> +                if (s->qcow_version >= 3) {
>>> +                    if (s->discard_no_unref && (type & 
>>> QCOW2_DISCARD_REQUEST)) {
>>> +                        new_l2_entry |= QCOW_OFLAG_ZERO;
>>> +                    } else {
>>> +                        new_l2_entry = QCOW_OFLAG_ZERO;
>>> +                    }
>>> +                } else {
>>> +                    new_l2_entry = 0;
>>> +                }
>>>               }
>>>           }
>>
>> Context below:
>>
>>         if (old_l2_entry == new_l2_entry && old_l2_bitmap == 
>> new_l2_bitmap) {
>>             continue;
>>         }
>>
>>         /* First remove L2 entries */
>>         qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>>         set_l2_entry(s, l2_slice, l2_index + i, new_l2_entry);
>>         if (has_subclusters(s)) {
>>             set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
>>         }
>>         /* Then decrease the refcount */
>>         qcow2_free_any_cluster(bs, old_l2_entry, type);
>>
>> If we keep the allocation, I don’t see why we would call 
>> qcow2_free_any_cluster().  If we simply skip the call (if 
>> `qcow2_is_allocated(qcow2_get_cluster_type(bs, new_l2_entry))`), I 
>> think you could drop the modification to update_refcount().
>>
> If we don't call qcow2_free_any_cluster, the discard will not get 
> passed to the lower layer.

That’s a pickle.

> We also call it in zero_in_l2_slice for example to discard lower layer.

We only call it there if the allocation is dropped.  (`new_l2_entry = 
unmap ? 0 : old_l2_entry`)

I’d either lift the discard to discard_in_l2_slice() (if dropping the 
reference, call qcow2_free_any_cluster(); otherwise, if the old cluster 
was a normal or zero allocated cluster, discard it); or add a bool 
parameter to `qcow2_free_any_cluster()` that tells it to only discard, 
not free, the cluster, which makes it take the existing `if 
(has_data_file(bs))` path there.

The latter is simpler, but I find it problematic still to call 
qcow2_free_any_cluster() when there’s no intention of actually freeing a 
cluster (i.e. releasing the reference to it).

Hanna



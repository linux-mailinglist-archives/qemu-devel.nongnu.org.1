Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAEA72C34
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Mar 2025 10:17:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjLW-0000ab-8j; Thu, 27 Mar 2025 05:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1txjLP-0000Zd-FO
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:16:15 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1txjLL-0006N1-Ac
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:16:10 -0400
Received: from [IPV6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c] (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id 6B7FF1520CC7;
 Thu, 27 Mar 2025 10:16:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1743066960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ax6rds7LRZrvWHwQJp64OtXQXBD10Va89eJSdzd0pX0=;
 b=KNWV2w3mZDtjf/VLkh8KGQA0hzCiGKzaO606kMagTxqJJaPrB/KDLG/zDk5+wY+sG2NHlW
 stF+wdOBEpOApQRaFvS8lflsG0WZwvQX5ila19eSniqNFP4shxBgrux3w3JWeragJ2GOOt
 Ts3o6/rPBzz0iB3XhUIARVQyMLl7zoZkwx3u4pX8jNvOaG5K+nCqx/BvAc86cmPidiAaQG
 /oJn778BLGZm1BMsAv/Ws31CkmnaM6XbEM3xqTRuwuEt26nDUyrobt9JvmIwmbotFpIkQk
 lvF020G9AytbHv/+uUw/joj8+6abx//0IPsf3VMYOWtc8+44fatqXNnYQZAQig==
Message-ID: <6a324cf0-ad13-4c9f-a6cf-fd35290eb428@dupond.be>
Date: Thu, 27 Mar 2025 10:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qcow2: handle discard-no-unref in measure
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org,
 kwolf@redhat.com, andrey.drobyshev@virtuozzo.com
References: <20240605132539.3668497-2-jean-louis@dupond.be>
 <80a77456-da98-4346-aa56-a7389934cdcf@redhat.com>
 <a652c543-faa4-4c26-85b6-4fd56183aa66@dupond.be>
Content-Language: en-US
In-Reply-To: <a652c543-faa4-4c26-85b6-4fd56183aa66@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Any chance this can get reviewed and perhaps merged?

We would like to enable discard-no-unref by default on oVirt, as this 
makes qcow2 inside LVM LV's way more reliable (because we can calculate 
the size).
But we are still missing this measure patch to be able to properly 
calculate the destination size of the LV on a snapshot merge.

Thanks
Jean-Louis

On 2/17/25 16:34, Jean-Louis Dupond wrote:
> Hi,
>
> First of all sorry for the huge delay, but didn't had time to 
> follow-up on this lately.
> And it got some lower priority, as we don't hit it often and have a 
> fairly easy workaround (fill the empty blocks again in the snapshot by 
> writing data to the disk).
>
> On 7/10/24 14:58, Hanna Czenczek wrote:
>> On 05.06.24 15:25, Jean-Louis Dupond wrote:
>>> When doing a measure on an image with a backing file and
>>> discard-no-unref is enabled, the code should take this into account.
>>
>> That doesn’t make sense to me.  As far as I understand, 'measure' is 
>> supposed to report how much space you need for a given image, i.e. if 
>> you were to convert it to a new image. discard-no-unref doesn’t 
>> factor into that, because for a 'convert' target (a new image), 
>> nothing can be discarded.
>>
>> Reading the issue, I understand that oVirt uses measure to determine 
>> the size of the target of a 'commit' operation.  Seems a bit like 
>> abuse to me, precisely because of the issue you’re facing.  More 
>> specifically, a 'commit' operation is a complex thing with a lot of 
>> variables, so the outcome depends on a lot.
> Correct. oVirt uses the measure command to find out how big the 
> destination volume needs to be when running a commit/merge of 2 disks.
> This way it can resize the container (Logical Volume here) to the 
> correct size in order to succeed the commit.
>>
>> For example, this patch just checks the discard-no-unref setting on 
>> the top image.  But AFAIU it doesn’t matter what the setting on the 
>> top image is, it matters what the setting on the commit target is. 
>> 'measure' can’t know this because it doesn’t know what the commit 
>> target is.  As far as I can see, this patch actually assumes the 
>> commit target is the first backing image (it specifically checks in 
>> the image whether a block is allocated) – why?
> By default it would check the top image indeed, but not when using the 
> complex json parameters to qemu-img measure.
> For example:
> ./build/qemu-img create -f qcow2 /tmp/test.qcow2 128M
> ./build/qemu-io -c 'open /tmp/test.qcow2' -c 'write 0 8M' -c 'write 
> 56M 20M' -c 'write 10M 8M' -c 'write 24M 32M'
> ./build/qemu-img create -f qcow2 -b /tmp/test.qcow2 -F qcow2 
> /tmp/test_snap.qcow2
> ./build/qemu-io -c 'open -o discard=unmap,discard-no-unref=on 
> /tmp/test_snap.qcow2' -c 'write 16M 8M' -c 'discard 60M 20M' -c 'write 
> 84M 10M'
>
>
> The following commands will give the current output:
> [jean-louis@lt-jeanlouis qemu]$ ./build/qemu-img measure --output json 
> -O qcow2 'json:{"file": {"driver": "file", "filename": 
> "/tmp/test_snap.qcow2"}, "driver": "qcow2", "discard":"unmap", 
> "discard-no-unref":true, "backing": {"driver": "qcow2", 
> "discard-no-unref":false, "file": {"driver": "file", "filename": 
> "/tmp/test.qcow2"}, "backing": null}}'
> {
>     "bitmaps": 0,
>     "required": 71630848,
>     "fully-allocated": 134545408
> }
> [jean-louis@lt-jeanlouis qemu]$ ./build/qemu-img measure --output json 
> -O qcow2 /tmp/test_snap.qcow2
> {
>     "bitmaps": 0,
>     "required": 71630848,
>     "fully-allocated": 134545408
> }
> [jean-louis@lt-jeanlouis qemu]$ ./build/qemu-img measure --output json 
> -O qcow2 'json:{"file": {"driver": "file", "filename": 
> "/tmp/test_snap.qcow2"}, "driver": "qcow2", "backing": {"driver": 
> "qcow2", "file": {"driver": "file", "filename": "/tmp/test.qcow2"}, 
> "backing": null}}'
> {
>     "bitmaps": 0,
>     "required": 71630848,
>     "fully-allocated": 134545408
> }
>
> Cause it will not take into account the discard-no-unref flag. And 
> will give the output like you have in the current version.
>
>
> But when running measure with the following options:
> ./build/qemu-img measure --output json -O qcow2 'json:{"file": 
> {"driver": "file", "filename": "/tmp/test_snap.qcow2"}, "driver": 
> "qcow2", "discard":"unmap", "discard-no-unref":true, "backing": 
> {"driver": "qcow2", "discard-no-unref":true, "file": {"driver": 
> "file", "filename": "/tmp/test.qcow2"}, "backing": null}}'
>
> It will give a bigger required size:
> {
>     "bitmaps": 0,
>     "required": 88408064,
>     "fully-allocated": 134545408
> }
>
>
> Why? if a block has already been allocated (either with data or 
> contains an allocated ZERO block), we want to include its size in the 
> calculation.
> Because with discard-no-unref, an allocated block will not be reused 
> for some other cluster, so it's not available for data in the snapshot 
> layer.
> So if the cluster was not yet allocated in the destination image, a 
> new cluster will need to be allocated to fit the new data from the 
> snapshot layer.
>
>>
>> So to me that means if 'measure' is supposed to give reliable data on 
>> the commit case, it needs to be extended.  Best thing I can come up 
>> with off the top of my head would be to add an option e.g. 
>> 'commit=<target-node-name>', so we (A) that we’re looking at a commit 
>> and not a convert, and (B) we know what data will be collapsed into 
>> which image and where we need to check for discard-no-unref.
> I think that is what can be achieved by using the json argument. Cause 
> there we can specify the target with its flags.
> And it's then the responsibility of oVirt (or whatever other tool), to 
> pass the correct flags.
>>
>> Hanna
> Thanks for the review
>
> Jean-Louis
>>
>>> If for example you have a snapshot image with a base, and you do a
>>> discard within the snapshot, it will be ZERO and ALLOCATED, but without
>>> host offset.
>>> Now if we commit this snapshot, and the clusters in the base image have
>>> a host offset, the clusters will only be set to ZERO, but the host 
>>> offset
>>> will not be cleared.
>>> Therefor non-data clusters in the top image need to check the
>>> base to see if space will be freed or not, to have a correct measure
>>> output.
>>>
>>> Bug-Url: https://gitlab.com/qemu-project/qemu/-/issues/2369
>>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>>> ---
>>>   block/qcow2.c | 32 +++++++++++++++++++++++++++++---
>>>   1 file changed, 29 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 956128b409..50354e5b98 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -5163,9 +5163,16 @@ static BlockMeasureInfo 
>>> *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>>>           } else {
>>>               int64_t offset;
>>>               int64_t pnum = 0;
>>> +            BlockDriverState *parent = bdrv_filter_or_cow_bs(in_bs);
>>> +            BDRVQcow2State *s = NULL;
>>> +
>>> +            if (parent) {
>>> +                s = parent->opaque;
>>> +            }
>>>                 for (offset = 0; offset < ssize; offset += pnum) {
>>>                   int ret;
>>> +                int retp = 0;
>>>                     ret = bdrv_block_status_above(in_bs, NULL, offset,
>>>                                                 ssize - offset, 
>>> &pnum, NULL,
>>> @@ -5176,10 +5183,29 @@ static BlockMeasureInfo 
>>> *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>>>                       goto err;
>>>                   }
>>>   -                if (ret & BDRV_BLOCK_ZERO) {
>>> +                /* If we have a parent in the chain and the current 
>>> block is not data,
>>> +                 * then we want to check the allocation state of 
>>> the parent block.
>>> +                 * If it has a valid offset, then we want to 
>>> include it into
>>> +                 * the calculation, cause blocks with an offset 
>>> will not be freed when
>>> +                 * committing the top into base with 
>>> discard-no-unref enabled.
>>> +                 */
>>> +                if (parent && s->discard_no_unref && !(ret & 
>>> BDRV_BLOCK_DATA)) {
>>> +                        int64_t pnum_parent = 0;
>>> +                        retp = bdrv_block_status_above(parent, 
>>> NULL, offset,
>>> +                                              ssize - offset, 
>>> &pnum_parent, NULL,
>>> +                                              NULL);
>>> +                        /* If the parent continuous block is 
>>> smaller, use that pnum,
>>> +                         * so the next iteration starts with the 
>>> smallest offset.
>>> +                         */
>>> +                        if (pnum_parent < pnum) {
>>> +                            pnum = pnum_parent;
>>> +                        }
>>> +                }
>>> +                if (ret & BDRV_BLOCK_ZERO && !parent && !(parent && 
>>> s->discard_no_unref)) {
>>>                       /* Skip zero regions (safe with no backing 
>>> file) */
>>> -                } else if ((ret & (BDRV_BLOCK_DATA | 
>>> BDRV_BLOCK_ALLOCATED)) ==
>>> -                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
>>> +                } else if (((ret & (BDRV_BLOCK_DATA | 
>>> BDRV_BLOCK_ALLOCATED)) ==
>>> +                            (BDRV_BLOCK_DATA | 
>>> BDRV_BLOCK_ALLOCATED)) ||
>>> +                           (retp & BDRV_BLOCK_OFFSET_VALID)) {
>>>                       /* Extend pnum to end of cluster for next 
>>> iteration */
>>>                       pnum = ROUND_UP(offset + pnum, cluster_size) - 
>>> offset;
>>


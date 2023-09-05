Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B69297922D3
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 15:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVoh-0005ut-7f; Tue, 05 Sep 2023 09:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qdVoe-0005uO-Md
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:10:00 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qdVob-0001gw-W8
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 09:10:00 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 199871520BEF;
 Tue,  5 Sep 2023 15:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1693919394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvDc7cO/p+zZ4MZ64cNv605qeJxL1KUrHo/oezl1FF4=;
 b=RWqsoJ9o5/ucWVvRjGeD817OIz9+GYNfoqE4tq0BiKwc1Q27ulRTsWN9PCMPhqfcedS/qE
 2g5Q/8t5fMS+yj3F1XPW3oJIyeVBzhp1mK34qIc3g6XTdg2OdIeFqTrWVNnWoTxeMDB/rB
 kuqbb+K56OXKYycKHwN98Q4VFVn5ad1s756SUzfxvA2SAw2mofKd2KhCuR6RDvOs4QfyI+
 wVpuAYL1JU+wj9dw6CIm6X983Pia2twLYZV5pF71+RnX2Y1cNUAfc0D7jKclTn5ag+3nmW
 pRBJtuIS3UZ+G2ZhEGjHl/ewJQ2B3ZAmbpJNR/ElDmC5DfT1eXjNRnhvQxX1Pw==
Message-ID: <0da4b866-bcb0-46ec-89bc-d17aa87dc36d@dupond.be>
Date: Tue, 5 Sep 2023 15:09:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qcow2: keep reference on zeroize with discard-no-unref
 enabled
To: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
References: <20230904150958.823365-1-jean-louis@dupond.be>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20230904150958.823365-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Replaced by PATCH v2.

On 4/09/2023 17:09, Jean-Louis Dupond wrote:
> When the discard-no-unref flag is enabled, we keep the reference for
> normal discard requests.
> But when a discard is executed on a snapshot/qcow2 image with backing,
> the discards are saved as zero clusters in the snapshot image.
>
> When committing the snapshot to the backing file, not
> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
> any logic to keep the reference when discard-no-unref is enabled.
>
> Therefor we add logic in the zero_in_l2_slice call to keep the reference
> on commit.
>
> Next to that we also revert some logic from 42a2890a and just call
> qcow2_free_any_cluster. As this will just decrease the refcount but not
> remove the reference itself. And it will also send the discard further
> to the lower layer.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2-cluster.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f4f6cd6ad0..48532ca3c2 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1975,16 +1975,7 @@ static int discard_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>           if (has_subclusters(s)) {
>               set_l2_bitmap(s, l2_slice, l2_index + i, new_l2_bitmap);
>           }
> -        if (!keep_reference) {
> -            /* Then decrease the refcount */
> -            qcow2_free_any_cluster(bs, old_l2_entry, type);
> -        } else if (s->discard_passthrough[type] &&
> -                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
> -                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> -            /* If we keep the reference, pass on the discard still */
> -            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                          s->cluster_size);
> -       }
> +        qcow2_free_any_cluster(bs, old_l2_entry, type);
>       }
>   
>       qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
> @@ -2062,9 +2053,14 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>           QCow2ClusterType type = qcow2_get_cluster_type(bs, old_l2_entry);
>           bool unmap = (type == QCOW2_CLUSTER_COMPRESSED) ||
>               ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
> -        uint64_t new_l2_entry = unmap ? 0 : old_l2_entry;
> +        uint64_t new_l2_entry = old_l2_entry;
>           uint64_t new_l2_bitmap = old_l2_bitmap;
>   
> +        if (unmap &&
> +            !(s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED)) {
> +            new_l2_entry = 0;
> +        }
> +
>           if (has_subclusters(s)) {
>               new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
>           } else {


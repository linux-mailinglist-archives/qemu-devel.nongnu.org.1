Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F57D9510
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 12:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJva-0000cg-Fw; Fri, 27 Oct 2023 06:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qwJvX-0000cC-7v
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:18:51 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qwJvU-0005vV-JG
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:18:50 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b])
 by apollo.dupie.be (Postfix) with ESMTPSA id EBDB31520E7F;
 Fri, 27 Oct 2023 12:18:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1698401922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/L15TZEbDhxQA7dmj1mmoACWwHG7gpuZAMrNABr9hE=;
 b=OOuRTBQeOQ+nYlw4E0BMLFjWl3Za7M24qyLnxhLsh5JyudTVCTS4NvAYPcHv4QOFMR8Wzk
 f2uIMGndsmTlBLUtHKYSi6FspzYeBB4lDDWsbXkkzYXZ13UHdJeDA2oVQO24qpLZdFUlNW
 vUuBhcFx9IGw6ygVvQXs8L5QKXbhOqyRdxTifm9AqToqnJbzzAVwjzgvupf3mjlOSgVhyr
 EQHjEfWxT3aPcsPpRqlphl3QGhMd1CoAWq8mQSuCZSHo+pm1p4WpoB2MrH+YgkQPuGc0KZ
 DRCY4f8MSUOjaHcDrSDAxPz2DWLUPztLIfvQsgx79PDNrNrBMlMWwS+oUKlpBg==
Message-ID: <5ac70f50-6084-4d21-8f11-0f666b69383c@dupond.be>
Date: Fri, 27 Oct 2023 12:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qcow2: keep reference on zeroize with discard-no-unref
 enabled
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20231003125236.216473-2-jean-louis@dupond.be>
 <9b6735e5-3ce2-448e-a347-70fd5cf169f2@redhat.com>
Content-Language: en-US
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <9b6735e5-3ce2-448e-a347-70fd5cf169f2@redhat.com>
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


On 27/10/2023 11:49, Hanna Czenczek wrote:
> On 03.10.23 14:52, Jean-Louis Dupond wrote:
>> When the discard-no-unref flag is enabled, we keep the reference for
>> normal discard requests.
>> But when a discard is executed on a snapshot/qcow2 image with backing,
>> the discards are saved as zero clusters in the snapshot image.
>>
>> When committing the snapshot to the backing file, not
>> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
>> any logic to keep the reference when discard-no-unref is enabled.
>>
>> Therefor we add logic in the zero_in_l2_slice call to keep the reference
>> on commit.
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   block/qcow2-cluster.c | 22 ++++++++++++++++++----
>>   qapi/block-core.json  |  7 ++++---
>>   qemu-options.hx       |  3 ++-
>>   3 files changed, 24 insertions(+), 8 deletions(-)
>
> [...]
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 89751d81f2..9836195850 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3476,15 +3476,16 @@
>>   #     should be issued on other occasions where a cluster gets freed
>>   #
>>   # @discard-no-unref: when enabled, discards from the guest will not
>> -#     cause cluster allocations to be relinquished.  This prevents
>> +#     cause cluster allocations to be relinquished. The same will
>> +#     happen for discards triggered by zeroize. This prevents
>
> I don’t think “zeroize” has any meaning outside of qemu’s qcow2 code.  
> I’d write “when enabled, data clusters will remain preallocated when 
> they are no longer used, e.g. because they are discarded or converted 
> to zero clusters.  As usual, whether the old data is discarded or kept 
> on the protocol level (i.e. in the image file) depends on the setting 
> of the pass-discard-request option. Keeping the clusters preallocated 
> prevents qcow2 fragmentation that would otherwise be caused by freeing 
> and re-allocating them later. Besides potential performance 
> degradation, [...]”
>
> If you’re OK with that, I can change that (here and in 
> qemu-options.hx) when taking the patch.

Perfect!

>
>>   #     qcow2 fragmentation that would be caused by such discards.
>>   #     Besides potential performance degradation, such fragmentation
>>   #     can lead to increased allocation of clusters past the end of the
>>   #     image file, resulting in image files whose file length can grow
>> -#     much larger than their guest disk size would suggest.  If image
>> +#     much larger than their guest disk size would suggest. If image
>>   #     file length is of concern (e.g. when storing qcow2 images
>>   #     directly on block devices), you should consider enabling this
>> -#     option.  (since 8.1)
>> +#     option. (since 8.1)
>
> These two changes don’t seem related, I’d remove them, too. 
> (Double-space after '.' is fairly common in block-core.json, and in my 
> emails, too. :))
Fine
>
> Hanna
>

Thanks
Jean-Louis



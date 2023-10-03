Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3777B6987
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:54:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneue-0004Hz-T6; Tue, 03 Oct 2023 08:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qneua-0004Ck-Sd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:54:05 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1qneuL-0004r4-Hf
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:54:04 -0400
Received: from [IPV6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b] (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ecd9:958e:7098:f62b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 1C7771520C25;
 Tue,  3 Oct 2023 14:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1696337628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU/mqpPODovjYAeIBE0/jwgonHR1iHOIB0X7XaqNnF4=;
 b=GZmJk6PMmoAdJmBUyMPaT/0j8frkT3s5Vj3BfTiKewbRoLrcWL6QywwdhN/jwtSRqpnWaJ
 Ljw2/TvlfVKDJvHl9+4EAeNw/CJYsmgHKizA26Mlq4OImBvMaWCtCtDslElFD7RBDA0A3O
 0I0DklskiotUU/UhG+aGln8BC06tb8wSWH0ZND3VwrbGwStXEZQfZUJNxVWHZU2Y7ClLTz
 vJvWLddwnF59/gn3aWsDpE9SJctSoyfeFZAK8eNVVLxt8SZAs4nDZJvrJeuyD9AR3SXBqC
 JEc6n3jI8AOojcFUgE94rdHN3BI4Lav+OXbvFzm8xdL3V9kxO04kpPvN6ZHchQ==
Message-ID: <2e0f5e7a-6237-4630-9fd8-8ac09fe3e4b3@dupond.be>
Date: Tue, 3 Oct 2023 14:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qcow2: keep reference on zeroize with discard-no-unref
 enabled
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com
References: <20230905130839.923041-2-jean-louis@dupond.be>
 <1088caf4-3f59-84be-25d4-f2574674cb2a@redhat.com>
 <0208337f-92ac-4019-909b-2c3d333c46de@dupond.be>
 <ce017f83-672c-392f-7be9-12ec5fe52166@redhat.com>
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <ce017f83-672c-392f-7be9-12ec5fe52166@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
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


On 25/09/2023 16:17, Hanna Czenczek wrote:
> On 25.09.23 13:40, Jean-Louis Dupond wrote:
>> On 15/09/2023 13:21, Hanna Czenczek wrote:
>>> On 05.09.23 15:08, Jean-Louis Dupond wrote:
>>>> When the discard-no-unref flag is enabled, we keep the reference for
>>>> normal discard requests.
>>>> But when a discard is executed on a snapshot/qcow2 image with backing,
>>>> the discards are saved as zero clusters in the snapshot image.
>>>>
>>>> When committing the snapshot to the backing file, not
>>>> discard_in_l2_slice is called but zero_in_l2_slice. Which did not had
>>>> any logic to keep the reference when discard-no-unref is enabled.
>>>>
>>>> Therefor we add logic in the zero_in_l2_slice call to keep the 
>>>> reference
>>>> on commit.
>>>>
>>>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1621
>>>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>>>> ---
>>>>   block/qcow2-cluster.c | 22 ++++++++++++++++++----
>>>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>>
>>> The code looks OK, but the obvious problem I find is that this is 
>>> not what the discard-no-unref option describes.  It talks about 
>>> discards, but this now changes the zero-write path.
>> But it's still touching the discard code in the zeroize code path.
>> Cause we modify the way zeroize does its discard (when 
>> BDRV_REQ_MAY_UNMAP)
>
> I find there’s a difference between discard code handling discards 
> from the guest, and code handling zero-writes from the guest that 
> internally issues discards.  I see your POV, but the documentation 
> isn’t clear that not unref'ing on discards not only affects discards 
> issued by the guest, but also internal discards that have been 
> generated upon write-zero from the guest.
>
>>>
>>> I’m fairly certain that you are the only one using this option for 
>>> now, so we might as well change its definition to include zero 
>>> writes for 8.2, but we should do that.
>> I agree. How would you name the option then? Cause it still involves 
>> discard-only code.
>
> I wouldn’t change the name, just the definition (description).
Posted a new version with fixed description.
>
> Hanna
>
>> Next to that, the option was already added to libvirt also (so this 
>> needs to be fixed afterwards also).
>>>
>>> Hanna
>>>
>>
>


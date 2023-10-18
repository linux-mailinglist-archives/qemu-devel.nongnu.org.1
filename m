Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F67CD8AA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:54:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3G2-0007ui-1u; Wed, 18 Oct 2023 05:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt3Fy-0007uR-Da; Wed, 18 Oct 2023 05:54:27 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=IJBG=GA=kaod.org=clg@ozlabs.org>)
 id 1qt3Fw-0005M9-IK; Wed, 18 Oct 2023 05:54:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9R5R1JMRz4x1t;
 Wed, 18 Oct 2023 20:54:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9R5K0kkCz4wxZ;
 Wed, 18 Oct 2023 20:54:12 +1100 (AEDT)
Message-ID: <00f18d3d-f0b6-42cf-ae13-46c350e57689@kaod.org>
Date: Wed, 18 Oct 2023 11:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/4] tests/avocado: Add test for amigaone board
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1697568616.git.balaton@eik.bme.hu>
 <dea7938f15c3231984546b12ccc8e3b8ba42a203.1697568616.git.balaton@eik.bme.hu>
 <80c9cc1a-7d5b-4840-8dd5-9cbaae51114a@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <80c9cc1a-7d5b-4840-8dd5-9cbaae51114a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=IJBG=GA=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/18/23 07:58, Thomas Huth wrote:
> Please add a short patch description if this moves from RFC to a real patch
> 
> On 17/10/2023 21.06, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> I have no idea if this works so testing and corrections are welcome
> 
> Why don't you test it on your own? I think this should be sufficient:
> 
>   make check-avocado AVOCADO_TAGS=machine:amigaone

Test doesn't pass :

Fetching asset from tests/avocado/ppc_amiga.py:AmigaOneMachine.test_ppc_amigaone
JOB ID     : 39645d61f6f6c90ae87e3a48fe29beb16146aa73
JOB LOG    : /home/legoater/work/qemu/qemu.git/build/tests/results/job-2023-10-18T05.51-39645d6/job.log
  (1/1) tests/avocado/ppc_amiga.py:AmigaOneMachine.test_ppc_amigaone:  ERROR: file is not an archive (0.10 s)
Interrupting job (failfast).
RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
JOB TIME   : 2.53 s

C.

> 
>> but this could be a basic test. Booting further is a bit more involved
>> as we'd need alternative VGA BIOS and selecting menu items in the
>> firmware to allow CD boot so I did not try to automate that.
>>
>> This could be simpler if the u-boot-amigaone.bin could be added to
>> pc-bios. It's GPL so should be OK to include and distribute but irs
>> sources seem to be lost and could not be recovered or reconstructed so
>> we only have this binary. Who should be able to decide about that?
> 
> I'm sorry, but if the sources are not available anymore, then I think it will not be possible to ship the binary in the QEMU tarball - since the GPL requires that the distributor of the binary can also provide the sources on request.
> 
>   Thomas
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC97974360D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8oL-0006GU-Om; Fri, 30 Jun 2023 03:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF8oJ-0006Fd-N2; Fri, 30 Jun 2023 03:44:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF8oH-0001a6-DW; Fri, 30 Jun 2023 03:44:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QsnQm0VjLz4whk;
 Fri, 30 Jun 2023 17:44:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsnQk2gKYz4wZy;
 Fri, 30 Jun 2023 17:44:46 +1000 (AEST)
Message-ID: <bcf6dff6-45e8-738a-3600-d2f2369283b4@kaod.org>
Date: Fri, 30 Jun 2023 09:44:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] ppc/pnv: Add P10 quad ops
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-4-joel@jms.id.au>
 <da80494b-0626-62f5-65b7-1e4b0901ee27@linux.ibm.com>
 <CACPK8Xdyp_buQ4A=h8aJB1A_Q2kUpAGRHY1mm0Gn3jB3vk9a3Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8Xdyp_buQ4A=h8aJB1A_Q2kUpAGRHY1mm0Gn3jB3vk9a3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Okcj=CS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/30/23 09:35, Joel Stanley wrote:
> On Fri, 30 Jun 2023 at 07:30, Frederic Barrat <fbarrat@linux.ibm.com> wrote:
>>
>>
>>
>> On 30/06/2023 05:55, Joel Stanley wrote:
>>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>>> index b9a57463aec4..7fff2fd9e298 100644
>>> --- a/hw/ppc/pnv_core.c
>>> +++ b/hw/ppc/pnv_core.c
>>
>>> +static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>> ...
>>> +        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
>>
>>                                            ^^^ reading
>>
>> I'm guessing we'll need to flush out that function pretty soon, so not
>> worth resending.
> 
> Thanks, good catch. It's incorrect in the p9 callback too.
> 
> I had it fixed locally along with a re-wording to make it clear the
> message was for unimplemented operations, but decided not to send
> that.


There is still time for a v2 ! Please keep the R-b.

Thanks,

C.


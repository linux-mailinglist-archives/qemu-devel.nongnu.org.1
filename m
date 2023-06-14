Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45372F557
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 09:03:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9KW3-0002hJ-VX; Wed, 14 Jun 2023 03:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9KVw-0002gu-CK; Wed, 14 Jun 2023 03:01:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9KVt-0005k4-8E; Wed, 14 Jun 2023 03:01:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QgxDV5024z4xFm;
 Wed, 14 Jun 2023 17:01:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QgxDS4qMXz4x3m;
 Wed, 14 Jun 2023 17:01:44 +1000 (AEST)
Message-ID: <5c71cb2b-8fd2-f885-f56b-63dc87f1cac3@kaod.org>
Date: Wed, 14 Jun 2023 09:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] pnv/chiptod: Add POWER9/10 chiptod model
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Frederic Barrat <frederic.barrat@fr.ibm.com>
References: <20230603233612.125879-1-npiggin@gmail.com>
 <20230603233612.125879-2-npiggin@gmail.com>
 <69c9cd27-87b5-3864-1ae2-a6b01a26086e@kaod.org>
 <CTC4K105L91Y.YIIZVUGP786T@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CTC4K105L91Y.YIIZVUGP786T@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UREO=CC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.098, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Nick,

[ ... ]

>>> +    case TOD_TX_TTYPE_CTRL_REG:
>>> +        if (val & PPC_BIT(35)) { /* SCOM addressing */
>>> +            uint32_t addr = val >> 32;
>>> +            uint32_t reg = addr & 0xfff;
>>> +            PnvCore *pc;
>>> +
>>> +            if (reg != PC_TOD) {
>>> +                qemu_log_mask(LOG_GUEST_ERROR, "pnv_chiptod: SCOM addressing: "
>>> +                              "unimplemented slave register 0x%" PRIx32 "\n",
>>> +                              reg);
>>> +                return;
>>> +            }
>>> +
>>> +            /*
>>> +             * This may not deal with P10 big-core addressing at the moment.
>>> +             * The big-core code in skiboot syncs small cores, but it targets
>>> +             * the even PIR (first small-core) when syncing second small-core.
>>> +             */
>>> +            pc = pnv_get_vcpu_by_xscom_base(chiptod->chip, addr & ~0xfff);
>>
>> hmm, couldn't we map xscom subregions, one for each thread instead ?
> 
> I'm not sure what you mean. This scom-addressing uses the xscom
> address of the core's PC unit (where its time facilities are) to
> point nest chiptod transfers to cores.

What I meant is that if you could map one xscom subregion per thread in
an overall container region, each region could have its own 'opaque' data
(the thread object you are interested in) and you wouldn't need to do the
CPU lookup. A bit like for the ICP on POWER8 :


     0003ffff80000000-0003ffff800fffff (prio 0, i/o): icp-0
       0003ffff80008000-0003ffff80008fff (prio 0, i/o): icp-thread
       0003ffff80010000-0003ffff80010fff (prio 0, i/o): icp-thread
       0003ffff80018000-0003ffff80018fff (prio 0, i/o): icp-thread
       0003ffff80020000-0003ffff80020fff (prio 0, i/o): icp-thread
       0003ffff80028000-0003ffff80028fff (prio 0, i/o): icp-thread
       0003ffff80030000-0003ffff80030fff (prio 0, i/o): icp-thread
       0003ffff80048000-0003ffff80048fff (prio 0, i/o): icp-thread
       0003ffff80050000-0003ffff80050fff (prio 0, i/o): icp-thread


But, I missed that part :

+        if (val & PPC_BIT(35)) { /* SCOM addressing */
+            uint32_t addr = val >> 32;
+            uint32_t reg = addr & 0xfff;

and pnv_get_vcpu_by_xscom_base() is a bit of a hack. That's why you need
a backpointer to the chip which is always a bit suspicious for a sub unit.
An address space would be cleaner since writing to this register generates
another transaction it seems.

Do you plan to support other registers than PC_TOD ?

The part handling "SCOM addressing" deserves its own patch IMO. It would
clarifies how the logic works and the modeling.

[ ... ]

>>> +static void pnv_chiptod_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    static bool got_primary = false;
>>> +    static bool got_secondary = false;
>>> +
>>> +    PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
>>> +    PnvChipTODClass *pctc = PNV_CHIPTOD_GET_CLASS(chiptod);
>>> +
>>> +    if (!got_primary) {
>>> +        got_primary = true;
>>> +        chiptod->primary = true;
>>> +        chiptod->pss_mss_ctrl_reg |= PPC_BIT(1); /* TOD is master */
>>> +    } else if (!got_secondary) {
>>> +        got_secondary = true;
>>> +        chiptod->secondary = true;
>>> +    }
>>
>> It would be cleaner to introduce "primary" and "secondary" properties
>> defined by the model realizing the PnvChipTOD objects.
> 
> Hum. There's a few hard-coded primaries on chip_id == 0 already

XCSOM doesn't have a QOM model but it should be done that way. XIVE is
bit special because the TIMA is an overlapping mapping on all chips.

> in the tree. I don't know how closely related they are, chiptod
> can set other chips as primary AFAIK but maybe it just makes
> sense to make primary a chip property.

It really shouldn't be too much work, mostly setting properties in the
chip realize routine :

     object_property_set_bool(OBJECT(&chip10->chiptod), "primary",
                              chip->chip_id == 0, &error_abort);
     object_property_set_bool(OBJECT(&chip10->chiptod), "secondary",
                              chip->chip_id == 1, &error_abort);
     if (!qdev_realize(DEVICE(&chip10->chiptod), NULL, errp)) {
         return;
     }

  
> I might dig a bit more into what we (and other IBM firmware) want
> to test or expect with these primaries. Maybe another pass to
> tidy all that up can be done.


Thanks,

C.





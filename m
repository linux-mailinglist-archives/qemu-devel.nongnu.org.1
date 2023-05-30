Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B22716A0B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Xu-0005JF-3W; Tue, 30 May 2023 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42Xp-0005Ii-O0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:50:03 -0400
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42Xk-0004P1-U5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:49:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.188])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id AD45B2A16E;
 Tue, 30 May 2023 16:49:53 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 18:49:53 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00256b58162-3a16-4694-904b-d8ef165e6afd,
 1689548285A2663F4093CB2B261AE0EDF3FE8C9C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b731ee69-0e1f-6eef-4c44-e6711ea39c12@kaod.org>
Date: Tue, 30 May 2023 18:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: Frederic Barrat <fbarrat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-5-fbarrat@linux.ibm.com>
 <be9a5a3a-a46a-6317-dd2b-cd442f019158@kaod.org>
In-Reply-To: <be9a5a3a-a46a-6317-dd2b-cd442f019158@kaod.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: bf7bdcf2-6fa0-4e49-9d1a-caa3d083d482
X-Ovh-Tracer-Id: 2968153631132060640
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuhffvfhgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegvdfhhffftdevieegtedvieegvddutdfghefflefhgeefjeehleetfeekffetvdenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleekpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehfsggrrhhrrghtsehlihhnuhigrdhisghmrdgtohhmpdgurghnihgvlhhhsgegudefsehgmhgrihhlrdgtohhmpdhqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/30/23 18:40, Cédric Le Goater wrote:
> On 5/30/23 18:11, Frederic Barrat wrote:
>> The Thread Interrupt Management Area (TIMA) can be accessed through 4
>> ports/snoop buses, targeted by the address. The base address of a TIMA
>> is using port 0 and the other ports are 0x80 apart. Using one port or
>> another can be useful to balance the load on the snoop buses.
> 
> and can we have some nice examples of how these ports are used ? only for
> snooping or also for balancing operations ? which ones ?
> 
>> The TIMA registers are in the 0x0 -> 0x3F range and there are 2
>> indication bits for special operations (bits 10 and 11; everything
>> fits on a 4k page). So the port address bits fall in between and are
>> "don't care" for the hardware when processing the TIMA operation. So
>> this patch filters out those port address bits so that a TIMA
>> operation can be triggered using any port.
>>
>> It is also true for indirect access (through the IC BAR) and it's
>> actually nothing new, it was already the case on P9. Which helps here,
>> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

one extra comment, since we already have one mask for the tima offsets :

     /*
      * First, check for special operations in the 2K region
      */
     if (offset & 0x800) {

I think it would be cleaner to add some defines in the reg definition file.

Can come later.

Thanks,

C.



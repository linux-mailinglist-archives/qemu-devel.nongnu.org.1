Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D06717678
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:00:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EsR-0006Hv-GG; Wed, 31 May 2023 02:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4Erj-0005JD-6H
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:59:24 -0400
Received: from 2.mo552.mail-out.ovh.net ([178.33.105.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4Erg-0004AY-Ul
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:59:22 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.52])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id AF93F29028;
 Wed, 31 May 2023 05:59:16 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 07:59:16 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003891c33b7-3008-443b-a862-35ff1bc9394b,
 AD4A5C7A17A66D4AFB6DE796C11E1CF112258E66) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <523179dd-7842-7f03-14d6-678ed680a017@kaod.org>
Date: Wed, 31 May 2023 07:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis
 <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
 <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
 <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 87895003-8a34-4e1a-b4e5-12929ef71550
X-Ovh-Tracer-Id: 16299652955581877097
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekkedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdelpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdpjhhovghlsehjmhhsrdhiugdrrghupdgrnhgurhgvfiesrghjrdhiugdrrghupdgrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpoffvtefjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=178.33.105.233; envelope-from=clg@kaod.org;
 helo=2.mo552.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/30/23 23:15, Philippe Mathieu-Daudé wrote:
> On 30/5/23 22:34, Philippe Mathieu-Daudé wrote:
>> On 8/5/23 09:58, Cédric Le Goater wrote:
>>> Simple routine to retrieve a DeviceState object on a SPI bus using its
>>> address/cs. It will be useful for the board to wire the CS lines.
>>>
>>> Cc: Alistair Francis <alistair@alistair23.me>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>   include/hw/ssi/ssi.h |  2 ++
>>>   hw/ssi/ssi.c         | 15 +++++++++++++++
>>>   2 files changed, 17 insertions(+)
>>>
>>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>>> index ffd3a34ba4..c7beabdb09 100644
>>> --- a/include/hw/ssi/ssi.h
>>> +++ b/include/hw/ssi/ssi.h
>>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>>>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>>> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);
> 
> Also, this helper should (preferably) return a SSIPeripheral type.

Well, having a DeviceState is handy for the callers (today) and
ssi_create_peripheral() returns a DeviceState. Let's keep it that
way.

Thanks,

C.

> 
>> Previous patch use uint32_t. uint8_t is probably enough,
>> otherwise 'unsigned'? Otherwise
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 



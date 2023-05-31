Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A572717673
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Ere-0005GV-De; Wed, 31 May 2023 01:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q4Eqs-0004uy-BU; Wed, 31 May 2023 01:58:30 -0400
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q4Eqq-0003xn-L3; Wed, 31 May 2023 01:58:30 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.171])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 413CF20295;
 Wed, 31 May 2023 05:58:25 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 07:58:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S00450903b1b-7065-4d3a-9a1f-2bcc50b61137,
 AD4A5C7A17A66D4AFB6DE796C11E1CF112258E66) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9134f0ac-c533-720b-d97b-4a4accb1c92a@kaod.org>
Date: Wed, 31 May 2023 07:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 04/12] hw/ssi: Add an "addr" property to SSIPeripheral
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Alistair Francis
 <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-5-clg@kaod.org>
 <dc9883f1-0d36-d86b-caf0-a54f18861913@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <dc9883f1-0d36-d86b-caf0-a54f18861913@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 3a09c27a-908a-4628-af25-ca57ea1d8d9f
X-Ovh-Tracer-Id: 16285297731720350569
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekkedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduuddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdpjhhovghlsehjmhhsrdhiugdrrghupdgrnhgurhgvfiesrghjrdhiugdrrghupdgrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=178.32.121.110; envelope-from=clg@kaod.org;
 helo=1.mo548.mail-out.ovh.net
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

On 5/30/23 22:33, Philippe Mathieu-Daudé wrote:
> On 8/5/23 09:58, Cédric Le Goater wrote:
>> Boards will use this new property to identify the device CS line and
>> wire the SPI controllers accordingly.
>>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/ssi/ssi.h | 3 +++
>>   hw/ssi/ssi.c         | 7 +++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>> index 6950f86810..ffd3a34ba4 100644
>> --- a/include/hw/ssi/ssi.h
>> +++ b/include/hw/ssi/ssi.h
>> @@ -64,6 +64,9 @@ struct SSIPeripheral {
>>       /* Chip select state */
>>       bool cs;
>> +
>> +    /* Chip select address/index */
>> +    uint32_t addr;
> 
> uint8_t is probably enough.

Yes. A uint8_t is more than enough.

Thanks,

C.

  
> 
> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>   };
> 



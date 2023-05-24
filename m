Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C72A70ED7F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 08:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1hYr-0001es-28; Wed, 24 May 2023 02:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q1hYo-0001eP-I1
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:01:22 -0400
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q1hYm-0001Bx-MR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 02:01:22 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.136])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 7007121A87;
 Wed, 24 May 2023 06:01:16 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 24 May
 2023 08:01:15 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001b67380eb-95f5-4987-9afc-821e23a1ba0d,
 B4F797F232AA4FE69AC097E437AC38C0A7FFBD15) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <462f394f-228a-e486-f4c2-f6342bcbc82d@kaod.org>
Date: Wed, 24 May 2023 08:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] Add vpd data for Rainier machine
To: Ninad Palsule <ninad@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>, Ninad Palsule
 <ninad@linux.ibm.com>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <andrew@aj.id.au>, <joe@jms.id.au>
CC: <qemu-arm@nongnu.org>
References: <20230522153659.3379729-1-ninad@linux.ibm.com>
 <20230522153659.3379729-2-ninad@linux.ibm.com>
 <df00a5c0-7b59-e21c-c758-b1085d0c50b7@linaro.org>
 <4a054c44-ef17-3644-e39b-3c472bf635f9@linux.vnet.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <4a054c44-ef17-3644-e39b-3c472bf635f9@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 527895d3-284a-40dd-995d-5bc10a7c70ec
X-Ovh-Tracer-Id: 12118060700146240364
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedvfedtgfdvhfdujeehieetveffgfefteeltedugeffueetuddtfeehuedtieeknecuffhomhgrihhnpehqvghmuhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtjedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhhinhgrugeslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdhphhhilhhmugeslhhinhgrrhhordhorhhgpdhnihhnrggusehlihhnuhigrdhisghmrdgtohhmpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprghnughrvgifsegrjhdrihgurdgruhdpjhhovgesjhhmshdrihgurdgruhdpqhgvmhhuqdgrrhhmse
 hnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.33.25; envelope-from=clg@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/23/23 23:48, Ninad Palsule wrote:
> Hello Philippe,
> 
> On 5/23/23 3:52 AM, Philippe Mathieu-Daudé wrote:
>> Hi Ninad,
>>
>> On 22/5/23 17:36, Ninad Palsule wrote:
>>> The VPD data is added for system and BMC FRU. This data is fabricated.
>>
>> Per https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message:
>>
>>   QEMU follows the usual standard for git commit messages: the first
>>   line (which becomes the email subject line) is “subsystem: single
>>   line summary of change”.
>>
>> In this patch the subsystem is "hw/arm", but you can also use
>> "hw/arm/aspeed" or even "hw/arm/aspeed_eeprom" for subject prefix.
>>
> Added subsystem tag.
>>> Tested:
>>>     - The system-vpd.service is active.
>>>     - VPD service related to bmc is active.
>>
>>   ... more detailed description of the patch, another blank and your
>>   Signed-off-by: line.
> Added more details in the description.

This is not a fix, it's adding VPD support on the board. How is FW
impacted ? Is there some output ? what are these new VPD services
doing ? How is it helping the development team ?

Reviewers like to know a bit more about changes and how useful they
are. We are curious :)

Thanks,

C.

>>
>> Missing a blank line :)
> 
> Added blank line.
> 
> Thank you for the review!
> 
>>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>> ---
>>>   hw/arm/aspeed.c        |  6 ++++--
>>>   hw/arm/aspeed_eeprom.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>>>   hw/arm/aspeed_eeprom.h |  5 +++++
>>>   3 files changed, 53 insertions(+), 3 deletions(-)



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD3711FC0
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QnG-0007MD-9q; Fri, 26 May 2023 02:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q2Qmp-0007Bq-HB
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:18:51 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q2Qmn-0007zP-Fz
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:18:51 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.35])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 7F3922059B;
 Fri, 26 May 2023 06:18:45 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 08:18:45 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00611beb345-3319-414e-ab01-588248bf14c9,
 6F597A683095702A73A6C7CDE7888C96B2985428) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <72d241c8-635c-0c8d-4822-15a35fb9748d@kaod.org>
Date: Fri, 26 May 2023 08:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
Content-Language: en-US
To: Ninad Palsule <ninad@linux.vnet.ibm.com>, Andrew Jeffery
 <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
CC: Ninad Palsule <ninad@linux.ibm.com>, Cameron Esfahani via
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9_via?= <qemu-arm@nongnu.org>
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
 <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
 <80168e3a-b0f6-463e-b473-8488a897ef16@app.fastmail.com>
 <164e53c1-03dd-a530-8c91-357a10517556@kaod.org>
 <ba1e794c-ee3a-0dff-b008-7fac4b007255@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <ba1e794c-ee3a-0dff-b008-7fac4b007255@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: f6a16c6a-557a-49ad-80e0-82a1244324e4
X-Ovh-Tracer-Id: 5711971703202941801
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejkedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepleefhfegueeuiefhkedtjefhfffhtdevteetgeekueduvdekvdeukeeuheefkeeinecuffhomhgrihhnpehkrghougdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtiedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhhinhgrugeslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdgrnhgurhgvfiesrghjrdhiugdrrghupdhjohgvlhesjhhmshdrihgurdgruhdpnhhinhgrugeslhhinhhugidrihgsmhdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdfovfetjfhosh
 htpehmohehvdelpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/25/23 21:57, Ninad Palsule wrote:
> Hello Cedric,
> 
> 
> On 5/25/23 1:37 AM, Cédric Le Goater wrote:
>> [ ... ]
>>
>>> However, regarding Cédric's log above, a reboot is expected on the first
>>> boot of a fresh image when there's valid VPD available. For the first
>>> boot of a fresh image we configure the kernel with a minimal devicetree
>>> that allows us to read the VPD data. This determines the system we're
>>> actually on and configures an appropriate devicetree for subsequent
>>> boots. We then reboot to pick up the new devicetree.
>>
>> Yes. Then, the behavior looks correct under QEMU :
>>
>>   https://www.kaod.org/qemu/aspeed/rainier/rainer.log
>>
>> Here are the services which still have with some issues :
>>
>> * clear-once.service                loaded failed failed Clear one time boot overrides
>> * ncsi-linkspeed@eth0.service       loaded failed failed          Set eth0 gigabit link speed
>> * ncsi-linkspeed@eth1.service       loaded failed failed          Set eth1 gigabit link speed
>> * obmc-flash-bios-init.service      loaded failed failed Setup Host FW directories
>> * system-vpd.service                loaded failed failed System VPD Collection
>> * trace-enable.service              loaded failed failed Enable Linux trace events in the boot loader
> 
> On my system system-vpd.service was active. I couldn't run your build on my development machine.

That's how I run it :

   qemu-system-arm -M rainier-bmc -net user -drive file=./mmc-p10bmc.qcow2,format=qcow2,if=sd,id=sd2,index=2 -nographic -snapshot -serial mon:stdio

You will need to use my branch to have emmc support.

Thanks,

C.



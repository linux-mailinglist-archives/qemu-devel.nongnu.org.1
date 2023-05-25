Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7129D7105B7
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 08:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q24bq-0001XY-Ga; Thu, 25 May 2023 02:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q24bj-0001NF-RX; Thu, 25 May 2023 02:37:55 -0400
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q24bg-0006pc-Su; Thu, 25 May 2023 02:37:55 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.53])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 91909209ED;
 Thu, 25 May 2023 06:37:40 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 08:37:39 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004151609b7-ae7b-4002-b8f8-09ae99d7bcc2,
 E940071DC4947EF3E713969D80F20F6FFD8427E3) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <164e53c1-03dd-a530-8c91-357a10517556@kaod.org>
Date: Thu, 25 May 2023 08:37:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
Content-Language: en-US
To: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
CC: Ninad Palsule <ninad@linux.ibm.com>, Cameron Esfahani via
 <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9_via?= <qemu-arm@nongnu.org>
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
 <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
 <80168e3a-b0f6-463e-b473-8488a897ef16@app.fastmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <80168e3a-b0f6-463e-b473-8488a897ef16@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 142b79b9-2128-423d-a219-0415f8cb76fb
X-Ovh-Tracer-Id: 158751890873944870
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejiedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepleefhfegueeuiefhkedtjefhfffhtdevteetgeekueduvdekvdeukeeuheefkeeinecuffhomhgrihhnpehkrghougdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtuddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheprghnughrvgifsegrjhdrihgurdgruhdpjhhovghlsehjmhhsrdhiugdrrghupdhnihhnrggusehlihhnuhigrdhisghmrdgtohhmpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdpqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

[ ... ]

> However, regarding Cédric's log above, a reboot is expected on the first
> boot of a fresh image when there's valid VPD available. For the first
> boot of a fresh image we configure the kernel with a minimal devicetree
> that allows us to read the VPD data. This determines the system we're
> actually on and configures an appropriate devicetree for subsequent
> boots. We then reboot to pick up the new devicetree.

Yes. Then, the behavior looks correct under QEMU :

   https://www.kaod.org/qemu/aspeed/rainier/rainer.log

Here are the services which still have with some issues :

* clear-once.service                loaded failed     failed          Clear one time boot overrides
* ncsi-linkspeed@eth0.service       loaded failed     failed          Set eth0 gigabit link speed
* ncsi-linkspeed@eth1.service       loaded failed     failed          Set eth1 gigabit link speed
* obmc-flash-bios-init.service      loaded failed     failed          Setup Host FW directories
* system-vpd.service                loaded failed     failed          System VPD Collection
* trace-enable.service              loaded failed     failed          Enable Linux trace events in the boot loader

C.






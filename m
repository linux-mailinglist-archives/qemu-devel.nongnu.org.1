Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0D70F117
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jy1-0002cy-7K; Wed, 24 May 2023 04:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q1jxx-0002bz-CY; Wed, 24 May 2023 04:35:30 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q1jxv-0008ME-9I; Wed, 24 May 2023 04:35:29 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.208])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 5205521F6B;
 Wed, 24 May 2023 08:35:22 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 24 May
 2023 10:35:22 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001a447bc52-2dc7-43e8-8232-2be635070245,
 B4F797F232AA4FE69AC097E437AC38C0A7FFBD15) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <019afb96-5a94-e619-c864-d7c7ab46c9c3@kaod.org>
Date: Wed, 24 May 2023 10:35:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
CC: Ninad Palsule <ninad@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <peter.maydell@linaro.org>, <andrew@aj.id.au>, <qemu-arm@nongnu.org>
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
 <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 0557040d-ae27-417a-b83b-2870f141f417
X-Ovh-Tracer-Id: 14720578332827618086
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeuieetffduledtieekgeefvefhkeeffffhkeetvedtueeggfevfeefjedvgedujeenucffohhmrghinhepvhhinhhiughrrdguvgdprhhtrdhvihhnpdhgihhthhhusgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleeipdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdpnhhinhgrugeslhhinhhugidrihgsmhdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdgrnhgurhgvfiesrghjrdhiugdrrghupdhqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdfovfetjfhoshhtpehmohehvdelpd
 hmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

On 5/24/23 09:44, Joel Stanley wrote:
> On Wed, 24 May 2023 at 06:38, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 5/23/23 23:45, Ninad Palsule wrote:
>>> The current modeling of Rainier machine creates zero filled VPDs(EEPROMs).
>>> This makes some services and applications unhappy and causing them to fail.
>>> Hence this drop adds some fabricated data for system and BMC FRU so that
>>> vpd services are happy and active.
>>>
>>> Tested:
>>>      - The system-vpd.service is active.
>>>      - VPD service related to bmc is active.
>>>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>
>> You can keep the R-b tag when you resend, unless there are a lot of changes.
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>
>> Since I am curious, I started a rainier machine under QEMU and ran some
>> commands :
>>
>>     root@p10bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0050/eeprom
>>     00000000  00 00 00 00 00 00 00 00  00 00 00 84 28 00 52 54  |............(.RT|
>>     00000010  04 56 48 44 52 56 44 02  01 00 50 54 0e 56 54 4f  |.VHDRVD...PT.VTO|
>>     00000020  43 00 00 37 00 4a 00 00  00 00 00 50 46 08 00 00  |C..7.J.....PF...|
>>     00000030  00 00 00 00 00 00 00 00  46 00 52 54 04 56 54 4f  |........F.RT.VTO|
>>     00000040  43 50 54 38 56 49 4e 49  00 00 81 00 3a 00 00 00  |CPT8VINI....:...|
>>     00000050  00 00 56 53 59 53 00 00  bb 00 27 00 00 00 00 00  |..VSYS....'.....|
>>     00000060  56 43 45 4e 00 00 e2 00  27 00 00 00 00 00 56 53  |VCEN....'.....VS|
>>     00000070  42 50 00 00 09 01 19 00  00 00 00 00 50 46 01 00  |BP..........PF..|
>>     00000080  00 00 36 00 52 54 04 56  49 4e 49 44 52 04 44 45  |..6.RT.VINIDR.DE|
>>     00000090  53 43 48 57 02 30 31 43  43 04 33 34 35 36 46 4e  |SCHW.01CC.3456FN|
>>     000000a0  04 46 52 34 39 53 4e 04  53 52 31 32 50 4e 04 50  |.FR49SN.SR12PN.P|
>>     000000b0  52 39 39 50 46 04 00 00  00 00 00 00 23 00 52 54  |R99PF.......#.RT|
>>     000000c0  04 56 53 59 53 53 45 07  49 42 4d 53 59 53 31 54  |.VSYSSE.IBMSYS1T|
>>     000000d0  4d 08 32 32 32 32 2d 32  32 32 50 46 04 00 00 00  |M.2222-222PF....|
>>     000000e0  00 00 00 23 00 52 54 04  56 43 45 4e 53 45 07 31  |...#.RT.VCENSE.1|
>>     000000f0  32 33 34 35 36 37 46 43  08 31 31 31 31 2d 31 31  |234567FC.1111-11|
>>     00000100  31 50 46 04 00 00 00 00  00 00 15 00 52 54 04 56  |1PF.........RT.V|
>>     00000110  53 42 50 49 4d 04 50 00  10 01 50 46 04 00 00 00  |SBPIM.P...PF....|
>>     00000120  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>>     *
>>     00002000
>>     root@p10bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0051/eeprom
>>     00000000  00 00 00 00 00 00 00 00  00 00 00 84 28 00 52 54  |............(.RT|
>>     00000010  04 56 48 44 52 56 44 02  01 00 50 54 0e 56 54 4f  |.VHDRVD...PT.VTO|
>>     00000020  43 00 00 37 00 20 00 00  00 00 00 50 46 08 00 00  |C..7. .....PF...|
>>     00000030  00 00 00 00 00 00 00 00  1c 00 52 54 04 56 54 4f  |..........RT.VTO|
>>     00000040  43 50 54 0e 56 49 4e 49  00 00 57 00 1e 00 00 00  |CPT.VINI..W.....|
>>     00000050  00 00 50 46 01 00 00 00  1a 00 52 54 04 56 49 4e  |..PF......RT.VIN|
>>     00000060  49 44 52 04 44 45 53 43  48 57 02 30 31 50 46 04  |IDR.DESCHW.01PF.|
>>     00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>>
>> and
>>
>>     root@p10bmc:~# systemctl status  com.ibm.VPD.Manager.service  -l
>>     * com.ibm.VPD.Manager.service - IBM VPD Manager
>>          Loaded: loaded (/lib/systemd/system/com.ibm.VPD.Manager.service; enabled; preset: enabled)
>>          Active: active (running) since Wed 2023-05-24 06:26:34 UTC; 1min 28s ago
>>        Main PID: 2784 (vpd-manager)
>>             CPU: 101ms
>>          CGroup: /system.slice/com.ibm.VPD.Manager.service
>>                  `-2784 /usr/bin/vpd-manager
> 
> When it works we should be able to do things like this, I'm told:
> 
> vpd-tool -r -O /system/chassis/motherboard -R VSYS -K TM
> {
>      "/system/chassis/motherboard": {
>          "TM": "2222-222"
>      }
> }
> 
> 
>>
>> But, I also got this :
>>
>>     root@p10bmc:~# [   91.656331] watchdog: watchdog0: watchdog did not stop!
>>     [   91.734858] systemd-shutdown[1]: Using hardware watchdog 'aspeed_wdt', version 0, device /dev/watchdog0
>>     [   91.735766] systemd-shutdown[1]: Watchdog running with a timeout of 1min.
>>     [   91.987363] systemd-shutdown[1]: Syncing filesystems and block devices.
>>     [   93.471897] systemd-shutdown[1]: Sending SIGTERM to remaining processes...
>>
>> and the machine rebooted.
>>
>> Joel had the same problem :
>>
>>     https://github.com/openbmc/qemu/issues/39
>>
>> Is it unrelated ? I haven't started a rainier in 2 years at least so I can
>> not tell.
> 
> I don't think it's related to Ninad's patches.
> 
> I am able to reproduce the issue on my old Skylake x86 machine, but it
> doesn't happen on my M1 mac mini.

I saw it on a Ryzen Threadripper PRO 5955WX.

> I suspect the emulation is moving too slowly, but the host's wall
> clock is still ticking, so all of a sudden the BMC finds out that time
> has passed an the watchdog bites. I could be wrong.
> 
> The rainier firmware crashes all over the place due to missing
> hardware. These crashes cause applications to core dump due to
> OpenBMC's C++ exception throwing coding style, causing the system to
> go even slower which leads to more timeouts and more crashes. Ninad's
> work is the first piece in an attempt to get us to "BMC ready" without
> any services crashing.

May be disable services from uboot with systemd.mask=... ?

Cheers,

C.


> 
> The status quo does make it hard to test.
> 
> Cheers,
> 
> Joel



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDA71025A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 03:27:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1zkN-0005vf-BO; Wed, 24 May 2023 21:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q1zkJ-0005uo-QC; Wed, 24 May 2023 21:26:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q1zkG-0005ws-Ra; Wed, 24 May 2023 21:26:27 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34P05bVi002179; Thu, 25 May 2023 01:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eo0VkwKRdWNqO9tjn2fLDky6A0tmtzQWeinTi7THCKA=;
 b=ACAEP5+2tlrcD1NZHkjIMQaeGuti2W0PcUlbCgwjRIUwc916FgiTnutUlwOyQuRaREjW
 S5zMtia1iY7EjtTi6KsuU+OsYt9Y/8Xkafyp2uuue4TZuHSGqlzv8hoDBJ4j5cbHhqQ9
 G4kbQpVaD55dAiKnqv0r2SmPGiPsQhE3U17TGLGyq9qU8qZBG+UWWo/J2gewff6xd7TH
 QeUMZLbL26hjpWaPUV+tFzmBIAI7A0Y6jDclNiQ48Xm1zqVkZy63sJ/LrtW6jEeOmBqF
 fXzL5OIVpb2boPqPwj1k3qg9gL224UMkO5ZkamcnzMtqtxnL21nwqx2SfqYuYz/us21n GQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsvh6smkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 01:26:05 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34OMwFTx010654;
 Thu, 25 May 2023 01:26:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
 by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qppds76br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 01:26:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34P1Q2ho2884168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 01:26:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09CA358055;
 Thu, 25 May 2023 01:26:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC9D758043;
 Thu, 25 May 2023 01:26:01 +0000 (GMT)
Received: from [9.163.91.62] (unknown [9.163.91.62])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 May 2023 01:26:01 +0000 (GMT)
Message-ID: <1f3d8799-7c12-e9d4-91bd-5fead72b7f82@linux.vnet.ibm.com>
Date: Wed, 24 May 2023 20:26:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joel@jms.id.au
Cc: qemu-arm@nongnu.org
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
From: Ninad Palsule <ninad@linux.vnet.ibm.com>
In-Reply-To: <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cP-lD3bO0G-t60V84S8AZEr_sJFpaWJs
X-Proofpoint-GUID: cP-lD3bO0G-t60V84S8AZEr_sJFpaWJs
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_17,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250008
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ninad@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Cedric,

On 5/24/23 1:36 AM, Cédric Le Goater wrote:
> On 5/23/23 23:45, Ninad Palsule wrote:
>> The current modeling of Rainier machine creates zero filled 
>> VPDs(EEPROMs).
>> This makes some services and applications unhappy and causing them to 
>> fail.
>> Hence this drop adds some fabricated data for system and BMC FRU so that
>> vpd services are happy and active.
>>
>> Tested:
>>     - The system-vpd.service is active.
>>     - VPD service related to bmc is active.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>
> You can keep the R-b tag when you resend, unless there are a lot of 
> changes.
Yes, Sure. Sorry about that.
>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>
> Since I am curious, I started a rainier machine under QEMU and ran some
> commands :
>     root@p10bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0050/eeprom
>   00000000  00 00 00 00 00 00 00 00  00 00 00 84 28 00 52 54 
> |............(.RT|
>   00000010  04 56 48 44 52 56 44 02  01 00 50 54 0e 56 54 4f 
> |.VHDRVD...PT.VTO|
>   00000020  43 00 00 37 00 4a 00 00  00 00 00 50 46 08 00 00 
> |C..7.J.....PF...|
>   00000030  00 00 00 00 00 00 00 00  46 00 52 54 04 56 54 4f 
> |........F.RT.VTO|
>   00000040  43 50 54 38 56 49 4e 49  00 00 81 00 3a 00 00 00 
> |CPT8VINI....:...|
>   00000050  00 00 56 53 59 53 00 00  bb 00 27 00 00 00 00 00 
> |..VSYS....'.....|
>   00000060  56 43 45 4e 00 00 e2 00  27 00 00 00 00 00 56 53 
> |VCEN....'.....VS|
>   00000070  42 50 00 00 09 01 19 00  00 00 00 00 50 46 01 00 
> |BP..........PF..|
>   00000080  00 00 36 00 52 54 04 56  49 4e 49 44 52 04 44 45 
> |..6.RT.VINIDR.DE|
>   00000090  53 43 48 57 02 30 31 43  43 04 33 34 35 36 46 4e 
> |SCHW.01CC.3456FN|
>   000000a0  04 46 52 34 39 53 4e 04  53 52 31 32 50 4e 04 50 
> |.FR49SN.SR12PN.P|
>   000000b0  52 39 39 50 46 04 00 00  00 00 00 00 23 00 52 54 
> |R99PF.......#.RT|
>   000000c0  04 56 53 59 53 53 45 07  49 42 4d 53 59 53 31 54 
> |.VSYSSE.IBMSYS1T|
>   000000d0  4d 08 32 32 32 32 2d 32  32 32 50 46 04 00 00 00 
> |M.2222-222PF....|
>   000000e0  00 00 00 23 00 52 54 04  56 43 45 4e 53 45 07 31 
> |...#.RT.VCENSE.1|
>   000000f0  32 33 34 35 36 37 46 43  08 31 31 31 31 2d 31 31 
> |234567FC.1111-11|
>   00000100  31 50 46 04 00 00 00 00  00 00 15 00 52 54 04 56 
> |1PF.........RT.V|
>   00000110  53 42 50 49 4d 04 50 00  10 01 50 46 04 00 00 00 
> |SBPIM.P...PF....|
>   00000120  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
> |................|
>   *
>   00002000
>   root@p10bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0051/eeprom
>   00000000  00 00 00 00 00 00 00 00  00 00 00 84 28 00 52 54 
> |............(.RT|
>   00000010  04 56 48 44 52 56 44 02  01 00 50 54 0e 56 54 4f 
> |.VHDRVD...PT.VTO|
>   00000020  43 00 00 37 00 20 00 00  00 00 00 50 46 08 00 00 |C..7. 
> .....PF...|
>   00000030  00 00 00 00 00 00 00 00  1c 00 52 54 04 56 54 4f 
> |..........RT.VTO|
>   00000040  43 50 54 0e 56 49 4e 49  00 00 57 00 1e 00 00 00 
> |CPT.VINI..W.....|
>   00000050  00 00 50 46 01 00 00 00  1a 00 52 54 04 56 49 4e 
> |..PF......RT.VIN|
>   00000060  49 44 52 04 44 45 53 43  48 57 02 30 31 50 46 04 
> |IDR.DESCHW.01PF.|
>   00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
> |................|
>
> and
>
>   root@p10bmc:~# systemctl status  com.ibm.VPD.Manager.service  -l
>   * com.ibm.VPD.Manager.service - IBM VPD Manager
>        Loaded: loaded 
> (/lib/systemd/system/com.ibm.VPD.Manager.service; enabled; preset: 
> enabled)
>        Active: active (running) since Wed 2023-05-24 06:26:34 UTC; 
> 1min 28s ago
>      Main PID: 2784 (vpd-manager)
>           CPU: 101ms
>        CGroup: /system.slice/com.ibm.VPD.Manager.service
>                `-2784 /usr/bin/vpd-manager
>

Thank you for checking.


> But, I also got this :
>
>   root@p10bmc:~# [   91.656331] watchdog: watchdog0: watchdog did not 
> stop!
>   [   91.734858] systemd-shutdown[1]: Using hardware watchdog 
> 'aspeed_wdt', version 0, device /dev/watchdog0
>   [   91.735766] systemd-shutdown[1]: Watchdog running with a timeout 
> of 1min.
>   [   91.987363] systemd-shutdown[1]: Syncing filesystems and block 
> devices.
>   [   93.471897] systemd-shutdown[1]: Sending SIGTERM to remaining 
> processes...
This is a different issue. I am also hitting it without my changes.
>
> and the machine rebooted.
>
> Joel had the same problem :
>     https://github.com/openbmc/qemu/issues/39
>   Is it unrelated ? I haven't started a rainier in 2 years at least so 
> I can
> not tell.
>   Thanks,
>   C.
>
>
>
>
>
>
>> ---
>>   hw/arm/aspeed.c        |  6 ++++--
>>   hw/arm/aspeed_eeprom.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>>   hw/arm/aspeed_eeprom.h |  5 +++++
>>   3 files changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 0b29028fe1..bfc2070bd2 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -788,8 +788,10 @@ static void 
>> rainier_bmc_i2c_init(AspeedMachineState *bmc)
>>                        0x48);
>> i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), TYPE_TMP105,
>>                        0x4a);
>> -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 64 * 
>> KiB);
>> -    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 64 * 
>> KiB);
>> +    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50,
>> +                          64 * KiB, rainier_bb_fruid, 
>> rainier_bb_fruid_len);
>> +    at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51,
>> +                          64 * KiB, rainier_bmc_fruid, 
>> rainier_bmc_fruid_len);
>>       create_pca9552(soc, 8, 0x60);
>>       create_pca9552(soc, 8, 0x61);
>>       /* Bus 8: ucd90320@11 */
>> diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
>> index dc33a88a54..ace5266cec 100644
>> --- a/hw/arm/aspeed_eeprom.c
>> +++ b/hw/arm/aspeed_eeprom.c
>> @@ -119,9 +119,52 @@ const uint8_t yosemitev2_bmc_fruid[] = {
>>       0x6e, 0x66, 0x69, 0x67, 0x20, 0x41, 0xc1, 0x45,
>>   };
>>   +const uint8_t rainier_bb_fruid[] = {
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
>> 0x00, 0x84,
>> +    0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 
>> 0x44, 0x02,
>> +    0x01, 0x00, 0x50, 0x54, 0x0e, 0x56, 0x54, 0x4f, 0x43, 0x00, 
>> 0x00, 0x37,
>> +    0x00, 0x4a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x08, 
>> 0x00, 0x00,
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46, 0x00, 
>> 0x52, 0x54,
>> +    0x04, 0x56, 0x54, 0x4f, 0x43, 0x50, 0x54, 0x38, 0x56, 0x49, 
>> 0x4e, 0x49,
>> +    0x00, 0x00, 0x81, 0x00, 0x3a, 0x00, 0x00, 0x00, 0x00, 0x00, 
>> 0x56, 0x53,
>> +    0x59, 0x53, 0x00, 0x00, 0xbb, 0x00, 0x27, 0x00, 0x00, 0x00, 
>> 0x00, 0x00,
>> +    0x56, 0x43, 0x45, 0x4e, 0x00, 0x00, 0xe2, 0x00, 0x27, 0x00, 
>> 0x00, 0x00,
>> +    0x00, 0x00, 0x56, 0x53, 0x42, 0x50, 0x00, 0x00, 0x09, 0x01, 
>> 0x19, 0x00,
>> +    0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x01, 0x00, 0x00, 0x00, 
>> 0x36, 0x00,
>> +    0x52, 0x54, 0x04, 0x56, 0x49, 0x4e, 0x49, 0x44, 0x52, 0x04, 
>> 0x44, 0x45,
>> +    0x53, 0x43, 0x48, 0x57, 0x02, 0x30, 0x31, 0x43, 0x43, 0x04, 
>> 0x33, 0x34,
>> +    0x35, 0x36, 0x46, 0x4e, 0x04, 0x46, 0x52, 0x34, 0x39, 0x53, 
>> 0x4e, 0x04,
>> +    0x53, 0x52, 0x31, 0x32, 0x50, 0x4e, 0x04, 0x50, 0x52, 0x39, 
>> 0x39, 0x50,
>> +    0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x23, 0x00, 
>> 0x52, 0x54,
>> +    0x04, 0x56, 0x53, 0x59, 0x53, 0x53, 0x45, 0x07, 0x49, 0x42, 
>> 0x4d, 0x53,
>> +    0x59, 0x53, 0x31, 0x54, 0x4d, 0x08, 0x32, 0x32, 0x32, 0x32, 
>> 0x2d, 0x32,
>> +    0x32, 0x32, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 
>> 0x00, 0x23,
>> +    0x00, 0x52, 0x54, 0x04, 0x56, 0x43, 0x45, 0x4e, 0x53, 0x45, 
>> 0x07, 0x31,
>> +    0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x46, 0x43, 0x08, 0x31, 
>> 0x31, 0x31,
>> +    0x31, 0x2d, 0x31, 0x31, 0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 
>> 0x00, 0x00,
>> +    0x00, 0x00, 0x15, 0x00, 0x52, 0x54, 0x04, 0x56, 0x53, 0x42, 
>> 0x50, 0x49,
>> +    0x4d, 0x04, 0x50, 0x00, 0x10, 0x01, 0x50, 0x46, 0x04, 0x00, 
>> 0x00, 0x00,
>> +    0x00, 0x00,
>> +};
>> +
>> +/* Rainier BMC FRU */
>> +const uint8_t rainier_bmc_fruid[] = {
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
>> 0x00, 0x84,
>> +    0x28, 0x00, 0x52, 0x54, 0x04, 0x56, 0x48, 0x44, 0x52, 0x56, 
>> 0x44, 0x02,
>> +    0x01, 0x00, 0x50, 0x54, 0x0e, 0x56, 0x54, 0x4f, 0x43, 0x00, 
>> 0x00, 0x37,
>> +    0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x46, 0x08, 
>> 0x00, 0x00,
>> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1c, 0x00, 
>> 0x52, 0x54,
>> +    0x04, 0x56, 0x54, 0x4f, 0x43, 0x50, 0x54, 0x0e, 0x56, 0x49, 
>> 0x4e, 0x49,
>> +    0x00, 0x00, 0x57, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 
>> 0x50, 0x46,
>> +    0x01, 0x00, 0x00, 0x00, 0x1a, 0x00, 0x52, 0x54, 0x04, 0x56, 
>> 0x49, 0x4e,
>> +    0x49, 0x44, 0x52, 0x04, 0x44, 0x45, 0x53, 0x43, 0x48, 0x57, 
>> 0x02, 0x30,
>> +    0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +};
>> +
>>   const size_t tiogapass_bmc_fruid_len = sizeof(tiogapass_bmc_fruid);
>>   const size_t fby35_nic_fruid_len = sizeof(fby35_nic_fruid);
>>   const size_t fby35_bb_fruid_len = sizeof(fby35_bb_fruid);
>>   const size_t fby35_bmc_fruid_len = sizeof(fby35_bmc_fruid);
>> -
>>   const size_t yosemitev2_bmc_fruid_len = sizeof(yosemitev2_bmc_fruid);
>> +const size_t rainier_bb_fruid_len = sizeof(rainier_bb_fruid);
>> +const size_t rainier_bmc_fruid_len = sizeof(rainier_bmc_fruid);
>> diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
>> index 86db6f0479..bbf9e54365 100644
>> --- a/hw/arm/aspeed_eeprom.h
>> +++ b/hw/arm/aspeed_eeprom.h
>> @@ -22,4 +22,9 @@ extern const size_t fby35_bmc_fruid_len;
>>   extern const uint8_t yosemitev2_bmc_fruid[];
>>   extern const size_t yosemitev2_bmc_fruid_len;
>>   +extern const uint8_t rainier_bb_fruid[];
>> +extern const size_t rainier_bb_fruid_len;
>> +extern const uint8_t rainier_bmc_fruid[];
>> +extern const size_t rainier_bmc_fruid_len;
>> +
>>   #endif
>


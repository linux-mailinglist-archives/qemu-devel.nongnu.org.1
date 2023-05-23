Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09A70E75E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ZYr-0004bv-H6; Tue, 23 May 2023 17:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q1ZYp-0004bY-BA; Tue, 23 May 2023 17:28:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q1ZYn-0002PV-6l; Tue, 23 May 2023 17:28:51 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NLR9DZ012575; Tue, 23 May 2023 21:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2csBDxV1zguBvGgyEdKjn0fdKJ9qVusmOZdgpvZP3d4=;
 b=F36SFbxsn+J1RFA2y34AKa1cis+f43b7dHG8Rsk0fk7f+BP/GS0mOrY2ZuqCX1evKOJ0
 w5PRFxOuxUfdZCtoE61Llzs/l7wY/xOjsJY8n1PDe06vi4TK9HFS6k1eHBROhBCiabQn
 ZKTZVVwT51AmXEXZxlO4OJpGr3hAhpbnKWVLnJWq3eK5k1Gs6W6skr+GOLnsbBCpPXSN
 uBL9jf7+YH0UOa1TqLV3PRZE8WBXrPJ31xcXzs7LhK/F0VlnYZXcGPfNcZOouPrJOdlP
 TgKye+lP4UG2h/3xtosQk1M9s9SQUUa6qjQV+8BwXKdy/Rlsr2oitmQgXkMT1eUuf9+v eg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs4d71jec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 21:28:30 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NL1UoJ030140;
 Tue, 23 May 2023 21:28:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3qppcd56c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 21:28:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34NLSSkg2491038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 21:28:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30C1A5803F;
 Tue, 23 May 2023 21:28:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5E2F58054;
 Tue, 23 May 2023 21:28:27 +0000 (GMT)
Received: from [9.211.84.237] (unknown [9.211.84.237])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 May 2023 21:28:27 +0000 (GMT)
Message-ID: <140a525f-aed4-c47e-871d-a5fe6d1140f5@linux.vnet.ibm.com>
Date: Tue, 23 May 2023 16:28:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] Add vpd data for Rainier machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@aj.id.au, joe@jms.id.au
Cc: qemu-arm@nongnu.org
References: <20230522153659.3379729-1-ninad@linux.ibm.com>
 <20230522153659.3379729-2-ninad@linux.ibm.com>
 <52f72e7d-fe49-a3b9-271c-b508fa2c5a87@kaod.org>
From: Ninad Palsule <ninad@linux.vnet.ibm.com>
In-Reply-To: <52f72e7d-fe49-a3b9-271c-b508fa2c5a87@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WCeXa-6wN5Liu4CfKoZrxOh0g2nr2FNH
X-Proofpoint-ORIG-GUID: WCeXa-6wN5Liu4CfKoZrxOh0g2nr2FNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230168
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ninad@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001,
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

On 5/23/23 12:53 AM, Cédric Le Goater wrote:
> On 5/22/23 17:36, Ninad Palsule wrote:
>> The VPD data is added for system and BMC FRU. This data is fabricated.
>>
>> Tested:
>>     - The system-vpd.service is active.
>>     - VPD service related to bmc is active.
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>


Thank you for the review!

>
> Thanks,
>
> C.
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


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994470E7F6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ZsN-000239-AL; Tue, 23 May 2023 17:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q1ZsK-00022r-PS; Tue, 23 May 2023 17:49:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q1ZsI-0006mw-Uw; Tue, 23 May 2023 17:49:00 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NLea3V016106; Tue, 23 May 2023 21:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zzOPhJw31i6eRrkAnJQr3MhlNLW/hOHYKIpZwDQ5TdI=;
 b=meXdsdKvyGz1oNixZHOZOzaZ3u2y1fKzA4Ux9NOGSXbg1SMo/xKcOOOSVNBAutfwqC8t
 Qkquqzya7ZEoVTL1E+vbVDkDiF0C+25ExRQHtl+F7wRsl8Ts7MYBIXwiaTyjxQu8OWyd
 wIPigmvfESClENWsu/vssWqQ+O1tzhK620KEfbhaG30TIPMsCmZnjWY7zg4qwB19qWVH
 vN9e5U/OTddia4d1/nePhxtYsYnVFeaehdWYOqOV1bRcXiuyQbMHA0nYHpZyz4utb36e
 V6g1aa7yrqO5fesZBhJLxVssiSlDJs8CuzhmC1gWcfCcQIC08kwmUjw1KiBz5ELy+HUJ Hw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs58egg76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 21:48:43 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NL3OOQ031267;
 Tue, 23 May 2023 21:48:42 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qppdpn88r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 21:48:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34NLmesQ2884348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 21:48:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E477E58060;
 Tue, 23 May 2023 21:48:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 681A75803F;
 Tue, 23 May 2023 21:48:40 +0000 (GMT)
Received: from [9.211.84.237] (unknown [9.211.84.237])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 May 2023 21:48:40 +0000 (GMT)
Message-ID: <4a054c44-ef17-3644-e39b-3c472bf635f9@linux.vnet.ibm.com>
Date: Tue, 23 May 2023 16:48:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/1] Add vpd data for Rainier machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, peter.maydell@linaro.org, andrew@aj.id.au, joe@jms.id.au
Cc: qemu-arm@nongnu.org
References: <20230522153659.3379729-1-ninad@linux.ibm.com>
 <20230522153659.3379729-2-ninad@linux.ibm.com>
 <df00a5c0-7b59-e21c-c758-b1085d0c50b7@linaro.org>
From: Ninad Palsule <ninad@linux.vnet.ibm.com>
In-Reply-To: <df00a5c0-7b59-e21c-c758-b1085d0c50b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ttvL4xGsYf2kBGgnv-99NI3VKY22xJVo
X-Proofpoint-GUID: ttvL4xGsYf2kBGgnv-99NI3VKY22xJVo
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=590 mlxscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230173
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ninad@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hello Philippe,

On 5/23/23 3:52 AM, Philippe Mathieu-Daudé wrote:
> Hi Ninad,
>
> On 22/5/23 17:36, Ninad Palsule wrote:
>> The VPD data is added for system and BMC FRU. This data is fabricated.
>
> Per 
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message:
>
>   QEMU follows the usual standard for git commit messages: the first
>   line (which becomes the email subject line) is “subsystem: single
>   line summary of change”.
>
> In this patch the subsystem is "hw/arm", but you can also use
> "hw/arm/aspeed" or even "hw/arm/aspeed_eeprom" for subject prefix.
>
Added subsystem tag.
>> Tested:
>>     - The system-vpd.service is active.
>>     - VPD service related to bmc is active.
>
>   ... more detailed description of the patch, another blank and your
>   Signed-off-by: line.
Added more details in the description.
>
> Missing a blank line :)

Added blank line.

Thank you for the review!

>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   hw/arm/aspeed.c        |  6 ++++--
>>   hw/arm/aspeed_eeprom.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>>   hw/arm/aspeed_eeprom.h |  5 +++++
>>   3 files changed, 53 insertions(+), 3 deletions(-)


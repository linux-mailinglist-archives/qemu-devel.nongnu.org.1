Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD37117C2
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 21:59:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2H63-0002uP-HO; Thu, 25 May 2023 15:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q2H61-0002u9-K9; Thu, 25 May 2023 15:58:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q2H5y-0002CZ-N1; Thu, 25 May 2023 15:58:01 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PJn1Rx001730; Thu, 25 May 2023 19:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=K4sjjUpWu4qp8a03WcUL80jIiCG1mi7qnzMivpinndg=;
 b=FhVYFnYjYLLa7Hi1BFsawqmES2CbsKl/whqxA3U2TNX1NUXrqHIROJoFyu58fYvNq8W+
 +F25x4Oj1RV0Fe8U2l39C4glIq02EQoNeUchsG/gT2F3k0Dc68DaXlamXgDrowheQcFu
 87D7GsRBPC2y9YWAAgX6c+2j2rd4ubvHWRFqZGEulEr8yyrX7+/My/yU1EF7thYNSrlV
 1fnT+j/88wSt6FVzoxnz4Aci03YQg/ZuCQNUtIq7VjRTp04ouLATAbz9lUZJCOg/1nhp
 rI8/vtuPrJR0Mk4XnfqmC/JasGrtEBFloNw/+60nUiQwtcb1QCxTPBqBOChHs8vzOsUD 0Q== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtd681j07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 19:57:46 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34PG7Z4w030528;
 Thu, 25 May 2023 19:57:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
 by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3qppe7u624-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 19:57:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34PJviqd6095502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 19:57:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 037BD58052;
 Thu, 25 May 2023 19:57:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B96BE5805D;
 Thu, 25 May 2023 19:57:43 +0000 (GMT)
Received: from [9.61.0.148] (unknown [9.61.0.148])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 May 2023 19:57:43 +0000 (GMT)
Message-ID: <ba1e794c-ee3a-0dff-b008-7fac4b007255@linux.vnet.ibm.com>
Date: Thu, 25 May 2023 14:57:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
 Cameron Esfahani via <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9_via?= <qemu-arm@nongnu.org>
References: <20230523214520.2102894-1-ninad@linux.ibm.com>
 <20230523214520.2102894-2-ninad@linux.ibm.com>
 <7fadea2f-39e0-902f-848a-8f9bd7ff1f52@kaod.org>
 <CACPK8XeSBh+SMWPZ68rkeRnOcTFE0_SFcCNoYZr85DLhzGsgtQ@mail.gmail.com>
 <80168e3a-b0f6-463e-b473-8488a897ef16@app.fastmail.com>
 <164e53c1-03dd-a530-8c91-357a10517556@kaod.org>
From: Ninad Palsule <ninad@linux.vnet.ibm.com>
In-Reply-To: <164e53c1-03dd-a530-8c91-357a10517556@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V5zcooxMh-CO9m7koVU0Ia5i560VBeva
X-Proofpoint-ORIG-GUID: V5zcooxMh-CO9m7koVU0Ia5i560VBeva
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_12,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 mlxlogscore=822 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250165
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=ninad@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 5/25/23 1:37 AM, Cédric Le Goater wrote:
> [ ... ]
>
>> However, regarding Cédric's log above, a reboot is expected on the first
>> boot of a fresh image when there's valid VPD available. For the first
>> boot of a fresh image we configure the kernel with a minimal devicetree
>> that allows us to read the VPD data. This determines the system we're
>> actually on and configures an appropriate devicetree for subsequent
>> boots. We then reboot to pick up the new devicetree.
>
> Yes. Then, the behavior looks correct under QEMU :
>
>   https://www.kaod.org/qemu/aspeed/rainier/rainer.log
>
> Here are the services which still have with some issues :
>
> * clear-once.service                loaded failed failed          
> Clear one time boot overrides
> * ncsi-linkspeed@eth0.service       loaded failed failed          Set 
> eth0 gigabit link speed
> * ncsi-linkspeed@eth1.service       loaded failed failed          Set 
> eth1 gigabit link speed
> * obmc-flash-bios-init.service      loaded failed failed          
> Setup Host FW directories
> * system-vpd.service                loaded failed failed          
> System VPD Collection
> * trace-enable.service              loaded failed failed          
> Enable Linux trace events in the boot loader

On my system system-vpd.service was active. I couldn't run your build on 
my development machine.

I am still checking it.

>
> C.
>
>
>
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E17C71A254
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4k4m-0002Bx-At; Thu, 01 Jun 2023 11:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q4k4k-0002Bp-Dc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:18:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.vnet.ibm.com>)
 id 1q4k4i-0001Zf-Ce
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:18:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351EMNsm012479; Thu, 1 Jun 2023 14:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=w1wVGRGnQhiIsvaLLPoQ2pVm/1vr9VeVIV76ZkS7tIc=;
 b=piksCgyXYsSPmuBOXF6YOuwWWljCjQdNir1Q4ibsHCVhOjDr04tleNvqOsfikoCKqNZJ
 QGyrstJ1P7AeTiezDNf8zuyqzMTCyR7HYCENhMFPR8gianlJS4tkAfI3kL5n9MAYz3W5
 iG9SEDFd7mJmRJuMGiIhAHrjFSF4jYDob3jFU5ONmsLNEgkiqqioAmWQLZYB+xP1iN/y
 AQu63X2qBD0pqgOZ+RUTJSTBeje3uQ1Yap5MxxukdiToIucIfsk9slblLMA2VYeDAvCz
 kdLcCf6qvLPGAqnnZhJVd3JlCHAfUNDrf8o84XjswBZe2aPawXRs4CJCZLM5L3/ixLDu Ag== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxw1q8nsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 14:39:46 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351DDN2B019382;
 Thu, 1 Jun 2023 14:36:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3qu9g70dby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 14:36:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351EakEV64028972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 14:36:46 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 250AF5805A;
 Thu,  1 Jun 2023 14:36:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D25455803F;
 Thu,  1 Jun 2023 14:36:45 +0000 (GMT)
Received: from [9.61.87.138] (unknown [9.61.87.138])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 14:36:45 +0000 (GMT)
Message-ID: <57a102e4-f837-b5c5-cd77-60bf2ee945fa@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2023 09:36:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/1] hw/arm/aspeed:Add vpd data for Rainier machine
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
 <ba1e794c-ee3a-0dff-b008-7fac4b007255@linux.vnet.ibm.com>
 <72d241c8-635c-0c8d-4822-15a35fb9748d@kaod.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.vnet.ibm.com>
In-Reply-To: <72d241c8-635c-0c8d-4822-15a35fb9748d@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fz-WIqeBeiyKgMwWOTM7J0m2quDyNBXm
X-Proofpoint-ORIG-GUID: fz-WIqeBeiyKgMwWOTM7J0m2quDyNBXm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010128
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=ninad@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/26/23 1:18 AM, Cédric Le Goater wrote:
> On 5/25/23 21:57, Ninad Palsule wrote:
>> Hello Cedric,
>>
>>
>> On 5/25/23 1:37 AM, Cédric Le Goater wrote:
>>> [ ... ]
>>>
>>>> However, regarding Cédric's log above, a reboot is expected on the 
>>>> first
>>>> boot of a fresh image when there's valid VPD available. For the first
>>>> boot of a fresh image we configure the kernel with a minimal 
>>>> devicetree
>>>> that allows us to read the VPD data. This determines the system we're
>>>> actually on and configures an appropriate devicetree for subsequent
>>>> boots. We then reboot to pick up the new devicetree.
>>>
>>> Yes. Then, the behavior looks correct under QEMU :
>>>
>>>   https://www.kaod.org/qemu/aspeed/rainier/rainer.log
>>>
>>> Here are the services which still have with some issues :
>>>
>>> * clear-once.service                loaded failed failed Clear one 
>>> time boot overrides
>>> * ncsi-linkspeed@eth0.service       loaded failed failed          
>>> Set eth0 gigabit link speed
>>> * ncsi-linkspeed@eth1.service       loaded failed failed          
>>> Set eth1 gigabit link speed
>>> * obmc-flash-bios-init.service      loaded failed failed Setup Host 
>>> FW directories
>>> * system-vpd.service                loaded failed failed System VPD 
>>> Collection
>>> * trace-enable.service              loaded failed failed Enable 
>>> Linux trace events in the boot loader
>>
>> On my system system-vpd.service was active. I couldn't run your build 
>> on my development machine.
>
> That's how I run it :
>
>   qemu-system-arm -M rainier-bmc -net user -drive 
> file=./mmc-p10bmc.qcow2,format=qcow2,if=sd,id=sd2,index=2 -nographic 
> -snapshot -serial mon:stdio
>
> You will need to use my branch to have emmc support.
ok, Thanks you!
>
> Thanks,
>
> C.
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2778753E1D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 16:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKK9C-0003Cu-8O; Fri, 14 Jul 2023 10:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKK94-0003CW-E4
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:51:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qKK92-0005NI-Rr
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 10:51:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36EEe3Vt006924; Fri, 14 Jul 2023 14:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bQAvDYkN26IFPkfI/s6AULUVCsYeNx/tQOmI6/8k/jQ=;
 b=eX/iIvn1cl9B5zVvi2Y5MTDWyM2Ikkeqy/xg1uSKsYRRxY6TPpog7Ac2Dw1ay2i3sqhs
 7L9VJgmK/oMGQqSRlPNuTdzYcbul+9uEqggaTuMX1rs3ipQz5PjNNoQ+BUaK55jDIl6e
 ZmMGBHxEbo+72ROsJmVuxLxDHpnySRNKmC4Xvyoas/mV9zqw5w0QUV078cOCBvqJpaNu
 D8w1bLjCizSEGhLAlmzOXQE9A+SznkGAUIvgJGpoiVLImNK9zJr7BUbWPMpwdhIgLjcB
 +5toMl2bfi7jWR3uSVGvkvLoFd4c9pZcxweKCqDKwKL5JNdt50htz5jCLexb9b0aC8Ar qg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ru8058rfx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 14:51:41 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36ECQdSI002933;
 Fri, 14 Jul 2023 14:51:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
 by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rtqjkm263-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Jul 2023 14:51:38 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36EEpbFd22545146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Jul 2023 14:51:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5CAC5804B;
 Fri, 14 Jul 2023 14:51:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83D4258059;
 Fri, 14 Jul 2023 14:51:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 14 Jul 2023 14:51:37 +0000 (GMT)
Message-ID: <fe8ea892-0690-2308-5036-f31e10da0351@linux.ibm.com>
Date: Fri, 14 Jul 2023 10:51:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 11/11] tpm_crb: support restoring older vmstate
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-12-j@getutm.app>
 <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
In-Reply-To: <581b037d-ccb7-8df7-8946-df8198cb04e6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7qlIOdo_c4iLQuwgDqucy_gY_tVCX9mf
X-Proofpoint-ORIG-GUID: 7qlIOdo_c4iLQuwgDqucy_gY_tVCX9mf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=870 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140132
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 7/14/23 10:05, Stefan Berger wrote:
> 
> 
> On 7/14/23 03:09, Joelle van Dyne wrote:
>> When we moved to a single mapping and modified TPM CRB's VMState, it
>> broke restoring of VMs that were saved on an older version. This
>> change allows those VMs to gracefully migrate to the new memory
>> mapping.
> 
> Thanks. This has to be in 4/11 though.
> 

After applying the whole series and trying to resume state taken with current git
master I cannot restore it but it leads to this error here. I would just leave it
completely untouched in 4/11.

2023-07-14T14:46:34.547550Z qemu-system-x86_64: Unknown ramblock "tpm-crb-cmd", cannot accept migration
2023-07-14T14:46:34.547799Z qemu-system-x86_64: error while loading state for instance 0x0 of device 'ram'
2023-07-14T14:46:34.547835Z qemu-system-x86_64: load of migration failed: Invalid argument

    Stefan


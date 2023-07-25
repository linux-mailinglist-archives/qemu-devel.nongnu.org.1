Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0828A760D73
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:45:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qODep-0001cX-Ok; Tue, 25 Jul 2023 04:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qODel-0001ab-Q9; Tue, 25 Jul 2023 04:44:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qODek-0004vF-75; Tue, 25 Jul 2023 04:44:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36P89UX9001172; Tue, 25 Jul 2023 08:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/tUaBBZ3+TiGbnVEyeuh5DSVPWs3Npkig74UNe50P6M=;
 b=CaB0jraQJFzWC+STP8crZBspFtS+dhR+eQvH4dGyhsRAxtdo+tL9vGaN//nIaR6jGDfP
 cU2bxA/E7+kHQm8yivbPFgtN8ENcpYiDn1NTS9GD3ScQ86v5KBGBFYBY1KAB71p+eU65
 rGbsTncZrey7y3eOCQAG62pi/t0TYzaQdeidsLP9f7mBo8+JYZGB6sjRK+CHuADxhpef
 XLagGz1S4nj5o2k2mRAEiFeSIXrJrJPJIroMuDOYbT81prvo3KFUX+ub8+M39NLw6MQ7
 HNRSiOdsBQcOklhzkpiVacf3Z4fwXM8pqTl0RRKwdR6V6DitycDh6Sy9w19zHg2ao46X sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s261detjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 08:44:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36P8Xiuo024365;
 Tue, 25 Jul 2023 08:44:30 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s261detj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 08:44:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36P7EJ4G002379; Tue, 25 Jul 2023 08:44:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unja503-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Jul 2023 08:44:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36P8iPDC59310554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jul 2023 08:44:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E87820043;
 Tue, 25 Jul 2023 08:44:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6A2120040;
 Tue, 25 Jul 2023 08:44:23 +0000 (GMT)
Received: from [9.179.30.40] (unknown [9.179.30.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Jul 2023 08:44:23 +0000 (GMT)
Message-ID: <5d189aee-2d75-db31-89a3-11d60f001564@linux.ibm.com>
Date: Tue, 25 Jul 2023 10:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 02/20] s390x/cpu topology: add topology entries on CPU
 hotplug
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-3-pmorel@linux.ibm.com>
 <0743d96760a7b3d8d79ed1443c26896eac6a1a13.camel@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <0743d96760a7b3d8d79ed1443c26896eac6a1a13.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o6nOilthFBY8OEhwi5r3RgBxf3VUMDbm
X-Proofpoint-ORIG-GUID: aAAouNWCx2lJMztGZlf9ILQlnh9U7K1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0
 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250075
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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


On 7/24/23 22:19, Nina Schoetterl-Glausch wrote:
> On Fri, 2023-06-30 at 11:17 +0200, Pierre Morel wrote:
>> The topology information are attributes of the CPU and are
>> specified during the CPU device creation.
>>
>> On hot plug we:
>> - calculate the default values for the topology for drawers,
>>    books and sockets in the case they are not specified.
>> - verify the CPU attributes
>> - check that we have still room on the desired socket
>>
>> The possibility to insert a CPU in a mask is dependent on the
>> number of cores allowed in a socket, a book or a drawer, the
>> checking is done during the hot plug of the CPU to have an
>> immediate answer.
>>
>> If the complete topology is not specified, the core is added
>> in the physical topology based on its core ID and it gets
>> defaults values for the modifier attributes.
>>
>> This way, starting QEMU without specifying the topology can
>> still get some advantage of the CPU topology.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com> if you address
> Thomas' comments.
>
Thanks,

regards

Pierre



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B47227AB2AF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgCT-0002ji-Ur; Fri, 22 Sep 2023 09:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qjgCR-0002ft-HV
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:28:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qjgCP-000733-OW
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:28:03 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MDGJRa027289
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 13:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WfZlpUG1+sFrR7ZXvngZ8v58ocl6dp+tlgCxvldzosQ=;
 b=sCRdSj4UJe0Cl9330T77KPiRDjAVJowuz6bzwPu+ICzQZK7AjzFwc6buJ3HgjYHKdg2V
 IUUPYlcJkIeyXNii4+Bpc7Ssgn5QL6hIrstJRaHsVUJeDKbjpptxtD/bTNjhaf1HRpOp
 2fVrkQjmkNQYorebMssyICUKzSfrOGpfVmRGeqIav+7MPYt5A37lvqxZT1zA9QjLAB+f
 /QwyaxIA/pWAWy+dVoo/B5lu4Wo2D984Xyh1xrKvIUoi6GxQKmb2b+Jiu5oGzZP5/9Pr
 08QpjsUc/Wv7QbT3SU+3d+/484CcYs54jk1zKV+3tGaHTVKgxLfMnxnl8K2GKD4ZI3vs 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9aauaj3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 13:28:00 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38MDGhC6030700
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 13:27:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t9aauaj3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 13:27:59 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38MDJPjg029819; Fri, 22 Sep 2023 13:27:59 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t8tsp2qjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Sep 2023 13:27:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38MDRwUQ787122
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Sep 2023 13:27:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 687DE58056;
 Fri, 22 Sep 2023 13:27:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 272A358063;
 Fri, 22 Sep 2023 13:27:58 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 22 Sep 2023 13:27:58 +0000 (GMT)
Message-ID: <b2d53350-ce67-4c29-5d3d-6dee6484c8ed@linux.ibm.com>
Date: Fri, 22 Sep 2023 09:27:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 2/2] tpm: add backend for mssim
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 James Bottomley <jejb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-3-jejb@linux.ibm.com> <87bkduwxv7.fsf@pond.sub.org>
 <2629ce63-e4dd-67f3-6341-d477c39b29f7@linux.ibm.com>
 <ZQ2QdBr1a90RX7Wm@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ZQ2QdBr1a90RX7Wm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: clMEohsIboDlfaCXoLl5qKuq6x49k_i1
X-Proofpoint-GUID: Y_bFuAXRH1CIwLFdh4GAJ6UePoEc7PHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_11,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=840
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220111
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/22/23 09:02, Daniel P. Berrangé wrote:
> On Fri, Sep 22, 2023 at 08:41:19AM -0400, Stefan Berger wrote:
>> On 9/22/23 02:00, Markus Armbruster wrote:
>>> Found this cleaning out old mail, sorry for missing it until now!
>>>
>>> I think we owe James a quick decision wether we're willing to take the
>>> feature.  Stefan, thoughts?
>> I thought we discusses it back then. Does it handle snapshotting and
>> migration correctly?
> To quote the patch itself:
>
>    +The mssim backend supports snapshotting and migration, but the state
>    +of the Microsoft Simulator server must be preserved (or the server
>    +kept running) outside of QEMU for restore to be successful.

How does 'it' support snapshotting where the state of the TPM can be 
completely different depending on the snapshot?  I know what it took to 
support this feature with swtpm/libtpms but I don't see the equivalent 
here in this backend driver nor in the TCG reference code that the 
underlying TPM 2 simulator is based upon.

I do not want to stand in the way of it being merged but please 
understand that I will also neither maintain nor fix bugs related to it 
nor its related underlying simulator -- with James being the maintainer 
of it, this should be clear. I have reason why I am saying this and they 
come from dealing with the upstream TPM 2 reference code.

Thanks,

   Stefan


>
> With regards,
> Daniel


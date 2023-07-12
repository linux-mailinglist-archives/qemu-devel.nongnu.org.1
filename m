Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F689750D70
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:04:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJcIa-0000Ku-Rm; Wed, 12 Jul 2023 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJcIV-0000Fg-9c; Wed, 12 Jul 2023 12:02:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJcIT-00050d-9Y; Wed, 12 Jul 2023 12:02:35 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36CFxsbP019210; Wed, 12 Jul 2023 16:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=B0a3O51e+ycrh1ypigGI0a93OWYLKKYUz1aSCWWqqyE=;
 b=lxC59YpNfYsuh6tzw/1QLv9s88t7Y5iEK1HrDlXqgxw4vWUkJjPAjay4eW7+AYNbOBJ/
 heYTvygwH2e8AZHqlSm71HitcTc04/CdBpq7ihmL6xjfZ0JqH5Wr0HWbtF3yUj4RbIl/
 lA3nmrTqrgAUcrT9XYCbMANVz485JGdl0113qs/axGxJlHFrM8Y7wi0bgxC46i5ZcsWp
 bLn09JUiNdF5y5BDYji2A9wfSAl7aJ7CtZBpqGrbNOQAlU0sv/OurXAKgAW/wxmh1f8b
 ojBxCMBDtoJUzsUsM35OZJoEJpKK/xE/d0RQp5kAKV1W2P7tgSeBrZmlONKNKvsdACRW yA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsya5032d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 16:02:21 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CG05nN019739;
 Wed, 12 Jul 2023 16:02:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsya50305-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 16:02:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C7611X024617;
 Wed, 12 Jul 2023 16:02:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rpy2e2r48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 16:02:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36CG2CVL21365464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jul 2023 16:02:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B65332004B;
 Wed, 12 Jul 2023 16:02:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F66120043;
 Wed, 12 Jul 2023 16:02:12 +0000 (GMT)
Received: from [9.152.222.242] (unknown [9.152.222.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Jul 2023 16:02:12 +0000 (GMT)
Message-ID: <8c275ab7-f0f7-b9b8-d4cf-9df2678648be@linux.ibm.com>
Date: Wed, 12 Jul 2023 18:02:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 10/20] machine: adding s390 topology to info
 hotpluggable-cpus
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-11-pmorel@linux.ibm.com>
 <843e8472-3af9-ccc5-f6b3-3423d67b9d8a@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <843e8472-3af9-ccc5-f6b3-3423d67b9d8a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hi0AZz9z3FJqgNICwLToZnB9mUuEWo1I
X-Proofpoint-GUID: WwoaLAlEik-YCDeIjYP8R2hZiPmPTAAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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


On 7/4/23 14:59, Thomas Huth wrote:
> On 30/06/2023 11.17, Pierre Morel wrote:
>> S390 topology adds books and drawers topology containers.
>> Let's add these to the HMP information for hotpluggable cpus.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> ---
>>   hw/core/machine-hmp-cmds.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
>> index c3e55ef9e9..f247ba3206 100644
>> --- a/hw/core/machine-hmp-cmds.c
>> +++ b/hw/core/machine-hmp-cmds.c
>> @@ -71,6 +71,12 @@ void hmp_hotpluggable_cpus(Monitor *mon, const 
>> QDict *qdict)
>>           if (c->has_node_id) {
>>               monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", 
>> c->node_id);
>>           }
>> +        if (c->has_drawer_id) {
>> +            monitor_printf(mon, "    drawer-id: \"%" PRIu64 "\"\n", 
>> c->drawer_id);
>> +        }
>> +        if (c->has_book_id) {
>> +            monitor_printf(mon, "      book-id: \"%" PRIu64 "\"\n", 
>> c->book_id);
>
> I think the output should be left-aligned (with four spaces at the 
> beginning), not right aligned to the colons?
>
>  Thomas
>

I think you are right, core-id is not aligned on the colons.

thanks,

Pierre


>
>> +        }
>>           if (c->has_socket_id) {
>>               monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", 
>> c->socket_id);
>>           }
>
>


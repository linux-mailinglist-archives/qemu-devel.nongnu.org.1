Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C087759180
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:26:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3QN-0005D9-TR; Wed, 19 Jul 2023 05:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qM3QG-0005Ci-Lb; Wed, 19 Jul 2023 05:24:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qM3Q6-0001UZ-ET; Wed, 19 Jul 2023 05:24:40 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J991q2012509; Wed, 19 Jul 2023 09:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j5EQgkiJNNE+OuadIU2oS5Y86zKvzpxJyDMHhiyOyXw=;
 b=JDsVqZcev0uie3dDYjoAQxuhp0UC5OlPDgOFkxTCE0J69Hz0JX45dZIxDOAXqSRD1Glf
 P334u8pmfZlIdd/yLVaXT+fAFlvo9Tj+eIDWP+rToUoC7D7lHOCzpB9S1XQJ3yPAO0vX
 9rSGSF5RJbS43OksBXKX4Jcwo8Mch5uH1aaAs9E7n0p3jpn1ylAJuZ0aq4TE+Q2eeEzS
 NpiXwH/cpUv1VXI7l1wd7H0rZo5biYQO1YoSTSEwpTANRkN/HJ0AxZXwd4B8RNrlVWMo
 XSfatER4dvXYIFZENocUgPIHhl1tCaOezpIYNFZ1kl1kCJ4SpqX/MtpucrCRsGyMbrGu 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxc8e18td-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:24:25 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J996NP013115;
 Wed, 19 Jul 2023 09:24:24 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxc8e18sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:24:24 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36J8A5FN016870; Wed, 19 Jul 2023 09:24:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srsw39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 09:24:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36J9OJ7d44958304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 09:24:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B77CE2004B;
 Wed, 19 Jul 2023 09:24:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AFEC20043;
 Wed, 19 Jul 2023 09:24:19 +0000 (GMT)
Received: from [9.155.200.205] (unknown [9.155.200.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Jul 2023 09:24:19 +0000 (GMT)
Message-ID: <276a3723-9fb0-3b3a-24e0-05668e97aa8d@linux.ibm.com>
Date: Wed, 19 Jul 2023 11:24:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 14/20] tests/avocado: s390x cpu topology core
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-15-pmorel@linux.ibm.com>
 <3ea3a276-a06a-b1b3-bc88-662c94d240e0@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <3ea3a276-a06a-b1b3-bc88-662c94d240e0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: msbojhcbm2bWXAmiPPjsvKXw1IbMkNlQ
X-Proofpoint-ORIG-GUID: KGlJRsjBRLEk1pFXjIbzudUlYXg_qJsZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_05,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1011
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


On 7/4/23 15:14, Thomas Huth wrote:
> On 30/06/2023 11.17, Pierre Morel wrote:
>> Introduction of the s390x cpu topology core functions and
>> basic tests.
>>
>> We test the corelation between the command line and
>> the QMP results in query-cpus-fast for various CPU topology.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   MAINTAINERS                    |   1 +
>>   tests/avocado/s390_topology.py | 196 +++++++++++++++++++++++++++++++++
>>   2 files changed, 197 insertions(+)
>>   create mode 100644 tests/avocado/s390_topology.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 76f236564c..12d0d7bd91 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1705,6 +1705,7 @@ F: hw/s390x/cpu-topology.c
>>   F: target/s390x/kvm/stsi-topology.c
>>   F: docs/devel/s390-cpu-topology.rst
>>   F: docs/system/s390x/cpu-topology.rst
>> +F: tests/avocado/s390_topology.py
>>     X86 Machines
>>   ------------
>> diff --git a/tests/avocado/s390_topology.py 
>> b/tests/avocado/s390_topology.py
>> new file mode 100644
>> index 0000000000..1758ec1f13
>> --- /dev/null
>> +++ b/tests/avocado/s390_topology.py
>> @@ -0,0 +1,196 @@
>> +# Functional test that boots a Linux kernel and checks the console
>> +#
>> +# Copyright IBM Corp. 2023
>> +#
>> +# Author:
>> +#  Pierre Morel <pmorel@linux.ibm.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import os
>> +import shutil
>> +import time
>> +
>> +from avocado_qemu import QemuSystemTest
>> +from avocado_qemu import exec_command
>> +from avocado_qemu import exec_command_and_wait_for_pattern
>> +from avocado_qemu import interrupt_interactive_console_until_pattern
>> +from avocado_qemu import wait_for_console_pattern
>> +from avocado.utils import process
>> +from avocado.utils import archive
>> +
>> +
>> +class S390CPUTopology(QemuSystemTest):
>> +    """
>> +    S390x CPU topology consist of 4 topology layers, from bottom to 
>> top,
>> +    the cores, sockets, books and drawers and 2 modifiers attributes,
>> +    the entitlement and the dedication.
>> +    See: docs/system/s390x/cpu-topology.rst.
>> +
>> +    S390x CPU topology is setup in different ways:
>> +    - implicitely from the '-smp' argument by completing each topology
>
> implicitly
>
>> +      level one after the other begining with drawer 0, book 0 and 
>> socket 0.
>
> beginning
>
>> +    - explicitely from the '-device' argument on the QEMU command line
>
> explicitly
>
>> +    - explicitely by hotplug of a new CPU using QMP or HMP
>
> explicitly
>
>  Thomas
>

Thanks, I make the corrections.

Pierre



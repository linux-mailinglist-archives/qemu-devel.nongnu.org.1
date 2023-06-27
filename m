Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5273FC7E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8SU-0000zh-AN; Tue, 27 Jun 2023 09:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qE8SN-0000ht-9M; Tue, 27 Jun 2023 09:10:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qE8SJ-0000JY-Gr; Tue, 27 Jun 2023 09:10:06 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35RCqAAI015410; Tue, 27 Jun 2023 13:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Pyo07U2Fl8Z/I3gqGM8gfyVpc4U4oAJUArirR9V5IeM=;
 b=LhAx2HHNmlhDHafsDom1Gcw0PufOfxatu31wrAUfwDdtFk0mhUX8Hwi4PqZCAt7MP3Qn
 3hJJuKCskMKt2WDuDzkvUbxJlLOJei0vhWaG8aVwC64B56RGUW7egmKMZ7C3i/Q+D3Gg
 Y0FB25aoulcDoVmPsX+Qm6vndz/njwZlujxr8kzAYAjRrtove446e58UbyBjIVGHuKNR
 HUyDMhSxgPfgpmziCNuzFCo6boBNDeqOb2JkwnAjee+Mb2BBIGgqI+0TlnpRDpfTb8Fo
 gQ1S280zeJad6DqSQCzkuPbRZFdDS7kkalg2tkFOmiPudGPJo105eLtlhjGf+MzL8O9g rw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rg057rhpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 13:09:57 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35RD5Wrx011641;
 Tue, 27 Jun 2023 13:09:41 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rg057rdpy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 13:09:41 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35RB8Ppt018953;
 Tue, 27 Jun 2023 13:01:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rdr451e0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Jun 2023 13:01:37 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35RD1V4s61604096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Jun 2023 13:01:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21A312004D;
 Tue, 27 Jun 2023 13:01:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90E7020049;
 Tue, 27 Jun 2023 13:01:30 +0000 (GMT)
Received: from [9.152.222.242] (unknown [9.152.222.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 27 Jun 2023 13:01:30 +0000 (GMT)
Message-ID: <17761625-f0fe-28a4-e783-3a7615ab9e55@linux.ibm.com>
Date: Tue, 27 Jun 2023 15:01:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v20 15/21] tests/avocado: s390x cpu topology polarisation
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230425161456.21031-1-pmorel@linux.ibm.com>
 <20230425161456.21031-16-pmorel@linux.ibm.com>
 <b695a55e294038b2a9e300031f27a74c36b49b5d.camel@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <b695a55e294038b2a9e300031f27a74c36b49b5d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HukngIda67lpjNQFx8NV8fC9IzGMKbS_
X-Proofpoint-GUID: 0JfhbpVeNn9Gv0L1lqpjbrLpHuGzWYLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306270121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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


On 5/22/23 21:45, Nina Schoetterl-Glausch wrote:
> Try to be consistent in the spelling of polarization.
> You use an s in the title and in the test name below.
>
> On Tue, 2023-04-25 at 18:14 +0200, Pierre Morel wrote:
>> Polarization is changed on a request from the guest.
>> Let's verify the polarization is accordingly set by QEMU.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   tests/avocado/s390_topology.py | 38 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
>> index ce119a095e..30d3c0d0cb 100644
>> --- a/tests/avocado/s390_topology.py
>> +++ b/tests/avocado/s390_topology.py
>> @@ -104,6 +104,15 @@ def kernel_init(self):
>>                            '-initrd', initrd_path,
>>                            '-append', kernel_command_line)
>>   
>> +    def system_init(self):
>> +        self.log.info("System init")
>> +        exec_command(self, 'mount proc -t proc /proc')
>> +        time.sleep(0.2)
>> +        exec_command(self, 'mount sys -t sysfs /sys')
>> +        time.sleep(0.2)
>> +        exec_command_and_wait_for_pattern(self,
>> +                '/bin/cat /sys/devices/system/cpu/dispatching', '0')
>> +
>>       def test_single(self):
>>           self.kernel_init()
>>           self.vm.launch()
>> @@ -206,3 +215,32 @@ def test_hotplug_full(self):
>>           self.check_topology(3, 1, 1, 1, 'high', False)
>>           self.check_topology(4, 1, 1, 1, 'medium', False)
>>           self.check_topology(5, 2, 1, 1, 'high', True)
>> +
>> +    def test_polarisation(self):
> I would unite this test with test_query_polarization, they are very similar.


Yes I find now that this test is of little interest.

I will merge it with test_query_polarization as you propose.

it is much better as man can see that the

>
>> +        """
>> +        This test verifies that QEMU modifies the entitlement change after
>> +        several guest polarization change requests.
>> +
>> +        :avocado: tags=arch:s390x
>> +        :avocado: tags=machine:s390-ccw-virtio
>> +        """
>> +        self.kernel_init()
>> +        self.vm.launch()
>> +        self.wait_for_console_pattern('no job control')
>> +
>> +        self.system_init()
>> +        self.check_topology(0, 0, 0, 0, 'medium', False)
>> +
>> +        exec_command(self, 'echo 1 > /sys/devices/system/cpu/dispatching')
>> +        time.sleep(0.2)
> Can you find a way to wait for the event here?


Right, I can wait for CPU_POLARIZATION_CHANGE


>
>> +        exec_command_and_wait_for_pattern(self,
>> +                '/bin/cat /sys/devices/system/cpu/dispatching', '1')
> I think it would be good to refactor this snippet into a function.
>
> def guest_set_dispatching(self, dispatching):
>          exec_command(self, f'echo {dispatching} > /sys/devices/system/cpu/dispatching')
>          #TODO wait
>          exec_command_and_wait_for_pattern(self,
>                  '/bin/cat /sys/devices/system/cpu/dispatching', dispatching)
>
> or similar, you could also put the path into a variable.


Yes good, I do this

Thanks Nina.

Regards,

Pierre



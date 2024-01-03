Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE0822CF3
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:24:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL0HG-0003kL-Ch; Wed, 03 Jan 2024 07:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowsjois@linux.vnet.ibm.com>)
 id 1rL0HD-0003jR-UJ; Wed, 03 Jan 2024 07:23:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowsjois@linux.vnet.ibm.com>)
 id 1rL0HB-0006xi-Sv; Wed, 03 Jan 2024 07:23:15 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403Bh6Ps026278; Wed, 3 Jan 2024 12:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=pp1; bh=s8gB57DJHWAa3S4og3HWARwbbHbA5ER5H6wpJwwXkro=;
 b=K5DpB1nD9k2CEKjdly8E4TvUUjVT/CqQCVLndLtt+rrURTgtLlMJRiI59WfXJVm9mpnx
 tNKA+aj1IUpWt/trTYCD/tu9KLVqDlPYuugVRuNnZKTNdA7eSRa0pATHx6jJKfYiyuck
 vlP2mruXpJERzs4jByvmxhuiQbooW33A2qQB9pQc9l8CLD/d9kjI8HTPmHkSfY5ePB1g
 Tqd+MnXlkF8QBF5mxU3sTr09fvGoW5BQXwBQssXzj/Cz/Uzw+s+/4bXGBySlSQRiel07
 e4wbD3xXNrbKnMUkSLZENSLa6A83UTj7Bzjng7jd+PPBIBGugmb6KCb0ZX4fknE6Zx6N 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd6xwsacm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 12:23:06 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403CN23t018958;
 Wed, 3 Jan 2024 12:23:06 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd6xwsacc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 12:23:06 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 403C3uf1017981; Wed, 3 Jan 2024 12:23:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vayrkjh4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jan 2024 12:23:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 403CN3T837749310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jan 2024 12:23:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B3A5F20043;
 Wed,  3 Jan 2024 12:23:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CF8520040;
 Wed,  3 Jan 2024 12:23:02 +0000 (GMT)
Received: from [9.43.62.72] (unknown [9.43.62.72])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  3 Jan 2024 12:23:01 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------R806MJOAAw0Sa9p8G8ZxVmlz"
Message-ID: <a2727f05-a287-4691-9667-a6dbdf025576@linux.vnet.ibm.com>
Date: Wed, 3 Jan 2024 17:53:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ppc/spapr: Initialize max_cpus limit to
 SPAPR_IRQ_NR_IPIS.
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, npiggin@gmail.com,
 qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au, qemu-devel@nongnu.org
References: <20231123055733.1002890-1-harshpb@linux.ibm.com>
 <20231123055733.1002890-3-harshpb@linux.ibm.com>
 <e320f1d3-7f8e-4d75-b10a-35d54d4ee26a@kaod.org>
From: Kowshik Jois B S <kowsjois@linux.vnet.ibm.com>
In-Reply-To: <e320f1d3-7f8e-4d75-b10a-35d54d4ee26a@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: liUXjDAkdQwR0bQFjD7gw5_ju8PZXHMe
X-Proofpoint-ORIG-GUID: 0Ib73dWaxJjmeTGnMFnpS8uyhPbyqNTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_06,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030102
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowsjois@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------R806MJOAAw0Sa9p8G8ZxVmlz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 23/11/23 14:21, Cédric Le Goater wrote:
> On 11/23/23 06:57, Harsh Prateek Bora wrote:
>> Initialize the machine specific max_cpus limit as per the maximum range
>> of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
>> free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
>> assert in tcg_region_init or spapr_xive_claim_irq.
>>
>> Logs:
>>
>> Without patch fix:
>>
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>> qemu-system-ppc64: IRQ 4096 is not free
>> [root@host build]#
>>
>> On LPAR:
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>> **
>> ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>> (region_size >= 2 * page_size)
>> Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
>> (region_size >= 2 * page_size)
>> Aborted (core dumped)
>> [root@host build]#
>>
>> On x86:
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
>> qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
>> Assertion `lisn < xive->nr_irqs' failed.
>> Aborted (core dumped)
>> [root@host build]#
>>
>> With patch fix:
>> [root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
>> qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
>> machine 'pseries-8.2' is 4096
>> [root@host build]#
>>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>
> Thanks,
>
> C.
>
>
>
>> ---
>>   hw/ppc/spapr.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>> index df09aa9d6a..222d926f46 100644
>> --- a/hw/ppc/spapr.c
>> +++ b/hw/ppc/spapr.c
>> @@ -4647,13 +4647,10 @@ static void 
>> spapr_machine_class_init(ObjectClass *oc, void *data)
>>       mc->block_default_type = IF_SCSI;
>>         /*
>> -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
>> -     * should be limited by the host capability instead of hardcoded.
>> -     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
>> -     * guests are welcome to have as many CPUs as the host are capable
>> -     * of emulate.
>> +     * While KVM determines max cpus in kvm_init() using 
>> kvm_max_vcpus(),
>> +     * In TCG the limit is restricted by the range of CPU IPIs 
>> available.
>>        */
>> -    mc->max_cpus = INT32_MAX;
>> +    mc->max_cpus = SPAPR_IRQ_NR_IPIS;
>>         mc->no_parallel = 1;
>>       mc->default_boot_order = "";
>
> I've applied these patches and verified on the latest upstream qemu. 
> The code is working as expected. Tested-by: Kowshik 
> Jois<kowsjois@linux.ibm.com>




--------------R806MJOAAw0Sa9p8G8ZxVmlz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 23/11/23 14:21, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:e320f1d3-7f8e-4d75-b10a-35d54d4ee26a@kaod.org">On
      11/23/23 06:57, Harsh Prateek Bora wrote:
      <br>
      <blockquote type="cite">Initialize the machine specific max_cpus
        limit as per the maximum range
        <br>
        of CPU IPIs available. Keeping between 4096 to 8192 will throw
        IRQ not
        <br>
        free error due to XIVE/XICS limitation and keeping beyond 8192
        will hit
        <br>
        assert in tcg_region_init or spapr_xive_claim_irq.
        <br>
        <br>
        Logs:
        <br>
        <br>
        Without patch fix:
        <br>
        <br>
        [root@host build]# qemu-system-ppc64 -accel tcg -smp
        10,maxcpus=4097
        <br>
        qemu-system-ppc64: IRQ 4096 is not free
        <br>
        [root@host build]#
        <br>
        <br>
        On LPAR:
        <br>
        [root@host build]# qemu-system-ppc64 -accel tcg -smp
        10,maxcpus=8193
        <br>
        **
        <br>
        ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
        <br>
        (region_size &gt;= 2 * page_size)
        <br>
        Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion
        failed:
        <br>
        (region_size &gt;= 2 * page_size)
        <br>
        Aborted (core dumped)
        <br>
        [root@host build]#
        <br>
        <br>
        On x86:
        <br>
        [root@host build]# qemu-system-ppc64 -accel tcg -smp
        10,maxcpus=8193
        <br>
        qemu-system-ppc64: ../hw/intc/spapr_xive.c:596:
        spapr_xive_claim_irq:
        <br>
        Assertion `lisn &lt; xive-&gt;nr_irqs' failed.
        <br>
        Aborted (core dumped)
        <br>
        [root@host build]#
        <br>
        <br>
        With patch fix:
        <br>
        [root@host build]# qemu-system-ppc64 -accel tcg -smp
        10,maxcpus=4097
        <br>
        qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported
        by
        <br>
        machine 'pseries-8.2' is 4096
        <br>
        [root@host build]#
        <br>
        <br>
        Signed-off-by: Harsh Prateek Bora <a class="moz-txt-link-rfc2396E" href="mailto:harshpb@linux.ibm.com">&lt;harshpb@linux.ibm.com&gt;</a>
        <br>
      </blockquote>
      <br>
      <br>
      Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
      <br>
      <br>
      <blockquote type="cite">---
        <br>
          hw/ppc/spapr.c | 9 +++------
        <br>
          1 file changed, 3 insertions(+), 6 deletions(-)
        <br>
        <br>
        diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
        <br>
        index df09aa9d6a..222d926f46 100644
        <br>
        --- a/hw/ppc/spapr.c
        <br>
        +++ b/hw/ppc/spapr.c
        <br>
        @@ -4647,13 +4647,10 @@ static void
        spapr_machine_class_init(ObjectClass *oc, void *data)
        <br>
              mc-&gt;block_default_type = IF_SCSI;
        <br>
                /*
        <br>
        -     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus
        values
        <br>
        -     * should be limited by the host capability instead of
        hardcoded.
        <br>
        -     * max_cpus for KVM guests will be checked in kvm_init(),
        and TCG
        <br>
        -     * guests are welcome to have as many CPUs as the host are
        capable
        <br>
        -     * of emulate.
        <br>
        +     * While KVM determines max cpus in kvm_init() using
        kvm_max_vcpus(),
        <br>
        +     * In TCG the limit is restricted by the range of CPU IPIs
        available.
        <br>
               */
        <br>
        -    mc-&gt;max_cpus = INT32_MAX;
        <br>
        +    mc-&gt;max_cpus = SPAPR_IRQ_NR_IPIS;
        <br>
                mc-&gt;no_parallel = 1;
        <br>
              mc-&gt;default_boot_order = "";
        <br>
      </blockquote>
      <br>
      <pre id="b"
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
      class="q"
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 102);">I've applied these patches and verified on the latest upstream qemu. The code is working as expected.

Tested-by: Kowshik Jois<a class="moz-txt-link-rfc2396E" href="mailto:kowsjois@linux.ibm.com">&lt;kowsjois@linux.ibm.com&gt;</a>
</span></pre>
    </blockquote>
    <p><br>
    </p>
    <p><br>
    </p>
    <br>
    <blockquote type="cite"
      cite="mid:e320f1d3-7f8e-4d75-b10a-35d54d4ee26a@kaod.org">
      <pre id="b"
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
      class="q"
style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 102);">
</span></pre>
    </blockquote>
  </body>
</html>

--------------R806MJOAAw0Sa9p8G8ZxVmlz--



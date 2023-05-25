Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B37103F8
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 06:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q22P6-0006cE-Bu; Thu, 25 May 2023 00:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1q22P2-0006bc-0l; Thu, 25 May 2023 00:16:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1q22Oz-0002JZ-7U; Thu, 25 May 2023 00:16:39 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34P4A36J030020; Thu, 25 May 2023 04:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=pp1; bh=AZ4WA1ObwPxymNTKsrGVqWteNfJGkwq4grCMf9BZLBU=;
 b=j+wZ0xk3WcCPQZLisaoQhjII/r2BOlvvjEj/peJj9ERdYMYMrk8Psaa95Fpvz391u19v
 hFuayBmrAghFpsSGZhzCWxRmUbYb1kMbVvKLbWii9b2pV0DCm7dlEb7RT3zLDN3oMyl2
 ACIHIqX4UdKkINXSt2cZNM9OtKX2xVeDsaFm4LLviz6GeZKKZUFr6d4jvPt9yaM6G6yt
 kR9EITNfU5pxpEjXEJ/ZyjKoTAyrXDpWULT7ZJBYTnKuhoTqAB6nanL62wlgvn+IWpa8
 6BrvjpW0mpWdV2ies6XElikRTzAmQtctG8pZ8ttKyZUnYA1Vk3bDSjYh1tAvLDJnCi2w jA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsyqc8vq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 04:15:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34P4C0tC001651;
 Thu, 25 May 2023 04:15:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsyqc8vpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 04:15:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P2eib0014407;
 Thu, 25 May 2023 04:15:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcua8ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 May 2023 04:15:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34P4FFJh19989034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 May 2023 04:15:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B38A20043;
 Thu, 25 May 2023 04:15:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 892FB20040;
 Thu, 25 May 2023 04:15:12 +0000 (GMT)
Received: from [9.109.208.57] (unknown [9.109.208.57])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 May 2023 04:15:12 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------oJctBMf0DWvu8YY8p0UFXnWx"
Message-ID: <460d3d0f-3b4b-330e-87ba-d491d7c55d07@linux.vnet.ibm.com>
Date: Thu, 25 May 2023 09:45:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Narayana Murty N <nnmlinux@linux.ibm.com>, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, groug@kaod.org, npiggin@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 npiggin@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com, Greg Kurz <groug@kaod.org>
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
 <b73560c5-6422-bc5b-1819-ca0ea41e2baf@kaod.org>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.vnet.ibm.com>
In-Reply-To: <b73560c5-6422-bc5b-1819-ca0ea41e2baf@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U65ZLeRx2XlsZLfXjCowxwYRu3edSP2-
X-Proofpoint-GUID: xxTrHvdxEenf2NqcyiQ0-3aJFyan2T8H
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_01,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250031
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, NICE_REPLY_A=-0.107,
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

This is a multi-part message in MIME format.
--------------oJctBMf0DWvu8YY8p0UFXnWx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/23/23 15:52, Cédric Le Goater wrote:
> On 5/22/23 18:02, Narayana Murty N wrote:
>> Currently on PPC64 qemu always dumps the guest memory in
>> Big Endian (BE) format even though the guest running in Little Endian
>
>
>
> The patch is surely correct. I have problems understanding the config
> you are testing. PPC Book3s has multiple hypervisor implementations :
>
> 1. pHyp (AKA PowerVM)
> 2. OPAL/PowerNV (AKA Power KVM-HV)
> 3. OPAL/PowerNV/pSeries (AKA Power KVMHV-on-pSeries)
> 4. pHyp/pSeries (very recent implementation, I don't know how it is
>    referred to in the kernel)
>
> I am leaving the KVM-PR implementation out of the discussions for
> simplicity.
>
> QEMU also supports emulation of 2. and 3. in two different machines
> PowerNV and pseries, although running pseries guests under a PowerNV
> machine is slow, so is running pseries guests under pseries.
>
> Could you please describe your environment ?
>
> Thanks,
>
> C.
>
>
It had been tested target machine OPAL/PowerNV with big endian host os.
and also target OPAL/PowerNV/pSeries little endian host setup with qemu.

>
>> (LE) mode. So crash tool fails to load the dump as illustrated below:
>>
>> Log :
>> $ virsh dump DOMAIN --memory-only dump.file
>>
>> Domain 'DOMAIN' dumped to dump.file
>>
>> $ crash vmlinux dump.file
>>
>> <snip>
>> crash 8.0.2-1.el9
>>
>> WARNING: endian mismatch:
>>            crash utility: little-endian
>>            dump.file: big-endian
>>
>> WARNING: machine type mismatch:
>>            crash utility: PPC64
>>            dump.file: (unknown)
>>
>> crash: dump.file: not a supported file format
>> <snip>
>>
>> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
>> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
>> always set for powerNV even though the guest is not running in hv mode.
>> The hv mode should be taken from msr_mask MSR_HVB bit
>> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
>> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
>> the guest endianness.
>>
>> The crash tool also expects guest kernel endianness should match the
>> endianness of the dump.
>>
>> The patch was tested on POWER9 box booted with Linux as host in
>> following cases:
>>
>> Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess 
>> Qemu-Generated-Guest
>> Memory-Dump-Format
>> BE             powernv             LE KVM guest LE
>> BE             powernv             BE KVM guest BE
>> LE             powernv             LE KVM guest LE
>> LE             powernv             BE KVM guest BE
>> LE             pseries KVM         LE KVM guest LE
>> LE             pseries TCG         LE guest LE
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>> Changes since V2:
>> commit message modified as per feedbak from Nicholas Piggin.
>> Changes since V1:
>> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/ 
>>
>> The approach to solve the issue was changed based on feedback from
>> Fabiano Rosas on patch V1.
>> ---
>>   target/ppc/arch_dump.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
>> index f58e6359d5..a8315659d9 100644
>> --- a/target/ppc/arch_dump.c
>> +++ b/target/ppc/arch_dump.c
>> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>       info->d_machine = PPC_ELF_MACHINE;
>>       info->d_class = ELFCLASS;
>>   -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
>> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & 
>> MSR_HVB))) {
>>           info->d_endian = ELFDATA2LSB;
>>       } else {
>>           info->d_endian = ELFDATA2MSB;
>
--------------oJctBMf0DWvu8YY8p0UFXnWx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/23/23 15:52, Cédric Le Goater
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:b73560c5-6422-bc5b-1819-ca0ea41e2baf@kaod.org">
      <pre>On 5/22/23 18:02, Narayana Murty N wrote:
</pre>
      <blockquote type="cite">Currently on PPC64 qemu always dumps the
        guest memory in
        <br>
        Big Endian (BE) format even though the guest running in Little
        Endian
        <br>
      </blockquote>
      <br>
      <br>
      <br>
      The patch is surely correct. I have problems understanding the
      config
      <br>
      you are testing. PPC Book3s has multiple hypervisor
      implementations :
      <br>
      <br>
      1. pHyp (AKA PowerVM)
      <br>
      2. OPAL/PowerNV (AKA Power KVM-HV)
      <br>
      3. OPAL/PowerNV/pSeries (AKA Power KVMHV-on-pSeries)
      <br>
      4. pHyp/pSeries (very recent implementation, I don't know how it
      is
      <br>
         referred to in the kernel)
      <br>
      <br>
      I am leaving the KVM-PR implementation out of the discussions for
      <br>
      simplicity.
      <br>
      <br>
      QEMU also supports emulation of 2. and 3. in two different
      machines
      <br>
      PowerNV and pseries, although running pseries guests under a
      PowerNV
      <br>
      machine is slow, so is running pseries guests under pseries.
      <br>
      <br>
      Could you please describe your environment ?
      <br>
      <br>
      Thanks,
      <br>
      <br>
      C.
      <br>
      <br>
      <br>
    </blockquote>
    <pre>It had been tested target machine OPAL/PowerNV with big endian host os.
and also target OPAL/PowerNV/pSeries little endian host setup with qemu. </pre>
    <blockquote type="cite"
      cite="mid:b73560c5-6422-bc5b-1819-ca0ea41e2baf@kaod.org">
      <br>
      <blockquote type="cite">(LE) mode. So crash tool fails to load the
        dump as illustrated below:
        <br>
        <br>
        Log :
        <br>
        $ virsh dump DOMAIN --memory-only dump.file
        <br>
        <br>
        Domain 'DOMAIN' dumped to dump.file
        <br>
        <br>
        $ crash vmlinux dump.file
        <br>
        <br>
        &lt;snip&gt;
        <br>
        crash 8.0.2-1.el9
        <br>
        <br>
        WARNING: endian mismatch:
        <br>
                   crash utility: little-endian
        <br>
                   dump.file: big-endian
        <br>
        <br>
        WARNING: machine type mismatch:
        <br>
                   crash utility: PPC64
        <br>
                   dump.file: (unknown)
        <br>
        <br>
        crash: dump.file: not a supported file format
        <br>
        &lt;snip&gt;
        <br>
        <br>
        This happens because cpu_get_dump_info() passes
        cpu-&gt;env-&gt;has_hv_mode
        <br>
        to function ppc_interrupts_little_endian(), the
        cpu-&gt;env-&gt;has_hv_mode
        <br>
        always set for powerNV even though the guest is not running in
        hv mode.
        <br>
        The hv mode should be taken from msr_mask MSR_HVB bit
        <br>
        (cpu-&gt;env.msr_mask &amp; MSR_HVB). This patch fixes the issue
        by passing
        <br>
        MSR_HVB value to ppc_interrupts_little_endian() in order to
        determine
        <br>
        the guest endianness.
        <br>
        <br>
        The crash tool also expects guest kernel endianness should match
        the
        <br>
        endianness of the dump.
        <br>
        <br>
        The patch was tested on POWER9 box booted with Linux as host in
        <br>
        following cases:
        <br>
        <br>
        Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess 
        Qemu-Generated-Guest
        <br>
                                                                  
        Memory-Dump-Format
        <br>
        BE             powernv             LE KVM guest                
        LE
        <br>
        BE             powernv             BE KVM guest                
        BE
        <br>
        LE             powernv             LE KVM guest                
        LE
        <br>
        LE             powernv             BE KVM guest                
        BE
        <br>
        LE             pseries KVM         LE KVM guest                
        LE
        <br>
        LE             pseries TCG         LE guest                    
        LE
        <br>
        <br>
        Signed-off-by: Narayana Murty N <a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.ibm.com">&lt;nnmlinux@linux.ibm.com&gt;</a>
        <br>
        ---
        <br>
        Changes since V2:
        <br>
        commit message modified as per feedbak from Nicholas Piggin.
        <br>
        Changes since V1:
        <br>
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/">https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/</a>
        <br>
        The approach to solve the issue was changed based on feedback
        from
        <br>
        Fabiano Rosas on patch V1.
        <br>
        ---
        <br>
          target/ppc/arch_dump.c | 2 +-
        <br>
          1 file changed, 1 insertion(+), 1 deletion(-)
        <br>
        <br>
        diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
        <br>
        index f58e6359d5..a8315659d9 100644
        <br>
        --- a/target/ppc/arch_dump.c
        <br>
        +++ b/target/ppc/arch_dump.c
        <br>
        @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
        <br>
              info-&gt;d_machine = PPC_ELF_MACHINE;
        <br>
              info-&gt;d_class = ELFCLASS;
        <br>
          -    if (ppc_interrupts_little_endian(cpu,
        cpu-&gt;env.has_hv_mode)) {
        <br>
        +    if (ppc_interrupts_little_endian(cpu,
        !!(cpu-&gt;env.msr_mask &amp; MSR_HVB))) {
        <br>
                  info-&gt;d_endian = ELFDATA2LSB;
        <br>
              } else {
        <br>
                  info-&gt;d_endian = ELFDATA2MSB;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------oJctBMf0DWvu8YY8p0UFXnWx--



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983DB73B14D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 09:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCbB7-0001Ix-Uk; Fri, 23 Jun 2023 03:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1qCbAz-0001Ct-Mq; Fri, 23 Jun 2023 03:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1qCbAx-0008Ir-Dq; Fri, 23 Jun 2023 03:25:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35N7Cchl012293; Fri, 23 Jun 2023 07:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=pp1; bh=e+N37XbP+k2La0dsROcZLR0UJIe4J21GTx+8ctDfG08=;
 b=Q30GRlESQLK5NF4J4NC8CqYuEsbw/aJ9NUO3vDXSSxT8ilB+N1uH4wIJqiHuHv32yLBW
 3jnKFe3UetlUD+voB12G+EEtLjo/TnfnGhp1XItiJTIQ3p3KOvDORW9API9C8tCpy/bm
 reShYTskkOTljokwDATZ3NDT8ebB1+arG1jNLh+s0/brOmLONfQaahdXD7w86bjCm7t4
 umvnfW2lUDXudsY8vnZvisyknSg1LWjbTSUMypPQlD0We/GUU+l0pp1BzIAy6XMd3c1d
 Qg4pobn2sDvav3l3+rDbOz5Yr8Gz2O+liUGh64Ca40ZdyNosJoXCi5XoavMsQKWt5LXR YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd6t189x1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 07:25:34 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35N7Dung015649;
 Fri, 23 Jun 2023 07:25:34 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd6t189we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 07:25:33 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6TJKN024127;
 Fri, 23 Jun 2023 07:25:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3r94f5312k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 07:25:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35N7PRl318875050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 07:25:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99F7920049;
 Fri, 23 Jun 2023 07:25:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EE1D20043;
 Fri, 23 Jun 2023 07:25:25 +0000 (GMT)
Received: from [9.124.31.146] (unknown [9.124.31.146])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jun 2023 07:25:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------6yQW1MMEMOW58A5F4FVnsYRj"
Message-ID: <1fcc0a33-5fa1-7e25-d310-3ed5c3253c5a@linux.vnet.ibm.com>
Date: Fri, 23 Jun 2023 12:55:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
To: Greg Kurz <groug@kaod.org>
Cc: Narayana Murty N <nnmlinux@linux.ibm.com>, danielhb413@gmail.com,
 clg@kaod.org, david@gibson.dropbear.id.au, npiggin@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 npiggin@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
 <20230522202024.735f02a6@bahia>
 <29625575-d8f1-a66a-6d5a-0ce28a486525@linux.vnet.ibm.com>
 <20230523121529.57739259@bahia>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.vnet.ibm.com>
In-Reply-To: <20230523121529.57739259@bahia>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZpFYBd31_G2HnxgjQrC05W1v6l8KP36z
X-Proofpoint-ORIG-GUID: w6GLCJZKbgoB3OlPn31qdrbJd26SVYvI
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230063
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, NICE_REPLY_A=-0.09,
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

This is a multi-part message in MIME format.
--------------6yQW1MMEMOW58A5F4FVnsYRj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/23/23 15:45, Greg Kurz wrote:
> On Tue, 23 May 2023 12:20:17 +0530
> Narayana Murty N<nnmlinux@linux.vnet.ibm.com>  wrote:
>
>> On 5/22/23 23:50, Greg Kurz wrote:
>>> On Mon, 22 May 2023 12:02:42 -0400
>>> Narayana Murty N<nnmlinux@linux.ibm.com>   wrote:
>>>
>>>> Currently on PPC64 qemu always dumps the guest memory in
>>>> Big Endian (BE) format even though the guest running in Little Endian
>>>> (LE) mode. So crash tool fails to load the dump as illustrated below:
>>>>
>>>> Log :
>>>> $ virsh dump DOMAIN --memory-only dump.file
>>>>
>>>> Domain 'DOMAIN' dumped to dump.file
>>>>
>>>> $ crash vmlinux dump.file
>>>>
>>>> <snip>
>>>> crash 8.0.2-1.el9
>>>>
>>>> WARNING: endian mismatch:
>>>>             crash utility: little-endian
>>>>             dump.file: big-endian
>>>>
>>>> WARNING: machine type mismatch:
>>>>             crash utility: PPC64
>>>>             dump.file: (unknown)
>>>>
>>>> crash: dump.file: not a supported file format
>>>> <snip>
>>>>
>>>> This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
>>>> to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
>>>> always set for powerNV even though the guest is not running in hv mode.
>>>> The hv mode should be taken from msr_mask MSR_HVB bit
>>>> (cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
>>>> MSR_HVB value to ppc_interrupts_little_endian() in order to determine
>>>> the guest endianness.
>>>>
>>>> The crash tool also expects guest kernel endianness should match the
>>>> endianness of the dump.
>>>>
>>>> The patch was tested on POWER9 box booted with Linux as host in
>>>> following cases:
>>>>
>>>> Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-Guest
>>>>                                                             Memory-Dump-Format
>>>> BE             powernv             LE KVM guest                 LE
>>>> BE             powernv             BE KVM guest                 BE
>>>> LE             powernv             LE KVM guest                 LE
>>>> LE             powernv             BE KVM guest                 BE
>>> I don't quite understand why KVM is mentioned with the powernv machine.
>> guest running mode was mentioned.
>>
> QEMU cannot use KVM on the host to run a powernv machine. The
> guest is thus necessarily running in TCG mode.
>
> Please describe your setup and what exactly you are testing.

described in v4.

>>> Also have you tried to dump at various moments, e.g. during skiboot
>>> and when guest is booted, as in [1] which introduced the code this
>>> patch is changing ?
>>>
>>> [1]https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e.
>>>
>>>> LE             pseries KVM         LE KVM guest                 LE
>>>> LE             pseries TCG         LE guest                     LE
>>>>
>>> Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory dumps")
>> I agree, commit 5609400a4228 fixes endianness detection only for initial stage (skiboot) till endianness switch happens.
>> However, has_hv_mode is just a capability flag which is always set based on command-line param and doesnt really represent current hv state.
>> With this patch, it relies on the current state of the hv state based on the MSR_HVB of the msr_mask.
>>
> Yes I see what your patch is doing. The 'Fixes: 5609400a4228 ...' line is
> intended to the changelog because it is supposedly a fix to this commit.

done

>>>> Signed-off-by: Narayana Murty N<nnmlinux@linux.ibm.com>
>>>> ---
>>>> Changes since V2:
>>>> commit message modified as per feedbak from Nicholas Piggin.
>>>> Changes since V1:
>>>> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
>>>> The approach to solve the issue was changed based on feedback from
>>>> Fabiano Rosas on patch V1.
>>>> ---
>>>>    target/ppc/arch_dump.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
>>>> index f58e6359d5..a8315659d9 100644
>>>> --- a/target/ppc/arch_dump.c
>>>> +++ b/target/ppc/arch_dump.c
>>>> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>>>        info->d_machine = PPC_ELF_MACHINE;
>>>>        info->d_class = ELFCLASS;
>>>>    
>>>> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
>>>> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
>>>>            info->d_endian = ELFDATA2LSB;
>>>>        } else {
>>>>            info->d_endian = ELFDATA2MSB;
--------------6yQW1MMEMOW58A5F4FVnsYRj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/23/23 15:45, Greg Kurz wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230523121529.57739259@bahia">
      <pre class="moz-quote-pre" wrap="">On Tue, 23 May 2023 12:20:17 +0530
Narayana Murty N <a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.vnet.ibm.com">&lt;nnmlinux@linux.vnet.ibm.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 5/22/23 23:50, Greg Kurz wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, 22 May 2023 12:02:42 -0400
Narayana Murty N<a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.ibm.com">&lt;nnmlinux@linux.ibm.com&gt;</a>  wrote:

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Currently on PPC64 qemu always dumps the guest memory in
Big Endian (BE) format even though the guest running in Little Endian
(LE) mode. So crash tool fails to load the dump as illustrated below:

Log :
$ virsh dump DOMAIN --memory-only dump.file

Domain 'DOMAIN' dumped to dump.file

$ crash vmlinux dump.file

&lt;snip&gt;
crash 8.0.2-1.el9

WARNING: endian mismatch:
           crash utility: little-endian
           dump.file: big-endian

WARNING: machine type mismatch:
           crash utility: PPC64
           dump.file: (unknown)

crash: dump.file: not a supported file format
&lt;snip&gt;

This happens because cpu_get_dump_info() passes cpu-&gt;env-&gt;has_hv_mode
to function ppc_interrupts_little_endian(), the cpu-&gt;env-&gt;has_hv_mode
always set for powerNV even though the guest is not running in hv mode.
The hv mode should be taken from msr_mask MSR_HVB bit
(cpu-&gt;env.msr_mask &amp; MSR_HVB). This patch fixes the issue by passing
MSR_HVB value to ppc_interrupts_little_endian() in order to determine
the guest endianness.

The crash tool also expects guest kernel endianness should match the
endianness of the dump.

The patch was tested on POWER9 box booted with Linux as host in
following cases:

Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-Guest
                                                           Memory-Dump-Format
BE             powernv             LE KVM guest                 LE
BE             powernv             BE KVM guest                 BE
LE             powernv             LE KVM guest                 LE
LE             powernv             BE KVM guest                 BE
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I don't quite understand why KVM is mentioned with the powernv machine.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
guest running mode was mentioned.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
QEMU cannot use KVM on the host to run a powernv machine. The
guest is thus necessarily running in TCG mode.

Please describe your setup and what exactly you are testing.
</pre>
    </blockquote>
    <pre>described in v4.
</pre>
    <blockquote type="cite" cite="mid:20230523121529.57739259@bahia">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Also have you tried to dump at various moments, e.g. during skiboot
and when guest is booted, as in [1] which introduced the code this
patch is changing ?

[1]<a class="moz-txt-link-freetext" href="https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e">https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e</a>.

</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">LE             pseries KVM         LE KVM guest                 LE
LE             pseries TCG         LE guest                     LE

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory dumps")
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I agree, commit 5609400a4228 fixes endianness detection only for initial stage (skiboot) till endianness switch happens.
However, has_hv_mode is just a capability flag which is always set based on command-line param and doesnt really represent current hv state.
With this patch, it relies on the current state of the hv state based on the MSR_HVB of the msr_mask.

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Yes I see what your patch is doing. The 'Fixes: 5609400a4228 ...' line is
intended to the changelog because it is supposedly a fix to this commit.
</pre>
    </blockquote>
    <pre>done
</pre>
    <blockquote type="cite" cite="mid:20230523121529.57739259@bahia">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Signed-off-by: Narayana Murty N<a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.ibm.com">&lt;nnmlinux@linux.ibm.com&gt;</a>
---
Changes since V2:
commit message modified as per feedbak from Nicholas Piggin.
Changes since V1:
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/">https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/</a>
The approach to solve the issue was changed based on feedback from
Fabiano Rosas on patch V1.
---
  target/ppc/arch_dump.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index f58e6359d5..a8315659d9 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
      info-&gt;d_machine = PPC_ELF_MACHINE;
      info-&gt;d_class = ELFCLASS;
  
-    if (ppc_interrupts_little_endian(cpu, cpu-&gt;env.has_hv_mode)) {
+    if (ppc_interrupts_little_endian(cpu, !!(cpu-&gt;env.msr_mask &amp; MSR_HVB))) {
          info-&gt;d_endian = ELFDATA2LSB;
      } else {
          info-&gt;d_endian = ELFDATA2MSB;
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------6yQW1MMEMOW58A5F4FVnsYRj--



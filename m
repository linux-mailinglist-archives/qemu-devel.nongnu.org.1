Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D670D453
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:51:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1LrU-0005Cf-AN; Tue, 23 May 2023 02:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1q1LrR-0005Bf-JI; Tue, 23 May 2023 02:51:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.vnet.ibm.com>)
 id 1q1LrE-0003zq-O4; Tue, 23 May 2023 02:51:06 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34N6JvXL006684; Tue, 23 May 2023 06:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=pp1; bh=QuilCvg9U2+6DhHbbLWK7VARkk4Xf3dPzQMzIrFbffA=;
 b=kyjdTQoeuUQ1Qg5UCddkr5P0wOIbW2B+O+FRt+wSE/dPRG+2HTDrQYOCHU7SXx1f5nlu
 W7dxBGVfLyrcuWc22NmUWFnAXS9Om6ozklTsXLxC6HJ0XbY7HtxfznRpZjNqjx1SdLgC
 5ANX7vjDEVrLpsrkrkAka6axRLjyKcgqGiOq5W9aW2Y0L9qki+PWCbfDkCIO7IqbAFgY
 wx5Yb1YM2JQhmKc+8Gn5/gZUWBwo9p3SxmKSfpuC3jOpP3ib9kdrdsVx+XuKTpB0p6PY
 M2VxEh9Xp1rJn/qa2J8VW/41yu6AkZ8/vFvNHkr3+XL3rAtLSxItlsBVGRaVV6AlCtTw gA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrq8226by-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 06:50:27 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34N6JxUi006926;
 Tue, 23 May 2023 06:50:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrq8226b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 06:50:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4crKI030859;
 Tue, 23 May 2023 06:50:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk1a2v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 06:50:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34N6oKR220251254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 06:50:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE59720043;
 Tue, 23 May 2023 06:50:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 631592004E;
 Tue, 23 May 2023 06:50:18 +0000 (GMT)
Received: from [9.109.208.57] (unknown [9.109.208.57])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 May 2023 06:50:18 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------57wDqvfbep1ZhOcAy0yzkf9m"
Message-ID: <29625575-d8f1-a66a-6d5a-0ce28a486525@linux.vnet.ibm.com>
Date: Tue, 23 May 2023 12:20:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target
 endianness for memory dump
Content-Language: en-US
To: Greg Kurz <groug@kaod.org>, Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 npiggin@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 farosas@suse.de, npiggin@linux.ibm.com, vaibhav@linux.ibm.com,
 harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
 <20230522202024.735f02a6@bahia>
From: Narayana Murty N <nnmlinux@linux.vnet.ibm.com>
In-Reply-To: <20230522202024.735f02a6@bahia>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 10wnNOLdRTnP7gn4ckHi1azBGM97aCEb
X-Proofpoint-GUID: jI2FJUaQixGLdzdCfClBEyCMHyhpvLTY
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305230053
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, NICE_REPLY_A=-0.091,
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
--------------57wDqvfbep1ZhOcAy0yzkf9m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/23 23:50, Greg Kurz wrote:
> On Mon, 22 May 2023 12:02:42 -0400
> Narayana Murty N<nnmlinux@linux.ibm.com>  wrote:
>
>> Currently on PPC64 qemu always dumps the guest memory in
>> Big Endian (BE) format even though the guest running in Little Endian
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
>>            crash utility: little-endian
>>            dump.file: big-endian
>>
>> WARNING: machine type mismatch:
>>            crash utility: PPC64
>>            dump.file: (unknown)
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
>> Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-Guest
>>                                                            Memory-Dump-Format
>> BE             powernv             LE KVM guest                 LE
>> BE             powernv             BE KVM guest                 BE
>> LE             powernv             LE KVM guest                 LE
>> LE             powernv             BE KVM guest                 BE
> I don't quite understand why KVM is mentioned with the powernv machine.

guest running mode was mentioned.

>
> Also have you tried to dump at various moments, e.g. during skiboot
> and when guest is booted, as in [1] which introduced the code this
> patch is changing ?
>
> [1]https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e.
>
>> LE             pseries KVM         LE KVM guest                 LE
>> LE             pseries TCG         LE guest                     LE
>>
> Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory dumps")

I agree, commit 5609400a4228 fixes endianness detection only for initial stage (skiboot) till endianness switch happens.
However, has_hv_mode is just a capability flag which is always set based on command-line param and doesnt really represent current hv state.
With this patch, it relies on the current state of the hv state based on the MSR_HVB of the msr_mask.

>
>> Signed-off-by: Narayana Murty N<nnmlinux@linux.ibm.com>
>> ---
>> Changes since V2:
>> commit message modified as per feedbak from Nicholas Piggin.
>> Changes since V1:
>> https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
>> The approach to solve the issue was changed based on feedback from
>> Fabiano Rosas on patch V1.
>> ---
>>   target/ppc/arch_dump.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
>> index f58e6359d5..a8315659d9 100644
>> --- a/target/ppc/arch_dump.c
>> +++ b/target/ppc/arch_dump.c
>> @@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>>       info->d_machine = PPC_ELF_MACHINE;
>>       info->d_class = ELFCLASS;
>>   
>> -    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
>> +    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
>>           info->d_endian = ELFDATA2LSB;
>>       } else {
>>           info->d_endian = ELFDATA2MSB;
--------------57wDqvfbep1ZhOcAy0yzkf9m
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/22/23 23:50, Greg Kurz wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230522202024.735f02a6@bahia">
      <pre class="moz-quote-pre" wrap="">On Mon, 22 May 2023 12:02:42 -0400
Narayana Murty N <a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.ibm.com">&lt;nnmlinux@linux.ibm.com&gt;</a> wrote:

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
      <pre class="moz-quote-pre" wrap="">
I don't quite understand why KVM is mentioned with the powernv machine.</pre>
    </blockquote>
    <pre>guest running mode was mentioned.
</pre>
    <blockquote type="cite" cite="mid:20230522202024.735f02a6@bahia">
      <pre class="moz-quote-pre" wrap="">

Also have you tried to dump at various moments, e.g. during skiboot
and when guest is booted, as in [1] which introduced the code this
patch is changing ?

[1] <a class="moz-txt-link-freetext" href="https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e">https://github.com/qemu/qemu/commit/5609400a422809c89ea788e4d0e13124a617582e</a>.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">LE             pseries KVM         LE KVM guest                 LE
LE             pseries TCG         LE guest                     LE

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory dumps")</pre>
    </blockquote>
    <pre>I agree, commit 5609400a4228 fixes endianness detection only for initial stage (skiboot) till endianness switch happens.
However, has_hv_mode is just a capability flag which is always set based on command-line param and doesnt really represent current hv state.
With this patch, it relies on the current state of the hv state based on the MSR_HVB of the msr_mask. 
</pre>
    <blockquote type="cite" cite="mid:20230522202024.735f02a6@bahia">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Narayana Murty N <a class="moz-txt-link-rfc2396E" href="mailto:nnmlinux@linux.ibm.com">&lt;nnmlinux@linux.ibm.com&gt;</a>
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
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------57wDqvfbep1ZhOcAy0yzkf9m--



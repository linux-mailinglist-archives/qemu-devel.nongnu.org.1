Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D929B72F449
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9JPk-000263-6w; Wed, 14 Jun 2023 01:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1q9JPY-00025f-P8; Wed, 14 Jun 2023 01:51:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1q9JPW-0000bH-36; Wed, 14 Jun 2023 01:51:16 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35E5HJbO016986; Wed, 14 Jun 2023 05:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : mime-version : subject : to : references : cc : from :
 in-reply-to; s=pp1; bh=q6rJrdrPwr8CwAOjbefdARbdGsECcOZTtWIUWJ3q388=;
 b=Q5aKHd3bIo9NtLNJnTVbkUzXYDvpf7gav4GEwt/hj89fFzD9Lh2ZLR2cx6T9xEIY4an9
 nhD1Nk3kU4hFLRTs4RIqh2qW5KEQpYnCurtNpWcTzeyUeIuDAwtv9MX8O9GrHp4MqTTD
 qXOZ02SUG/FG40PFrUmRXNEcjTxAbE/kjFbsuqw16i5zV+AnzbLahdNc0/s5sKUeOJm2
 f9sP+h2dmxUOLRlA7vNdm+hYisjAXNnmY2fNxT4leXS1yu/R8Z8T2RNaWdNLlduHbKvh
 G88qsEd1KPvQI7FIDLWbCmK5rCJf0FzcHCYrGVn0JPuK5ODtTxELfEsGCTidp6B/tNPh 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r77948nuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jun 2023 05:51:08 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35E5QSFL009642;
 Wed, 14 Jun 2023 05:51:07 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r77948nuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jun 2023 05:51:07 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35E5Sxxv002804;
 Wed, 14 Jun 2023 05:51:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
 by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r4gt5m29n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Jun 2023 05:51:07 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35E5p6vG62128386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Jun 2023 05:51:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E23DE5803F;
 Wed, 14 Jun 2023 05:51:05 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 58F4D58060;
 Wed, 14 Jun 2023 05:51:03 +0000 (GMT)
Received: from [9.109.244.180] (unknown [9.109.244.180])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 Jun 2023 05:51:03 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------CVerZVSTa0OifFfUVjH0LFYY"
Message-ID: <0bbbffa7-d66c-66f2-f660-321e4f8aa026@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2023 11:21:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/6] target/ppc: Fix instruction loading endianness in
 alignment interrupt
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20230530132543.385138-2-npiggin@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, harshpb@linux.ibm.com
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <20230530132543.385138-2-npiggin@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OIXW2fRKzXV6fE3_pSni3sIAqk2CGFo7
X-Proofpoint-ORIG-GUID: wAZSJY3Ky5Su0j0LmXS0yTzZsL5FjC7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_02,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=740
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140046
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001, NICE_REPLY_A=-0.098,
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
--------------CVerZVSTa0OifFfUVjH0LFYY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/30/23 18:55, Nicholas Piggin wrote:
> powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
> after cpu_ldl_code(). This corrects DSISR bits in alignment
> interrupts when running in little endian mode.
>
> Reviewed-by: Fabiano Rosas<farosas@suse.de>
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
>   target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index c13f2afa04..0274617b4a 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
>                     env->nip);
>   }
>   
> +#ifdef CONFIG_TCG
> +/* Return true iff byteswap is needed in a scalar memop */
> +static inline bool need_byteswap(CPUArchState *env)
> +{
> +    /* SOFTMMU builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
> +    return !!(env->msr & ((target_ulong)1 << MSR_LE));
> +}
> +
> +static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)

This hunk fails to compile with configure --disable-tcg

> FAILED: libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o
> cc -m64 -mlittle-endian -Ilibqemu-ppc64-softmmu.fa.p -I. -I..
> -Itarget/ppc -I../target/ppc -I../dtc/libfdt -Iqapi -Itrace -Iui
> -Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0
> -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g
> -fstack-protector-strong -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wundef
> -Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes
> -Wredundant-decls -Wold-style-declaration -Wold-style-definition
> -Wtype-limits -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels
> -Wexpansion-to-defined -Wimplicit-fallthrough=2
> -Wmissing-format-attribute -Wno-missing-include-dirs
> -Wno-shift-negative-value -Wno-psabi -isystem
> /home/Shreya/qemu/linux-headers -isystem linux-headers -iquote . -iquote
> /home/Shreya/qemu -iquote /home/Shreya/qemu/include -pthread
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
> -fno-strict-aliasing -fno-common -fwrapv -fPIE -isystem../linux-headers
> -isystemlinux-headers -DNEED_CPU_H
> '-DCONFIG_TARGET="ppc64-softmmu-config-target.h"'
> '-DCONFIG_DEVICES="ppc64-softmmu-config-devices.h"' -MD -MQ
> libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o -MF
> libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o.d -o
> libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o -c
> ../target/ppc/excp_helper.c
> ../target/ppc/excp_helper.c:143:49: error: unknown type name ‘abi_ptr’;
> did you mean ‘si_ptr’?
>     143 | static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
>         |                                                 ^~~~~~~
>         |                                                 si_ptr
> ../target/ppc/excp_helper.c: In function ‘powerpc_excp_books’:
> ../target/ppc/excp_helper.c:1416:16: error: implicit declaration of
> function ‘ppc_ldl_code’ [-Werror=implicit-function-declaration]
>    1416 |         insn = ppc_ldl_code(env, env->nip);
>         |                ^~~~~~~~~~~~
> ../target/ppc/excp_helper.c:1416:16: error: nested extern declaration of
> ‘ppc_ldl_code’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors

> +{
> +    uint32_t insn = cpu_ldl_code(env, addr);
> +
> +    if (need_byteswap(env)) {
> +        insn = bswap32(insn);
> +    }
> +
> +    return insn;
> +}
> +#endif
> +
>   static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
>   {
>       const char *es;
> @@ -3100,7 +3120,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
>   
>       /* Restore state and reload the insn we executed, for filling in DSISR.  */
>       cpu_restore_state(cs, retaddr);
> -    insn = cpu_ldl_code(env, env->nip);
> +    insn = ppc_ldl_code(env, env->nip);
>   
>       switch (env->mmu_model) {
>       case POWERPC_MMU_SOFT_4xx:
--------------CVerZVSTa0OifFfUVjH0LFYY
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/30/23 18:55, Nicholas Piggin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230530132543.385138-2-npiggin@gmail.com">
      <pre id="b" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">powerpc ifetch endianness depends on MSR[LE] so it has to byteswap
after cpu_ldl_code(). This corrects DSISR bits in alignment
interrupts when running in little endian mode.

Reviewed-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
Signed-off-by: Nicholas Piggin <a class="moz-txt-link-rfc2396E" href="mailto:npiggin@gmail.com">&lt;npiggin@gmail.com&gt;</a>
---
 target/ppc/excp_helper.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index c13f2afa04..0274617b4a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -133,6 +133,26 @@ static void dump_hcall(CPUPPCState *env)
                   env-&gt;nip);
 }
 
+#ifdef CONFIG_TCG
+/* Return true iff byteswap is needed in a scalar memop */
+static inline bool need_byteswap(CPUArchState *env)
+{
+    /* SOFTMMU builds TARGET_BIG_ENDIAN. Need to swap when MSR[LE] is set */
+    return !!(env-&gt;msr &amp; ((target_ulong)1 &lt;&lt; MSR_LE));
+}
+
+static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)</pre>
    </blockquote>
    <pre id="b" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">This hunk fails to compile with configure --disable-tcg</pre>
    <blockquote type="cite"
      cite="mid:20230530132543.385138-2-npiggin@gmail.com">
      <pre id="b" style="font-size: 13px; font-family: monospace; background: rgb(255, 255, 255); color: rgb(0, 0, 51); white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">FAILED: libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o
cc -m64 -mlittle-endian -Ilibqemu-ppc64-softmmu.fa.p -I. -I.. 
-Itarget/ppc -I../target/ppc -I../dtc/libfdt -Iqapi -Itrace -Iui 
-Iui/shader -I/usr/include/pixman-1 -I/usr/include/glib-2.0 
-I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O2 -g 
-fstack-protector-strong -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wundef 
-Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes 
-Wredundant-decls -Wold-style-declaration -Wold-style-definition 
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self 
-Wignored-qualifiers -Wempty-body -Wnested-externs -Wendif-labels 
-Wexpansion-to-defined -Wimplicit-fallthrough=2 
-Wmissing-format-attribute -Wno-missing-include-dirs 
-Wno-shift-negative-value -Wno-psabi -isystem 
/home/Shreya/qemu/linux-headers -isystem linux-headers -iquote . -iquote 
/home/Shreya/qemu -iquote /home/Shreya/qemu/include -pthread 
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
-fno-strict-aliasing -fno-common -fwrapv -fPIE -isystem../linux-headers 
-isystemlinux-headers -DNEED_CPU_H 
'-DCONFIG_TARGET="ppc64-softmmu-config-target.h"' 
'-DCONFIG_DEVICES="ppc64-softmmu-config-devices.h"' -MD -MQ 
libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o -MF 
libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o.d -o 
libqemu-ppc64-softmmu.fa.p/target_ppc_excp_helper.c.o -c 
../target/ppc/excp_helper.c
../target/ppc/excp_helper.c:143:49: error: unknown type name ‘abi_ptr’; 
did you mean ‘si_ptr’?
   143 | static uint32_t ppc_ldl_code(CPUArchState *env, abi_ptr addr)
       |                                                 ^~~~~~~
       |                                                 si_ptr
../target/ppc/excp_helper.c: In function ‘powerpc_excp_books’:
../target/ppc/excp_helper.c:1416:16: error: implicit declaration of 
function ‘ppc_ldl_code’ [-Werror=implicit-function-declaration]
  1416 |         insn = ppc_ldl_code(env, env-&gt;nip);
       |                ^~~~~~~~~~~~
../target/ppc/excp_helper.c:1416:16: error: nested extern declaration of 
‘ppc_ldl_code’ [-Werror=nested-externs]
cc1: all warnings being treated as errors</pre>
    </blockquote>
    <p></p>
    <span style="color: rgb(36, 41, 47); font-family: -apple-system,
      BlinkMacSystemFont, &quot;Segoe UI&quot;, Helvetica, Arial,
      sans-serif, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
      Emoji&quot;; font-size: 14px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255);
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"></span>
    <blockquote type="cite"
      cite="mid:20230530132543.385138-2-npiggin@gmail.com">
      <pre class="moz-quote-pre" wrap="">+{
+    uint32_t insn = cpu_ldl_code(env, addr);
+
+    if (need_byteswap(env)) {
+        insn = bswap32(insn);
+    }
+
+    return insn;
+}
+#endif
+
 static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
 {
     const char *es;
@@ -3100,7 +3120,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 
     /* Restore state and reload the insn we executed, for filling in DSISR.  */
     cpu_restore_state(cs, retaddr);
-    insn = cpu_ldl_code(env, env-&gt;nip);
+    insn = ppc_ldl_code(env, env-&gt;nip);
 
     switch (env-&gt;mmu_model) {
     case POWERPC_MMU_SOFT_4xx:
</pre>
    </blockquote>
  </body>
</html>

--------------CVerZVSTa0OifFfUVjH0LFYY--



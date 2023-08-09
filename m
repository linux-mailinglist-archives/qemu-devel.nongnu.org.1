Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1887F776088
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 15:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTj7X-0003j3-QE; Wed, 09 Aug 2023 09:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qTj7T-0003iR-R4
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:20:59 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qTj7Q-0006vU-4K
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 09:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691587256; x=1723123256;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=rpn4rm74LJhFnDHsdtW+7bi+vSI9IC8hE5QYWtUGbUE=;
 b=icJWMCGO8lKPqOEtBQJFXEzmlKfZQx4nvfWys7fZ5Jj1nT4Mr4wstbY/
 xpT4R5gE+3wbICjkIVnp63tXn+hmSAHL7fH4d+0mEk2mMApmjE0sJ4LRQ
 5lNRhp6+RliClbjbaPL4LFfKQbytmzzd5zRFjLWKLCW5/olmYyAodwoyr
 6djAKWeyhbIZoGjk2/mp2/jpgKYSA/1fRGtjgjG13E329ztIFvxsFkmbi
 K46CSs41kPdxoHB6r4MlrIXCSAg77RnGl8ONhbbDWwU76+OtViMo6R0Da
 B5mbmxRgomhbQKYSkGUwqdhKlxImB7w1Wu/BS7OqOk5SFC5UKgMg4j2RD g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="402083742"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
 d="scan'208,217";a="402083742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2023 06:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725399003"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
 d="scan'208,217";a="725399003"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.93.8.78])
 ([10.93.8.78])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Aug 2023 06:20:50 -0700
Content-Type: multipart/alternative;
 boundary="------------yW4rw3Rl9tUeKxsYtq37zrpG"
Message-ID: <f1710cde-a3ce-6125-2608-c1ebcf4be581@intel.com>
Date: Wed, 9 Aug 2023 21:20:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] target/i386: Avoid cpu number overflow in legacy
 topology
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, babu.moger@amd.com
References: <20230809102732.3124908-1-qian.wen@intel.com>
 <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: "Wen, Qian" <qian.wen@intel.com>
In-Reply-To: <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-4.14, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------yW4rw3Rl9tUeKxsYtq37zrpG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/2023 7:14 PM, Igor Mammedov wrote:
> On Wed,  9 Aug 2023 18:27:32 +0800
> Qian Wen <qian.wen@intel.com> wrote:
>
>> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
>> Vol2:
>>
>> Bits 23-16: Maximum number of addressable IDs for logical processors in
>> this physical package.
>>
>> When launching the VM with -smp 256, the value written to EBX[23:16] is
>> 0 because of data overflow. If the guest only supports legacy topology,
>> without V2 Extended Topology enumerated by CPUID.0x1f or Extended
>> Topology enumerated by CPUID.0x0b to support over 255 CPUs, the return
>> of the kernel invoking cpu_smt_allowed() is false and AP's bring-up will
>> fail. Then only CPU 0 is online, and others are offline.
>>
>> To avoid this issue caused by overflow, limit the max value written to
>> EBX[23:16] to 255.
> what happens on real hw or in lack of thereof what SDM says about this
> value when there is more than 255 threads?.
>

Current SDM doesn't specify what the value should be when APIC IDs per package exceeds 255. So we asked the internal HW architect, the response is that EBX[23:16] will report 255 instead of being truncated to a smaller value.

Thanks,
Qian

>> Signed-off-by: Qian Wen <qian.wen@intel.com>
>> ---
>> Changes v1 -> v2:
>>  - Revise the commit message and comment to more clearer.
>>  - Rebased to v8.1.0-rc2.
>> ---
>>  target/i386/cpu.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 97ad229d8b..6e1d88fbd7 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>      uint32_t die_offset;
>>      uint32_t limit;
>>      uint32_t signature[3];
>> +    uint32_t threads_per_socket;
>>      X86CPUTopoInfo topo_info;
>>  
>>      topo_info.dies_per_pkg = env->nr_dies;
>> @@ -6049,8 +6050,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>              *ecx |= CPUID_EXT_OSXSAVE;
>>          }
>>          *edx = env->features[FEAT_1_EDX];
>> -        if (cs->nr_cores * cs->nr_threads > 1) {
>> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
>> +        /*
>> +         * Only bits [23:16] represent the maximum number of addressable
>> +         * IDs for logical processors in this physical package.
>> +         * When thread_per_socket > 255, it will 1) overwrite bits[31:24]
>> +         * which is apic_id, 2) bits [23:16] get truncated.
>> +         */
>> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
>> +        if (threads_per_socket > 255) {
>> +            threads_per_socket = 255;
>> +        }
>> +
>> +        if (threads_per_socket > 1) {
>> +            *ebx |= threads_per_socket << 16;
>>              *edx |= CPUID_HT;
>>          }
>>          if (!cpu->enable_pmu) {
--------------yW4rw3Rl9tUeKxsYtq37zrpG
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 8/9/2023 7:14 PM, Igor Mammedov
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230809131426.1d9f5821@imammedo.users.ipa.redhat.com">
      <pre class="moz-quote-pre" wrap="">On Wed,  9 Aug 2023 18:27:32 +0800
Qian Wen <a class="moz-txt-link-rfc2396E" href="mailto:qian.wen@intel.com">&lt;qian.wen@intel.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
Vol2:

Bits 23-16: Maximum number of addressable IDs for logical processors in
this physical package.

When launching the VM with -smp 256, the value written to EBX[23:16] is
0 because of data overflow. If the guest only supports legacy topology,
without V2 Extended Topology enumerated by CPUID.0x1f or Extended
Topology enumerated by CPUID.0x0b to support over 255 CPUs, the return
of the kernel invoking cpu_smt_allowed() is false and AP's bring-up will
fail. Then only CPU 0 is online, and others are offline.

To avoid this issue caused by overflow, limit the max value written to
EBX[23:16] to 255.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
what happens on real hw or in lack of thereof what SDM says about this
value when there is more than 255 threads?.

</pre>
    </blockquote>
    <br>
    Current SDM doesn't specify what the value should be when APIC IDs
    per package exceeds 255. So we asked the internal HW architect, the
    response is that EBX[23:16] will report 255 instead of being
    truncated to a smaller value.<br>
    <br>
    Thanks,<br>
    Qian<br>
    <br>
    <blockquote type="cite"
      cite="mid:20230809131426.1d9f5821@imammedo.users.ipa.redhat.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Qian Wen <a class="moz-txt-link-rfc2396E" href="mailto:qian.wen@intel.com">&lt;qian.wen@intel.com&gt;</a>
---
Changes v1 -&gt; v2:
 - Revise the commit message and comment to more clearer.
 - Rebased to v8.1.0-rc2.
---
 target/i386/cpu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8b..6e1d88fbd7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    uint32_t threads_per_socket;
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env-&gt;nr_dies;
@@ -6049,8 +6050,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env-&gt;features[FEAT_1_EDX];
-        if (cs-&gt;nr_cores * cs-&gt;nr_threads &gt; 1) {
-            *ebx |= (cs-&gt;nr_cores * cs-&gt;nr_threads) &lt;&lt; 16;
+        /*
+         * Only bits [23:16] represent the maximum number of addressable
+         * IDs for logical processors in this physical package.
+         * When thread_per_socket &gt; 255, it will 1) overwrite bits[31:24]
+         * which is apic_id, 2) bits [23:16] get truncated.
+         */
+        threads_per_socket = cs-&gt;nr_cores * cs-&gt;nr_threads;
+        if (threads_per_socket &gt; 255) {
+            threads_per_socket = 255;
+        }
+
+        if (threads_per_socket &gt; 1) {
+            *ebx |= threads_per_socket &lt;&lt; 16;
             *edx |= CPUID_HT;
         }
         if (!cpu-&gt;enable_pmu) {
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------yW4rw3Rl9tUeKxsYtq37zrpG--


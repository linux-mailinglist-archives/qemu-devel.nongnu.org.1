Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8A77A5FF
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 12:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV8fg-00087P-MA; Sun, 13 Aug 2023 06:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qV8fY-00086y-KW
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 06:50:00 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qV8fV-0002UY-0V
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 06:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691923797; x=1723459797;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to;
 bh=T8PSG9GlXJFkThrYB0uf0875QHr+h2bXErz2kME8toE=;
 b=U/Wem8YtN0hGTFwhSkAvjgvzeMqquYLDqILzE5f7pGvEUASCY7T+3zw5
 1mDvkcM2kDL9N7zEt8R0qofJTZgRjpB1Yvd4UgiUPg5NFN8p9bISGhYoL
 HPukGSRu3Xekz6adARfwvZ30rX2gi55RLvpb8+mKL3adMP0qEn2xyNlCt
 lVDBGWxziOo2seIyJkKgbJVIUqbiJhh/5fpTMlesNolOlvgXmdU77IweU
 oTdDLyaGmJphAV9XRl1UIkgUzXCGM6M6RTP8gI7hBjJ5zkKrXW1btPzup
 aUXzpdABsPB/AhzWvUhBut7Tv9/KRr6t5Rv911f2SdI5Bb4foYX/3u1eA A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="351491346"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
 d="scan'208,217";a="351491346"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2023 03:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="736231651"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
 d="scan'208,217";a="736231651"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.93.21.67])
 ([10.93.21.67])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2023 03:49:42 -0700
Content-Type: multipart/alternative;
 boundary="------------Qfi55lrJxHc2EsXaeIipV8BS"
Message-ID: <6aa7915c-c39d-ad5f-0171-8516868c9632@intel.com>
Date: Sun, 13 Aug 2023 18:49:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: "Wen, Qian" <qian.wen@intel.com>
Subject: Re: [PATCH v2] target/i386: Avoid cpu number overflow in legacy
 topology
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, babu.moger@amd.com
References: <20230809102732.3124908-1-qian.wen@intel.com>
 <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
 <f1710cde-a3ce-6125-2608-c1ebcf4be581@intel.com>
 <20230809154742.494c3697@imammedo.users.ipa.redhat.com>
Content-Language: en-US
In-Reply-To: <20230809154742.494c3697@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=192.55.52.136; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.972, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
--------------Qfi55lrJxHc2EsXaeIipV8BS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/9/2023 9:47 PM, Igor Mammedov wrote:
> On Wed, 9 Aug 2023 21:20:48 +0800
> "Wen, Qian" <qian.wen@intel.com> wrote:
>
>> On 8/9/2023 7:14 PM, Igor Mammedov wrote:
>>> On Wed,  9 Aug 2023 18:27:32 +0800
>>> Qian Wen <qian.wen@intel.com> wrote:
>>>  
>>>> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
>>>> Vol2:
>>>>
>>>> Bits 23-16: Maximum number of addressable IDs for logical processors in
>>>> this physical package.
>>>>
>>>> When launching the VM with -smp 256, the value written to EBX[23:16] is
>>>> 0 because of data overflow. If the guest only supports legacy topology,
>>>> without V2 Extended Topology enumerated by CPUID.0x1f or Extended
>>>> Topology enumerated by CPUID.0x0b to support over 255 CPUs, the return
>>>> of the kernel invoking cpu_smt_allowed() is false and AP's bring-up will
>>>> fail. Then only CPU 0 is online, and others are offline.
>>>>
>>>> To avoid this issue caused by overflow, limit the max value written to
>>>> EBX[23:16] to 255.  
>>> what happens on real hw or in lack of thereof what SDM says about this
>>> value when there is more than 255 threads?.
>>>  
>> Current SDM doesn't specify what the value should be when APIC IDs per package exceeds 255. So we asked the internal HW architect, the response is that EBX[23:16] will report 255 instead of being truncated to a smaller value.
> then mention it in commit log so one wouldn't wonder where the value came from.

Ok, thanks for your suggestion!

>> Thanks,
>> Qian
>>
>>>> Signed-off-by: Qian Wen <qian.wen@intel.com>
>>>> ---
>>>> Changes v1 -> v2:
>>>>  - Revise the commit message and comment to more clearer.
>>>>  - Rebased to v8.1.0-rc2.
>>>> ---
>>>>  target/i386/cpu.c | 16 ++++++++++++++--
>>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>>> index 97ad229d8b..6e1d88fbd7 100644
>>>> --- a/target/i386/cpu.c
>>>> +++ b/target/i386/cpu.c
>>>> @@ -6008,6 +6008,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>>      uint32_t die_offset;
>>>>      uint32_t limit;
>>>>      uint32_t signature[3];
>>>> +    uint32_t threads_per_socket;
>>>>      X86CPUTopoInfo topo_info;
>>>>  
>>>>      topo_info.dies_per_pkg = env->nr_dies;
>>>> @@ -6049,8 +6050,19 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>>              *ecx |= CPUID_EXT_OSXSAVE;
>>>>          }
>>>>          *edx = env->features[FEAT_1_EDX];
>>>> -        if (cs->nr_cores * cs->nr_threads > 1) {
>>>> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
>>>> +        /*
>>>> +         * Only bits [23:16] represent the maximum number of addressable
>>>> +         * IDs for logical processors in this physical package.
>>>> +         * When thread_per_socket > 255, it will 1) overwrite bits[31:24]
>>>> +         * which is apic_id, 2) bits [23:16] get truncated.
>>>> +         */
>>>> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
>>>> +        if (threads_per_socket > 255) {
>>>> +            threads_per_socket = 255;
>>>> +        }
>>>> +
>>>> +        if (threads_per_socket > 1) {
>>>> +            *ebx |= threads_per_socket << 16;
>                           ^^^^^^^^^^^^^^^^^^^^^^^^^
> more robust would be mask out non-relevant fields at rhs 

I think a mask for this case is a bit redundant, since the limitation of 255 already filtered non-relevant fields.
I prefer not to add the mask here and keep code style consistency with others place.

> also perhaps double check if we could do induce similar overflow
> tweaking other -smp properties (todo for another patch[es] if there are such places).

I have a check, the CPUID.0x4:EAX[31:26] indicates the Maximum number of addressable IDs for processor cores in the physical package.
If we launch over 64 cores VM, the 6-bits field will also overflow. I will add the following fix to patch2 in v2.

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52a2a1a1c7..9c1ae3d83d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -243,6 +243,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
                           cache->partitions * cache->sets);

     assert(num_apic_ids > 0);
+    num_cores = num_cores > 64 ? 64 : num_cores;
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |


Thanks,
Qian
>>>>              *edx |= CPUID_HT;
>>>>          }
>>>>          if (!cpu->enable_pmu) {  
--------------Qfi55lrJxHc2EsXaeIipV8BS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 8/9/2023 9:47 PM, Igor Mammedov
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230809154742.494c3697@imammedo.users.ipa.redhat.com">
      <pre class="moz-quote-pre" wrap="">On Wed, 9 Aug 2023 21:20:48 +0800
"Wen, Qian" <a class="moz-txt-link-rfc2396E" href="mailto:qian.wen@intel.com">&lt;qian.wen@intel.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 8/9/2023 7:14 PM, Igor Mammedov wrote:
</pre>
        <blockquote type="cite">
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
          <pre class="moz-quote-pre" wrap="">what happens on real hw or in lack of thereof what SDM says about this
value when there is more than 255 threads?.
 
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Current SDM doesn't specify what the value should be when APIC IDs per package exceeds 255. So we asked the internal HW architect, the response is that EBX[23:16] will report 255 instead of being truncated to a smaller value.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">then mention it in commit log so one wouldn't wonder where the value came from.</pre>
    </blockquote>
    <br>
    Ok, thanks for your suggestion!<br>
    <br>
    <blockquote type="cite"
      cite="mid:20230809154742.494c3697@imammedo.users.ipa.redhat.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Thanks,
Qian

</pre>
        <blockquote type="cite">
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
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">+            *ebx |= threads_per_socket &lt;&lt; 16;
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">                          ^^^^^^^^^^^^^^^^^^^^^^^^^
more robust would be mask out non-relevant fields at rhs </pre>
    </blockquote>
    <br>
    I think a mask for this case is a bit redundant, since the
    limitation of 255 already filtered non-relevant fields. <br>
    I prefer not to add the mask here and keep code style consistency
    with others place.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20230809154742.494c3697@imammedo.users.ipa.redhat.com">
      <pre class="moz-quote-pre" wrap="">also perhaps double check if we could do induce similar overflow
tweaking other -smp properties (todo for another patch[es] if there are such places).</pre>
    </blockquote>
    <br>
    I have a check, the CPUID.0x4:EAX[31:26] indicates the Maximum
    number of addressable IDs for processor cores in the physical
    package.<br>
    If we launch over 64 cores VM, the 6-bits field will also overflow.
    I will add the following fix to patch2 in v2.<br>
    <br>
    diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
    index 52a2a1a1c7..9c1ae3d83d 100644<br>
    --- a/target/i386/cpu.c<br>
    +++ b/target/i386/cpu.c<br>
    @@ -243,6 +243,7 @@ static void encode_cache_cpuid4(CPUCacheInfo
    *cache,<br>
                               cache-&gt;partitions * cache-&gt;sets);<br>
    <br>
         assert(num_apic_ids &gt; 0);<br>
    +    num_cores = num_cores &gt; 64 ? 64 : num_cores;<br>
         *eax = CACHE_TYPE(cache-&gt;type) |<br>
                CACHE_LEVEL(cache-&gt;level) |<br>
                (cache-&gt;self_init ? CACHE_SELF_INIT_LEVEL : 0) |<br>
    <br>
    <br>
    Thanks,<br>
    Qian<br>
    <blockquote type="cite"
      cite="mid:20230809154742.494c3697@imammedo.users.ipa.redhat.com">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">             *edx |= CPUID_HT;
         }
         if (!cpu-&gt;enable_pmu) {  
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
    <lt-container></lt-container>
  </body>
</html>

--------------Qfi55lrJxHc2EsXaeIipV8BS--


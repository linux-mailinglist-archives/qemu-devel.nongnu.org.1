Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F22D771DC8
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSxCy-0007yT-PB; Mon, 07 Aug 2023 06:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qSxCw-0007yF-Qb
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:11:26 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qSxCv-0000Kx-41
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691403085; x=1722939085;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=0yY5pxHhfA3kyaNwWcDyGdI/uY166DHKX2giopHyCMI=;
 b=ShJpAZ0oZAXTTXvuDlZciBtF29SncFOkR0mKCrcFRa80VoSh4NKUF7Mm
 NI0nRbppf+K4cpLsfGqBZm5tXpVQ92tHiefH64frHn3ZYL5RCXzAhO1P7
 mBRDQQd7Hk1HhSiso/SR7xO2SzPbdN3BNtwP2O03bwFbvtaZKHRgUr+LD
 cqk4KLNFeIkILpH2/QSOxYY/Abk2Os6kr+hMmoXxzDxZZrmwc6ON+ArNZ
 0rDSiB09GpbYF04YrVs6l2DC5ckj1MP1r7e+jNbEoC3zKBSFbesm4xD00
 E7M7WrRoKM8AjaJDglFb4eKRrXIjrfdbzmWW/cCC+4i2NI4WMDG01OA9G g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="456888907"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
 d="scan'208,217";a="456888907"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 03:10:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="977387859"
X-IronPort-AV: E=Sophos;i="6.01,261,1684825200"; 
 d="scan'208,217";a="977387859"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.238.5.29])
 ([10.238.5.29])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 03:10:57 -0700
Content-Type: multipart/alternative;
 boundary="------------LwHq7lfkdOUPQmHvbjo70m4S"
Message-ID: <5d8ba2be-2f61-38b8-5a96-18011921380a@intel.com>
Date: Mon, 7 Aug 2023 18:10:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>, richard.henderson@linaro.org,
 babu.moger@amd.com
References: <20230728080150.2958048-1-qian.wen@intel.com>
 <ZNCmZJg0Sv1byFNM@liuzhao-OptiPlex-7080>
From: "Wen, Qian" <qian.wen@intel.com>
In-Reply-To: <ZNCmZJg0Sv1byFNM@liuzhao-OptiPlex-7080>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-4.139, RCVD_IN_DNSWL_MED=-2.3,
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
--------------LwHq7lfkdOUPQmHvbjo70m4S
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/2023 4:08 PM, Zhao Liu wrote:
> On Fri, Jul 28, 2023 at 04:01:50PM +0800, Qian Wen wrote:
>> Date: Fri, 28 Jul 2023 16:01:50 +0800
>> From: Qian Wen <qian.wen@intel.com>
>> Subject: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
>> X-Mailer: git-send-email 2.25.1
>>
>> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
>> Vol2:
>>
>> Bits 23-16: Maximum number of addressable IDs for logical processors in
>> this physical package.
>>
>> To avoid data overflow, limit the max value written to EBX[23:16] to
>> 255.
>>
>> Signed-off-by: Qian Wen <qian.wen@intel.com>
>> ---
>>  target/i386/cpu.c | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 1294be374ab2..70589a58b727 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -5356,6 +5356,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>      uint32_t die_offset;
>>      uint32_t limit;
>>      uint32_t signature[3];
>> +    uint32_t threads_per_socket;
>>      X86CPUTopoInfo topo_info;
>>  
>>      topo_info.dies_per_pkg = env->nr_dies;
>> @@ -5397,8 +5398,18 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>              *ecx |= CPUID_EXT_OSXSAVE;
>>          }
>>          *edx = env->features[FEAT_1_EDX];
>> -        if (cs->nr_cores * cs->nr_threads > 1) {
>> -            *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
>> +        /*
>> +         * The vCPU number more than 255 needs support of V2 Extended
>> +         * Topology enumerated by CPUID.0x1f or Extended Topology
>> +         * enumerated by CPUID.0x0b.
>> +         */
>> +        threads_per_socket = cs->nr_cores * cs->nr_threads;
>> +        if (threads_per_socket > 255) {
>> +            threads_per_socket = 255;
> Straight encoding to 255 is good for me!
>
> -Zhao


Got it, thanks!

Thanks,
Qian

>> +        }
>> +
>> +        if (threads_per_socket > 1) {
>> +            *ebx |= threads_per_socket << 16;
>>              *edx |= CPUID_HT;
>>          }
>>          /*
>> -- 
>> 2.25.1
>>
--------------LwHq7lfkdOUPQmHvbjo70m4S
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 8/7/2023 4:08 PM, Zhao Liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ZNCmZJg0Sv1byFNM@liuzhao-OptiPlex-7080">
      <pre class="moz-quote-pre" wrap="">On Fri, Jul 28, 2023 at 04:01:50PM +0800, Qian Wen wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Date: Fri, 28 Jul 2023 16:01:50 +0800
From: Qian Wen <a class="moz-txt-link-rfc2396E" href="mailto:qian.wen@intel.com">&lt;qian.wen@intel.com&gt;</a>
Subject: [PATCH] target/i386: Avoid cpu number overflow in legacy topology
X-Mailer: git-send-email 2.25.1

The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
Vol2:

Bits 23-16: Maximum number of addressable IDs for logical processors in
this physical package.

To avoid data overflow, limit the max value written to EBX[23:16] to
255.

Signed-off-by: Qian Wen <a class="moz-txt-link-rfc2396E" href="mailto:qian.wen@intel.com">&lt;qian.wen@intel.com&gt;</a>
---
 target/i386/cpu.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1294be374ab2..70589a58b727 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5356,6 +5356,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
+    uint32_t threads_per_socket;
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env-&gt;nr_dies;
@@ -5397,8 +5398,18 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env-&gt;features[FEAT_1_EDX];
-        if (cs-&gt;nr_cores * cs-&gt;nr_threads &gt; 1) {
-            *ebx |= (cs-&gt;nr_cores * cs-&gt;nr_threads) &lt;&lt; 16;
+        /*
+         * The vCPU number more than 255 needs support of V2 Extended
+         * Topology enumerated by CPUID.0x1f or Extended Topology
+         * enumerated by CPUID.0x0b.
+         */
+        threads_per_socket = cs-&gt;nr_cores * cs-&gt;nr_threads;
+        if (threads_per_socket &gt; 255) {
+            threads_per_socket = 255;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Straight encoding to 255 is good for me!

-Zhao
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Got it, thanks!<br>
      <br>
      Thanks,<br>
      Qian<br>
      <br>
    </p>
    <blockquote type="cite"
      cite="mid:ZNCmZJg0Sv1byFNM@liuzhao-OptiPlex-7080">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+        }
+
+        if (threads_per_socket &gt; 1) {
+            *ebx |= threads_per_socket &lt;&lt; 16;
             *edx |= CPUID_HT;
         }
         /*
-- 
2.25.1

</pre>
      </blockquote>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------LwHq7lfkdOUPQmHvbjo70m4S--


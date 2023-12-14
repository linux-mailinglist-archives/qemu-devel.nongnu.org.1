Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F8812A1D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 09:16:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDgsn-0000Ps-A4; Thu, 14 Dec 2023 03:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan1.wu@intel.com>) id 1rDgsU-0000MD-L2
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 03:15:32 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan1.wu@intel.com>) id 1rDgsR-0001PW-Il
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 03:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702541727; x=1734077727;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=R+PFWdMNNy6xXLkHZS2SwEGDaXt1stQeMNBg7HfY6gE=;
 b=DJQPgFPaTjOU2dlvSRBgiOkQDcLPjJWtTgXUsOj3yTVIUfjuacf/WxDJ
 SlwglZA6TU+nfmuYQ/mygbB/3bpmYar9krig5voWs8WpCwSA7V1bX8obS
 Okt6DWqSYWt0qADwZ+4jbfdUY6gYE25302X/fgTeb3D3HSfU0PbrrAuAv
 3Bbb7wWagXRbEJExRr8IaxAFtUG0y0HZPp2jS5QBPir6Z9CG+BpkVMs0o
 mruKUraK12d22AK9yWPYpW8i/ZuS4KQEQFdY8TIcCJDR5ZaBQx/6RAHne
 UTdxhDUstyXwDG+OAOnLrGuPBzs684bDMJWoXFZBCe3c/8Zqpd9AnSqOy g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="397870722"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
 d="scan'208,217";a="397870722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 00:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; d="scan'208,217";a="15752696"
Received: from danwu1-mobl.ccr.corp.intel.com (HELO [10.238.4.153])
 ([10.238.4.153])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2023 00:15:21 -0800
Content-Type: multipart/alternative;
 boundary="------------0ox3zeB6nYbOFSdQ9JsZFRLb"
Message-ID: <bfdebf3f-9467-41fe-a09f-ebc4e02465b4@intel.com>
Date: Thu, 14 Dec 2023 16:15:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] target/i386: add support for FRED in CPUID
 enumeration
Content-Language: en-US
To: Xin Li <xin3.li@intel.com>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 eduardo@habkost.net, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
 xiaoyao.li@intel.com, weijiang.yang@intel.com
References: <20231109072012.8078-1-xin3.li@intel.com>
 <20231109072012.8078-2-xin3.li@intel.com>
From: "Wu, Dan1" <dan1.wu@intel.com>
In-Reply-To: <20231109072012.8078-2-xin3.li@intel.com>
Received-SPF: pass client-ip=134.134.136.24; envelope-from=dan1.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
--------------0ox3zeB6nYbOFSdQ9JsZFRLb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/9/2023 3:20 PM, Xin Li wrote:
> FRED, i.e., the Intel flexible return and event delivery architecture,
> defines simple new transitions that change privilege level (ring
> transitions).
>
> The new transitions defined by the FRED architecture are FRED event
> delivery and, for returning from events, two FRED return instructions.
> FRED event delivery can effect a transition from ring 3 to ring 0, but
> it is used also to deliver events incident to ring 0.  One FRED
> instruction (ERETU) effects a return from ring 0 to ring 3, while the
> other (ERETS) returns while remaining in ring 0.  Collectively, FRED
> event delivery and the FRED return instructions are FRED transitions.
>
> In addition to these transitions, the FRED architecture defines a new
> instruction (LKGS) for managing the state of the GS segment register.
> The LKGS instruction can be used by 64-bit operating systems that do
> not use the new FRED transitions.
>
> WRMSRNS is an instruction that behaves exactly like WRMSR, with the
> only difference being that it is not a serializing instruction by
> default.  Under certain conditions, WRMSRNS may replace WRMSR to improve
> performance.  FRED uses it to switch RSP0 in a faster manner.
>
> Search for the latest FRED spec in most search engines with this search
> pattern:
>
>    site:intel.com FRED (flexible return and event delivery) specification
>
> The CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[17] enumerates FRED, and
> the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[18] enumerates LKGS, and
> the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[19] enumerates WRMSRNS.
>
> Add CPUID definitions for FRED/LKGS/WRMSRNS, and expose them to KVM guests.
>
> Because FRED relies on LKGS and WRMSRNS, add that to feature dependency
> map.
>
> Tested-by: Shan Kang<shan.kang@intel.com>
> Signed-off-by: Xin Li<xin3.li@intel.com>
> ---
>   target/i386/cpu.c | 10 +++++++++-
>   target/i386/cpu.h |  6 ++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 358d9c0a65..403c84177a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -965,7 +965,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>               "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
>               NULL, NULL, "fzrm", "fsrs",
>               "fsrc", NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, "fred", "lkgs", "wrmsrns",
>               NULL, "amx-fp16", NULL, "avx-ifma",
>               NULL, NULL, NULL, NULL,
>               NULL, NULL, NULL, NULL,
> @@ -1552,6 +1552,14 @@ static FeatureDep feature_dependencies[] = {
>           .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
>           .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
>       },
> +    {
> +        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
> +        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_LKGS },
> +    },
> +    {
> +        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
> +        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_WRMSRNS },
> +    },

since FRED relies on LKGS and WRMSRNS, here should be as follow:

+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },

>   };
>   
>   typedef struct X86RegisterInfo32 {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index cd2e295bd6..5faf00551d 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -934,6 +934,12 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
>   #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
>   /* PREFETCHIT0/1 Instructions */
>   #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
> +/* Flexible return and event delivery (FRED) */
> +#define CPUID_7_1_EAX_FRED              (1U << 17)
> +/* Load into IA32_KERNEL_GS_BASE (LKGS) */
> +#define CPUID_7_1_EAX_LKGS              (1U << 18)
> +/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
> +#define CPUID_7_1_EAX_WRMSRNS           (1U << 19)
>   
>   /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
>   #define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
--------------0ox3zeB6nYbOFSdQ9JsZFRLb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/9/2023 3:20 PM, Xin Li wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20231109072012.8078-2-xin3.li@intel.com">
      <pre class="moz-quote-pre" wrap="">FRED, i.e., the Intel flexible return and event delivery architecture,
defines simple new transitions that change privilege level (ring
transitions).

The new transitions defined by the FRED architecture are FRED event
delivery and, for returning from events, two FRED return instructions.
FRED event delivery can effect a transition from ring 3 to ring 0, but
it is used also to deliver events incident to ring 0.  One FRED
instruction (ERETU) effects a return from ring 0 to ring 3, while the
other (ERETS) returns while remaining in ring 0.  Collectively, FRED
event delivery and the FRED return instructions are FRED transitions.

In addition to these transitions, the FRED architecture defines a new
instruction (LKGS) for managing the state of the GS segment register.
The LKGS instruction can be used by 64-bit operating systems that do
not use the new FRED transitions.

WRMSRNS is an instruction that behaves exactly like WRMSR, with the
only difference being that it is not a serializing instruction by
default.  Under certain conditions, WRMSRNS may replace WRMSR to improve
performance.  FRED uses it to switch RSP0 in a faster manner.

Search for the latest FRED spec in most search engines with this search
pattern:

  site:intel.com FRED (flexible return and event delivery) specification

The CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[17] enumerates FRED, and
the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[18] enumerates LKGS, and
the CPUID feature flag CPUID.(EAX=7,ECX=1):EAX[19] enumerates WRMSRNS.

Add CPUID definitions for FRED/LKGS/WRMSRNS, and expose them to KVM guests.

Because FRED relies on LKGS and WRMSRNS, add that to feature dependency
map.

Tested-by: Shan Kang <a class="moz-txt-link-rfc2396E" href="mailto:shan.kang@intel.com">&lt;shan.kang@intel.com&gt;</a>
Signed-off-by: Xin Li <a class="moz-txt-link-rfc2396E" href="mailto:xin3.li@intel.com">&lt;xin3.li@intel.com&gt;</a>
---
 target/i386/cpu.c | 10 +++++++++-
 target/i386/cpu.h |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 358d9c0a65..403c84177a 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -965,7 +965,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "avx-vnni", "avx512-bf16", NULL, "cmpccxadd",
             NULL, NULL, "fzrm", "fsrs",
             "fsrc", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "fred", "lkgs", "wrmsrns",
             NULL, "amx-fp16", NULL, "avx-ifma",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -1552,6 +1552,14 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
         .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
     },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_LKGS },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_FRED },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_WRMSRNS },
+    },</pre>
    </blockquote>
    <br>
    <pre><font face="monospace">since <span
    style="white-space: pre-wrap">FRED relies on LKGS and WRMSRNS, here should be as follow:
</span></font><font face="monospace"><span style="white-space: pre-wrap"></span></font></pre>
    <pre class="moz-quote-pre" wrap="">+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_LKGS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },
+    {
+        .from = { FEAT_7_1_EAX,             CPUID_7_1_EAX_WRMSRNS },
+        .to = { FEAT_7_1_EAX,               CPUID_7_1_EAX_FRED },
+    },</pre>
    <blockquote type="cite"
      cite="mid:20231109072012.8078-2-xin3.li@intel.com">
      <pre class="moz-quote-pre" wrap=""></pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:20231109072012.8078-2-xin3.li@intel.com">
      <pre class="moz-quote-pre" wrap="">
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd2e295bd6..5faf00551d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -934,6 +934,12 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U &lt;&lt; 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U &lt;&lt; 14)
+/* Flexible return and event delivery (FRED) */
+#define CPUID_7_1_EAX_FRED              (1U &lt;&lt; 17)
+/* Load into IA32_KERNEL_GS_BASE (LKGS) */
+#define CPUID_7_1_EAX_LKGS              (1U &lt;&lt; 18)
+/* Non-Serializing Write to Model Specific Register (WRMSRNS) */
+#define CPUID_7_1_EAX_WRMSRNS           (1U &lt;&lt; 19)
 
 /* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
 #define CPUID_7_2_EDX_MCDT_NO           (1U &lt;&lt; 5)
</pre>
    </blockquote>
  </body>
</html>

--------------0ox3zeB6nYbOFSdQ9JsZFRLb--


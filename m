Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA67D8DA5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 05:52:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwDs8-0006DO-GT; Thu, 26 Oct 2023 23:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1qwDs3-0006D4-7a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:50:51 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1qwDrx-00014Q-Ts
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:50:50 -0400
X-ASG-Debug-ID: 1698378631-1eb14e2e6408050001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id 0ovRvlD84LfcwvPL (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 27 Oct 2023 11:50:31 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 27 Oct
 2023 11:50:31 +0800
Received: from [10.28.66.55] (10.28.66.55) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 27 Oct
 2023 11:50:30 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Content-Type: multipart/alternative;
 boundary="------------4sY3eFZV9amVDiYvXERzcfSy"
X-Barracuda-RBL-Trusted-Forwarder: 10.28.66.55
Message-ID: <eb9a08b2-a7c4-c45c-edd8-0585037194aa@zhaoxin.com>
Date: Thu, 26 Oct 2023 23:50:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
 compatibility
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH] target/i386/kvm: Refine VMX controls setting for
 backward compatibility
To: Zhao Liu <zhao1.liu@intel.com>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
References: <20230925071453.14908-1-ewanhai-oc@zhaoxin.com>
 <ZTnbFJrHeKhoUA6F@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <ZTnbFJrHeKhoUA6F@intel.com>
X-Originating-IP: [10.28.66.55]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1698378631
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 13802
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=HTML_MESSAGE
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.115928
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.00 HTML_MESSAGE           BODY: HTML included in message
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
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

--------------4sY3eFZV9amVDiYvXERzcfSy
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 10/25/23 23:20, Zhao Liu wrote:
> On Mon, Sep 25, 2023 at 03:14:53AM -0400, EwanHai wrote:
>> Date: Mon, 25 Sep 2023 03:14:53 -0400
>> From: EwanHai<ewanhai-oc@zhaoxin.com>
>> Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
>>   compatibility
>> X-Mailer: git-send-email 2.34.1
>>
>> Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
>> execution controls") implemented a workaround for hosts that have
>> specific CPUID features but do not support the corresponding VMX
>> controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
>>
>> In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
>> If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
>> use KVM's settings, avoiding any modifications to this MSR.
>>
>> However, this commit (4a910e1) didn’t account for cases in older Linux
> s/didn’t/didn't/

I'll fix it.

>
>> kernels(e.g., linux-4.19.90) where `MSR_IA32_VMX_PROCBASED_CTLS2` is
> For this old kernel, it's better to add the brief lifecycle note (e.g.,
> lts, EOL) to illustrate the value of considering such compatibility
> fixes.

I've checked the linux-stable repo, found that
MSR_IA32_VMX_PROCBASED_CTLS2 is not included in kvm regular msr list
until linux-5.3, and in linux-4.19.x(EOL:Dec,2024), there is also no
MSR_IA32_VMX_PROCBASED_CTLS2 in kvm regular msr list.

So maybe this is an important compatibility fix for kernel < 5.3.

>> in `kvm_feature_msrs`—obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> s/—obtained/-obtained/

I'll fix it.

>
>> but not in `kvm_msr_list`—obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> s/—obtained/-obtained/

I'll fix it.

>
>> As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
>> on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
>>
>> This patch supplements the above logic, ensuring that
>> `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
>> lists, thus maintaining compatibility with older kernels.
>>
>> Signed-off-by: EwanHai<ewanhai-oc@zhaoxin.com>
>> ---
>>   target/i386/kvm/kvm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index af101fcdf6..6299284de4 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>>   static int kvm_get_supported_feature_msrs(KVMState *s)
>>   {
>>       int ret = 0;
>> +    int i;
>>   
>>       if (kvm_feature_msrs != NULL) {
>>           return 0;
>> @@ -2377,6 +2378,11 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>>           return ret;
>>       }
> It's worth adding a comment here to indicate that this is a
> compatibility fix.
>
> -Zhao
>
>>   
>> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
>> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
>> +            has_msr_vmx_procbased_ctls2 = true;
>> +        }
>> +    }
>>       return 0;
>>   }
>>   
>> -- 
>> 2.34.1
>>
Plan to use patch bellow, any more suggestion?

>  From a3006fcec3615d98ac1eb252a61952d44aa5029b Mon Sep 17 00:00:00 2001
> From: EwanHai<ewanhai-oc@zhaoxin.com>
> Date: Mon, 25 Sep 2023 02:11:59 -0400
> Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
>   compatibility
>
> Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
> execution controls") implemented a workaround for hosts that have
> specific CPUID features but do not support the corresponding VMX
> controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.
>
> In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
> If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
> use KVM's settings, avoiding any modifications to this MSR.
>
> However, this commit (4a910e1) didn't account for cases in older Linux
> kernels(<5.3) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
> `kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
> but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
> As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
> on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.
>
> This patch supplements the above logic, ensuring that
> `has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
> lists, thus maintaining compatibility with older kernels.
>
> Signed-off-by: EwanHai<ewanhai-oc@zhaoxin.com>
> ---
>   target/i386/kvm/kvm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index af101fcdf6..3cf95f8579 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
>   static int kvm_get_supported_feature_msrs(KVMState *s)
>   {
>       int ret = 0;
> +    int i;
>
>       if (kvm_feature_msrs != NULL) {
>           return 0;
> @@ -2377,6 +2378,19 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
>           return ret;
>       }
>
> +    /*
> +     * Compatibility fix:
> +     * Older Linux kernels(<5.3) include the MSR_IA32_VMX_PROCBASED_CTLS2
> +     * only in feature msr list, but not in regular msr list. This lead to
> +     * an issue in older kernel versions where QEMU, through the regular
> +     * MSR list check, assumes the kernel doesn't maintain this msr,
> +     * resulting in incorrect settings by QEMU for this msr.
> +     */
> +    for (i = 0; i < kvm_feature_msrs->nmsrs; i++) {
> +        if (kvm_feature_msrs->indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
> +            has_msr_vmx_procbased_ctls2 = true;
> +        }
> +    }
>       return 0;
>   }
>
> -- 
> 2.34.1

--------------4sY3eFZV9amVDiYvXERzcfSy
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/25/23 23:20, Zhao Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ZTnbFJrHeKhoUA6F@intel.com">
      <pre class="moz-quote-pre" wrap="">On Mon, Sep 25, 2023 at 03:14:53AM -0400, EwanHai wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Date: Mon, 25 Sep 2023 03:14:53 -0400
From: EwanHai <a class="moz-txt-link-rfc2396E" href="mailto:ewanhai-oc@zhaoxin.com">&lt;ewanhai-oc@zhaoxin.com&gt;</a>
Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
 compatibility
X-Mailer: git-send-email 2.34.1

Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
execution controls") implemented a workaround for hosts that have
specific CPUID features but do not support the corresponding VMX
controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.

In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
use KVM's settings, avoiding any modifications to this MSR.

However, this commit (4a910e1) didn’t account for cases in older Linux
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
s/didn’t/didn't/</pre>
    </blockquote>
    <pre>I'll fix it.</pre>
    <blockquote type="cite" cite="mid:ZTnbFJrHeKhoUA6F@intel.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">kernels(e.g., linux-4.19.90) where `MSR_IA32_VMX_PROCBASED_CTLS2` is
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
For this old kernel, it's better to add the brief lifecycle note (e.g.,
lts, EOL) to illustrate the value of considering such compatibility
fixes.
</pre>
    </blockquote>
    <pre class="moz-quote-pre" wrap="">I've checked the linux-stable repo, found that 
MSR_IA32_VMX_PROCBASED_CTLS2 is not included in kvm regular msr list 
until linux-5.3, and in linux-4.19.x(EOL:Dec,2024), there is also no
MSR_IA32_VMX_PROCBASED_CTLS2 in kvm regular msr list.

So maybe this is an important compatibility fix for kernel &lt; 5.3.
</pre>
    <blockquote type="cite" cite="mid:ZTnbFJrHeKhoUA6F@intel.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">in `kvm_feature_msrs`—obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
s/—obtained/-obtained/</pre>
    </blockquote>
    <pre>I'll fix it.
</pre>
    <blockquote type="cite" cite="mid:ZTnbFJrHeKhoUA6F@intel.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">but not in `kvm_msr_list`—obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
s/—obtained/-obtained/</pre>
    </blockquote>
    <pre>I'll fix it.</pre>
    <blockquote type="cite" cite="mid:ZTnbFJrHeKhoUA6F@intel.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.

This patch supplements the above logic, ensuring that
`has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
lists, thus maintaining compatibility with older kernels.

Signed-off-by: EwanHai <a class="moz-txt-link-rfc2396E" href="mailto:ewanhai-oc@zhaoxin.com">&lt;ewanhai-oc@zhaoxin.com&gt;</a>
---
 target/i386/kvm/kvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index af101fcdf6..6299284de4 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
 static int kvm_get_supported_feature_msrs(KVMState *s)
 {
     int ret = 0;
+    int i;
 
     if (kvm_feature_msrs != NULL) {
         return 0;
@@ -2377,6 +2378,11 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
         return ret;
     }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
It's worth adding a comment here to indicate that this is a
compatibility fix.

-Zhao

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
+    for (i = 0; i &lt; kvm_feature_msrs-&gt;nmsrs; i++) {
+        if (kvm_feature_msrs-&gt;indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
+            has_msr_vmx_procbased_ctls2 = true;
+        }
+    }
     return 0;
 }
 
-- 
2.34.1

</pre>
      </blockquote>
    </blockquote>
    <pre>Plan to use patch bellow, any more suggestion?

<blockquote type="cite"><pre>From a3006fcec3615d98ac1eb252a61952d44aa5029b Mon Sep 17 00:00:00 2001
From: EwanHai <a class="moz-txt-link-rfc2396E" href="mailto:ewanhai-oc@zhaoxin.com">&lt;ewanhai-oc@zhaoxin.com&gt;</a>
Date: Mon, 25 Sep 2023 02:11:59 -0400
Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward
 compatibility

Commit 4a910e1 ("target/i386: do not set unsupported VMX secondary
execution controls") implemented a workaround for hosts that have
specific CPUID features but do not support the corresponding VMX
controls, e.g., hosts support RDSEED but do not support RDSEED-Exiting.

In detail, commit 4a910e1 introduced a flag `has_msr_vmx_procbased_clts2`.
If KVM has `MSR_IA32_VMX_PROCBASED_CTLS2` in its msr list, QEMU would
use KVM's settings, avoiding any modifications to this MSR.

However, this commit (4a910e1) didn't account for cases in older Linux
kernels(&lt;5.3) where `MSR_IA32_VMX_PROCBASED_CTLS2` is in
`kvm_feature_msrs`-obtained by ioctl(KVM_GET_MSR_FEATURE_INDEX_LIST),
but not in `kvm_msr_list`-obtained by ioctl(KVM_GET_MSR_INDEX_LIST).
As a result,it did not set the `has_msr_vmx_procbased_clts2` flag based
on `kvm_msr_list` alone, even though KVM maintains the value of this MSR.

This patch supplements the above logic, ensuring that
`has_msr_vmx_procbased_clts2` is correctly set by checking both MSR
lists, thus maintaining compatibility with older kernels.

Signed-off-by: EwanHai <a class="moz-txt-link-rfc2396E" href="mailto:ewanhai-oc@zhaoxin.com">&lt;ewanhai-oc@zhaoxin.com&gt;</a>
---
 target/i386/kvm/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index af101fcdf6..3cf95f8579 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2343,6 +2343,7 @@ void kvm_arch_do_init_vcpu(X86CPU *cpu)
 static int kvm_get_supported_feature_msrs(KVMState *s)
 {
     int ret = 0;
+    int i;

     if (kvm_feature_msrs != NULL) {
         return 0;
@@ -2377,6 +2378,19 @@ static int kvm_get_supported_feature_msrs(KVMState *s)
         return ret;
     }

+    /*
+     * Compatibility fix:
+     * Older Linux kernels(&lt;5.3) include the MSR_IA32_VMX_PROCBASED_CTLS2
+     * only in feature msr list, but not in regular msr list. This lead to
+     * an issue in older kernel versions where QEMU, through the regular
+     * MSR list check, assumes the kernel doesn't maintain this msr,
+     * resulting in incorrect settings by QEMU for this msr.
+     */
+    for (i = 0; i &lt; kvm_feature_msrs-&gt;nmsrs; i++) {
+        if (kvm_feature_msrs-&gt;indices[i] == MSR_IA32_VMX_PROCBASED_CTLS2) {
+            has_msr_vmx_procbased_ctls2 = true;
+        }
+    }
     return 0;
 }

-- 
2.34.1
</pre></blockquote>
</pre>
  </body>
</html>

--------------4sY3eFZV9amVDiYvXERzcfSy--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 239C6783B45
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMG3-0000kr-9a; Tue, 22 Aug 2023 03:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qYMFx-0000ke-0k
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:56:53 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qYMFt-0005ui-AM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:56:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692691009; x=1724227009;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to;
 bh=7MPteGdMS7MANubr57+ll2bTF97bmDmWP7x6m1CSr8c=;
 b=Vey3//IwjYv3qXMd4ZZTnWgc5eo73+qjqcwwFtI4G36KI3Y/ZnfLT/Ra
 I7wNXgj5SRjI6+u5NzCp1zh5U70nOv0ELEU+z+Qn6dpeEbAWEDXr65Gjq
 dIj2KJXfvg17nCBu+oxk/S0g9xbC/7UH2ftcurYauv8Akl1+3qWrTpqC3
 z6eFYVRRyQ+oxkRQe3o07I+zWvyLJ1j+Ubx+zNWayiAobFU0rnH0j8GQl
 i+UWuZjo4qDY1+7ZxFaXvt+3d1yrxu+i6JscqKMHrLOWNcQ6RadRZ6O9m
 E/a2UjnwZpKYdEOAtsthHM7E9BrkndwF6J6z+9Ju/qe+xFXOcEVVkPjvH g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358803113"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
 d="scan'208,217";a="358803113"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:56:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826233818"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
 d="scan'208,217";a="826233818"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.93.26.225])
 ([10.93.26.225])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:56:23 -0700
Content-Type: multipart/alternative;
 boundary="------------37QJYBUDynT1iPOP7FDsgu1d"
Message-ID: <f04add44-03c3-654b-8761-fd9f470eb053@intel.com>
Date: Tue, 22 Aug 2023 15:56:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: "Wen, Qian" <qian.wen@intel.com>
Subject: Re: [PATCH v3 0/2] Fix overflow of the max number of IDs for logic
 processor and core
To: Isaku Yamahata <isaku.yamahata@gmail.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, babu.moger@amd.com
References: <20230816080658.3562730-1-qian.wen@intel.com>
 <20230817193319.GA3637892@ls.amr.corp.intel.com>
Content-Language: en-US
In-Reply-To: <20230817193319.GA3637892@ls.amr.corp.intel.com>
Received-SPF: pass client-ip=134.134.136.126; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-3.374, SPF_HELO_NONE=0.001,
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
--------------37QJYBUDynT1iPOP7FDsgu1d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/2023 3:33 AM, Isaku Yamahata wrote:
> On Wed, Aug 16, 2023 at 04:06:56PM +0800,
> Qian Wen <qian.wen@intel.com> wrote:
>
>> CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
>> processors in this physical package.
>> CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
>> in the physical package.
>>
>> The current qemu code doesn't limit the value written to these two fields.
>> If the guest has a huge number of cores, APs (application processor) will
>> fail to bring up and the wrong info will be reported.
>> According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
>> to 255, and CPUID.4:EAX[31:26] to 63.
>>
>> ---
>> Changes v2 -> v3:
>>   - Add patch 2.
>>   - Revise the commit message and comment to be clearer.
>>   - Using MIN() for limitation.
>> Changes v1 -> v2:
>>   - Revise the commit message and comment to more clearer.
>>   - Rebased to v8.1.0-rc2.
>>
>> Qian Wen (2):
>>   target/i386: Avoid cpu number overflow in legacy topology
>>   target/i386: Avoid overflow of the cache parameter enumerated by leaf 4
>>
>>  target/i386/cpu.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> base-commit: 0d52116fd82cdd1f4a88837336af5b6290c364a4
>> -- 
>> 2.25.1
>>
> The patch itself looks good. Can we add test cases?
> We have some in qemu/tests/unit/test-x86-cpuid.c.


Hi Isaku, thanks for your comments!

I take a look, the test-x86-cpuid.c has some tests for topology functions, e.g., apicid_smt/core/die_width, apicid_core/die/pkg_offset, x86_apicid_from_cpu_idx...

Do you mean adding another test for function cpu_x86_cpuid() like below? If so, it seems that some effort is required to instantiate CPUX86State for input of cpu_x86_cpuid, but the result of this test case is obvious. So, is it necessary to add this test?

+    uint32_t unused, eax, ebx;
+    /* CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
+       processors in this physical package.
+    */
+    cpu_x86_cpuid(env, 1, 0, &unused, &ebx, &unused, &unused);
+    g_assert_cmpuint(ebx & 0xFF0000, ==, 0xFF0000);
+
+    /* CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor
+       cores in the physical package.
+    */
+    cpu_x86_cpuid(env, 4, 0, &eax, &unused, &unused, &unused);
+    g_assert_cmpuint(ebx & 0xFC000000, ==, 0xFC000000);


Thanks,
Qian

--------------37QJYBUDynT1iPOP7FDsgu1d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 8/18/2023 3:33 AM, Isaku Yamahata
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20230817193319.GA3637892@ls.amr.corp.intel.com">
      <pre class="moz-quote-pre" wrap="">On Wed, Aug 16, 2023 at 04:06:56PM +0800,
Qian Wen <a class="moz-txt-link-rfc2396E" href="mailto:qian.wen@intel.com">&lt;qian.wen@intel.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">CPUID.1.EBX[23:16]: Maximum number of addressable IDs for logical
processors in this physical package.
CPUID.4:EAX[31:26]: Maximum number of addressable IDs for processor cores
in the physical package.

The current qemu code doesn't limit the value written to these two fields.
If the guest has a huge number of cores, APs (application processor) will
fail to bring up and the wrong info will be reported.
According to HW behavior, setting max value written to CPUID.1.EBX[23:16]
to 255, and CPUID.4:EAX[31:26] to 63.

---
Changes v2 -&gt; v3:
  - Add patch 2.
  - Revise the commit message and comment to be clearer.
  - Using MIN() for limitation.
Changes v1 -&gt; v2:
  - Revise the commit message and comment to more clearer.
  - Rebased to v8.1.0-rc2.

Qian Wen (2):
  target/i386: Avoid cpu number overflow in legacy topology
  target/i386: Avoid overflow of the cache parameter enumerated by leaf 4

 target/i386/cpu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

base-commit: 0d52116fd82cdd1f4a88837336af5b6290c364a4
-- 
2.25.1

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">The patch itself looks good. Can we add test cases?
We have some in qemu/tests/unit/test-x86-cpuid.c.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Hi Isaku, thanks for your comments!<br>
      <br>
      I take a look, the test-x86-cpuid.c has some tests for topology
      functions, e.g., apicid_smt/core/die_width,
      apicid_core/die/pkg_offset, x86_apicid_from_cpu_idx...<br>
      <br>
      Do you mean adding another test for function cpu_x86_cpuid() like
      below? If so, it seems that some effort is required to instantiate
      CPUX86State for input of cpu_x86_cpuid, but the result of this
      test case is obvious. So, is it necessary to add this test?<br>
      <br>
      +    uint32_t unused, eax, ebx;<br>
      +    /* CPUID.1.EBX[23:16]: Maximum number of addressable IDs for
      logical<br>
      +       processors in this physical package.<br>
      +    */<br>
      +    cpu_x86_cpuid(env, 1, 0, &amp;unused, &amp;ebx, &amp;unused,
      &amp;unused);<br>
      +    g_assert_cmpuint(ebx &amp; 0xFF0000, ==, 0xFF0000);<br>
      +<br>
      +    /* CPUID.4:EAX[31:26]: Maximum number of addressable IDs for
      processor<br>
      +       cores in the physical package.<br>
      +    */<br>
      +    cpu_x86_cpuid(env, 4, 0, &amp;eax, &amp;unused, &amp;unused,
      &amp;unused);<br>
      +    g_assert_cmpuint(ebx &amp; 0xFC000000, ==, 0xFC000000);<br>
    </p>
    <p><br>
      Thanks,<br>
      Qian<br>
    </p>
    <blockquote type="cite"
      cite="mid:20230817193319.GA3637892@ls.amr.corp.intel.com"> </blockquote>
    <lt-container></lt-container>
  </body>
</html>

--------------37QJYBUDynT1iPOP7FDsgu1d--


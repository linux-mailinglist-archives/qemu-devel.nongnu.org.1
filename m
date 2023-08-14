Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2432977B19E
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 08:34:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVR8V-0007sV-MG; Mon, 14 Aug 2023 02:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qVR8T-0007sH-JW
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:33:05 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qian.wen@intel.com>)
 id 1qVR8R-0000N3-7A
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691994783; x=1723530783;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to;
 bh=CHlDYdmYNu3cyUpqXdWHRw4vN4dCLFAu7IfHbY/vuqg=;
 b=IYEn3PbyquSegEZlu1CEb21j51kcu82gCn4oJgYBtq/sqJX4/AojGDj1
 tnXTmn1Yod0XjaSkoOrzewEt8GXqw2/yAZOefT2mbqi2qxdNWSzxgplbL
 MemRIhXKaKLX7T1/rpqt9MHHOW+579aPA/Qz6KAi+OcEBobzsMDZ17RPK
 m0gLdGZB/ezPi43JZ1teRvyWgWaL+ruEeiVT/8SjpSU/s1dfsQopX8w6W
 wbbVcIQ6QsJQpXwKLiX2+Vn5uxprTsG0f2uzccML2ybzRH06VFEdl8mTR
 94MQh0fcvmv/rJiGwl5y+j95wirWuCGMkZUNFY/ae42hrmj5YdSOmYNxS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="371976533"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
 d="scan'208,217";a="371976533"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2023 23:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="823332986"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
 d="scan'208,217";a="823332986"
Received: from qianwen-mobl1.ccr.corp.intel.com (HELO [10.238.5.29])
 ([10.238.5.29])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2023 23:32:57 -0700
Content-Type: multipart/alternative;
 boundary="------------F81HNbLQBVf2KpKxxr4j9XJf"
Message-ID: <72aa3939-46b8-6664-6bb7-31ce666e5daf@intel.com>
Date: Mon, 14 Aug 2023 14:32:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] target/i386: Avoid cpu number overflow in legacy
 topology
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 babu.moger@amd.com
References: <20230809102732.3124908-1-qian.wen@intel.com>
 <20230809131426.1d9f5821@imammedo.users.ipa.redhat.com>
 <f1710cde-a3ce-6125-2608-c1ebcf4be581@intel.com>
 <20230809154742.494c3697@imammedo.users.ipa.redhat.com>
 <6aa7915c-c39d-ad5f-0171-8516868c9632@intel.com>
 <ZNluSyIAyOxYFomL@liuzhao-OptiPlex-7080>
Content-Language: en-US
From: "Wen, Qian" <qian.wen@intel.com>
In-Reply-To: <ZNluSyIAyOxYFomL@liuzhao-OptiPlex-7080>
Received-SPF: pass client-ip=192.55.52.115; envelope-from=qian.wen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -87
X-Spam_score: -8.8
X-Spam_bar: --------
X-Spam_report: (-8.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-4.359, RCVD_IN_DNSWL_MED=-2.3,
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
--------------F81HNbLQBVf2KpKxxr4j9XJf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/14/2023 7:59 AM, Zhao Liu wrote:
> Hi Qian,
>
> On Sun, Aug 13, 2023 at 06:49:40PM +0800, Wen, Qian wrote:
>
> [snip]
>
>>> also perhaps double check if we could do induce similar overflow
>>> tweaking other -smp properties (todo for another patch[es] if there are such places).
>> I have a check, the CPUID.0x4:EAX[31:26] indicates the Maximum number of addressable IDs for processor cores in the physical package.
>> If we launch over 64 cores VM, the 6-bits field will also overflow. I will add the following fix to patch2 in v3.
> Good catch!
>
> Just discussion, I find if we use APIC ID offset to encode 0x4, then it
> seems no need for an explicit check [1], right?
>
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00027.html

Yes. The offset is always power of 2, so the value written to the 6-bit field likes 0b1111, 0b11111, 0b111111, 0b1111111...
So, EAX[31:26] will be expected, i.e., 0x3f, when the value is overflow and truncated.

>
> Thanks,
> Zhao
>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 52a2a1a1c7..9c1ae3d83d 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -243,6 +243,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
>>                            cache->partitions * cache->sets);
>>
>>      assert(num_apic_ids > 0);
>> +    num_cores = num_cores > 64 ? 64 : num_cores;
>>      *eax = CACHE_TYPE(cache->type) |
>>             CACHE_LEVEL(cache->level) |
>>             (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
>>
>>
>> Thanks,
>> Qian
>>>>>>              *edx |= CPUID_HT;
>>>>>>          }
>>>>>>          if (!cpu->enable_pmu) {  
--------------F81HNbLQBVf2KpKxxr4j9XJf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html data-lt-installed="true">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body style="padding-bottom: 1px;">
    <div class="moz-cite-prefix">On 8/14/2023 7:59 AM, Zhao Liu wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ZNluSyIAyOxYFomL@liuzhao-OptiPlex-7080">
      <pre class="moz-quote-pre" wrap="">Hi Qian,

On Sun, Aug 13, 2023 at 06:49:40PM +0800, Wen, Qian wrote:

[snip]

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">also perhaps double check if we could do induce similar overflow
tweaking other -smp properties (todo for another patch[es] if there are such places).
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
I have a check, the CPUID.0x4:EAX[31:26] indicates the Maximum number of addressable IDs for processor cores in the physical package.
If we launch over 64 cores VM, the 6-bits field will also overflow. I will add the following fix to patch2 in v3.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Good catch!

Just discussion, I find if we use APIC ID offset to encode 0x4, then it
seems no need for an explicit check [1], right?

[1]: <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00027.html">https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00027.html</a></pre>
    </blockquote>
    <br>
    Yes. The offset is always power of 2, so the value written to the
    6-bit field likes 0b1111, 0b11111, 0b111111, 0b1111111...<br>
    So, EAX[31:26] will be expected, i.e., 0x3f, when the value is
    overflow and truncated.<br>
    <br>
    <blockquote type="cite"
      cite="mid:ZNluSyIAyOxYFomL@liuzhao-OptiPlex-7080">
      <pre class="moz-quote-pre" wrap="">

Thanks,
Zhao

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 52a2a1a1c7..9c1ae3d83d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -243,6 +243,7 @@ static void encode_cache_cpuid4(CPUCacheInfo *cache,
                           cache-&gt;partitions * cache-&gt;sets);

     assert(num_apic_ids &gt; 0);
+    num_cores = num_cores &gt; 64 ? 64 : num_cores;
     *eax = CACHE_TYPE(cache-&gt;type) |
            CACHE_LEVEL(cache-&gt;level) |
            (cache-&gt;self_init ? CACHE_SELF_INIT_LEVEL : 0) |


Thanks,
Qian
</pre>
        <blockquote type="cite">
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
      </blockquote>
    </blockquote>
  </body>
  <lt-container></lt-container>
</html>

--------------F81HNbLQBVf2KpKxxr4j9XJf--


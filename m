Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E5782130
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 03:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXtjX-0003zi-Vk; Sun, 20 Aug 2023 21:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qXtjT-0003zX-AP
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 21:29:27 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qXtjO-0001Y2-FL
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 21:29:25 -0400
Received: from [192.168.1.8] (unknown [223.72.70.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id D970C43FBF;
 Mon, 21 Aug 2023 01:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1692581355; bh=yfJsBGol+djbSBpA8ppDT1E5YYJspAhDNvw2d3pb0gA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=SJhp6jbm66MsiLbx+WrZQq5rtWTMyEiUODTFgmBPMI3S7V0Zw7+MaxwYYNWlRf65z
 yYyHXx38KAqyspBv13k5J455edtxafEC24HdSXJKHm35THmmhsDrWRyopdYU9rbKHx
 LgUTMPZnDASmkTCnRSJWTprplJkZZcIxwmysOxcE=
Content-Type: multipart/alternative;
 boundary="------------pQt001bqsV9qC7xMK920djVP"
Message-ID: <df896eaa-599d-26f1-1efa-36e57cd8bc71@jia.je>
Date: Mon, 21 Aug 2023 09:29:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hw/loongarch: Fix ACPI processor id off-by-one error
Content-Language: en-US
To: bibo mao <maobibo@loongson.cn>
Cc: richard.henderson@linaro.org, gaosong@loongson.cn,
 zhaotianrui@loongson.cn, qemu-devel@nongnu.org, =?UTF-8?B?5p2O6aaZ5p2l?=
 <lixianglai@loongson.cn>
References: <20230820105658.99123-2-c@jia.je>
 <5b4b93c2-bfe2-09b0-facd-42f899767451@loongson.cn>
From: Jiajie Chen <c@jia.je>
In-Reply-To: <5b4b93c2-bfe2-09b0-facd-42f899767451@loongson.cn>
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-4.279, SPF_HELO_PASS=-0.001,
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
--------------pQt001bqsV9qC7xMK920djVP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023/8/21 09:24, bibo mao wrote:
> + Add xianglai
>
> Good catch.
>
> In theory, it is logical id, and it can be not equal to physical id.
> However it must be equal to _UID in cpu dsdt table which is missing
> now.

Yes, the logical id can be different from index. The spec says:

If the processor structure represents an actual processor, this field 
must match the value of ACPI processor ID field in the processor’s entry 
in the MADT. If the processor structure represents a group of associated 
processors, the structure might match a processor container in the name 
space. In that case this entry will match the value of the _UID method 
of the associated processor container. Where there is a match it must be 
represented. The flags field, described in/Processor Structure Flags/, 
includes a bit to describe whether the ACPI processor ID is valid.

I believe PPTT, MADT and DSDT should all adhere to the same logical id 
mapping.

>
> Can pptt table parse error be fixed if cpu dsdt table is added?
>
> Regards
> Bibo Mao
>
>
> 在 2023/8/20 18:56, Jiajie Chen 写道:
>> In hw/acpi/aml-build.c:build_pptt() function, the code assumes that the
>> ACPI processor id equals to the cpu index, for example if we have 8
>> cpus, then the ACPI processor id should be in range 0-7.
>>
>> However, in hw/loongarch/acpi-build.c:build_madt() function we broke the
>> assumption. If we have 8 cpus again, the ACPI processor id in MADT table
>> would be in range 1-8. It violates the following description taken from
>> ACPI spec 6.4 table 5.138:
>>
>> If the processor structure represents an actual processor, this field
>> must match the value of ACPI processor ID field in the processor’s entry
>> in the MADT.
>>
>> It will break the latest Linux 6.5-rc6 with the
>> following error message:
>>
>> ACPI PPTT: PPTT table found, but unable to locate core 7 (8)
>> Invalid BIOS PPTT
>>
>> Here 7 is the last cpu index, 8 is the ACPI processor id learned from
>> MADT.
>>
>> With this patch, Linux can properly detect SMT threads when "-smp
>> 8,sockets=1,cores=4,threads=2" is passed:
>>
>> Thread(s) per core:  2
>> Core(s) per socket:  2
>> Socket(s):           2
>>
>> The detection of number of sockets is still wrong, but that is out of
>> scope of the commit.
>>
>> Signed-off-by: Jiajie Chen<c@jia.je>
>> ---
>>   hw/loongarch/acpi-build.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
>> index 0b62c3a2f7..ae292fc543 100644
>> --- a/hw/loongarch/acpi-build.c
>> +++ b/hw/loongarch/acpi-build.c
>> @@ -127,7 +127,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
>>           build_append_int_noprefix(table_data, 17, 1);    /* Type */
>>           build_append_int_noprefix(table_data, 15, 1);    /* Length */
>>           build_append_int_noprefix(table_data, 1, 1);     /* Version */
>> -        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
>> +        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
>>           build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
>>           build_append_int_noprefix(table_data, 1, 4);     /* Flags */
>>       }
--------------pQt001bqsV9qC7xMK920djVP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023/8/21 09:24, bibo mao wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5b4b93c2-bfe2-09b0-facd-42f899767451@loongson.cn">
      <pre class="moz-quote-pre" wrap="">+ Add xianglai

Good catch.

In theory, it is logical id, and it can be not equal to physical id.
However it must be equal to _UID in cpu dsdt table which is missing
now.</pre>
    </blockquote>
    <p>Yes, the logical id can be different from index. The spec says:</p>
    <p><span style="color: rgb(64, 64, 64); font-family: Lato,
        proxima-nova, &quot;Helvetica Neue&quot;, Arial, sans-serif;
        font-size: 16px; font-style: normal; font-variant-ligatures:
        normal; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; widows: 2; word-spacing:
        0px; -webkit-text-stroke-width: 0px; white-space: normal;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">If the
        processor structure represents an actual processor, this field
        must match the value of ACPI processor ID field in the
        processor’s entry in the MADT. If the processor structure
        represents a group of associated processors, the structure might
        match a processor container in the name space. In that case this
        entry will match the value of the _UID method of the associated
        processor container. Where there is a match it must be
        represented. The flags field, described in<span> </span></span><em
        style="box-sizing: border-box; color: rgb(64, 64, 64);
        font-family: Lato, proxima-nova, &quot;Helvetica Neue&quot;,
        Arial, sans-serif; font-size: 16px; font-variant-ligatures:
        normal; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; widows: 2; word-spacing:
        0px; -webkit-text-stroke-width: 0px; white-space: normal;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">Processor Structure Flags</em><span style="color:
        rgb(64, 64, 64); font-family: Lato, proxima-nova,
        &quot;Helvetica Neue&quot;, Arial, sans-serif; font-size: 16px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; white-space: normal;
        background-color: rgb(252, 252, 252); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">, includes a
        bit to describe whether the ACPI processor ID is valid.</span></p>
    <p>I believe PPTT, MADT and DSDT should all adhere to the same
      logical id mapping.<br>
    </p>
    <blockquote type="cite"
      cite="mid:5b4b93c2-bfe2-09b0-facd-42f899767451@loongson.cn">
      <pre class="moz-quote-pre" wrap="">

Can pptt table parse error be fixed if cpu dsdt table is added?

Regards
Bibo Mao


在 2023/8/20 18:56, Jiajie Chen 写道:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">In hw/acpi/aml-build.c:build_pptt() function, the code assumes that the
ACPI processor id equals to the cpu index, for example if we have 8
cpus, then the ACPI processor id should be in range 0-7.

However, in hw/loongarch/acpi-build.c:build_madt() function we broke the
assumption. If we have 8 cpus again, the ACPI processor id in MADT table
would be in range 1-8. It violates the following description taken from
ACPI spec 6.4 table 5.138:

If the processor structure represents an actual processor, this field
must match the value of ACPI processor ID field in the processor’s entry
in the MADT.

It will break the latest Linux 6.5-rc6 with the
following error message:

ACPI PPTT: PPTT table found, but unable to locate core 7 (8)
Invalid BIOS PPTT

Here 7 is the last cpu index, 8 is the ACPI processor id learned from
MADT.

With this patch, Linux can properly detect SMT threads when "-smp
8,sockets=1,cores=4,threads=2" is passed:

Thread(s) per core:  2
Core(s) per socket:  2
Socket(s):           2

The detection of number of sockets is still wrong, but that is out of
scope of the commit.

Signed-off-by: Jiajie Chen <a class="moz-txt-link-rfc2396E" href="mailto:c@jia.je">&lt;c@jia.je&gt;</a>
---
 hw/loongarch/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 0b62c3a2f7..ae292fc543 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -127,7 +127,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
         build_append_int_noprefix(table_data, 17, 1);    /* Type */
         build_append_int_noprefix(table_data, 15, 1);    /* Length */
         build_append_int_noprefix(table_data, 1, 1);     /* Version */
-        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
+        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
         build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
         build_append_int_noprefix(table_data, 1, 4);     /* Flags */
     }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------pQt001bqsV9qC7xMK920djVP--


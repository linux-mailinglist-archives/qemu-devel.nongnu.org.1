Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A66E8BD53E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 May 2024 21:13:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43kq-0006pB-1D; Mon, 06 May 2024 15:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shum.sdl@nppct.ru>) id 1s43km-0006oQ-3P
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:12:00 -0400
Received: from mail.nppct.ru ([195.133.245.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shum.sdl@nppct.ru>) id 1s43kh-0002zk-9G
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:11:59 -0400
Received: from mail.nppct.ru (localhost [127.0.0.1])
 by mail.nppct.ru (Postfix) with ESMTP id DBE701C158F
 for <qemu-devel@nongnu.org>; Mon,  6 May 2024 22:11:41 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
 in-reply-to:from:from:content-language:references:to:subject
 :subject:user-agent:mime-version:date:date:message-id
 :content-type:content-type; s=dkim; t=1715022700; x=1715886701;
 bh=U2rYzKds8VDbjUyJE6Iwx7B8bz/UQJnabEQd+7p6b5w=; b=ilLIQ8SY+K81
 7PMC295B7XYM77+TOoFA1j4KTUjqaXkvzxnzYsP2kf82GaFXjgLZ8nIsULZMgrNM
 zY45AGw2aNTY9zj6KcvEBcyfWP56Ojs7KUFCN2fk4r64rmrpbv+DupBgwT87aPiM
 5LTEttTIbKPvBK2fUEgRr6Mzj3BnJgg=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
 by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id j9ckdUmxr-TG for <qemu-devel@nongnu.org>;
 Mon,  6 May 2024 22:11:40 +0300 (MSK)
Received: from [10.66.66.2] (unknown [176.222.55.70])
 by mail.nppct.ru (Postfix) with ESMTPSA id 6E5BA1C1571;
 Mon,  6 May 2024 22:11:39 +0300 (MSK)
Content-Type: multipart/alternative;
 boundary="------------dQ0IFg4gXZJKeG2jp6HFXw3t"
Message-ID: <3e3d3c9c-e8df-4447-91d9-a156712d57ba@nppct.ru>
Date: Mon, 6 May 2024 22:11:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [sdl-qemu] [PATCH v1] /hw/intc/arm_gic WRONG ARGUMENTS
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <a4cbfe6c-27d6-4df0-ae31-db0d60d88f9e@nppct.ru>
 <95ab6dcf-cc96-4472-93ab-f08682b37d5e@tls.msk.ru>
 <4c4dfebb-698d-466f-90b0-9475ad4c123a@nppct.ru>
 <8734qvuukl.fsf@draig.linaro.org>
Content-Language: ru
From: Andrey Shumilin <shum.sdl@nppct.ru>
In-Reply-To: <8734qvuukl.fsf@draig.linaro.org>
Received-SPF: pass client-ip=195.133.245.4; envelope-from=shum.sdl@nppct.ru;
 helo=mail.nppct.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
--------------dQ0IFg4gXZJKeG2jp6HFXw3t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 1. s - This argument passes a pointer to the GICState structure that
    contains the state of the interrupt controller. This argument is
    passed first and used correctly.
 2. regno - This is the register number, which in the context of
    gic_cpu_read is calculated as (offset - 0xd0) / 4. In gic_cpu_read
    code, this number is used to identify the specific APR register to
    be read or modified. In gic_apr_ns_view, this number is also used to
    determine which NSAPR register to read or how to compute bits,
    implying that it is used as a register index.
 3. cpu - This is the CPU number used to address a particular CPU in the
    nsapr, apr, and other arrays.

Based on the context, it is important that regno and cpu are passed to 
gic_apr_ns_view in the correct order for correct handling of arrays and 
indexes within this function. An error in the order of the arguments can 
result in incorrect data handling, as arrays are indexed first by CPU 
number and then by register number. In the considered call 
gic_apr_ns_view the arguments are passed in the wrong order

06.05.2024 13:02, Alex Bennée пишет:
> Andrey Shumilin<shum.sdl@nppct.ru>  writes:
>
>> 1 Possibly mismatched call arguments in function 'gic_apr_ns_view': 'cpu' and 'regno' passed in place of 'int regno' and 'int
>>   cpu'.
>> 2 Possibly mismatched call arguments in function 'gic_apr_write_ns_view': 'cpu' and 'regno' passed in place of 'int regno' and
>>   'int cpu'.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> So this purely a heuristic test based on the parameter names?
>
>>  From 23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00 2001
>> From: Andrey Shumilin<shum.sdl@nppct.ru>
>> Date: Sun, 5 May 2024 20:13:40 +0300
>> Subject: [PATCH] Patch hw/intc/arm_gic.c
>>
>> Signed-off-by: Andrey Shumilin<shum.sdl@nppct.ru>
>> ---
>>   hw/intc/arm_gic.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>> index 7a34bc0998..47f01e45e3 100644
>> --- a/hw/intc/arm_gic.c
>> +++ b/hw/intc/arm_gic.c
>> @@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>>               *data = s->h_apr[gic_get_vcpu_real_id(cpu)];
>>           } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>>               /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
>> -            *data = gic_apr_ns_view(s, regno, cpu);
>> +            *data = gic_apr_ns_view(s, cpu, regno);
>>           } else {
>>               *data = s->apr[regno][cpu];
>>           }
>> @@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>>               s->h_apr[gic_get_vcpu_real_id(cpu)] = value;
>>           } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>>               /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
>> -            gic_apr_write_ns_view(s, regno, cpu, value);
>> +            gic_apr_write_ns_view(s, cpu, regno, value);
>>           } else {
>>               s->apr[regno][cpu] = value;
>>           }
> Ahh C's lack of strong typing wins again :-/
>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
>
--------------dQ0IFg4gXZJKeG2jp6HFXw3t
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <ol>
      <li>s - This argument passes a pointer to the GICState structure
        that contains the state of the interrupt controller. This
        argument is passed first and used correctly.</li>
      <li>regno - This is the register number, which in the context of
        gic_cpu_read is calculated as (offset - 0xd0) / 4. In
        gic_cpu_read code, this number is used to identify the specific
        APR register to be read or modified. In gic_apr_ns_view, this
        number is also used to determine which NSAPR register to read or
        how to compute bits, implying that it is used as a register
        index.</li>
      <li>cpu - This is the CPU number used to address a particular CPU
        in the nsapr, apr, and other arrays.</li>
    </ol>
    Based on the context, it is important that regno and cpu are passed
    to gic_apr_ns_view in the correct order for correct handling of
    arrays and indexes within this function. An error in the order of
    the arguments can result in incorrect data handling, as arrays are
    indexed first by CPU number and then by register number. In the
    considered call gic_apr_ns_view the arguments are passed in the
    wrong order<br>
    <p></p>
    <div class="moz-cite-prefix">06.05.2024 13:02, Alex Bennée пишет:<br>
    </div>
    <blockquote type="cite" cite="mid:8734qvuukl.fsf@draig.linaro.org">
      <pre class="moz-quote-pre" wrap="">Andrey Shumilin <a class="moz-txt-link-rfc2396E" href="mailto:shum.sdl@nppct.ru">&lt;shum.sdl@nppct.ru&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">1 Possibly mismatched call arguments in function 'gic_apr_ns_view': 'cpu' and 'regno' passed in place of 'int regno' and 'int
 cpu'.
2 Possibly mismatched call arguments in function 'gic_apr_write_ns_view': 'cpu' and 'regno' passed in place of 'int regno' and
 'int cpu'.

Found by Linux Verification Center (linuxtesting.org) with SVACE.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
So this purely a heuristic test based on the parameter names?

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
From 23b142f5046ba9d3aec57217f6d8f3127f9bff69 Mon Sep 17 00:00:00 2001
From: Andrey Shumilin <a class="moz-txt-link-rfc2396E" href="mailto:shum.sdl@nppct.ru">&lt;shum.sdl@nppct.ru&gt;</a>
Date: Sun, 5 May 2024 20:13:40 +0300
Subject: [PATCH] Patch hw/intc/arm_gic.c

Signed-off-by: Andrey Shumilin <a class="moz-txt-link-rfc2396E" href="mailto:shum.sdl@nppct.ru">&lt;shum.sdl@nppct.ru&gt;</a>
---
 hw/intc/arm_gic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 7a34bc0998..47f01e45e3 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1658,7 +1658,7 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
             *data = s-&gt;h_apr[gic_get_vcpu_real_id(cpu)];
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR&lt;n&gt; is the top half of GIC_NSAPR&lt;n&gt; */
-            *data = gic_apr_ns_view(s, regno, cpu);
+            *data = gic_apr_ns_view(s, cpu, regno);
         } else {
             *data = s-&gt;apr[regno][cpu];
         }
@@ -1746,7 +1746,7 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
             s-&gt;h_apr[gic_get_vcpu_real_id(cpu)] = value;
         } else if (gic_cpu_ns_access(s, cpu, attrs)) {
             /* NS view of GICC_APR&lt;n&gt; is the top half of GIC_NSAPR&lt;n&gt; */
-            gic_apr_write_ns_view(s, regno, cpu, value);
+            gic_apr_write_ns_view(s, cpu, regno, value);
         } else {
             s-&gt;apr[regno][cpu] = value;
         }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Ahh C's lack of strong typing wins again :-/

Reviewed-by: Alex Bennée <a class="moz-txt-link-rfc2396E" href="mailto:alex.bennee@linaro.org">&lt;alex.bennee@linaro.org&gt;</a>

</pre>
    </blockquote>
  </body>
</html>

--------------dQ0IFg4gXZJKeG2jp6HFXw3t--


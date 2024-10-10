Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A7899876C
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Oct 2024 15:19:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3z-0008FP-6v; Thu, 10 Oct 2024 09:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1syrff-0003mX-Og; Thu, 10 Oct 2024 07:49:31 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1syrfc-0000ez-EN; Thu, 10 Oct 2024 07:49:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 271F4E000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1728560960; bh=0lTK80os3XtA7KvfezUh3FBr5cgL23Qc5mGV/l6i3HI=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=axSb9HHNtr4z4uHTfMc7zQ/14TvfsL5iG3cwpUOv+GOFw/y/MItM6OH5L5lPpsIUL
 ZP8yB42NeY9CXJxBQXcS28mIHtnqJ5CtGuGt+ETkbFUrizpLjOxZwS1ExHpXlC8M1j
 P+aHG5+ooS+Q4l7B6LcHmVu/ihZlTcUlqKqVxa7cAmJBxSyhc6l9cW/OKO/IjdJUZJ
 Yybtmxz7Si1PaKZTcU0d+d+wB3V+1Xcdb7LuxHFDLU55U54HPpn7VfelCM3sSx4Q4v
 KUDFDugRvemEZ6ODNtrYLC6O1YPFth6s7GcMaZgliaZUpT265ViJPCeAvN9NpLBVzT
 RLCVlNzB4QWhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1728560960; bh=0lTK80os3XtA7KvfezUh3FBr5cgL23Qc5mGV/l6i3HI=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=edIqFWRm2AG6UYI5cvWMT+/aYYLREBAkZ8qoJsyA+JWwqy+Ct42WQA+P+e+kjEhrr
 icQwz9znT8RgJWphJQhXCPalus8QzlCmlN8BhxDCt3Kvxt9lVZcM6iVUUu0sFVtejO
 nL4jHPTcUXA2GQ/yLLi+j+dzUaDa2FWoTuRA5FzNqyz2iQdSOLgu7G58rzRm9MIBGL
 28vtbBdDH3VuqwZLyQW9lJzoehoM4dIpAeW3GatgfZRnbmk3IA4ap5EnsI9uStT+cg
 8E/agm2jYa9ssn2mkfVXgKqB0Hq6vq4j8ma5e55oPixGX6r9BmaFv++DSCWRCeNhlE
 yiVoO6h6NWJAg==
Message-ID: <71a77e97-e55d-41e4-9b3b-bef07c45b015@yadro.com>
Date: Thu, 10 Oct 2024 14:49:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] target/riscv: Add support for machine specific
 pmu's events
To: Atish Kumar Patra <atishp@rivosinc.com>, Alistair Francis
 <alistair23@gmail.com>
CC: Alexei Filippov <alexei.filippov@syntacore.com>, <palmer@dabbelt.com>,
 <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>,
 <liwei1518@gmail.com>, <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
References: <20240910174747.148141-1-alexei.filippov@syntacore.com>
 <CAKmqyKPH33Lf5YdNrdHEQ9K0ZLrnJmvcGi9DjsP6gKNQZYAxaA@mail.gmail.com>
 <CAHBxVyEFDkDm5Tiytiemxohj1YdqdBiKk2YSiFdQ83dqN5zvyw@mail.gmail.com>
Content-Language: en-US
From: Alexei Filippov <alexei.filippov@yadro.com>
In-Reply-To: <CAHBxVyEFDkDm5Tiytiemxohj1YdqdBiKk2YSiFdQ83dqN5zvyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Oct 2024 09:18:36 -0400
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



On 09.10.2024 06:51, Atish Kumar Patra wrote:
> On Mon, Oct 7, 2024 at 7:52 PM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Wed, Sep 11, 2024 at 3:49 AM Alexei Filippov
>> <alexei.filippov@syntacore.com> wrote:
>>>
>>> Following original patch [1] here's a patch with support of machine
>>> specific pmu events and PoC with initial support for sifive_u's HPM.
>>
>> Thanks for the patch.
>>
>> I'm hesitate to support these callback functions as I feel they
>> (callbacks in the CPU to the machine in general) are clunky.
>>
>> I think the cover letter, code and commit messages need more details here.
>>
>> First can you link to the exact spec you are trying to implement
>> (RISC-V has a habit of creating multiple "ratified" specs that are all
>> incompatible). It's really handy to point to the exact PDF in the
>> cover letter or commit message to just be really clear what you are
>> supporting.
>>
> 
> This patch is trying to implement SiFive specific event encodings.
> There is no standard
> RISC-V ISA involved here.
> 
>> Secondly, can you describe why this is useful? What is the point of
>> machine specific PMU events? Why do we want to support this in QEMU?
>>
> 
> I happen to work on a similar implementation as well. Apologies for
> not seeing this patch earlier.
> Here is the link to the series that I have been working on to
> implement a similar feature.
> https://github.com/atishp04/qemu/tree/b4/pmu_event_machine
> I will send it to the mailing list tomorrow after some checkpatch fixes.
> 
> Regarding the motivation, RISC-V ISA doesn't  define any standard
> event encodings.
> The virt machine implemented event encodings defined in the SBI PMU
> extension because
> there was nothing else available. There is an active performance
> events TG who is working on defining
> the standard events for RISC-V but not the encodings. The goal is
> provide flexibility for the platforms while
> allowing a minimum set of events that would work across platforms.
> 
> However, any platform would define their own event encodings and want
> to support those in their Qemu
> machine implementation. That's why, we should disassociate the event
> encodings in the pmu.c to make it
> more generic and usable across machines.
> 
>> The callbacks should also have some documentation in the code base so
>> others can implement the functionality.
>>
>> It might also be helpful to split this patch up a little bit more. A
>> quick read through and it seems like the patches could be a little
>> smaller, making it easier to review.
>>
>> Finally, for the next version CC @Atish Patra  who has ended up being
>> the PMU person :)
>>
> 
> Thanks for Ccing me. I completely missed this patch earlier. Few
> thoughts by looking at this series.
> 
> @Alexei:
> 1. Event encoding needs to be widened to 64 bits. That's what I tried
Hi, Atish, thanks for the review. Does we really need to wide up? Can 
you please share why?
> to achieve with my implementation
> along with a bunch of other cleanups.
> 
> 2. Why do we need machine specific counter write/read functions ? If
> we really need it, we should definitely have that
> as a separate patch as my implementation only focussed on
> disassociating the events and pmu implementation.
Ok, I saw your path and I think we should have this. Just because it's 
more scalable solution. Any event could count differently, but every 1 
of those must count something, as described in their own specs. This 
will make life of perf folks much easier, cz they will be able to debug 
perf on qemu. Same to sbi folks i guess.
> 
> Please take a look at the patches shared above or the mailing list
> (should land tomorrow) and let me know your thoughts.
> I am happy to collaborate on your patches so that we have more than
> just a virt machine that we can test with this series.
Thanks for your series, I have some thoughts about it, I'll describe 
them on your patchset.
> 
>> Alistair
>>
>>>
>>> == Test scenarios ==
>>>
>>> So, I tested this patches on current Linux master with perf.
>>> something like `perf stat -e branch-misses perf bench mem memcpy` works
>>> just fine, also 'perf record -e branch-misses perf bench mem memcpy'
>>> collect samples just fine and `perf report` works.
>>>
>>> == ToDos / Limitations ==
>>>
>>> Second patch is only inital sifive_u's HPM support, without any
>>> filtering, events combining features or differrent counting
>>> algorithm for different events. There are also no tests, but if you
>>> have any suggestions about where I need to look to implement them, please
>>> point me to.
>>>
>>> == Changes since original patch ==
>>>
>>> - Rebased to current master
>>>
>>> [1] https://lore.kernel.org/all/20240625144643.34733-1-alexei.filippov@syntacore.com/
>>>
>>> Alexei Filippov (2):
>>>    target/riscv: Add support for machine specific pmu's events
>>>    hw/riscv/sifive_u.c: Add initial HPM support
>>>
>>>   hw/misc/meson.build            |   1 +
>>>   hw/misc/sifive_u_pmu.c         | 384 +++++++++++++++++++++++++++++++++
>>>   hw/riscv/sifive_u.c            |  14 ++
>>>   include/hw/misc/sifive_u_pmu.h |  24 +++
>>>   target/riscv/cpu.c             |  20 +-
>>>   target/riscv/cpu.h             |   9 +
>>>   target/riscv/csr.c             |  93 +++++---
>>>   target/riscv/pmu.c             | 138 ++++++------
>>>   target/riscv/pmu.h             |  19 +-
>>>   9 files changed, 599 insertions(+), 103 deletions(-)
>>>   create mode 100644 hw/misc/sifive_u_pmu.c
>>>   create mode 100644 include/hw/misc/sifive_u_pmu.h
>>>
>>> --
>>> 2.34.1
>>>
>>>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0184C714F5B
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 20:24:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3hXY-0002zc-IT; Mon, 29 May 2023 14:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hXV-0002zE-RA
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:24:17 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hXT-0001zh-4V
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:24:17 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-256932cea7aso557354a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685384653; x=1687976653;
 h=to:subject:message-id:date:in-reply-to:mime-version:references:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KS1n5ly/U5qB9CxJiabvqoCFWCkO4jvuL7LN+pCTZE4=;
 b=SQTPi4BAnLYCSnrfOzM4+zwWbc0rJQa1Mxdm0+18k9yeTnqAPj+m+KGel9HtPg1IK1
 kaH+B1Z2RKecc2u5o3eTG818BP5yDaJ4hUmj8I5TyhxYy0ICa+malAbuOGTYWETYFuxy
 IfzQUSJfuacHUc3AsrJh3aNp9LikCOBqar4DGOzM3W1L6MBbGTclSViYvrKVJT69lQA6
 5RLmuwWH6liBRcq4xKmV8YLd7QKXRdhw5O/2tIwGwpQ8jn0oiQvsx4nBnAq9B/OQsp17
 8riaSzLUFybW+a/qPKY1wX5/ZIMBFEF5m0TTx7Uo6AQCS2qIMPmExyVIl8mRe94hYMb+
 j0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685384653; x=1687976653;
 h=to:subject:message-id:date:in-reply-to:mime-version:references:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KS1n5ly/U5qB9CxJiabvqoCFWCkO4jvuL7LN+pCTZE4=;
 b=E510PSq9+gJJp31HLI7NVBDajcr/Tnyj11PnAy6x/FcZjOun4V+m5xatTwnCKu4Qs2
 X+ixmLt1GQi4t+mhYu9N2sRmxo1d8JAjti5tYuxoN9E3CAcU27OK2cEZA8W+ae0Pmj8e
 AXIEVOYK79gPWo0pjqFlWniHh55kzeDaxw902IQZxdWr408E0k5cSkK6gwvolrvJO3n4
 EMsJ/YexJZpWlJp4XTPfa30BgdtoyLe5MFzSJQS1VE45q8M+jWjQllVtH9AygS3QCALs
 OvcOtJQIhhp8NwGIuh4as64wF9QyzwwXS+UH/NeV9vJGSBo9JMH9k5fLSlZZ9vxAXYb8
 2B0w==
X-Gm-Message-State: AC+VfDwDfDIxteszfX1RvbhU8/J5Xss0QNZnTPtZ4TbNYg8Ex1vH0QH/
 w4QeK3K4H8SmNCEKRNlfKV4A/mJxRPeU2G1lvMBiYw==
X-Google-Smtp-Source: ACHHUZ7JJghewCkEW1xSof3Y9zIBJKBK4LTh+3LyoQyMQm/6uvBJQDPy4nlfYePd0r6Cx08aHQ2br/UfgcpMkWX22RI=
X-Received: by 2002:a17:90a:d3d2:b0:255:63e0:1248 with SMTP id
 d18-20020a17090ad3d200b0025563e01248mr104051pjw.0.1685384653185; Mon, 29 May
 2023 11:24:13 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 29 May 2023 11:24:12 -0700
From: Hao Xiang <hao.xiang@bytedance.com>
References: <20230529182001.2232069-1-hao.xiang@bytedance.com>
Mime-Version: 1.0
In-Reply-To: <20230529182001.2232069-1-hao.xiang@bytedance.com>
Date: Mon, 29 May 2023 11:24:12 -0700
Message-ID: <CAAYibXhxpjVuBSooJ9h8KaZry2C9LmANQa=jso3C7mqLSJB4uA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add Intel Data Streaming Accelerator offloading
To: pbonzini@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009049d005fcd93129"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--0000000000009049d005fcd93129
Content-Type: text/plain; charset="UTF-8"

Hi all, this is meant to be an RFC. Sorry I didn't put that in the email
subject correctly.
From: "Hao Xiang"<hao.xiang@bytedance.com>
Date:  Mon, May 29, 2023, 11:20
Subject:  [PATCH 0/4] Add Intel Data Streaming Accelerator offloading
To: <pbonzini@redhat.com>, <quintela@redhat.com>, <qemu-devel@nongnu.org>
Cc: "Hao Xiang"<hao.xiang@bytedance.com>
* Idea:

Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th
generation
Xeon server, aka Sapphire Rapids.
https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator

One of the things DSA can do is to offload memory comparison workload from
CPU to DSA accelerator hardware. This change proposes a solution to offload
QEMU's zero page checking from CPU to DSA accelerator hardware. For this to
work, I am looking into two potential improvements during QEMU background
operations, eg, VM checkpoint, VM live migration.

1. Reduce CPU usage.

I did a simple tracing for the save VM workload. I started VMs with
64GB RAM, 128GB RAM and 256GB RAM respectively and then ran the "savevm"
command from QEMU's commandline. During this savevm workload, I recorded
the CPU cycles spent in function save_snapshot and the total CPU cycles
spent in repeated callings into function buffer_is_zero, which performs
zero page checking.

|------------------------------------------|
|VM memory  |save_snapshot  |buffer_is_zero|
|capacity   |(CPU cycles)   |(CPU cycles)  |
|------------------------------------------|
|64GB       |19449838924    |5022504892    |
|------------------------------------------|
|128GB      |36966951760    |10049561066   |
|------------------------------------------|
|256GB      |72744615676    |20042076440   |
|------------------------------------------|

In the three scenarios, the CPU cycles spent in zero page checking accounts
roughly 27% of the total cycles spent in save_snapshot. I believe this is
due
to the fact that a large part of save_snapshot performs file IO operations
writing all memory pages into the QEMU image file and there is a linear
increase
on CPU cycles spent in savevm as the VM's total memory increases. If we can
offload all zero page checking function calls to the DSA accelerator, we
will
reduce the CPU usage by 27% in the savevm workload, potentially freeing CPU
resources for other work. The same savings should apply to live VM
migration
workload as well. Furthermore, if the guest VM's vcpu shares the same
physical
CPU core used for live migration, the guest VM will gain more underlying
CPU
resource and hence making the guest VM more responsive to it's own guest
workload
during live migration.

2. Reduce operation latency.

I did some benchmark testing on pure CPU memomory comparison implementation
and DSA hardware offload implementation.

Testbed: Intel(R) Xeon(R) Platinum 8457C, CPU 3100MHz

Latency is measured by completing memory comparison on two memory buffers,
each
with one GB in size. The memory comparison are done via CPU and DSA
accelerator
respectively. When performing CPU memory comparison, I use a single thread.
When
performing DSA accelerator memory comparison, I use one DSA engine. While
doing
memory comparison, both CPU and DSA based implementation uses 4k memory
buffer
as the granularity for comparison.

|-------------------------------|
|Memory           |Latency      |
|-------------------------------|
|CPU one thread   |80ms         |
|-------------------------------|
|DSA one engine   |89ms         |
|-------------------------------|

In our test system, we have two sockets and two DSA devices per socket.
Each
DSA device has four engines built in. I believe that if we leverage more
DSA
engine resources and a good parallelization on zero page checking, we can
keep the DSA devices busy and reduce CPU usage.

* Current state:

This patch implements the DSA offloading operation for zero page checking.
User can optionally replace the zero page checking function with DSA
offloading
by specifying a new argument in qemu start up commandline. There is no
performance gain in this change. This is mainly because zero page checking
is
a synchronous operation and each page size is 4k. Offloading a single 4k
memory
page comparison to the DSA accelerator and wait for the driver to complete
the operation introduces overhead. Currently the overhead is bigger than
the CPU cycles saved due to offloading.

* Future work:

1. Need to make the zero page checking workflow asynchronous. The idea is
that
we can throw lots of zero page checking operations at once to
N(configurable)
DSA engines. Then we wait for those operations to be completed by idxd (DSA
device driver). Currently ram_save_iterate has a loop to iterate through
all
the memory blocks, find the dirty pages and save them all. The loop exits
when there is no more dirty pages to save. I think when we walk through all
the memory blocks, we just need to identify whether there is dirty pages
remaining but we can do the actual "save page" asynchronously. We can
return
from ram_save_iterate when we finish walking through the memory blocks and
all pages are saved. This sounds like a pretty large refactoring change and
I am looking hard into this path to figure out exactly how I can tackle it.
Any feedback would be really appreciated.

2. Need to implement an abstraction layer where QEMU can just throw zero
page
checking operations to the DSA layer and the DSA layer will figure out
which
work queue/engine to handle the operation. Probably we can use a
round-robin
dispatcher to balance the work across multiple DSA engines.

3. The current patch uses busy loop to pull for DSA completions and that's
really a bad practice. I need to either use the umonitor/umwait
instructions
or user mode interrupt for true async completion.

4. The DSA device can also offload other operations.
* memcpy
* xbzrle encoding/decoding
* crc32

base-commit: ac84b57b4d74606f7f83667a0606deef32b2049d

Hao Xiang (4):
  Introduce new instruction set enqcmd/mmovdir64b to the build system.
  Add dependency idxd.
  Implement zero page checking using DSA.
  Add QEMU command line argument to enable DSA offloading.

include/qemu/cutils.h                |   6 +
linux-headers/linux/idxd.h           | 356 +++++++++++++++++++++++++++
meson.build                          |   3 +
meson_options.txt                    |   4 +
migration/ram.c                      |   4 +
qemu-options.hx                      |  10 +
scripts/meson-buildoptions.sh        |   6 +
softmmu/runstate.c                   |   4 +
softmmu/vl.c                         |  22 ++
storage-daemon/qemu-storage-daemon.c |   2 +
util/bufferiszero.c                  |  14 ++
util/dsa.c                           | 295 ++++++++++++++++++++++
util/meson.build                     |   1 +
13 files changed, 727 insertions(+)
create mode 100644 linux-headers/linux/idxd.h
create mode 100644 util/dsa.c

-- 
2.30.2

--0000000000009049d005fcd93129
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_1.26.2_FU83OjiQ" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div class=3D"" style=3D"font-size:14px">Hi all, this is me=
ant to be an RFC. Sorry I didn&#39;t put that in the email subject correctl=
y.
</div></div></div><div class=3D"history-quote-wrapper" style=3D"word-break:=
break-word" id=3D"lark-mail-quote-168538464"><div id=3D"lark-mail-quote-9df=
10ac34e8d800b96ce3bb9dedc7f31"><div class=3D"adit-html-block__attr history-=
quote-meta-wrapper history-quote-gap-tag" style=3D"padding:12px;background:=
rgb(245,246,247);color:rgb(31,35,41);border-radius:4px;margin-top:24px;marg=
in-bottom:12px" id=3D"lark-mail-quote-meta-Shf2bNzNk"><div class=3D"history=
-quote-line quote-head-meta-line" style=3D"margin:0px"><div class=3D"">From=
: &quot;Hao Xiang&quot;&lt;<a class=3D"quote-head-meta-mailto" target=3D"_b=
lank" rel=3D"noopener noreferrer" href=3D"mailto:hao.xiang@bytedance.com" s=
tyle=3D"text-decoration:none;color:inherit">hao.xiang@bytedance.com</a>&gt;
</div></div><div class=3D"history-quote-line quote-head-meta-line" style=3D=
"margin:0px"><div class=3D"">Date:=C2=A0 Mon, May 29, 2023, 11:20
</div></div><div class=3D"history-quote-line quote-head-meta-line" style=3D=
"margin:0px"><div class=3D"">Subject:=C2=A0 [PATCH 0/4] Add Intel Data Stre=
aming Accelerator offloading
</div></div><div class=3D"history-quote-line quote-head-meta-line" style=3D=
"margin:0px"><div class=3D"">To: &lt;<a class=3D"quote-head-meta-mailto" ta=
rget=3D"_blank" rel=3D"noopener noreferrer" href=3D"mailto:pbonzini@redhat.=
com" style=3D"text-decoration:none;color:inherit">pbonzini@redhat.com</a>&g=
t;, &lt;<a class=3D"quote-head-meta-mailto" target=3D"_blank" rel=3D"noopen=
er noreferrer" href=3D"mailto:quintela@redhat.com" style=3D"text-decoration=
:none;color:inherit">quintela@redhat.com</a>&gt;, &lt;<a class=3D"quote-hea=
d-meta-mailto" target=3D"_blank" rel=3D"noopener noreferrer" href=3D"mailto=
:qemu-devel@nongnu.org" style=3D"text-decoration:none;color:inherit">qemu-d=
evel@nongnu.org</a>&gt;
</div></div><div class=3D"history-quote-line quote-head-meta-line" style=3D=
"margin:0px"><div class=3D"">Cc: &quot;Hao Xiang&quot;&lt;<a class=3D"quote=
-head-meta-mailto" target=3D"_blank" rel=3D"noopener noreferrer" href=3D"ma=
ilto:hao.xiang@bytedance.com" style=3D"text-decoration:none;color:inherit">=
hao.xiang@bytedance.com</a>&gt;
</div></div></div><div class=3D"history-quote-line" style=3D"margin-top:4px=
;margin-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px=
">* Idea:
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">Inte=
l Data Streaming Accelerator(DSA) is introduced in Intel&#39;s 4th generati=
on
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">Xeon=
 server, aka Sapphire Rapids.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><a h=
ref=3D"https://01.org/blogs/2019/introducing-intel-data-streaming-accelerat=
or" target=3D"_blank" rel=3D"noopener noreferrer" style=3D"margin-right:2px=
;text-decoration:none;color:rgb(51,112,255)">https://01.org/blogs/2019/intr=
oducing-intel-data-streaming-accelerator</a>
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">One =
of the things DSA can do is to offload memory comparison workload from
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">CPU =
to DSA accelerator hardware. This change proposes a solution to offload
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">QEMU=
&#39;s zero page checking from CPU to DSA accelerator hardware. For this to
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">work=
, I am looking into two potential improvements during QEMU background
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">oper=
ations, eg, VM checkpoint, VM live migration.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">1. R=
educe CPU usage.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">I di=
d a simple tracing for the save VM workload. I started VMs with
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">64GB=
 RAM, 128GB RAM and 256GB RAM respectively and then ran the &quot;savevm&qu=
ot;
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">comm=
and from QEMU&#39;s commandline. During this savevm workload, I recorded
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">the =
CPU cycles spent in function save_snapshot and the total CPU cycles
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">spen=
t in repeated callings into function buffer_is_zero, which performs
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">zero=
 page checking.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
---------------------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|VM =
memory=C2=A0 |save_snapshot=C2=A0 |buffer_is_zero|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|cap=
acity =C2=A0 |(CPU cycles) =C2=A0 |(CPU cycles)=C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
---------------------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|64G=
B =C2=A0 =C2=A0 =C2=A0 |19449838924 =C2=A0=C2=A0 |5022504892 =C2=A0=C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
---------------------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|128=
GB =C2=A0 =C2=A0=C2=A0 |36966951760 =C2=A0=C2=A0 |10049561066 =C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
---------------------------------------|=20
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|256=
GB =C2=A0 =C2=A0=C2=A0 |72744615676 =C2=A0=C2=A0 |20042076440 =C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
---------------------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">In t=
he three scenarios, the CPU cycles spent in zero page checking accounts
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">roug=
hly 27% of the total cycles spent in save_snapshot. I believe this is due
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">to t=
he fact that a large part of save_snapshot performs file IO operations
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">writ=
ing all memory pages into the QEMU image file and there is a linear increas=
e
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">on C=
PU cycles spent in savevm as the VM&#39;s total memory increases. If we can
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">offl=
oad all zero page checking function calls to the DSA accelerator, we will
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">redu=
ce the CPU usage by 27% in the savevm workload, potentially freeing CPU
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">reso=
urces for other work. The same savings should apply to live VM migration
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">work=
load as well. Furthermore, if the guest VM&#39;s vcpu shares the same physi=
cal
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">CPU =
core used for live migration, the guest VM will gain more underlying CPU
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">reso=
urce and hence making the guest VM more responsive to it&#39;s own guest wo=
rkload
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">duri=
ng live migration.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">2. R=
educe operation latency.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">I di=
d some benchmark testing on pure CPU memomory comparison implementation
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">and =
DSA hardware offload implementation.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">Test=
bed: Intel(R) Xeon(R) Platinum 8457C, CPU 3100MHz
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">Late=
ncy is measured by completing memory comparison on two memory buffers, each
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">with=
 one GB in size. The memory comparison are done via CPU and DSA accelerator
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">resp=
ectively. When performing CPU memory comparison, I use a single thread. Whe=
n
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">perf=
orming DSA accelerator memory comparison, I use one DSA engine. While doing
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">memo=
ry comparison, both CPU and DSA based implementation uses 4k memory buffer
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">as t=
he granularity for comparison.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
----------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|Mem=
ory =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |Latency =C2=A0 =C2=A0=C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
----------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|CPU=
 one thread =C2=A0 |80ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
----------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|DSA=
 one engine =C2=A0 |89ms =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">|---=
----------------------------|
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">In o=
ur test system, we have two sockets and two DSA devices per socket. Each
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">DSA =
device has four engines built in. I believe that if we leverage more DSA
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">engi=
ne resources and a good parallelization on zero page checking, we can
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">keep=
 the DSA devices busy and reduce CPU usage.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">* Cu=
rrent state:
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">This=
 patch implements the DSA offloading operation for zero page checking.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">User=
 can optionally replace the zero page checking function with DSA offloading
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">by s=
pecifying a new argument in qemu start up commandline. There is no
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">perf=
ormance gain in this change. This is mainly because zero page checking is
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">a sy=
nchronous operation and each page size is 4k. Offloading a single 4k memory
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">page=
 comparison to the DSA accelerator and wait for the driver to complete
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">the =
operation introduces overhead. Currently the overhead is bigger than
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">the =
CPU cycles saved due to offloading.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">* Fu=
ture work:
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">1. N=
eed to make the zero page checking workflow asynchronous. The idea is that
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">we c=
an throw lots of zero page checking operations at once to N(configurable)
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">DSA =
engines. Then we wait for those operations to be completed by idxd (DSA
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">devi=
ce driver). Currently ram_save_iterate has a loop to iterate through all
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">the =
memory blocks, find the dirty pages and save them all. The loop exits
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">when=
 there is no more dirty pages to save. I think when we walk through all
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">the =
memory blocks, we just need to identify whether there is dirty pages
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">rema=
ining but we can do the actual &quot;save page&quot; asynchronously. We can=
 return
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">from=
 ram_save_iterate when we finish walking through the memory blocks and
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">all =
pages are saved. This sounds like a pretty large refactoring change and
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">I am=
 looking hard into this path to figure out exactly how I can tackle it.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">Any =
feedback would be really appreciated.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">2. N=
eed to implement an abstraction layer where QEMU can just throw zero page=
=20
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">chec=
king operations to the DSA layer and the DSA layer will figure out which
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">work=
 queue/engine to handle the operation. Probably we can use a round-robin
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">disp=
atcher to balance the work across multiple DSA engines.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">3. T=
he current patch uses busy loop to pull for DSA completions and that&#39;s
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">real=
ly a bad practice. I need to either use the umonitor/umwait instructions
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">or u=
ser mode interrupt for true async completion.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">4. T=
he DSA device can also offload other operations.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">* me=
mcpy
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">* xb=
zrle encoding/decoding
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">* cr=
c32
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">base=
-commit: ac84b57b4d74606f7f83667a0606deef32b2049d
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">Hao =
Xiang (4):
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">=C2=
=A0 Introduce new instruction set enqcmd/mmovdir64b to the build system.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">=C2=
=A0 Add dependency idxd.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">=C2=
=A0 Implement zero page checking using DSA.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">=C2=
=A0 Add QEMU command line argument to enable DSA offloading.
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> inc=
lude/qemu/cutils.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 |=
 =C2=A0 6 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> lin=
ux-headers/linux/idxd.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 356 ++++++++++=
+++++++++++++++++
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> mes=
on.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 | =C2=A0 3 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> mes=
on_options.txt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 | =C2=A0 4 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> mig=
ration/ram.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 | =C2=A0 4 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> qem=
u-options.hx =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 |=C2=A0 10 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> scr=
ipts/<a href=3D"http://meson-buildoptions.sh" target=3D"_blank" rel=3D"noop=
ener noreferrer" style=3D"margin-right:2px;text-decoration:none;color:rgb(5=
1,112,255)">meson-buildoptions.sh</a> =C2=A0 =C2=A0 =C2=A0=C2=A0 | =C2=A0 6=
 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> sof=
tmmu/runstate.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 4 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> sof=
tmmu/vl.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 22 ++
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> sto=
rage-daemon/qemu-storage-daemon.c | =C2=A0 2 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> uti=
l/bufferiszero.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 |=C2=A0 14 ++
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> uti=
l/dsa.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 295 ++++++++++++++++++++++
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> uti=
l/meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 1 +
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> 13 =
files changed, 727 insertions(+)
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> cre=
ate mode 100644 linux-headers/linux/idxd.h
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"> cre=
ate mode 100644 util/dsa.c
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px"><br>=
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">--=
=20
</div></div><div class=3D"history-quote-line" style=3D"margin-top:4px;margi=
n-bottom:4px;line-height:1.6"><div class=3D"" style=3D"font-size:14px">2.30=
.2
</div></div></div></div></body></html>

--0000000000009049d005fcd93129--


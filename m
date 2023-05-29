Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E2714F50
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 20:21:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3hU2-0007eb-Nc; Mon, 29 May 2023 14:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hTv-0007d3-0B
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:35 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1q3hTs-000188-BN
 for qemu-devel@nongnu.org; Mon, 29 May 2023 14:20:34 -0400
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-75b0830e2eeso198973685a.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1685384427; x=1687976427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BggNljHfcJbLJLIyE85YN720z+WQF80G9jGtpEeXnXQ=;
 b=LamlQkYiEqGwn+gFaLthgvbx8nkZW+g3oFJ+czSo6qW8NBl697VBK1xJjdPejqN+vM
 +jbTYb0cxdUepXXipY9Y/JhK6uhME9nT10eSF71UkRgdqIDyuYL7ymozrDte0nwlcc9+
 JZa3CTBc7uiZd6yWE1aZBU7EK7XCGHc7Ks0yCWpvwGe7bNZyK/q5Nz9kp7bKZUiTAYen
 JNoxEvmSraxvnAsqu7gxLBAd3hS11drhQsO3yTON+xSnhCz6iaCsDypzdWw4cD4ggFED
 o3OHO752do3MRQ/kg9kruHHIDsV7Y9dS1ra+DwddDWgwz+Cqz8GfyvAmAE/fFE5Mu22T
 fPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685384427; x=1687976427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BggNljHfcJbLJLIyE85YN720z+WQF80G9jGtpEeXnXQ=;
 b=Spk6wGc9LZBs2SQ+b6RSz52doAnasRejPlJ6KzNWjEi2yTUuqfM6x1OvT+b0UALwi2
 Y7qDi4QFbHy1h1dlZTFCdQDX435TLSxDNI0Boo+f3pPSHYp2ow2TqZ55E1vmF6Np1TY0
 CpUsTHufKhq/6vJtra1EFSD1h8e2Co93nAK2UznQ+jJh4mj1N622CK2RIAvZwCq9S5dT
 HQjyGvqigsOEWV2EYznfm2fv9htYM8ipBhLg0ZekwP1q5Gotu2Rng/1FH4/Ga9xKPCRe
 NAK0gjslhk9T264TerW8hAQ65XWK1EVkWEb87BPkTpzGyscMUwl0ah/Ia7sWgPdXUEUQ
 E4yg==
X-Gm-Message-State: AC+VfDw+GHvg8vfH6ghV9wsowCTiEjn/JoYwoD8OP9pIWf7SMi3Jz+5n
 q/2jBLNh29lgXUCBkYBgPNWN0w==
X-Google-Smtp-Source: ACHHUZ4c5Ob/kCQPCKy0cSIeDuQXihwzyx7d9twBVMvdKjAq69JkaCIbx7WWm0zHPhmD7tc8Cym5Fg==
X-Received: by 2002:a05:620a:2b11:b0:75b:23a1:d85a with SMTP id
 do17-20020a05620a2b1100b0075b23a1d85amr8413709qkb.28.1685384426897; 
 Mon, 29 May 2023 11:20:26 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.95])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a05620a126f00b0074e3cf3b44dsm2873314qkl.125.2023.05.29.11.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 11:20:26 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com,
	quintela@redhat.com,
	qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 0/4] Add Intel Data Streaming Accelerator offloading
Date: Mon, 29 May 2023 18:19:57 +0000
Message-Id: <20230529182001.2232069-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

* Idea:

Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th generation
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
roughly 27% of the total cycles spent in save_snapshot. I believe this is due
to the fact that a large part of save_snapshot performs file IO operations
writing all memory pages into the QEMU image file and there is a linear increase
on CPU cycles spent in savevm as the VM's total memory increases. If we can
offload all zero page checking function calls to the DSA accelerator, we will
reduce the CPU usage by 27% in the savevm workload, potentially freeing CPU
resources for other work. The same savings should apply to live VM migration
workload as well. Furthermore, if the guest VM's vcpu shares the same physical
CPU core used for live migration, the guest VM will gain more underlying CPU
resource and hence making the guest VM more responsive to it's own guest workload
during live migration.

2. Reduce operation latency.

I did some benchmark testing on pure CPU memomory comparison implementation
and DSA hardware offload implementation.

Testbed: Intel(R) Xeon(R) Platinum 8457C, CPU 3100MHz

Latency is measured by completing memory comparison on two memory buffers, each
with one GB in size. The memory comparison are done via CPU and DSA accelerator
respectively. When performing CPU memory comparison, I use a single thread. When
performing DSA accelerator memory comparison, I use one DSA engine. While doing
memory comparison, both CPU and DSA based implementation uses 4k memory buffer
as the granularity for comparison.

|-------------------------------|
|Memory           |Latency      |
|-------------------------------|
|CPU one thread   |80ms         |
|-------------------------------|
|DSA one engine   |89ms         |
|-------------------------------|

In our test system, we have two sockets and two DSA devices per socket. Each
DSA device has four engines built in. I believe that if we leverage more DSA
engine resources and a good parallelization on zero page checking, we can
keep the DSA devices busy and reduce CPU usage.

* Current state:

This patch implements the DSA offloading operation for zero page checking.
User can optionally replace the zero page checking function with DSA offloading
by specifying a new argument in qemu start up commandline. There is no
performance gain in this change. This is mainly because zero page checking is
a synchronous operation and each page size is 4k. Offloading a single 4k memory
page comparison to the DSA accelerator and wait for the driver to complete
the operation introduces overhead. Currently the overhead is bigger than
the CPU cycles saved due to offloading.

* Future work:

1. Need to make the zero page checking workflow asynchronous. The idea is that
we can throw lots of zero page checking operations at once to N(configurable)
DSA engines. Then we wait for those operations to be completed by idxd (DSA
device driver). Currently ram_save_iterate has a loop to iterate through all
the memory blocks, find the dirty pages and save them all. The loop exits
when there is no more dirty pages to save. I think when we walk through all
the memory blocks, we just need to identify whether there is dirty pages
remaining but we can do the actual "save page" asynchronously. We can return
from ram_save_iterate when we finish walking through the memory blocks and
all pages are saved. This sounds like a pretty large refactoring change and
I am looking hard into this path to figure out exactly how I can tackle it.
Any feedback would be really appreciated.

2. Need to implement an abstraction layer where QEMU can just throw zero page 
checking operations to the DSA layer and the DSA layer will figure out which
work queue/engine to handle the operation. Probably we can use a round-robin
dispatcher to balance the work across multiple DSA engines.

3. The current patch uses busy loop to pull for DSA completions and that's
really a bad practice. I need to either use the umonitor/umwait instructions
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



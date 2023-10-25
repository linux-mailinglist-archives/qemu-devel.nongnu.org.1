Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC55A7D7482
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjij-0000ma-P8; Wed, 25 Oct 2023 15:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjie-0000mL-7z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:08 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjia-0005wz-UF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:08 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-66cfc96f475so728266d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262738; x=1698867538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OImnXVOVX/6nAD5BnV6zruyVE+5cXlOfLSHr10TvICo=;
 b=gtE5gYC2vpYE1lzhFE8aSoACG1Nx3uJreoXyaaVK1USXYILWuHFd777SajOVrzNzmd
 3b86ilETAZGIzCtqpOgS6dowDUBSxfJVvdTyLK6LKcWVQ39Vz2L3jcA+V9FMENz1aITR
 0sCVUVqC+pd8ZvGqfwtdTHTER0WeiYllYsdUHQ6MIyGscW2hbT2E8iesnlDsyDRhrlwY
 z6C77GviqNDvCBz4BdmZR4NSyRmCJGE/b7dIqjRp8+K5DpLTLBmDwUlV7UsL8xfMCYq8
 xCc6H64Ug/tSWlOJFFto9hXXEDlpbfYLEEssoQ04k6Isr0UdyJdeLNlqcoycR0Eh76+e
 w5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262738; x=1698867538;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OImnXVOVX/6nAD5BnV6zruyVE+5cXlOfLSHr10TvICo=;
 b=oBcXkAl3pOoZMRTfWxQlv3rBBKdMv8lgmtqjZnzOMw+ZLJVXa2C8CHxR/c7Raparfe
 BaSvKwaPkj3uWPANTFtr1EGjC0HLfW9Y1ait98r8Kewy7YScjjd7yaa3U39k9kWIgpV7
 OeekGfPjItOcAK0gmrKZPvAK8w4E33aDe9rPhPMyFjouUq59F8qnxEaTgj+sur/5RTgj
 hVtuHXVyzXEhUNVQryFYROwixNXBkytrMy+GjzPFQue2R9PU0INsM6WDAAx4QBzPw/da
 lp7kfcLlfjhI+smqK9zsAyoTQLfInNq7auaeb+AFSBFqd8VQ3vgfZFZUl7mvigIzOxr4
 yb/Q==
X-Gm-Message-State: AOJu0YyvuXJlhNj8VfM2m3/sIUBkxwakNDY93QZQf0IgCR4stGjZloSr
 Sw0zoVfnoziGK9ewYsr4EbYmMw==
X-Google-Smtp-Source: AGHT+IGNjrZ+eXOqi+hbDFdQ7fTi6qqP5aOFdIAX+erahczz1a1Jzp2Um7L5uBn3MqpwiQyjYxLw8A==
X-Received: by 2002:a05:6214:230e:b0:66d:9d28:3686 with SMTP id
 gc14-20020a056214230e00b0066d9d283686mr19741663qvb.53.1698262738538; 
 Wed, 25 Oct 2023 12:38:58 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:38:58 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 00/16] Use Intel DSA accelerator to offload zero page checking
 in multifd live migration.
Date: Wed, 25 Oct 2023 19:38:06 +0000
Message-Id: <20231025193822.2813204-1-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

* Background:
I posted an RFC about DSA offloading in QEMU:
https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.com/

This patchset implements the DSA offloading on zero page checking in
multifd live migration code path.

* Overview:
Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th generation
Xeon server, aka Sapphire Rapids.
https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator

One of the things DSA can do is to offload memory comparison workload from
CPU to DSA accelerator hardware. This patchset implements a solution to offload
QEMU's zero page checking from CPU to DSA accelerator hardware. We gain
two benefits from this change:
1. Reduces CPU usage in multifd live migration workflow across all use
cases.
2. Reduces migration total time in some use cases. 

* Design:

These are the logical steps to perform DSA offloading:
1. Configure DSA accelerators and create user space openable DSA work
queues via the idxd driver.
2. Map DSA's work queue into a user space address space.
3. Fill an in-memory task descriptor to describe the memory operation.
4. Use dedicated CPU instruction _enqcmd to queue a task descriptor to
the work queue.
5. Pull the task descriptor's completion status field until the task
completes.
6. Check return status.

The memory operation is now totally done by the accelerator hardware but
the new workflow introduces overheads. The overhead is the extra cost CPU
prepares and submits the task descriptors and the extra cost CPU pulls for
completion. The design is around minimizing these two overheads.

1. In order to reduce the overhead on task preparation and submission,
we use batch descriptors. A batch descriptor will contain N individual
zero page checking tasks where the default N is 128 (default packet size
/ page size) and we can increase N by setting the packet size via a new
migration option.
2. The multifd sender threads prepares and submits batch tasks to DSA
hardware and it waits on a synchronization object for task completion.
Whenever a DSA task is submitted, the task structure is added to a
thread safe queue. It's safe to have multiple multifd sender threads to
submit tasks concurrently.
3. Multiple DSA hardware devices can be used. During multifd initialization,
every sender thread will be assigned a DSA device to work with. We
use a round-robin scheme to evenly distribute the work across all used
DSA devices.
4. Use a dedicated thread dsa_completion to perform busy pulling for all
DSA task completions. The thread keeps dequeuing DSA tasks from the
thread safe queue. The thread blocks when there is no outstanding DSA
task. When pulling for completion of a DSA task, the thread uses CPU
instruction _mm_pause between the iterations of a busy loop to save some
CPU power as well as optimizing core resources for the other hypercore.
5. DSA accelerator can encounter errors. The most popular error is a
page fault. We have tested using devices to handle page faults but
performance is bad. Right now, if DSA hits a page fault, we fallback to
use CPU to complete the rest of the work. The CPU fallback is done in
the multifd sender thread.
6. Added a new migration option multifd-dsa-accel to set the DSA device
path. If set, the multifd workflow will leverage the DSA devices for
offloading.
7. Added a new migration option multifd-normal-page-ratio to make
multifd live migration easier to test. Setting a normal page ratio will
make live migration recognize a zero page as a normal page and send
the entire payload over the network. If we want to send a large network
payload and analyze throughput, this option is useful.
8. Added a new migration option multifd-packet-size. This can increase
the number of pages being zero page checked and sent over the network.
The extra synchronization between the sender threads and the dsa
completion thread is an overhead. Using a large packet size can reduce
that overhead.

* Performance:

We use two Intel 4th generation Xeon servers for testing.

Architecture:        x86_64
CPU(s):              192
Thread(s) per core:  2
Core(s) per socket:  48
Socket(s):           2
NUMA node(s):        2
Vendor ID:           GenuineIntel
CPU family:          6
Model:               143
Model name:          Intel(R) Xeon(R) Platinum 8457C
Stepping:            8
CPU MHz:             2538.624
CPU max MHz:         3800.0000
CPU min MHz:         800.0000

We perform multifd live migration with below setup:
1. VM has 100GB memory. 
2. Use the new migration option multifd-set-normal-page-ratio to control the total
size of the payload sent over the network.
3. Use 8 multifd channels.
4. Use tcp for live migration.
4. Use CPU to perform zero page checking as the baseline.
5. Use one DSA device to offload zero page checking to compare with the baseline.
6. Use "perf sched record" and "perf sched timehist" to analyze CPU usage.

A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.

	CPU usage

	|---------------|---------------|---------------|---------------|
	|		|comm		|runtime(msec)	|totaltime(msec)|
	|---------------|---------------|---------------|---------------|
	|Baseline	|live_migration	|5657.58	|		|
	|		|multifdsend_0	|3931.563	|		|
	|		|multifdsend_1	|4405.273	|		|
	|		|multifdsend_2	|3941.968	|		|
	|		|multifdsend_3	|5032.975	|		|
	|		|multifdsend_4	|4533.865	|		|
	|		|multifdsend_5	|4530.461	|		|
	|		|multifdsend_6	|5171.916	|		|
	|		|multifdsend_7	|4722.769	|41922		|
	|---------------|---------------|---------------|---------------|
	|DSA		|live_migration	|6129.168	|		|
	|		|multifdsend_0	|2954.717	|		|
	|		|multifdsend_1	|2766.359	|		|
	|		|multifdsend_2	|2853.519	|		|
	|		|multifdsend_3	|2740.717	|		|
	|		|multifdsend_4	|2824.169	|		|
	|		|multifdsend_5	|2966.908	|		|
	|		|multifdsend_6	|2611.137	|		|
	|		|multifdsend_7	|3114.732	|		|
	|		|dsa_completion	|3612.564	|32568		|
	|---------------|---------------|---------------|---------------|

Baseline total runtime is calculated by adding up all multifdsend_X
and live_migration threads runtime. DSA offloading total runtime is
calculated by adding up all multifdsend_X, live_migration and
dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
that is 23% total CPU usage savings.

	Latency
	|---------------|---------------|---------------|---------------|---------------|---------------|
	|		|total time	|down time	|throughput	|transferred-ram|total-ram	|
	|---------------|---------------|---------------|---------------|---------------|---------------|	
	|Baseline	|10343 ms	|161 ms		|41007.00 mbps	|51583797 kb	|102400520 kb	|
	|---------------|---------------|---------------|---------------|-------------------------------|
	|DSA offload	|9535 ms	|135 ms		|46554.40 mbps	|53947545 kb	|102400520 kb	|	
	|---------------|---------------|---------------|---------------|---------------|---------------|

Total time is 8% faster and down time is 16% faster.

B) Scenario 2: 100% (100GB) zero pages on an 100GB vm.

	CPU usage
	|---------------|---------------|---------------|---------------|
	|		|comm		|runtime(msec)	|totaltime(msec)|
	|---------------|---------------|---------------|---------------|
	|Baseline	|live_migration	|4860.718	|		|
	|	 	|multifdsend_0	|748.875	|		|
	|		|multifdsend_1	|898.498	|		|
	|		|multifdsend_2	|787.456	|		|
	|		|multifdsend_3	|764.537	|		|
	|		|multifdsend_4	|785.687	|		|
	|		|multifdsend_5	|756.941	|		|
	|		|multifdsend_6	|774.084	|		|
	|		|multifdsend_7	|782.900	|11154		|
	|---------------|---------------|-------------------------------|
	|DSA offloading	|live_migration	|3846.976	|		|
	|		|multifdsend_0	|191.880	|		|
	|		|multifdsend_1	|166.331	|		|
	|		|multifdsend_2	|168.528	|		|
	|		|multifdsend_3	|197.831	|		|
	|		|multifdsend_4	|169.580	|		|
	|		|multifdsend_5	|167.984	|		|
	|		|multifdsend_6	|198.042	|		|
	|		|multifdsend_7	|170.624	|		|
	|		|dsa_completion	|3428.669	|8700		|
	|---------------|---------------|---------------|---------------|

Baseline total runtime is 11154 msec and DSA offloading total runtime is
8700 msec. That is 22% CPU savings.

	Latency
	|--------------------------------------------------------------------------------------------|
	|		|total time	|down time	|throughput	|transferred-ram|total-ram   |
	|---------------|---------------|---------------|---------------|---------------|------------|	
	|Baseline	|4867 ms	|20 ms		|1.51 mbps	|565 kb		|102400520 kb|
	|---------------|---------------|---------------|---------------|----------------------------|
	|DSA offload	|3888 ms	|18 ms		|1.89 mbps	|565 kb		|102400520 kb|	
	|---------------|---------------|---------------|---------------|---------------|------------|

Total time 20% faster and down time 10% faster.

* Testing:
1. Added unit tests for cover the added code path in dsa.c
2. Added integration tests to cover multifd live migration using DSA
offloading.

* Patchset
Apply this patchset on top of commit
800485762e6564e04e2ab315132d477069562d91

Hao Xiang (16):
  Cherry pick a set of patches that enables multifd zero page feature.
  meson: Introduce new instruction set enqcmd to the build system.
  util/dsa: Add dependency idxd.
  util/dsa: Implement DSA device start and stop logic.
  util/dsa: Implement DSA task enqueue and dequeue.
  util/dsa: Implement DSA task asynchronous completion thread model.
  util/dsa: Implement zero page checking in DSA task.
  util/dsa: Implement DSA task asynchronous submission and wait for
    completion.
  migration/multifd: Add new migration option for multifd DSA
    offloading.
  migration/multifd: Enable DSA offloading in multifd sender path.
  migration/multifd: Add test hook to set normal page ratio.
  migration/multifd: Enable set normal page ratio test hook in multifd.
  migration/multifd: Add migration option set packet size.
  migration/multifd: Enable set packet size migration option.
  util/dsa: Add unit test coverage for Intel DSA task submission and
    completion.
  migration/multifd: Add integration tests for multifd with Intel DSA
    offloading.

 include/qemu/dsa.h             |  119 ++++
 linux-headers/linux/idxd.h     |  356 ++++++++++
 meson.build                    |    2 +
 meson_options.txt              |    2 +
 migration/migration-hmp-cmds.c |   22 +
 migration/migration-stats.h    |    8 +-
 migration/multifd-zlib.c       |    4 +-
 migration/multifd-zstd.c       |    4 +-
 migration/multifd.c            |  220 ++++++-
 migration/multifd.h            |   25 +-
 migration/options.c            |  105 +++
 migration/options.h            |    4 +
 migration/ram.c                |   47 +-
 migration/trace-events         |    8 +-
 qapi/migration.json            |   51 +-
 scripts/meson-buildoptions.sh  |    3 +
 tests/qtest/migration-test.c   |   66 +-
 tests/unit/meson.build         |    6 +
 tests/unit/test-dsa.c          |  448 +++++++++++++
 util/dsa.c                     | 1132 ++++++++++++++++++++++++++++++++
 util/meson.build               |    1 +
 21 files changed, 2577 insertions(+), 56 deletions(-)
 create mode 100644 include/qemu/dsa.h
 create mode 100644 linux-headers/linux/idxd.h
 create mode 100644 tests/unit/test-dsa.c
 create mode 100644 util/dsa.c

-- 
2.30.2



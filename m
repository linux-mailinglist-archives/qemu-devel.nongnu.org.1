Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 677877EC9DB
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:44:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Jv9-0001Ek-EO; Wed, 15 Nov 2023 12:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1r3Jv6-0001EL-PT
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:43:20 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1r3Jv3-000596-Va
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:43:20 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507a98517f3so9410298e87.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700070195; x=1700674995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJJdpz1jkQqkifk+VhhkVAAHiOy0sGKO7S8sFm6iwBc=;
 b=EuvQfy7ge8bi20VY1JkNg6qzuIbOnFJ1QSjUqNITIXy9OruxlAvbGa4ldWQD9ZNeEd
 tqM1M12BNc/RLTee8qCDPJf8PRufQjQik4OFE1LG9rS58VhhqHSMMZZep4E0DRtEgdnF
 5BaMv2ovxm49gGzVYg25ZWLJQOEJPWQulLsoO6bxxZW7LpTAvU0pWaXwBHjJ8Ukfn+sZ
 +dAdaQgOYDJFjZuFGCroaXNVTVkQ2lEKrk+SzZqhqMSSZLAty2pQHaKf7yKqmSkoB+Gh
 5gtdctwvz62EPLM/iEkZrs1yoHiCRJoDoqhuljEWMvKIdU0gD/4en1rmboi2pCe1Yvij
 Tz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700070195; x=1700674995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJJdpz1jkQqkifk+VhhkVAAHiOy0sGKO7S8sFm6iwBc=;
 b=w6O51D5EMv3HGacfQIMLv3Cd9+vOIrUDcggY8RGJQhE+lLDphEgUJGxQL4/aeyBPyS
 I2KFa8yf7wVeJbFUtFkbQYj6GF8zhnGOou883YSx0goh0Y5kQ8bB8FjBbXcrC9tt4WIt
 PxcHIsYGcozkykr5tEA4uMqZBnrxcU2hd4WFUyUBT6bnc9DYKe3T+uFvRuZFlNvFJRE1
 6k3zR/G6ulbn11EjVRoCwRYUVAGO8361HYAdxJpNojerRV8kI69gddQVnmz156A9FWkk
 ytNGkIhNhCt1MPK3D8mHhPVQG6jo9JsSgboDVTgLrOttJ4KiqRiH4y3uLP/dftfTn93j
 +dPw==
X-Gm-Message-State: AOJu0Yyf4XEMM43M5z49zGLovVfGtcJ5ClhskECCl1sQKt/sUAQXFhE9
 pqA1MtXuHEmtl2d3tpqzBQ5LGWj6tYLSzv9tU5w=
X-Google-Smtp-Source: AGHT+IHoZirQyPIgmSWy2vTn4Bgmfy50UPcxCk1aiahBYm7fhfafcPoVY4dlqsAdgRESaFQpe3cIfZnXRZobTlpyJ9M=
X-Received: by 2002:a19:4f47:0:b0:4fb:7559:aea3 with SMTP id
 a7-20020a194f47000000b004fb7559aea3mr8907994lfk.39.1700070195179; Wed, 15 Nov
 2023 09:43:15 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Wed, 15 Nov 2023 09:43:03 -0800
Message-ID: <CAEr7rXj4Oqq8umVDJfqrA0ooQt5E=XrWDVBOA_bhkRnzzDauFw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] Use Intel DSA accelerator to offload zero page
 checking in multifd live migration.
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com, 
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=ufimtseva@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello Hao,

On Mon, Nov 13, 2023 at 9:42=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:
>
> v2
> * Rebase on top of 3e01f1147a16ca566694b97eafc941d62fa1e8d8.
> * Leave Juan's changes in their original form instead of squashing them.
> * Add a new commit to refactor the multifd_send_thread function to prepar=
e for introducing the DSA offload functionality.
> * Use page count to configure multifd-packet-size option.
> * Don't use the FLAKY flag in DSA tests.
> * Test if DSA integration test is setup correctly and skip the test if
> * not.
> * Fixed broken link in the previous patch cover.
>
> * Background:
>
> I posted an RFC about DSA offloading in QEMU:
> https://patchew.org/QEMU/20230529182001.2232069-1-hao.xiang@bytedance.com=
/
>
> This patchset implements the DSA offloading on zero page checking in
> multifd live migration code path.
>


Do you have performance numbers with different packet sizes for DSA
and non-DSA cases?
What have you found was an optimal size for DSA offloading?

Thank you!
> * Overview:
>
> Intel Data Streaming Accelerator(DSA) is introduced in Intel's 4th genera=
tion
> Xeon server, aka Sapphire Rapids.
> https://cdrdv2-public.intel.com/671116/341204-intel-data-streaming-accele=
rator-spec.pdf
> https://www.intel.com/content/www/us/en/content-details/759709/intel-data=
-streaming-accelerator-user-guide.html
> One of the things DSA can do is to offload memory comparison workload fro=
m
> CPU to DSA accelerator hardware. This patchset implements a solution to o=
ffload
> QEMU's zero page checking from CPU to DSA accelerator hardware. We gain
> two benefits from this change:
> 1. Reduces CPU usage in multifd live migration workflow across all use
> cases.
> 2. Reduces migration total time in some use cases.
>
> * Design:
>
> These are the logical steps to perform DSA offloading:
> 1. Configure DSA accelerators and create user space openable DSA work
> queues via the idxd driver.
> 2. Map DSA's work queue into a user space address space.
> 3. Fill an in-memory task descriptor to describe the memory operation.
> 4. Use dedicated CPU instruction _enqcmd to queue a task descriptor to
> the work queue.
> 5. Pull the task descriptor's completion status field until the task
> completes.
> 6. Check return status.
>
> The memory operation is now totally done by the accelerator hardware but
> the new workflow introduces overheads. The overhead is the extra cost CPU
> prepares and submits the task descriptors and the extra cost CPU pulls fo=
r
> completion. The design is around minimizing these two overheads.
>
> 1. In order to reduce the overhead on task preparation and submission,
> we use batch descriptors. A batch descriptor will contain N individual
> zero page checking tasks where the default N is 128 (default packet size
> / page size) and we can increase N by setting the packet size via a new
> migration option.
> 2. The multifd sender threads prepares and submits batch tasks to DSA
> hardware and it waits on a synchronization object for task completion.
> Whenever a DSA task is submitted, the task structure is added to a
> thread safe queue. It's safe to have multiple multifd sender threads to
> submit tasks concurrently.
> 3. Multiple DSA hardware devices can be used. During multifd initializati=
on,
> every sender thread will be assigned a DSA device to work with. We
> use a round-robin scheme to evenly distribute the work across all used
> DSA devices.
> 4. Use a dedicated thread dsa_completion to perform busy pulling for all
> DSA task completions. The thread keeps dequeuing DSA tasks from the
> thread safe queue. The thread blocks when there is no outstanding DSA
> task. When pulling for completion of a DSA task, the thread uses CPU
> instruction _mm_pause between the iterations of a busy loop to save some
> CPU power as well as optimizing core resources for the other hypercore.
> 5. DSA accelerator can encounter errors. The most popular error is a
> page fault. We have tested using devices to handle page faults but
> performance is bad. Right now, if DSA hits a page fault, we fallback to
> use CPU to complete the rest of the work. The CPU fallback is done in
> the multifd sender thread.
> 6. Added a new migration option multifd-dsa-accel to set the DSA device
> path. If set, the multifd workflow will leverage the DSA devices for
> offloading.
> 7. Added a new migration option multifd-normal-page-ratio to make
> multifd live migration easier to test. Setting a normal page ratio will
> make live migration recognize a zero page as a normal page and send
> the entire payload over the network. If we want to send a large network
> payload and analyze throughput, this option is useful.
> 8. Added a new migration option multifd-packet-size. This can increase
> the number of pages being zero page checked and sent over the network.
> The extra synchronization between the sender threads and the dsa
> completion thread is an overhead. Using a large packet size can reduce
> that overhead.
>
> * Performance:
>
> We use two Intel 4th generation Xeon servers for testing.
>
> Architecture:        x86_64
> CPU(s):              192
> Thread(s) per core:  2
> Core(s) per socket:  48
> Socket(s):           2
> NUMA node(s):        2
> Vendor ID:           GenuineIntel
> CPU family:          6
> Model:               143
> Model name:          Intel(R) Xeon(R) Platinum 8457C
> Stepping:            8
> CPU MHz:             2538.624
> CPU max MHz:         3800.0000
> CPU min MHz:         800.0000
>
> We perform multifd live migration with below setup:
> 1. VM has 100GB memory.
> 2. Use the new migration option multifd-set-normal-page-ratio to control =
the total
> size of the payload sent over the network.
> 3. Use 8 multifd channels.
> 4. Use tcp for live migration.
> 4. Use CPU to perform zero page checking as the baseline.
> 5. Use one DSA device to offload zero page checking to compare with the b=
aseline.
> 6. Use "perf sched record" and "perf sched timehist" to analyze CPU usage=
.
>
> A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
>
>         CPU usage
>
>         |---------------|---------------|---------------|---------------|
>         |               |comm           |runtime(msec)  |totaltime(msec)|
>         |---------------|---------------|---------------|---------------|
>         |Baseline       |live_migration |5657.58        |               |
>         |               |multifdsend_0  |3931.563       |               |
>         |               |multifdsend_1  |4405.273       |               |
>         |               |multifdsend_2  |3941.968       |               |
>         |               |multifdsend_3  |5032.975       |               |
>         |               |multifdsend_4  |4533.865       |               |
>         |               |multifdsend_5  |4530.461       |               |
>         |               |multifdsend_6  |5171.916       |               |
>         |               |multifdsend_7  |4722.769       |41922          |
>         |---------------|---------------|---------------|---------------|
>         |DSA            |live_migration |6129.168       |               |
>         |               |multifdsend_0  |2954.717       |               |
>         |               |multifdsend_1  |2766.359       |               |
>         |               |multifdsend_2  |2853.519       |               |
>         |               |multifdsend_3  |2740.717       |               |
>         |               |multifdsend_4  |2824.169       |               |
>         |               |multifdsend_5  |2966.908       |               |
>         |               |multifdsend_6  |2611.137       |               |
>         |               |multifdsend_7  |3114.732       |               |
>         |               |dsa_completion |3612.564       |32568          |
>         |---------------|---------------|---------------|---------------|
>
> Baseline total runtime is calculated by adding up all multifdsend_X
> and live_migration threads runtime. DSA offloading total runtime is
> calculated by adding up all multifdsend_X, live_migration and
> dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> that is 23% total CPU usage savings.
>
>         Latency
>         |---------------|---------------|---------------|---------------|=
---------------|---------------|
>         |               |total time     |down time      |throughput     |=
transferred-ram|total-ram      |
>         |---------------|---------------|---------------|---------------|=
---------------|---------------|
>         |Baseline       |10343 ms       |161 ms         |41007.00 mbps  |=
51583797 kb    |102400520 kb   |
>         |---------------|---------------|---------------|---------------|=
-------------------------------|
>         |DSA offload    |9535 ms        |135 ms         |46554.40 mbps  |=
53947545 kb    |102400520 kb   |
>         |---------------|---------------|---------------|---------------|=
---------------|---------------|
>
> Total time is 8% faster and down time is 16% faster.
>
> B) Scenario 2: 100% (100GB) zero pages on an 100GB vm.
>
>         CPU usage
>         |---------------|---------------|---------------|---------------|
>         |               |comm           |runtime(msec)  |totaltime(msec)|
>         |---------------|---------------|---------------|---------------|
>         |Baseline       |live_migration |4860.718       |               |
>         |               |multifdsend_0  |748.875        |               |
>         |               |multifdsend_1  |898.498        |               |
>         |               |multifdsend_2  |787.456        |               |
>         |               |multifdsend_3  |764.537        |               |
>         |               |multifdsend_4  |785.687        |               |
>         |               |multifdsend_5  |756.941        |               |
>         |               |multifdsend_6  |774.084        |               |
>         |               |multifdsend_7  |782.900        |11154          |
>         |---------------|---------------|-------------------------------|
>         |DSA offloading |live_migration |3846.976       |               |
>         |               |multifdsend_0  |191.880        |               |
>         |               |multifdsend_1  |166.331        |               |
>         |               |multifdsend_2  |168.528        |               |
>         |               |multifdsend_3  |197.831        |               |
>         |               |multifdsend_4  |169.580        |               |
>         |               |multifdsend_5  |167.984        |               |
>         |               |multifdsend_6  |198.042        |               |
>         |               |multifdsend_7  |170.624        |               |
>         |               |dsa_completion |3428.669       |8700           |
>         |---------------|---------------|---------------|---------------|
>
> Baseline total runtime is 11154 msec and DSA offloading total runtime is
> 8700 msec. That is 22% CPU savings.
>
>         Latency
>         |----------------------------------------------------------------=
----------------------------|
>         |               |total time     |down time      |throughput     |=
transferred-ram|total-ram   |
>         |---------------|---------------|---------------|---------------|=
---------------|------------|
>         |Baseline       |4867 ms        |20 ms          |1.51 mbps      |=
565 kb         |102400520 kb|
>         |---------------|---------------|---------------|---------------|=
----------------------------|
>         |DSA offload    |3888 ms        |18 ms          |1.89 mbps      |=
565 kb         |102400520 kb|
>         |---------------|---------------|---------------|---------------|=
---------------|------------|
>
> Total time 20% faster and down time 10% faster.
>
> * Testing:
>
> 1. Added unit tests for cover the added code path in dsa.c
> 2. Added integration tests to cover multifd live migration using DSA
> offloading.
>
> * Patchset
>
> Apply this patchset on top of commit
> f78ea7ddb0e18766ece9fdfe02061744a7afc41b
>
> Hao Xiang (16):
>   meson: Introduce new instruction set enqcmd to the build system.
>   util/dsa: Add dependency idxd.
>   util/dsa: Implement DSA device start and stop logic.
>   util/dsa: Implement DSA task enqueue and dequeue.
>   util/dsa: Implement DSA task asynchronous completion thread model.
>   util/dsa: Implement zero page checking in DSA task.
>   util/dsa: Implement DSA task asynchronous submission and wait for
>     completion.
>   migration/multifd: Add new migration option for multifd DSA
>     offloading.
>   migration/multifd: Prepare to introduce DSA acceleration on the
>     multifd path.
>   migration/multifd: Enable DSA offloading in multifd sender path.
>   migration/multifd: Add test hook to set normal page ratio.
>   migration/multifd: Enable set normal page ratio test hook in multifd.
>   migration/multifd: Add migration option set packet size.
>   migration/multifd: Enable set packet size migration option.
>   util/dsa: Add unit test coverage for Intel DSA task submission and
>     completion.
>   migration/multifd: Add integration tests for multifd with Intel DSA
>     offloading.
>
> Juan Quintela (4):
>   multifd: Add capability to enable/disable zero_page
>   multifd: Support for zero pages transmission
>   multifd: Zero pages transmission
>   So we use multifd to transmit zero pages.
>
>  include/qemu/dsa.h             |  119 ++++
>  linux-headers/linux/idxd.h     |  356 ++++++++++
>  meson.build                    |    2 +
>  meson_options.txt              |    2 +
>  migration/migration-hmp-cmds.c |   22 +
>  migration/multifd-zlib.c       |    8 +-
>  migration/multifd-zstd.c       |    8 +-
>  migration/multifd.c            |  203 +++++-
>  migration/multifd.h            |   28 +-
>  migration/options.c            |  107 +++
>  migration/options.h            |    4 +
>  migration/ram.c                |   45 +-
>  migration/trace-events         |    8 +-
>  qapi/migration.json            |   53 +-
>  scripts/meson-buildoptions.sh  |    3 +
>  tests/qtest/migration-test.c   |   77 ++-
>  tests/unit/meson.build         |    6 +
>  tests/unit/test-dsa.c          |  466 +++++++++++++
>  util/dsa.c                     | 1132 ++++++++++++++++++++++++++++++++
>  util/meson.build               |    1 +
>  20 files changed, 2612 insertions(+), 38 deletions(-)
>  create mode 100644 include/qemu/dsa.h
>  create mode 100644 linux-headers/linux/idxd.h
>  create mode 100644 tests/unit/test-dsa.c
>  create mode 100644 util/dsa.c
>
> --
> 2.30.2
>
>


--=20
Elena


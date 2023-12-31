Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB298820E98
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 22:23:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rK3G8-0001Hf-Qg; Sun, 31 Dec 2023 16:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2uo-00077x-7S
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:10 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rK2ul-0007AI-Lu
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 16:00:09 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-781600ab3d8so334282485a.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 13:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704056401; x=1704661201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1pM+6S5s1kWcUzrk/umGDrUTZJMQU/N8lp5nzmz05i8=;
 b=VyYg25qq87bPYMsts8ChaGC87Z2jrPp46USjMpbmMfmkyYMGkAaXazYuG0ufJlg1lk
 bgbQ3Luq9ThVITF2cobTDeFTnW6GpI56lY6r/SCfhyR5sIhosjIvAbd9tx+pyremHkzO
 saux7PzoHKe2+83Mw/46h9hU0vkx5GqkfgOsDn4Wzx2ZcAaOGOAYeofX+Xzzk5QfHNPc
 dKoNCqqAu1nkQSBQfehblOEgk9h8fN2HCjebeWrskg50dDkb9d9DZ1ub8p1JN8f3dZ/6
 Rw8WJPMYSdMbdQDS4pukrOo2hoS8EcZo2xD15KDnjBqVyFc2aUPAAwLH+K24wo6XUgcJ
 Ox9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704056401; x=1704661201;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1pM+6S5s1kWcUzrk/umGDrUTZJMQU/N8lp5nzmz05i8=;
 b=NUkyTaJzBxDWwdlBi5hGv2MUMa/62uANmaD1kkzVUrMTDSg2xdsuF5iUk9Z1ojKXKX
 0KkgaE0TgadOH2Mpy5pLBde9m+FE99hFiFvbnn0OkbApD15WmXR5yHwvRW1rMbFwwr9R
 D8gXtvnG49Kz4RhjOaINpP3GEx1z9/1pm3QYwOEidRlItyPbdvyhWXGL71qVLgpbHE6R
 SMrTQoNbtuc41wdP5dUAabbWIKhWGK+Bd0qCj1IOoSVKtYVjtU6CVFHqjxB6GsAfvwwS
 2611/NGVtkUSGr4a3HDW41GXOMqM8gEzK41HRdypt9e9SAAv2AoTbPfXr6zg7FXEMXQb
 ZN7g==
X-Gm-Message-State: AOJu0YxvVPx24974XFUrDQZNWGimaqYu3eHHRKI9z6tzNJlU5T0KpOMs
 LzJ/uiJOsxL7d4Jvm/74nLq2Ybq1tfF5GZQccge7xeefGx7UVA==
X-Google-Smtp-Source: AGHT+IEcg1YPDqcJfQ48G2IE/ryWxY0UzUS1ktfXrdDN9UjvefAToTPQFywj2Yea0axYIFoIUunsKQ==
X-Received: by 2002:a05:620a:1362:b0:781:5efd:403b with SMTP id
 d2-20020a05620a136200b007815efd403bmr9233059qkl.13.1704056400933; 
 Sun, 31 Dec 2023 13:00:00 -0800 (PST)
Received: from n36-186-108.byted.org. ([147.160.184.90])
 by smtp.gmail.com with ESMTPSA id
 pb21-20020a05620a839500b007811da87cefsm8111750qkn.127.2023.12.31.13.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 13:00:00 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org, farosas@suse.de, marcandre.lureau@redhat.com,
 peterx@redhat.com, quintela@redhat.com, peter.maydell@linaro.org,
 hao.xiang@bytedance.com
Cc: bryan.zhang@bytedance.com
Subject: [PATCH 0/5] *** Implement using Intel QAT to offload ZLIB
Date: Sun, 31 Dec 2023 20:57:59 +0000
Message-Id: <20231231205804.2366509-1-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RAZOR2_CF_RANGE_51_100=1.886,
 RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 31 Dec 2023 16:22:08 -0500
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

* Overview:

This patchset implements using Intel's QAT accelerator to offload ZLIB compression and decompression in the multifd live migration path.

* Background:

Intel's 4th generation Xeon processors support Intel's QuickAssist Technology (QAT), a hardware accelerator for cryptography and compression operations.

Intel has also released a software library, QATzip, that interacts with QAT and exposes an API for QAT-accelerated ZLIB compression and decompression.

This patchset introduces a new multifd compression method, `qatzip`, which uses QATzip to perform ZLIB compression and decompression.

* Implementation:

The bulk of this patchset is in `migration/multifd-qatzip.c`, which mirrors the other compression implementation files, `migration/multifd-zlib.c` and `migration/multifd-zstd.c`, by providing an implementation of the multifd send/recv methods using the API exposed by QATzip. This is fairly straightforward, as the multifd setup/prepare/teardown methods align closely with QATzip's methods for initialization/(de)compression/teardown.

The only major divergence from the other compression methods is that we use a non-streaming compression/decompression API, as opposed to streaming each page to the compression layer one at a time. This does not require any major code changes - by the time we want to call to the compression layer, we already have a batch of pages, so it is easy to copy them into a contiguous buffer. This decision is purely performance-based, as our initial QAT benchmark testing showed that QATzip's non-streaming API outperformed the streaming API.

* Performance:

** Setup:

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

Each server has two QAT devices, and the network bandwidth between the two servers is 1Gbps.

We perform multifd live migration over TCP using a VM with 64GB memory. We prepared the machine's memory by powering it on, allocating a large amount of memory (63GB) as a single buffer, and filling the buffer with the repeated contents of the Silesia corpus[0]. This is in lieu of a more realistic memory snapshot, which proved troublesome to acquire.

We analyzed CPU usage by averaging the output of `top` every second during live migration. This is admittedly imprecise, but we feel that it accurately portrays the different degrees of CPU usage of varying compression methods.

We present the latency, throughput, and CPU usage results for all of the compression methods, with varying numbers of multifd threads (4, 8, and 16).

[0] The Silesia corpus can be accessed here: https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia

** Results:

4 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         |111.256        |916.03          | 29.08%  | 51.90   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |193.033        |562.16          |297.36%  |237.84   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           |112.449        |920.67          |234.39%  |157.57   |
    |---------------|---------------|----------------|---------|---------|
    |none           |327.014        |933.41          |  9.50%  | 25.28   |
    |---------------|---------------|----------------|---------|---------|

8 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         |111.349        |915.20          | 29.13%  | 59.63   |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |149.378        |726.64          |516.24%  |400.46   |
    |---------------|---------------|----------------|---------|---------|
    |zstd           |111.942        |925.85          |345.75%  |170.74   |
    |---------------|---------------|----------------|---------|---------|
    |none           |327.417        |933.34          |  8.38%  | 27.72   |
    |---------------|---------------|----------------|---------|---------|

16 multifd threads:

    |---------------|---------------|----------------|---------|---------|
    |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
    |---------------|---------------|----------------|---------|---------|
    |qatzip         |112.035        |908.96          | 29.93%  | 63.83%  |
    |---------------|---------------|----------------|---------|---------|
    |zlib           |118.730        |912.94          |914.14%  |621.59%  |
    |---------------|---------------|----------------|---------|---------|
    |zstd           |112.167        |924.78          |384.81%  |171.54%  |
    |---------------|---------------|----------------|---------|---------|
    |none           |327.728        |932.08          |  9.31%  | 29.89%  |
    |---------------|---------------|----------------|---------|---------|

** Observations:

Latency: In our test setting, live migration is mostly network-constrained, so compression performs relatively well in general. `qatzip` particularly shows a significant improvement over `zlib` with limited threads. With 4 multifd threads, `qatzip` shows a ~42% decrease in latency over `zlib`. In all scenarios, `qatzip` shows comparable performance with `zstd`.

Throughput: In all scenarios, nearly all compression methods reach nearly the entire network throughput of 1Gbps except for `zlib`, which appears to be CPU-bound with 4 and 8 threads, but reaches comparable throughput performance with the other methods at 16 threads.

CPU usage: In all scenarios, `qatzip` consumes a fraction of the CPU usage that `zlib` and `zstd` use. In the most limited case, with 4 multifd threads, `qatzip`'s sender CPU usage is ~10% that of `zlib`, and ~12% that of `zstd`, and its receiver CPU usage is ~22% that of `zlib`, and ~33% that of `zstd`. The magnitude of these savings increases as we increase to 8 and 16 threads.

* Future work:

- Comparing QAT offloading against other compression methods in environments that are not as network-constrained.
- Combining compression offloading with offloading using other Intel accelerators (e.g. using Intel's Data Streaming Accelerator to offload zero page checking, which is part of another related patchset currently under discussion, and to offload `memcpy()` operations on the receiver side).
- Reworking multifd logic to pipeline live migration work to improve device saturation.

* Testing:

This patchset adds an integration test for the new `qatzip` multifd compression method.

* Patchset:

This patchset was generated on top of commit 7425b627.

Bryan Zhang (5):
  meson: Introduce 'qatzip' feature to the build system.
  migration: Add compression level parameter for QATzip
  migration: Introduce unimplemented 'qatzip' compression method
  migration: Implement 'qatzip' methods using QAT
  migration: Add integration test for 'qatzip' compression method

 hw/core/qdev-properties-system.c |   6 +-
 meson.build                      |  10 +
 meson_options.txt                |   2 +
 migration/meson.build            |   1 +
 migration/migration-hmp-cmds.c   |   4 +
 migration/multifd-qatzip.c       | 369 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   1 +
 migration/options.c              |  27 +++
 migration/options.h              |   1 +
 qapi/migration.json              |  24 +-
 scripts/meson-buildoptions.sh    |   3 +
 tests/qtest/meson.build          |   4 +
 tests/qtest/migration-test.c     |  37 ++++
 13 files changed, 486 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

-- 
2.30.2



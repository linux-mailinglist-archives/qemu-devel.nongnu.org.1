Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A147821334
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jan 2024 08:55:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKD7Q-00052H-E9; Mon, 01 Jan 2024 02:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rKD7L-00051C-BH
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 02:53:47 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rKD7H-0007QB-9v
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 02:53:46 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42827177e55so1323791cf.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704095616; x=1704700416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VyV5hnp91TeiHstvaoYF9rVSsCdsGMAQzGHGfrO6Wsw=;
 b=lPasiO5WH2tkXo/i6E1Q6gr5nisv4LXAqy9mfxuePCCCSNiuSQgLje3ra78Ufi9HNG
 CiqJn8DngG73EUgkdwhh6JiEJmKAlwvgi3x6QusysAHDd0rDjLvWj2SYS1bi0hE+TEPi
 V/67oGZ4YFezf6/ygq3NOyHF0VyAVVBS1D8Bf1WsMES7GQfZpQmhtOY+cXZ/7nNEB0c7
 kLxzNBVzP4gSAgFuwIRiMLNy37dDxJ2q4v3SUa4RRQeigZejj/0D5ifLSp7cJMJYShVQ
 9Bwp32iYq2R+asUoSH9iI9vlZDPrVS0isP1oP/Q80ko4zMJDRS5HJ34XA+W6CLdm/wXX
 1kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704095616; x=1704700416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VyV5hnp91TeiHstvaoYF9rVSsCdsGMAQzGHGfrO6Wsw=;
 b=akHeXAVnXwJKTE176+pi5nLUk8sSmnNCmB3WtRup51mxY0yfe4x2WtFFrd907CLXe2
 yhgoWyFGZRUIWyXSocF8/GkXfQ5iZo74ZZahQ0PaKpbjIW98zmG0SHK3Ewt2irZu/pmp
 9RkSA49VMaCCWSsLGCcrJS7iqBqjtJpelwgIM62uYFp0fN3ZqP6uWbUKarSSwNoY1GFc
 I0RKUGhLvKooAob7wCRJTA0T++YUw8tbPco47ElDlq8abFtHHwDDzea1Sh8ycSXPRri3
 qbReErM6qJ5QIVpye4+IBIDixNRXoa5WmEiVK3x+/tCXtyFOmzbhcTyJtu/rsIZvwOP5
 e6Iw==
X-Gm-Message-State: AOJu0YzzsOiB25uUPUmbrMi4Ak22hdB4DoRSlO+rD5Lf5kqk0CqktrRE
 wmfNjXL3+nJh6kA5L8hbTHMvq8+XtHK4wQ==
X-Google-Smtp-Source: AGHT+IE1gPh7c7nPqsNGj6usU8Pc4Isa5wAAybwbXhRHum8VBp1X72jKJrYzZU1Vb0UBULH3WflzzA==
X-Received: by 2002:ac8:5e0c:0:b0:427:fa9d:e91b with SMTP id
 h12-20020ac85e0c000000b00427fa9de91bmr7814434qtx.30.1704095616255; 
 Sun, 31 Dec 2023 23:53:36 -0800 (PST)
Received: from n73-164-11.byted.org ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 bx4-20020a05622a090400b00427f5c73636sm4465361qtb.27.2023.12.31.23.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 23:53:36 -0800 (PST)
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Hao Xiang" <hao.xiang@bytedance.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Ben Widawsky" <ben.widawsky@intel.com>,
 "Gregory Price" <gourry.memverge@gmail.com>, "Fan Ni" <fan.ni@samsung.com>,
 "Ira Weiny" <ira.weiny@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 linux-cxl@vger.kernel.org
Subject: [QEMU-devel][RFC PATCH 0/1] Introduce HostMemType for
 'memory-backend-*'
Date: Sun, 31 Dec 2023 23:53:14 -0800
Message-Id: <20240101075315.43167-1-horenchuang@bytedance.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=horenchuang@bytedance.com; helo=mail-qt1-x82f.google.com
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

Heterogeneous memory setups are becoming popular. Today, we can run a server
system combining DRAM, pmem, HBM, and CXL-attached DDR. CXL-attached DDR
memory shares the same set of attributes as normal system DRAM but with higher
latency and lower bandwidth. With the rapid increase in CPU core counts in
today's server platforms, memory capacity and bandwidth become bottlenecks.
High-capacity memory devices are very expensive and deliver poor value on a
dollar-per-GB basis. There are a limited number of memory channels per socket,
and hence the total memory capacity per socket is limited by cost.

As a cloud service provider, virtual machines are a fundamental service.
The virtual machine models have pre-set vCPU counts and memory capacity.
Large memory capacity VM models have a higher memory capacity per vCPU.
Delivering VM instances with the same vCPU and memory requirements
on new-generation Intel/AMD server platforms becomes challenging as
the CPU core count rapidly increases. With the help of CXL local
memory expanders, we can install more DDR memory devices on a socket and
almost double the total memory capacity per socket at a reasonable cost on
new server platforms. Thus, we can continue to deliver existing VM models. On
top of that, low-cost, large memory capacity VM models become a possibility.

CXL-attached memory (CXL type-3 device) can be used in exactly the same way
as system-DRAM but with somewhat degraded performance. QEMU is in the process
of supporting CXL virtualization. Currently, in QEMU, we can already create
virtualized CXL memory devices, and a guest OS running the latest Linux kernel
can successfully bring CXL memory online.

We conducted benchmark testing on VMs with three setups:
1. VM with virtualized system-DRAM, backed by system-DRAM on
the physical host. No virtualized CXL memory.
2. VM with virtualized system-DRAM, backed by CXL-attached memory on
the physical host. No virtualized CXL memory.
3. VM with virtualized system-DRAM, backed by system-DRAM on
the physical host, and virtualized CXL memory backed by CXL-attached memory on
the physical host.

Benchmark 1: Intel Memory Latency Checker
Link: https://www.intel.com/content/www/us/en/developer/articles/tool/intelr-memory-latency-checker.html
Guest VM idle latency for random access in nanoseconds:
- System-DRAM backed by system-DRAM on the host = 116.1
- CXL memory backed by CXL-attached DRAM on the host = 266.8
- System-DRAM backed by CXL-attached DRAM on the host = 269.7
From within the guest VM, read/write latency on memory backed by
host CXL-DRAM is 2X compared to memory backed by host system-DRAM memory.
We observe the same performance result regardless of whether memory is exposed
as virtualized system-DRAM or virtualized CXL memory. The driving factor for
performance is the memory backend (backing memory type: system-DRAM vs
CXL-DRAM) on the host, not the frontend memory type (virtualized system-DRAM
vs virtualized CXL-DRAM) exposed to the guest OS.

Benchmark 2: Redis memtier benchmark
Link: https://redis.com/blog/memtier_benchmark-a-high-throughput-benchmarking-tool-for-redis-memcached/
Guest VM Redis concurrent read latency in milliseconds:
- Key size = 800B, value size = 800B
                         P50         P99         P999
(1) System-DRAM only    13.43       40.95       243.71
(2) CXL-DRAM only       29.18       49.15       249.85
(3) Tiered memory       13.76       39.16       241.66

- Key size = 800B, value size = 70kB
                           P50        P99        P999
(1) System-DRAM only     342.01     630.78      925.69
(2) CXL-DRAM only        696.32     720.89     1007.61
(3) Tiered memory        610.30     671.74     1011.71

From within the guest VM, the Redis server is filled with a large number of
in-memory key-value pairs. Almost all memory is used inside the VM. We then
start a workload with concurrent read operations. For (3), we only read the
key-value pairs located in CXL-DRAM.

- The P50 latency for read operations is almost the same between tiered memory
and system-DRAM when the value size is small (800 bytes). The performance
results are primarily dominated by other software stacks like communication
and CPU cache. The read workload consistently hit the key-value pairs stored
in CXL memory. However, the P50 latency in CXL-only is >2X slower than the
other two setups. When the value size is small, the latency for
read operations is mostly spent in the software stack. It seems critical to
have the guest Linux kernel running on system-DRAM backed memory for
good performance.

- The P50 latency for read operations becomes 70% worse in the tiered memory
setup compared to system-DRAM only when the value size is large (70 KB). The
CXL-only option consistently exhibits poor performance. When the value size is
large, the latency for read operations is mostly spent in reading the value
from the Redis server. The read workload consistently hit the key-value pairs
stored in CXL memory.

Please note that in our experiment, the tiered memory system didn't
promote/demote the pages as expected. The tiered memory setup should have
better performance as the Linux community gradually improves the page
promotion/demotion algorithm. The Linux kernel community has developed a
tiered memory system to better utilize various types of DRAM-like memory.
The future of memory tiering: https://lwn.net/Articles/931421/


Having the guest kernel running on system-DRAM-backed memory and
application data running on CXL-backed memory shows comparable performance to
the topline (system-DRAM only), and it is also a cost-effective solution.
Moreover, in the near future, users will be able to benefit from memory with
different features. Enabling the tiered memory system in the guest OS seems to
be in the right direction. To enable these scenarios from end to end, we need
some plumbing work in the memory backend and CXL memory virtualization stacks.

- QEMU's memory backend object needs to support an option to automatically map
guest memory to a specified type of memory on the host. Take CXL-attached
memory for example, we can then create the virtualized CXL type-3 device as
the frontend and automatically map it to a type of CXL memory backend. This
patchset contains a prototype implementation that accomplishes this. 
We introduce a new configuration option 'host-mem-type=', enabling users
to specify the type of memory from which they want to allocate. An argument
'cxlram' is used to automatically locate CXL-DRAM NUMA nodes on the host and
use them as the backend memory. This provides users with great convenience.
There is no existing API in the Linux kernel to explicitly allocate memory
from CXL-attached memory. Therefore, we rely on the information provided by
the dax kmem driver under the sysfs path
'/sys/bus/cxl/devices/region[X]/dax_region[X]/dax[X]/target_node'
in the prototype.

- Kernel memory tiering uses the dax kmem driver's device probe path to query
ACPI to obtain CXL device attributes (latency, bandwidth) and calculates its
abstract distance. The abstract distance sets the memory to the correct tier.
Although QEMU already provides the option "-numa hmat-lb" to set memory
latency/bandwidth attributes, we were not able to connect the dots from end
to end. After setting the attributes in QEMU, booting up the VM, and creating
devdax CXL devices, the guest kernel was not able to correctly read the memory
attributes for the devdax devices. We are still debugging that path, but we
suspect that it's due to missing functionality in CXL virtualization support.

- When creating two virtualized CXL type-3 devices and bringing them up by
using cxl and daxctl tools, we were not able to create the
2nd memory region/devdax device inside the VM. We are debugging this issue
but would appreciate feedback if others are also dealing with similar
challenges.

Ho-Ren (Jack) Chuang (1):
  backends/hostmem: qapi/qom: Add ObjectOptions for memory-backend-*
    called HostMemType

 backends/hostmem.c       | 184 +++++++++++++++++++++++++++++++++++++++
 include/sysemu/hostmem.h |   1 +
 qapi/common.json         |  19 ++++
 qapi/qom.json            |   1 +
 qemu-options.hx          |   2 +-
 5 files changed, 206 insertions(+), 1 deletion(-)

-- 
Regards,
Hao Xiang and Ho-Ren (Jack) Chuang



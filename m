Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 161B2780DA1
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05f-0004rs-T3; Fri, 18 Aug 2023 10:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwGd-0004rj-Sp
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:43 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qWwG0-0000Gh-9t
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 05:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692352744; x=1723888744;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jz7IFd0vrXnGZ+gkRuqDWXyYjBmZTIdXgnI29s8/w30=;
 b=KxUOwL3EOVCvADv5ni3YOOEmD8eCHKTPpDZHO9xH2THiyESmkaA8Hv5d
 v+q7r3um8WESHBb7LdlDcujld9KvgkhlRqQ3BmZDS5MvO4wrsyJjsrhnO
 dMRpLetM6FUdpfIW7C4G5Nu7fQfJszKUsIUFzYz0yK2FRuPKkD/gYuP07
 mGH2rqKWsCkAb7IGEE4WNFZ3R9u0//qAeqZb2y6NYbPXyJh/LuIEgaHOc
 5kPg9AYt3KH8gAlEOuAVflOyYXSDiwkrB5c89yIjoNMWSy0CUXm7AePSe
 HW06inhkK9064OY5Gfdk7gPC+u1Nhccvh9BOnVy6NoEq6VrNqBBv71JhL A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="371966648"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="371966648"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2023 02:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="849235466"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="849235466"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga002.fm.intel.com with ESMTP; 18 Aug 2023 02:57:55 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 xiaoyao.li@intel.com, Isaku Yamahata <isaku.yamahata@gmail.com>,
 erdemaktas@google.com, Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v2 41/58] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Date: Fri, 18 Aug 2023 05:50:24 -0400
Message-Id: <20230818095041.1973309-42-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818095041.1973309-1-xiaoyao.li@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

For GetQuote, delegate a request to Quote Generation Service.  Add property
of address of quote generation server and On request, connect to the
server, read request buffer from shared guest memory, send the request
buffer to the server and store the response into shared guest memory and
notify TD guest by interrupt.

"quote-generation-service" is a property to specify Quote Generation
Service(QGS) in qemu socket address format.  The examples of the supported
format are "vsock:2:1234", "unix:/run/qgs", "localhost:1234".

command line example:
  qemu-system-x86_64 \
    -object 'tdx-guest,id=tdx0,quote-generation-service=localhost:1234' \
    -machine confidential-guest-support=tdx0

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 qapi/qom.json         |   5 +-
 target/i386/kvm/tdx.c | 380 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h |   7 +
 3 files changed, 391 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 87c1d440f331..37139949d761 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -879,13 +879,16 @@
 #
 # @mrownerconfig: MROWNERCONFIG SHA384 hex string of 48 * 2 length (default: 0)
 #
+# @quote-generation-service: socket address for Quote Generation Service(QGS)
+#
 # Since: 8.2
 ##
 { 'struct': 'TdxGuestProperties',
   'data': { '*sept-ve-disable': 'bool',
             '*mrconfigid': 'str',
             '*mrowner': 'str',
-            '*mrownerconfig': 'str' } }
+            '*mrownerconfig': 'str',
+            '*quote-generation-service': 'str' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 1b444886e294..73d6cd88af9e 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -22,6 +22,8 @@
 #include "exec/address-spaces.h"
 #include "exec/ramblock.h"
 
+#include "exec/address-spaces.h"
+#include "hw/i386/apic_internal.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf.h"
@@ -863,6 +865,25 @@ static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
     }
 }
 
+static char *tdx_guest_get_quote_generation(
+    Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+    return g_strdup(tdx->quote_generation_str);
+}
+
+static void tdx_guest_set_quote_generation(
+    Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+    tdx->quote_generation = socket_parse(value, errp);
+    if (!tdx->quote_generation)
+        return;
+
+    g_free(tdx->quote_generation_str);
+    tdx->quote_generation_str = g_strdup(value);
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -895,6 +916,12 @@ static void tdx_guest_init(Object *obj)
     object_property_add_sha384(obj, "mrownerconfig", tdx->mrownerconfig,
                                OBJ_PROP_FLAG_READWRITE);
 
+    tdx->quote_generation_str = NULL;
+    tdx->quote_generation = NULL;
+    object_property_add_str(obj, "quote-generation-service",
+                            tdx_guest_get_quote_generation,
+                            tdx_guest_set_quote_generation);
+
     tdx->event_notify_interrupt = -1;
     tdx->event_notify_apic_id = -1;
 }
@@ -907,6 +934,7 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
 {
 }
 
+#define TDG_VP_VMCALL_GET_QUOTE                         0x10002ULL
 #define TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT      0x10004ULL
 
 #define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
@@ -915,6 +943,355 @@ static void tdx_guest_class_init(ObjectClass *oc, void *data)
 #define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
 #define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
 
+#define TDX_GET_QUOTE_STRUCTURE_VERSION 1ULL
+
+#define TDX_VP_GET_QUOTE_SUCCESS                0ULL
+#define TDX_VP_GET_QUOTE_IN_FLIGHT              (-1ULL)
+#define TDX_VP_GET_QUOTE_ERROR                  0x8000000000000000ULL
+#define TDX_VP_GET_QUOTE_QGS_UNAVAILABLE        0x8000000000000001ULL
+
+/* Limit to avoid resource starvation. */
+#define TDX_GET_QUOTE_MAX_BUF_LEN       (128 * 1024)
+#define TDX_MAX_GET_QUOTE_REQUEST       16
+
+/* Format of pages shared with guest. */
+struct tdx_get_quote_header {
+    /* Format version: must be 1 in little endian. */
+    uint64_t structure_version;
+
+    /*
+     * GetQuote status code in little endian:
+     *   Guest must set error_code to 0 to avoid information leak.
+     *   Qemu sets this before interrupting guest.
+     */
+    uint64_t error_code;
+
+    /*
+     * in-message size in little endian: The message will follow this header.
+     * The in-message will be send to QGS.
+     */
+    uint32_t in_len;
+
+    /*
+     * out-message size in little endian:
+     * On request, out_len must be zero to avoid information leak.
+     * On return, message size from QGS. Qemu overwrites this field.
+     * The message will follows this header.  The in-message is overwritten.
+     */
+    uint32_t out_len;
+
+    /*
+     * Message buffer follows.
+     * Guest sets message that will be send to QGS.  If out_len > in_len, guest
+     * should zero remaining buffer to avoid information leak.
+     * Qemu overwrites this buffer with a message returned from QGS.
+     */
+};
+
+static hwaddr tdx_shared_bit(X86CPU *cpu)
+{
+    return (cpu->phys_bits > 48) ? BIT_ULL(51) : BIT_ULL(47);
+}
+
+struct tdx_get_quote_task {
+    uint32_t apic_id;
+    hwaddr gpa;
+    uint64_t buf_len;
+    struct tdx_get_quote_header hdr;
+    int event_notify_interrupt;
+    QIOChannelSocket *ioc;
+};
+
+struct x86_msi {
+    union {
+        struct {
+            uint32_t    reserved_0              : 2,
+                        dest_mode_logical       : 1,
+                        redirect_hint           : 1,
+                        reserved_1              : 1,
+                        virt_destid_8_14        : 7,
+                        destid_0_7              : 8,
+                        base_address            : 12;
+        } QEMU_PACKED x86_address_lo;
+        uint32_t address_lo;
+    };
+    union {
+        struct {
+            uint32_t    reserved        : 8,
+                        destid_8_31     : 24;
+        } QEMU_PACKED x86_address_hi;
+        uint32_t address_hi;
+    };
+    union {
+        struct {
+            uint32_t    vector                  : 8,
+                        delivery_mode           : 3,
+                        dest_mode_logical       : 1,
+                        reserved                : 2,
+                        active_low              : 1,
+                        is_level                : 1;
+        } QEMU_PACKED x86_data;
+        uint32_t data;
+    };
+};
+
+static void tdx_td_notify(struct tdx_get_quote_task *t)
+{
+    struct x86_msi x86_msi;
+    struct kvm_msi msi;
+    int ret;
+
+    /* It is optional for host VMM to interrupt TD. */
+    if(!(32 <= t->event_notify_interrupt && t->event_notify_interrupt <= 255))
+        return;
+
+    x86_msi = (struct x86_msi) {
+        .x86_address_lo  = {
+            .reserved_0 = 0,
+            .dest_mode_logical = 0,
+            .redirect_hint = 0,
+            .reserved_1 = 0,
+            .virt_destid_8_14 = 0,
+            .destid_0_7 = t->apic_id & 0xff,
+        },
+        .x86_address_hi = {
+            .reserved = 0,
+            .destid_8_31 = t->apic_id >> 8,
+        },
+        .x86_data = {
+            .vector = t->event_notify_interrupt,
+            .delivery_mode = APIC_DM_FIXED,
+            .dest_mode_logical = 0,
+            .reserved = 0,
+            .active_low = 0,
+            .is_level = 0,
+        },
+    };
+    msi = (struct kvm_msi) {
+        .address_lo = x86_msi.address_lo,
+        .address_hi = x86_msi.address_hi,
+        .data = x86_msi.data,
+        .flags = 0,
+        .devid = 0,
+    };
+    ret = kvm_vm_ioctl(kvm_state, KVM_SIGNAL_MSI, &msi);
+    if (ret < 0) {
+        /* In this case, no better way to tell it to guest.  Log it. */
+        error_report("TDX: injection %d failed, interrupt lost (%s).\n",
+                     t->event_notify_interrupt, strerror(-ret));
+    }
+}
+
+/*
+ * TODO: If QGS doesn't reply for long time, make it an error and interrupt
+ * guest.
+ */
+static void tdx_handle_get_quote_connected(QIOTask *task, gpointer opaque)
+{
+    struct tdx_get_quote_task *t = opaque;
+    Error *err = NULL;
+    char *in_data = NULL;
+    char *out_data = NULL;
+    size_t out_len;
+    ssize_t size;
+    MachineState *ms;
+    TdxGuest *tdx;
+
+    t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_ERROR);
+    if (qio_task_propagate_error(task, NULL)) {
+        t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
+        goto error;
+    }
+
+    in_data = g_malloc(le32_to_cpu(t->hdr.in_len));
+    if (address_space_read(&address_space_memory, t->gpa + sizeof(t->hdr),
+                           MEMTXATTRS_UNSPECIFIED, in_data,
+                           le32_to_cpu(t->hdr.in_len)) != MEMTX_OK) {
+        goto error;
+    }
+
+    if (qio_channel_write_all(QIO_CHANNEL(t->ioc), in_data,
+                              le32_to_cpu(t->hdr.in_len), &err) ||
+        err) {
+        t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
+        goto error;
+    }
+
+    out_data = g_malloc(t->buf_len);
+    out_len = 0;
+    size = 0;
+    while (true) {
+        char *buf;
+        size_t buf_size;
+
+        if (out_len < t->buf_len) {
+            buf = out_data + out_len;
+            buf_size = t->buf_len - out_len;
+        } else {
+            /*
+             * The received data is too large to fit in the shared GPA.
+             * Discard the received data and try to know the data size.
+             */
+            buf = out_data;
+            buf_size = t->buf_len;
+        }
+
+        size = qio_channel_read(QIO_CHANNEL(t->ioc), buf, buf_size, &err);
+        if (err) {
+            break;
+        }
+        if (size <= 0) {
+            break;
+        }
+        out_len += size;
+    }
+    /*
+     * Treat partial read as success and let the QGS client to handle it because
+     * the client knows better about the QGS.
+     */
+    if (out_len == 0 && (err || size < 0)) {
+        t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
+        goto error;
+    }
+    if (out_len > 0 && out_len > t->buf_len) {
+        /*
+         * There is no specific error code defined for this case(E2BIG) at the
+         * moment.
+         * TODO: Once an error code for this case is defined in GHCI spec ,
+         * update the error code.
+         */
+        t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_ERROR);
+        t->hdr.out_len = cpu_to_le32(out_len);
+        goto error_hdr;
+    }
+
+    if (address_space_write(
+            &address_space_memory, t->gpa + sizeof(t->hdr),
+            MEMTXATTRS_UNSPECIFIED, out_data, out_len) != MEMTX_OK) {
+        goto error;
+    }
+    /*
+     * Even if out_len == 0, it's a success.  It's up to the QGS-client contract
+     * how to interpret the zero-sized message as return message.
+     */
+    t->hdr.out_len = cpu_to_le32(out_len);
+    t->hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_SUCCESS);
+
+error:
+    if (t->hdr.error_code != cpu_to_le64(TDX_VP_GET_QUOTE_SUCCESS)) {
+        t->hdr.out_len = cpu_to_le32(0);
+    }
+error_hdr:
+    if (address_space_write(
+            &address_space_memory, t->gpa,
+            MEMTXATTRS_UNSPECIFIED, &t->hdr, sizeof(t->hdr)) != MEMTX_OK) {
+        error_report("TDX: failed to updsate GetQuote header.\n");
+    }
+    tdx_td_notify(t);
+
+    qio_channel_close(QIO_CHANNEL(t->ioc), &err);
+    object_unref(OBJECT(t->ioc));
+    g_free(in_data);
+    g_free(out_data);
+
+    /* Maintain the number of in-flight requests. */
+    ms = MACHINE(qdev_get_machine());
+    tdx = TDX_GUEST(ms->cgs);
+    qemu_mutex_lock(&tdx->lock);
+    tdx->quote_generation_num--;
+    qemu_mutex_unlock(&tdx->lock);
+
+    return;
+}
+
+static void tdx_handle_get_quote(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
+{
+    hwaddr gpa = vmcall->in_r12;
+    uint64_t buf_len = vmcall->in_r13;
+    struct tdx_get_quote_header hdr;
+    MachineState *ms;
+    TdxGuest *tdx;
+    QIOChannelSocket *ioc;
+    struct tdx_get_quote_task *t;
+
+    vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
+
+    /* GPA must be shared. */
+    if (!(gpa & tdx_shared_bit(cpu))) {
+        return;
+    }
+    gpa &= ~tdx_shared_bit(cpu);
+
+    if (!QEMU_IS_ALIGNED(gpa, 4096) || !QEMU_IS_ALIGNED(buf_len, 4096)) {
+        vmcall->status_code = TDG_VP_VMCALL_ALIGN_ERROR;
+        return;
+    }
+    if (buf_len == 0) {
+        return;
+    }
+
+    if (address_space_read(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                           &hdr, sizeof(hdr)) != MEMTX_OK) {
+        return;
+    }
+    if (le64_to_cpu(hdr.structure_version) != TDX_GET_QUOTE_STRUCTURE_VERSION) {
+        return;
+    }
+    /*
+     * Paranoid: Guest should clear error_code and out_len to avoid information
+     * leak.  Enforce it.  The initial value of them doesn't matter for qemu to
+     * process the request.
+     */
+    if (le64_to_cpu(hdr.error_code) != TDX_VP_GET_QUOTE_SUCCESS ||
+        le32_to_cpu(hdr.out_len) != 0) {
+        return;
+    }
+
+    /* Only safe-guard check to avoid too large buffer size. */
+    if (buf_len > TDX_GET_QUOTE_MAX_BUF_LEN ||
+        le32_to_cpu(hdr.in_len) > TDX_GET_QUOTE_MAX_BUF_LEN ||
+        le32_to_cpu(hdr.in_len) > buf_len) {
+        return;
+    }
+
+    /* Mark the buffer in-flight. */
+    hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_IN_FLIGHT);
+    if (address_space_write(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                            &hdr, sizeof(hdr)) != MEMTX_OK) {
+        return;
+    }
+
+    ms = MACHINE(qdev_get_machine());
+    tdx = TDX_GUEST(ms->cgs);
+    ioc = qio_channel_socket_new();
+
+    t = g_malloc(sizeof(*t));
+    t->apic_id = tdx->event_notify_apic_id;
+    t->gpa = gpa;
+    t->buf_len = buf_len;
+    t->hdr = hdr;
+    t->ioc = ioc;
+
+    qemu_mutex_lock(&tdx->lock);
+    if (!tdx->quote_generation ||
+        /* Prevent too many in-flight get-quote request. */
+        tdx->quote_generation_num >= TDX_MAX_GET_QUOTE_REQUEST) {
+        qemu_mutex_unlock(&tdx->lock);
+        vmcall->status_code = TDG_VP_VMCALL_RETRY;
+        object_unref(OBJECT(ioc));
+        g_free(t);
+        return;
+    }
+    tdx->quote_generation_num++;
+    t->event_notify_interrupt = tdx->event_notify_interrupt;
+    qio_channel_socket_connect_async(
+        ioc, tdx->quote_generation, tdx_handle_get_quote_connected, t, g_free,
+        NULL);
+    qemu_mutex_unlock(&tdx->lock);
+
+    vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
+}
+
 static void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
                                                     struct kvm_tdx_vmcall *vmcall)
 {
@@ -943,6 +1320,9 @@ static void tdx_handle_vmcall(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
     }
 
     switch (vmcall->subfunction) {
+    case TDG_VP_VMCALL_GET_QUOTE:
+        tdx_handle_get_quote(cpu, vmcall);
+        break;
     case TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
         tdx_handle_setup_event_notify_interrupt(cpu, vmcall);
         break;
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 50a151fc79c2..d861d8516668 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -5,8 +5,10 @@
 #include CONFIG_DEVICES /* CONFIG_TDX */
 #endif
 
+#include <linux/kvm.h>
 #include "exec/confidential-guest-support.h"
 #include "hw/i386/tdvf.h"
+#include "io/channel-socket.h"
 #include "sysemu/kvm.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
@@ -47,6 +49,11 @@ typedef struct TdxGuest {
     /* runtime state */
     int event_notify_interrupt;
     uint32_t event_notify_apic_id;
+
+    /* GetQuote */
+    int quote_generation_num;
+    char *quote_generation_str;
+    SocketAddress *quote_generation;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
-- 
2.34.1



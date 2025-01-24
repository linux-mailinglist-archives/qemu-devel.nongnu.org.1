Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A92A1BB76
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Jan 2025 18:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNWP-0002XO-0l; Fri, 24 Jan 2025 12:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tbNW1-0002QI-T0
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:30:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tbNVz-0000Wt-2h
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:30:45 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YflCX4Jmjz6L58F;
 Sat, 25 Jan 2025 01:28:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 404931402DB;
 Sat, 25 Jan 2025 01:30:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 Jan 2025 18:30:39 +0100
To: <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alexandre Iooss
 <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, <linuxarm@huawei.com>, Niyas Sait
 <niyas.sait@huawei.com>
Subject: [RFC PATCH QEMU x3/3] contrib: Add example hotness monitoring unit
 server
Date: Fri, 24 Jan 2025 17:29:05 +0000
Message-ID: <20250124172905.84099-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is used inconjuction with the cache plugin (with port
parameter supplied) and the CXL Type 3 device with a hotness
monitoring unit (chmu-port parameter supplied).

It implements a very basic oracle with a counter per 4KiB page
and simple loop to find large counts.  The hotlist length is
controlled by the QEMU device implementation.

This is only responsible for the data handling events etc are
a problem for the CXL HMU emulation.

Note that when running this things are fairly slow.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 contrib/hmu/hmu.c | 312 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/contrib/hmu/hmu.c b/contrib/hmu/hmu.c
new file mode 100644
index 0000000000..aa47efd98b
--- /dev/null
+++ b/contrib/hmu/hmu.c
@@ -0,0 +1,312 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <pthread.h>
+#include <arpa/inet.h>
+
+#define ID_PROVIDER 42
+#define ID_CONSUMER 41
+
+/* Move to shared header */
+enum consumer_request {
+    QUERY_TAIL,
+    QUERY_HEAD,
+    SET_HEAD,
+    SET_HOTLIST_SIZE,
+    QUERY_HOTLIST_ENTRY,
+    SIGNAL_EPOCH_END,
+    SET_ENABLED,
+    SET_NUMBER_GRANUALS,
+    SET_HPA_BASE,
+    SET_HPA_SIZE,
+};
+
+struct tracking_instance {
+    uint64_t base, size;
+    uint16_t head, tail;
+    uint16_t hotlist_length;
+    uint64_t *hotlist;
+    int32_t *counters;
+    size_t num_counters;
+    bool enabled;
+};
+
+#define MAX_INSTANCES 16
+static int num_tracking_instances;
+static struct tracking_instance *instances[MAX_INSTANCES] = {};
+/*
+ * Instances never removed so this only protects the index against
+ * parallel creations.
+ */
+pthread_mutex_t instances_lock;
+static int register_tracker(struct tracking_instance *inst)
+{
+    pthread_mutex_lock(&instances_lock);
+    if (num_tracking_instances >= MAX_INSTANCES) {
+        pthread_mutex_unlock(&instances_lock);
+        return -1;
+    }
+    instances[num_tracking_instances++] = inst;
+    printf("registered %d\n", num_tracking_instances);
+    pthread_mutex_unlock(&instances_lock);
+    return 0;
+}
+
+static void notify_tracker(struct tracking_instance *inst, uint64_t paddr)
+{
+    uint64_t offset;
+
+    if (paddr < inst->base || paddr >= inst->base + inst->size) {
+        return;
+    }
+    /* Fixme: multiple regions */
+    offset = (paddr - inst->base) / 4096;
+
+    /*  TODO - check masking */
+
+    if (!inst->counters) {
+        printf("No counter storage\n");
+        return;
+    }
+    if (offset >= inst->num_counters) {
+        printf("out of range? %lx %lx\n", offset, inst->num_counters);
+        return;
+    }
+    inst->counters[offset]++;
+}
+
+/* CHMU instance in QEMU */
+static void *provider_innerloop(void * _socket)
+{
+    int socket = *(int *)_socket;
+    uint64_t paddr;
+    int rc;
+
+    printf("Provider connected\n");
+    while (1) {
+        rc = read(socket, &paddr, sizeof(paddr));
+        if (rc == 0) {
+            return NULL;
+        }
+       /* Lock not taken as instances only goes up which should be safe */
+        for (int i = 0; i < num_tracking_instances; i++)
+            if (instances[i]->enabled) {
+                notify_tracker(instances[i], paddr);
+            }
+    }
+}
+
+
+/* Cache plugin hopefully squirting us some data */
+static void *consumer_innerloop(void *_socket)
+{
+    int socket = *(int *)_socket;
+    /* for now all chmu have 3 instances */
+    struct tracking_instance insts[3] = {};
+    /* Instance, command, parameter */
+    uint64_t paddr[3];
+    int rc;
+
+    for (int i = 0; i < 3; i++) {
+        rc = register_tracker(&insts[i]);
+        if (rc) {
+            printf("Failed to register tracker\n");
+            return NULL;
+            /* todo cleanup to not have partial trackers registered */
+        }
+    }
+    printf("Consumer connected\n");
+
+    while (1) {
+        uint64_t reply, param;
+        enum consumer_request request;
+
+        struct tracking_instance *inst;
+
+        rc = read(socket, paddr, sizeof(paddr));
+        if (rc < sizeof(paddr)) {
+            printf("short message %x\n", rc);
+            return NULL;
+        }
+        if (paddr[0] > 3) {
+            printf("garbage\n");
+            exit(-1);
+        }
+        inst = &insts[paddr[0]];
+        request = paddr[1];
+        param = paddr[2];
+
+        switch (request) {
+        case QUERY_TAIL:
+            reply = inst->tail;
+            break;
+        case QUERY_HEAD:
+            reply = inst->head;
+            break;
+        case SET_HEAD:
+            reply = param;
+            inst->head = param;
+            break;
+        case SET_HOTLIST_SIZE: {
+            uint64_t *newlist;
+            reply = param;
+            inst->hotlist_length = param;
+            newlist = realloc(inst->hotlist, sizeof(*inst->hotlist) * param);
+            if (!newlist) {
+                printf("failed to allocate hotlist\n");
+                break;
+            }
+            inst->hotlist = newlist;
+            break;
+        }
+        case QUERY_HOTLIST_ENTRY:
+            if (param >= inst->hotlist_length) {
+                printf("out of range hotlist read?\n");
+                break;
+            }
+            reply = inst->hotlist[param];
+            break;
+        case SIGNAL_EPOCH_END: {
+            int space;
+            int added = 0;
+            printf("into epoch end\n");
+            reply = param;
+
+            if (insts->tail > inst->head) {
+                space = inst->tail - inst->head;
+            } else {
+                space = inst->hotlist_length - inst->tail +
+                    inst->head;
+            }
+            if (!inst->counters) {
+                printf("How did we reach end of an epoque without counters?\n");
+                break;
+            }
+            for (int i = 0; i < inst->num_counters; i++) {
+                if (!(inst->counters[i] > 0)) {
+                    continue;
+                }
+                inst->hotlist[inst->tail] =
+                    (uint64_t)inst->counters[i] | ((uint64_t)i << 32);
+                printf("added hotlist element %lx at %u\n",
+                       inst->hotlist[inst->tail], inst->tail);
+                inst->tail = (inst->tail + 1) % inst->hotlist_length;
+                added++;
+                if (added == space) {
+                    break;
+                }
+            }
+            memset(inst->counters, 0,
+                   inst->num_counters * sizeof(*inst->counters));
+
+            printf("End of epoch %u %u\n", inst->head, inst->tail);
+            /* Overflow hadnling based on fullness detection in qemu */
+            break;
+        }
+        case SET_ENABLED:
+            reply = param;
+            inst->enabled = !!param;
+            printf("enabled? %d\n", inst->enabled);
+            break;
+        case SET_NUMBER_GRANUALS: { /* FIXME Should derive from granual size */
+            uint32_t *newcounters;
+
+            reply = param;
+            newcounters = realloc(inst->counters,
+                                  sizeof(*inst->counters) *
+                                  param);
+            if (!newcounters) {
+                printf("Failed to allocate counter storage\n");
+            }
+            printf("allocated space for %lu counters\n", param);
+            inst->counters = newcounters;
+            inst->num_counters = param;
+            break;
+        }
+        case SET_HPA_BASE:
+            reply = param;
+            inst->base = param;
+            break;
+        case SET_HPA_SIZE: /* Size */
+            reply = param;
+            inst->size = param;
+            break;
+        default:
+            printf("No idea yet\n");
+            break;
+        }
+        write(socket, &reply, sizeof(reply));
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int server_fd, new_socket;
+    struct sockaddr_in address;
+    int opt = 1;
+    int addrlen = sizeof(address);
+    uint64_t paddr;
+    unsigned short port;
+
+    if (argc < 2) {
+        printf("Please provide port to listen on\n");
+        return -1;
+    }
+    port = atoi(argv[1]);
+
+    if ((server_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) == 0) {
+        return -1;
+    }
+
+    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
+                   &opt, sizeof(opt))) {
+        return -1;
+    }
+    address.sin_family = AF_INET;
+    address.sin_addr.s_addr = INADDR_ANY;
+    address.sin_port = htons(port);
+
+    if (bind(server_fd, (struct sockaddr *)&address, sizeof(address)) < 0) {
+        return -1;
+    }
+
+    printf("Listening on port %u\n", port);
+    if (listen(server_fd, 3) < 0) {
+        return -1;
+    }
+
+    while (1) {
+        int rc;
+        pthread_t thread;
+        if ((new_socket = accept(server_fd, (struct sockaddr *)&address,
+                                 (socklen_t *)&addrlen)) < 0) {
+            exit(-1);
+        }
+
+        rc = read(new_socket, &paddr, sizeof(paddr));
+        if (rc == 0) {
+            return 0;
+        }
+
+        if (paddr == ID_PROVIDER) {
+            if (pthread_create(&thread, NULL, provider_innerloop,
+                               &new_socket)) {
+                printf("thread create fail\n");
+            };
+        } else if (paddr == ID_CONSUMER) {
+            if (pthread_create(&thread, NULL, consumer_innerloop,
+                               &new_socket)) {
+                printf("thread create fail\n");
+            };
+        } else {
+            printf("No idea what this was - initial value not provider or consumer\n");
+            close(new_socket);
+            return 0;
+        }
+    }
+
+    return 0;
+}
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FFE74D53D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoP-0000q5-2t; Mon, 10 Jul 2023 08:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoK-0000nk-V4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoI-0003Uc-Jq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FoumhPGYJHXRRvELNSv1KGH/PyI6hB/84DpYBGKRQw8=;
 b=crTtHaEFnM2aGYprmHw0O29p/wOp5S5YMXMKie1DemYbkYi6KKZzbb4WIlEhAZO2dcbGaT
 oUv5fV7XpkNY8+cJmur5JOzB+FMWHctCUiv+4cTPEoBo28kEkQE8GsFVJqDvE75iOcCLiS
 TBf8hgTNB6ogutWhzCZ9xHjP9mOgzdo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-yGgeDlKFOt-27RMXe9OZLA-1; Mon, 10 Jul 2023 08:16:08 -0400
X-MC-Unique: yGgeDlKFOt-27RMXe9OZLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0ED0185A793;
 Mon, 10 Jul 2023 12:16:07 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17C42F5CFA;
 Mon, 10 Jul 2023 12:16:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 16/21] tests/qtest/readconfig: Test the docs/config/q35-*.cfg
 files
Date: Mon, 10 Jul 2023 14:15:38 +0200
Message-Id: <20230710121543.197250-17-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Test that we can successfully parse the docs/config/q35-emulated.cfg,
docs/config/q35-virtio-graphical.cfg and docs/config/q35-virtio-serial.cfg
config files (the "...-serial.cfg" file is a subset of the graphical
config file, so we skip that in quick mode).

These config files use two hard-coded image names which we have to
replace with unique temporary files to avoid race conditions in case
the tests are run in parallel. So after creating the temporary image
files, we also have to create a copy of the config file where we
replaced the hard-coded image names.

If KVM is not available, we also have to disable the "accel" lines.
Once everything is in place, we can start QEMU with the modified
config file and check that everything is available in QEMU.

Message-Id: <20230704071655.75381-4-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/readconfig-test.c | 196 ++++++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/tests/qtest/readconfig-test.c b/tests/qtest/readconfig-test.c
index 74526f3af2..760f974e63 100644
--- a/tests/qtest/readconfig-test.c
+++ b/tests/qtest/readconfig-test.c
@@ -197,6 +197,189 @@ static void test_docs_config_ich9(void)
     qtest_quit(qts);
 }
 
+#if defined(CONFIG_POSIX) && defined(CONFIG_SLIRP)
+
+static char *make_temp_img(const char *template, const char *format, int size)
+{
+    GError *error = NULL;
+    char *temp_name;
+    int fd;
+
+    /* Create a temporary image names */
+    fd = g_file_open_tmp(template, &temp_name, &error);
+    if (fd == -1) {
+        fprintf(stderr, "unable to create file: %s\n", error->message);
+        g_error_free(error);
+        return NULL;
+    }
+    close(fd);
+
+    if (!mkimg(temp_name, format, size)) {
+        fprintf(stderr, "qemu-img failed to create %s\n", temp_name);
+        g_free(temp_name);
+        return NULL;
+    }
+
+    return temp_name;
+}
+
+struct device {
+    const char *name;
+    const char *type;
+};
+
+static void test_docs_q35(const char *input_file, struct device *devices)
+{
+    QTestState *qts;
+    QDict *resp;
+    QObject *qobj;
+    int ret, i;
+    g_autofree char *cfg_file = NULL, *sedcmd = NULL;
+    g_autofree char *hd_file = NULL, *cd_file = NULL;
+
+    /* Check that all the devices are available in the QEMU binary */
+    for (i = 0; devices[i].name; i++) {
+        if (!qtest_has_device(devices[i].type)) {
+            g_test_skip("one of the required devices is not available");
+            return;
+        }
+    }
+
+    hd_file = make_temp_img("qtest_disk_XXXXXX.qcow2", "qcow2", 1);
+    cd_file = make_temp_img("qtest_cdrom_XXXXXX.iso", "raw", 1);
+    if (!hd_file || !cd_file) {
+        g_test_skip("could not create disk images");
+        goto cleanup;
+    }
+
+    /* Create a temporary config file where we replace the disk image names */
+    ret = g_file_open_tmp("q35-emulated-XXXXXX.cfg", &cfg_file, NULL);
+    if (ret == -1) {
+        g_test_skip("could not create temporary config file");
+        goto cleanup;
+    }
+    close(ret);
+
+    sedcmd = g_strdup_printf("sed -e 's,guest.qcow2,%s,' -e 's,install.iso,%s,'"
+                             " %s %s > '%s'",
+                             hd_file, cd_file,
+                             !qtest_has_accel("kvm") ? "-e '/accel/d'" : "",
+                             input_file, cfg_file);
+    ret = system(sedcmd);
+    if (ret) {
+        g_test_skip("could not modify temporary config file");
+        goto cleanup;
+    }
+
+    qts = qtest_initf("-machine none -nodefaults -readconfig %s", cfg_file);
+
+    /* Check memory size */
+    resp = qtest_qmp(qts, "{ 'execute': 'query-memdev' }");
+    test_x86_memdev_resp(qdict_get(resp, "return"), "pc.ram", 1024);
+    qobject_unref(resp);
+
+    resp = qtest_qmp(qts, "{ 'execute': 'qom-list',"
+                          "  'arguments': {'path': '/machine/peripheral' }}");
+    qobj = qdict_get(resp, "return");
+
+    /* Check that all the devices have been created */
+    for (i = 0; devices[i].name; i++) {
+        test_object_available(qobj, devices[i].name, devices[i].type);
+    }
+
+    qobject_unref(resp);
+
+    qtest_quit(qts);
+
+cleanup:
+    if (hd_file) {
+        unlink(hd_file);
+    }
+    if (cd_file) {
+        unlink(cd_file);
+    }
+    if (cfg_file) {
+        unlink(cfg_file);
+    }
+}
+
+static void test_docs_q35_emulated(void)
+{
+    struct device devices[] = {
+        { "ich9-pcie-port-1", "ioh3420" },
+        { "ich9-pcie-port-2", "ioh3420" },
+        { "ich9-pcie-port-3", "ioh3420" },
+        { "ich9-pcie-port-4", "ioh3420" },
+        { "ich9-pci-bridge", "i82801b11-bridge" },
+        { "ich9-ehci-1", "ich9-usb-ehci1" },
+        { "ich9-ehci-2", "ich9-usb-ehci2" },
+        { "ich9-uhci-1", "ich9-usb-uhci1" },
+        { "ich9-uhci-2", "ich9-usb-uhci2" },
+        { "ich9-uhci-3", "ich9-usb-uhci3" },
+        { "ich9-uhci-4", "ich9-usb-uhci4" },
+        { "ich9-uhci-5", "ich9-usb-uhci5" },
+        { "ich9-uhci-6", "ich9-usb-uhci6" },
+        { "sata-disk", "ide-hd" },
+        { "sata-optical-disk", "ide-cd" },
+        { "net", "e1000" },
+        { "video", "VGA" },
+        { "ich9-hda-audio", "ich9-intel-hda" },
+        { "ich9-hda-duplex", "hda-duplex" },
+        { NULL, NULL }
+    };
+
+    test_docs_q35("docs/config/q35-emulated.cfg", devices);
+}
+
+static void test_docs_q35_virtio_graphical(void)
+{
+    struct device devices[] = {
+        { "pcie.1", "pcie-root-port" },
+        { "pcie.2", "pcie-root-port" },
+        { "pcie.3", "pcie-root-port" },
+        { "pcie.4", "pcie-root-port" },
+        { "pcie.5", "pcie-root-port" },
+        { "pcie.6", "pcie-root-port" },
+        { "pcie.7", "pcie-root-port" },
+        { "pcie.8", "pcie-root-port" },
+        { "scsi", "virtio-scsi-pci" },
+        { "scsi-disk", "scsi-hd" },
+        { "scsi-optical-disk", "scsi-cd" },
+        { "net", "virtio-net-pci" },
+        { "usb", "nec-usb-xhci" },
+        { "tablet", "usb-tablet" },
+        { "video", "qxl-vga" },
+        { "sound", "ich9-intel-hda" },
+        { "duplex", "hda-duplex" },
+        { NULL, NULL }
+    };
+
+    test_docs_q35("docs/config/q35-virtio-graphical.cfg", devices);
+}
+
+static void test_docs_q35_virtio_serial(void)
+{
+    struct device devices[] = {
+        { "pcie.1", "pcie-root-port" },
+        { "pcie.2", "pcie-root-port" },
+        { "pcie.3", "pcie-root-port" },
+        { "pcie.4", "pcie-root-port" },
+        { "pcie.5", "pcie-root-port" },
+        { "pcie.6", "pcie-root-port" },
+        { "pcie.7", "pcie-root-port" },
+        { "pcie.8", "pcie-root-port" },
+        { "scsi", "virtio-scsi-pci" },
+        { "scsi-disk", "scsi-hd" },
+        { "scsi-optical-disk", "scsi-cd" },
+        { "net", "virtio-net-pci" },
+        { NULL, NULL }
+    };
+
+    test_docs_q35("docs/config/q35-virtio-serial.cfg", devices);
+}
+
+#endif /* CONFIG_LINUX */
+
 int main(int argc, char *argv[])
 {
     const char *arch;
@@ -211,6 +394,19 @@ int main(int argc, char *argv[])
             qtest_has_device("ich9-usb-uhci1")) {
             qtest_add_func("readconfig/x86/ich9-ehci-uhci", test_docs_config_ich9);
         }
+#if defined(CONFIG_POSIX) && defined(CONFIG_SLIRP)
+        qtest_add_func("readconfig/x86/q35-emulated", test_docs_q35_emulated);
+        qtest_add_func("readconfig/x86/q35-virtio-graphical",
+                       test_docs_q35_virtio_graphical);
+        if (g_test_slow()) {
+            /*
+             * q35-virtio-serial.cfg is a subset of q35-virtio-graphical.cfg,
+             * so we can skip the test in quick mode
+             */
+            qtest_add_func("readconfig/x86/q35-virtio-serial",
+                           test_docs_q35_virtio_serial);
+        }
+#endif
     }
 #if defined(CONFIG_SPICE) && !defined(__FreeBSD__)
     qtest_add_func("readconfig/spice", test_spice);
-- 
2.39.3



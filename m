Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F67262A6
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0j-0002pj-KL; Wed, 07 Jun 2023 10:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0g-0002oL-Q7
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:38 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0e-0003PT-GY
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lZUzACCsa/eiibSQ8OwFKOw5Vxy0eEbqjsBKUOQieks=;
 b=HAHrBdmwJnRth12S+UkaOo+S/3UXdDv8ZQn26jn8rxAGQHPiO6MUX5xK
 l2MEswB1pIjSLXF2TnoDkOIS/cwcHKpNYijYaXm3hvYWQ0TTB4wXdzkSR
 U89fKuSMm1y+D/M+c0HVSzRWuLmBOFu4Mu42gi3QJzp+vfjmkgQD0AWKG w=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 112337997
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:SCOJR6imRk4Q5b+a/AweAPJqX161ZhAKZh0ujC45NGQN5FlHY01je
 htvWG2HMqmCNDSmLt51bNvkoEkD6pDdyNQ2Tgtq/3w9Qiob9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyq0N8klgZmP6sT4geBzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQEDDsXUDSurd6onru5Y7dnnJUbBsrSadZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJYw1MYH49tL7Aan3XejtEqFWTtOwv7nLa1gBZ27nxKtvFPNeNQK25m27B/
 zidpDuoU05y2Nq30QSd6DWguNb1ty7cX9MCKbGp0KJUqQjGroAUIEJPDgbqyRWjsWanVtdCb
 kAZ5Ccqha418kOtU5/6RRLQiHKbuwE0Ut9ZAeo8rgqKjLfXizt1HUBdEGQHMoZ/8pZrG3pzj
 AThc87V6SJHrJmeU0y5252os227OwFLJnVTXQUHdF5QizX8m70bghXKR9dlNae6iNzpBD39q
 wy3QDgCa6Y71pBSifjilbzTq3f1/8WSEFZpjunCdjj9hj6VcrJJcGBBBbLzyf9bZLiUQVCa1
 JTvs5jPtbteZX1hecHkfQnsIF1Lz6zdWNE/qQQ1d3XEy9hK0yDLQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp6k/C/S465DaGIN7Kih6SdkifdpEmCgmbKhgjQfLUEy/lja
 f93j+7yZZrlNUiX5GXvHLpMuVPa7is/2XnSVfjGI+ePiNKjiIquYe5dajOmN7lphJ5oVS2Jq
 76zwePWkUQAOAA/CwGLmbMuwacicyBmVM6s9pYOHgNBSyI/cFwc5zbq6etJU+RYc259z48kI
 lnVtpdk9WfC
IronPort-HdrOrdr: A9a23:6n/yNqmymJokl8jO60hPr47UZtDpDfIo3DAbv31ZSRFFG/Fw9v
 rDoB1/73TJYVkqN03I9ervBEDjexPhHO9OgLX5VI3KNGOKhILCFvAA0WKN+UyFJwTOssJbyK
 d8Y+xfJbTLfD9HZB/BkWuF+gAbsby6zJw=
X-Talos-CUID: 9a23:9TGoNGDW/Z2OJ536EzVD/1QqPu0PTmODxXX5fUSiWF5DS4TAHA==
X-Talos-MUID: 9a23:ILSdeAow8rBtRonyAyQezylcLN0v75qXMmoAtpJXq/SIJAosBR7I2Q==
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="112337997"
To: <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 03/12] xen: Drop support for Xen versions below 4.7.1
Date: Wed, 7 Jun 2023 15:18:30 +0100
Message-ID: <20230607141839.48422-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa1.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

In restructuring to allow for internal emulation of Xen functionality,
I broke compatibility for Xen 4.6 and earlier. Fix this by explicitly
removing support for anything older than 4.7.1, which is also ancient
but it does still build, and the compatibility support for it is fairly
unintrusive.

Fixes: 15e283c5b684 ("hw/xen: Add foreignmem operations to allow redirection to internal emulation")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20230412185102.441523-4-dwmw2@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen-operations.c     |  57 +------------------
 include/hw/xen/xen_native.h | 107 +-----------------------------------
 meson.build                 |   5 +-
 scripts/xen-detect.c        |  60 --------------------
 4 files changed, 3 insertions(+), 226 deletions(-)

diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
index 3d213d28df..e00983ec44 100644
--- a/hw/xen/xen-operations.c
+++ b/hw/xen/xen-operations.c
@@ -28,46 +28,13 @@
 #include <xenctrl.h>
 
 /*
- * We don't support Xen prior to 4.2.0.
+ * We don't support Xen prior to 4.7.1.
  */
 
-/* Xen 4.2 through 4.6 */
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
-
-typedef xc_evtchn xenevtchn_handle;
-typedef evtchn_port_or_error_t xenevtchn_port_or_error_t;
-
-#define xenevtchn_open(l, f) xc_evtchn_open(l, f);
-#define xenevtchn_close(h) xc_evtchn_close(h)
-#define xenevtchn_fd(h) xc_evtchn_fd(h)
-#define xenevtchn_pending(h) xc_evtchn_pending(h)
-#define xenevtchn_notify(h, p) xc_evtchn_notify(h, p)
-#define xenevtchn_bind_interdomain(h, d, p) xc_evtchn_bind_interdomain(h, d, p)
-#define xenevtchn_unmask(h, p) xc_evtchn_unmask(h, p)
-#define xenevtchn_unbind(h, p) xc_evtchn_unbind(h, p)
-
-typedef xc_gnttab xengnttab_handle;
-
-#define xengnttab_open(l, f) xc_gnttab_open(l, f)
-#define xengnttab_close(h) xc_gnttab_close(h)
-#define xengnttab_set_max_grants(h, n) xc_gnttab_set_max_grants(h, n)
-#define xengnttab_map_grant_ref(h, d, r, p) xc_gnttab_map_grant_ref(h, d, r, p)
-#define xengnttab_unmap(h, a, n) xc_gnttab_munmap(h, a, n)
-#define xengnttab_map_grant_refs(h, c, d, r, p) \
-    xc_gnttab_map_grant_refs(h, c, d, r, p)
-#define xengnttab_map_domain_grant_refs(h, c, d, r, p) \
-    xc_gnttab_map_domain_grant_refs(h, c, d, r, p)
-
-typedef xc_interface xenforeignmemory_handle;
-
-#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40701 */
-
 #include <xenevtchn.h>
 #include <xengnttab.h>
 #include <xenforeignmemory.h>
 
-#endif
-
 /* Xen before 4.8 */
 
 static int libxengnttab_fallback_grant_copy(xengnttab_handle *xgt,
@@ -223,26 +190,6 @@ static struct gnttab_backend_ops libxengnttab_backend_ops = {
     .unmap = libxengnttab_backend_unmap,
 };
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
-
-static void *libxenforeignmem_backend_map(uint32_t dom, void *addr, int prot,
-                                          size_t pages, xfn_pfn_t *pfns,
-                                          int *errs)
-{
-    if (errs) {
-        return xc_map_foreign_bulk(xen_xc, dom, prot, pfns, errs, pages);
-    } else {
-        return xc_map_foreign_pages(xen_xc, dom, prot, pfns, pages);
-    }
-}
-
-static int libxenforeignmem_backend_unmap(void *addr, size_t pages)
-{
-    return munmap(addr, pages * XC_PAGE_SIZE);
-}
-
-#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40701 */
-
 static void *libxenforeignmem_backend_map(uint32_t dom, void *addr, int prot,
                                           size_t pages, xen_pfn_t *pfns,
                                           int *errs)
@@ -256,8 +203,6 @@ static int libxenforeignmem_backend_unmap(void *addr, size_t pages)
     return xenforeignmemory_unmap(xen_fmem, addr, pages);
 }
 
-#endif
-
 struct foreignmem_backend_ops libxenforeignmem_backend_ops = {
     .map = libxenforeignmem_backend_map,
     .unmap = libxenforeignmem_backend_unmap,
diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 6bcc83baf9..f11eb423e3 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -24,23 +24,11 @@
 extern xc_interface *xen_xc;
 
 /*
- * We don't support Xen prior to 4.2.0.
+ * We don't support Xen prior to 4.7.1.
  */
 
-/* Xen 4.2 through 4.6 */
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40701
-
-typedef xc_interface xenforeignmemory_handle;
-
-#define xenforeignmemory_open(l, f) xen_xc
-#define xenforeignmemory_close(h)
-
-#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40701 */
-
 #include <xenforeignmemory.h>
 
-#endif
-
 extern xenforeignmemory_handle *xen_fmem;
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
@@ -148,8 +136,6 @@ static inline xendevicemodel_handle *xendevicemodel_open(
     return xen_xc;
 }
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40500
-
 static inline int xendevicemodel_create_ioreq_server(
     xendevicemodel_handle *dmod, domid_t domid, int handle_bufioreq,
     ioservid_t *id)
@@ -211,8 +197,6 @@ static inline int xendevicemodel_set_ioreq_server_state(
     return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
 }
 
-#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40500 */
-
 static inline int xendevicemodel_set_pci_intx_level(
     xendevicemodel_handle *dmod, domid_t domid, uint16_t segment,
     uint8_t bus, uint8_t device, uint8_t intx, unsigned int level)
@@ -340,15 +324,6 @@ static inline int xen_get_vmport_regs_pfn(xc_interface *xc, domid_t dom,
 }
 #endif
 
-/* Xen before 4.6 */
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40600
-
-#ifndef HVM_IOREQSRV_BUFIOREQ_ATOMIC
-#define HVM_IOREQSRV_BUFIOREQ_ATOMIC 2
-#endif
-
-#endif
-
 static inline int xen_get_default_ioreq_server_info(domid_t dom,
                                                     xen_pfn_t *ioreq_pfn,
                                                     xen_pfn_t *bufioreq_pfn,
@@ -386,84 +361,6 @@ static inline int xen_get_default_ioreq_server_info(domid_t dom,
     return 0;
 }
 
-/* Xen before 4.5 */
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40500
-
-#ifndef HVM_PARAM_BUFIOREQ_EVTCHN
-#define HVM_PARAM_BUFIOREQ_EVTCHN 26
-#endif
-
-#define IOREQ_TYPE_PCI_CONFIG 2
-
-typedef uint16_t ioservid_t;
-
-static inline void xen_map_memory_section(domid_t dom,
-                                          ioservid_t ioservid,
-                                          MemoryRegionSection *section)
-{
-}
-
-static inline void xen_unmap_memory_section(domid_t dom,
-                                            ioservid_t ioservid,
-                                            MemoryRegionSection *section)
-{
-}
-
-static inline void xen_map_io_section(domid_t dom,
-                                      ioservid_t ioservid,
-                                      MemoryRegionSection *section)
-{
-}
-
-static inline void xen_unmap_io_section(domid_t dom,
-                                        ioservid_t ioservid,
-                                        MemoryRegionSection *section)
-{
-}
-
-static inline void xen_map_pcidev(domid_t dom,
-                                  ioservid_t ioservid,
-                                  PCIDevice *pci_dev)
-{
-}
-
-static inline void xen_unmap_pcidev(domid_t dom,
-                                    ioservid_t ioservid,
-                                    PCIDevice *pci_dev)
-{
-}
-
-static inline void xen_create_ioreq_server(domid_t dom,
-                                           ioservid_t *ioservid)
-{
-}
-
-static inline void xen_destroy_ioreq_server(domid_t dom,
-                                            ioservid_t ioservid)
-{
-}
-
-static inline int xen_get_ioreq_server_info(domid_t dom,
-                                            ioservid_t ioservid,
-                                            xen_pfn_t *ioreq_pfn,
-                                            xen_pfn_t *bufioreq_pfn,
-                                            evtchn_port_t *bufioreq_evtchn)
-{
-    return xen_get_default_ioreq_server_info(dom, ioreq_pfn,
-                                             bufioreq_pfn,
-                                             bufioreq_evtchn);
-}
-
-static inline int xen_set_ioreq_server_state(domid_t dom,
-                                             ioservid_t ioservid,
-                                             bool enable)
-{
-    return 0;
-}
-
-/* Xen 4.5 */
-#else
-
 static bool use_default_ioreq_server;
 
 static inline void xen_map_memory_section(domid_t dom,
@@ -624,6 +521,4 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
                                                  enable);
 }
 
-#endif
-
 #endif /* QEMU_HW_XEN_NATIVE_H */
diff --git a/meson.build b/meson.build
index 553c8e0b9c..0984237c48 100644
--- a/meson.build
+++ b/meson.build
@@ -1683,16 +1683,13 @@ if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
     endif
   endif
   if not xen.found()
-    xen_tests = [ '4.11.0', '4.10.0', '4.9.0', '4.8.0', '4.7.1', '4.6.0', '4.5.0', '4.2.0' ]
+    xen_tests = [ '4.11.0', '4.10.0', '4.9.0', '4.8.0', '4.7.1' ]
     xen_libs = {
       '4.11.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
       '4.10.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
       '4.9.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
       '4.8.0': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
       '4.7.1': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-      '4.6.0': [ 'xenstore', 'xenctrl' ],
-      '4.5.0': [ 'xenstore', 'xenctrl' ],
-      '4.2.0': [ 'xenstore', 'xenctrl' ],
     }
     xen_deps = {}
     foreach ver: xen_tests
diff --git a/scripts/xen-detect.c b/scripts/xen-detect.c
index 85e8206490..db049e605c 100644
--- a/scripts/xen-detect.c
+++ b/scripts/xen-detect.c
@@ -138,66 +138,6 @@
     return 0;
   }
 
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 40600
-  #include <xenctrl.h>
-  #include <xenstore.h>
-  #include <stdint.h>
-  #include <xen/hvm/hvm_info_table.h>
-  #if !defined(HVM_MAX_VCPUS)
-  # error HVM_MAX_VCPUS not defined
-  #endif
-  int main(void) {
-    xc_interface *xc;
-    xs_daemon_open();
-    xc = xc_interface_open(0, 0, 0);
-    xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-    xc_gnttab_open(NULL, 0);
-    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-    xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-    xc_reserved_device_memory_map(xc, 0, 0, 0, 0, NULL, 0);
-    return 0;
-  }
-
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 40500
-  #include <xenctrl.h>
-  #include <xenstore.h>
-  #include <stdint.h>
-  #include <xen/hvm/hvm_info_table.h>
-  #if !defined(HVM_MAX_VCPUS)
-  # error HVM_MAX_VCPUS not defined
-  #endif
-  int main(void) {
-    xc_interface *xc;
-    xs_daemon_open();
-    xc = xc_interface_open(0, 0, 0);
-    xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-    xc_gnttab_open(NULL, 0);
-    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-    xc_hvm_create_ioreq_server(xc, 0, 0, NULL);
-    return 0;
-  }
-
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 40200
-  #include <xenctrl.h>
-  #include <xenstore.h>
-  #include <stdint.h>
-  #include <xen/hvm/hvm_info_table.h>
-  #if !defined(HVM_MAX_VCPUS)
-  # error HVM_MAX_VCPUS not defined
-  #endif
-  int main(void) {
-    xc_interface *xc;
-    xs_daemon_open();
-    xc = xc_interface_open(0, 0, 0);
-    xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-    xc_gnttab_open(NULL, 0);
-    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-    return 0;
-  }
-
 #else
 #error invalid CONFIG_XEN_CTRL_INTERFACE_VERSION
 #endif
-- 
Anthony PERARD



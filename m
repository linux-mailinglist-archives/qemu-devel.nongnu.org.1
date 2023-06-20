Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52698737566
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:51:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhOB-0000Uq-UJ; Tue, 20 Jun 2023 15:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBhO8-0000C6-EK
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:40 -0400
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qBhO2-0002kn-EF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:51:36 -0400
Received: from lenovo-t14s ([37.171.229.63]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MiZkX-1pZ5Ax482R-00fnHL; Tue, 20 Jun 2023 21:51:01 +0200
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 eric.auger@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/2] tpm_crb: mark memory as protected
Date: Tue, 20 Jun 2023 21:50:54 +0200
Message-ID: <20230620195054.23929-3-lvivier@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620195054.23929-1-lvivier@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g16mSSSjdFVfKKPs3z37Bqx5Jz6Ljqr7fhiUuxhxwmgujPCx9Ai
 cIETq1wjt9PmkAfJhYT0rEkqciUvKGfD0a25A9wnakpYMr58IoQVQyST/bGmMDGSzKf7MI5
 1Ly2qsBQvMDYrhfDnLETdGtcu6LxZDjnOk9rFQ1w6gr7YMNrSLBqdi+JXKq1ztA+K3cjABU
 X6m6zR9Hog3CXL6GLsldQ==
UI-OutboundReport: notjunk:1;M01:P0:M+1wXmKuHC8=;1erNwjG6VHrnLxongzkXxKPYnjc
 /09Ke9Z/MlNXxxYbh5VUNb9xd5DOTkiheqVqQeZkCcm1AaNhATV2hELwEuZDEeSfzPq7gfPbb
 RyxvFTtrF4vl/veaW95dKitemKvajWEwjRd++OKaLtttFkx3g3yTg7dXj2nCTALU6Lnpm/Ewz
 Rwggq+qWdn0DJyUwiyjpTIoQqwuy5S5Z0HWiXuz4hqE1bjRp+Ixi+MZbvrKVBq48P4YjeYJy8
 DbcjcFNscJzZxO+9OJ9srBi3ciObXR4gDF8CcyzZ7pocbpeW/kU+F8miLyYgy3jI7RHcaWVgC
 kZghGX0m2jOlTrZhI5OgIzB4pDDA1SE7bUpGyENKaOlcLnvaMq4izUc+lPXZMW9W9LVCb3mNH
 I+QSRguOraMYu5PvYI4+a3W16kAR9+Wse5aBjfABsIX+UzToArZX0D4iSvGOh/xcswheshg+3
 P0ypNOJ4sbtQrfJwvXQ9m/WcrmELgmeT+nd77DFOZw1QhLUntKHfEmEFbV0LgR/dvtaoHTv3n
 Y4s2+ZrjMa6A4PJglhUxL4AlCrqhFlZBNqlGIElVPpyY0rVpuxX16/epLjDv/3Bd3lkSB93cR
 VTU3/rENy97m6xmJRkSz/z47KiYkWcfY42F8e4qMUQdX2IhUkihY7T5FXJz1KdbV1mxJaP6I5
 bpMgmeG4sZJEwSO3JD1C7OlLeZXcI5rMvb425D1XdA==
Received-SPF: permerror client-ip=212.227.17.24;
 envelope-from=lvivier@redhat.com; helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_FAIL=0.001,
 SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This memory is not correctly aligned and cannot be registered
by vDPA and VFIO.

An error is reported for vhost-vdpa case:
qemu-kvm: vhost_vdpa_listener_region_add received unaligned region

To make it ignored by VFIO and vDPA devices, mark it as RAM_PROTECTED.

The RAM_PROTECTED flag has been introduced to skip memory
region that looks like RAM but is not accessible via normal
mechanims, including DMA.

See 56918a126a ("memory: Add RAM_PROTECTED flag to skip IOMMU mappings")

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=2141965

cc: peter.maydell@linaro.org
cc: marcandre.lureau@redhat.com
cc: eric.auger@redhat.com
cc: mst@redhat.com
cc: jasowang@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/tpm/tpm_crb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index ea930da545af..0a93c488f2fa 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -296,7 +296,7 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
 
     memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
         "tpm-crb-mmio", sizeof(s->regs));
-    memory_region_init_ram(&s->cmdmem, OBJECT(s),
+    memory_region_init_ram_protected(&s->cmdmem, OBJECT(s),
         "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
 
     memory_region_add_subregion(get_system_memory(),
-- 
2.41.0



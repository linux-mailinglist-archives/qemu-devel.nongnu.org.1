Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09D7DC3DF
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 02:28:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxdWe-00089J-AD; Mon, 30 Oct 2023 21:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qxdWZ-00089B-Sf
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 21:26:31 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liucong2@kylinos.cn>)
 id 1qxdWR-00028S-QB
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 21:26:31 -0400
X-UUID: 2104e3e41fbf40eeb3281b1b4bb1acb3-20231031
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32, REQID:b940a711-2d06-438c-b91c-e62d3211a158, IP:10,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-5
X-CID-INFO: VERSION:1.1.32, REQID:b940a711-2d06-438c-b91c-e62d3211a158, IP:10,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:5f78ec9, CLOUDID:7799f4fb-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:23103109255089P4TURM,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
 02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS, TF_CID_SPAM_FSD, TF_CID_SPAM_FSI,
 TF_CID_SPAM_ULN, TF_CID_SPAM_SNR
X-UUID: 2104e3e41fbf40eeb3281b1b4bb1acb3-20231031
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
 (envelope-from <liucong2@kylinos.cn>) (Generic MTA)
 with ESMTP id 1497134281; Tue, 31 Oct 2023 09:25:48 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: gurchetansingh@chromium.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: akihiko.odaki@gmail.com, alex.bennee@linaro.org, ernunes@redhat.com,
 hi@alyssa.is, manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, ray.huang@amd.com,
 shentey@gmail.com, thuth@redhat.com, Cong Liu <liucong2@kylinos.cn>
Subject: [PATCH] virtio-gpu-rutabaga: Add empty interface to fix arm64 crash
Date: Tue, 31 Oct 2023 09:25:15 +0800
Message-Id: <20231031012515.15504-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006010835.444-7-gurchetansingh@chromium.org>
References: <20231006010835.444-7-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232; envelope-from=liucong2@kylinos.cn;
 helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add an empty element to the interfaces array, which is consistent with
the behavior of other devices in qemu and fixes the crash on arm64.

0  0x0000fffff5c18550 in  () at /usr/lib64/libc.so.6
1  0x0000fffff6c9cd6c in g_strdup () at /usr/lib64/libglib-2.0.so.0
2  0x0000aaaaab4945d8 in g_strdup_inline (str=<optimized out>) at /usr/include/glib-2.0/glib/gstrfuncs.h:321
3  type_new (info=info@entry=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:133
4  0x0000aaaaab494f14 in type_register_internal (info=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:143
5  type_register (info=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:152
6  type_register_static (info=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:157
7  type_register_static_array (infos=<optimized out>, nr_infos=<optimized out>) at ../qom/object.c:165
8  0x0000aaaaab6147e8 in module_call_init (type=type@entry=MODULE_INIT_QOM) at ../util/module.c:109
9  0x0000aaaaab10a0ec in qemu_init_subsystems () at ../system/runstate.c:817
10 0x0000aaaaab10d334 in qemu_init (argc=13, argv=0xfffffffff198) at ../system/vl.c:2760
11 0x0000aaaaaae4da6c in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:47

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 hw/display/virtio-gpu-pci-rutabaga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
index c96729e19834..abbb898c65dc 100644
--- a/hw/display/virtio-gpu-pci-rutabaga.c
+++ b/hw/display/virtio-gpu-pci-rutabaga.c
@@ -36,6 +36,7 @@ static const TypeInfo virtio_gpu_rutabaga_pci_info[] = {
         .instance_init = virtio_gpu_rutabaga_initfn,
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
         }
     },
 };
-- 
2.34.1



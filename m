Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96264709A84
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Rx-0002Gx-Qt; Fri, 19 May 2023 10:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rv-00027D-PZ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Rq-0003cT-AD
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x8XsV0KlHYQh1ZXv+BOwKL6equViqnXJvPOITuHI9uI=;
 b=gAD4qEYpvyMicfgzwLugm8ZlW+LI+eF4vGQzsm4Dwi16RFvRZz/4TbQw8+R092EjNcDir7
 NblkDcJ9eUAqhMtVinOkSXZF2LyQ7JEJgz5c3fK7uKKGrOY2SGo36WTRe0Zxur2xLKMpPs
 uZhPv3i59Jo/2e4PHWDMG7e8agBiyOg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-9Dxj9jwzN1WrY8_ThJ9dCw-1; Fri, 19 May 2023 10:51:12 -0400
X-MC-Unique: 9Dxj9jwzN1WrY8_ThJ9dCw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4ef455ba5feso2115281e87.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507870; x=1687099870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8XsV0KlHYQh1ZXv+BOwKL6equViqnXJvPOITuHI9uI=;
 b=gPpzIMEiULXsdsx+XG1vEvF0abUJ1S8kloJRZ/Z4gFeFqDlC0BZbuWlvYUJyn1OPUO
 sUf7eXsCS7EUwrykYVi2QECFmsLagsSVtLDgMxo0YiJr9652jlM7s6PFKMyuYtdJ+Pla
 b53RLcZY9eYaV96Bm5+2BUZeN4Rti1mqgO/gPgjxGVvVur4pN09JRTTbrFNm/UQO/YZD
 brW+/a0uOXaiEZCCrA4N1nF1ck6w5PZDDTVN4kI0Q9HDOrOXT3zsmq1Y/U6MWmV2U2vk
 hlnuNqReVGdlrwmBHLd8c5ioQeyuwuUcbCw3cdwd0KAwLTphW1XSNKmIoRiQjqSmoQ4K
 URzg==
X-Gm-Message-State: AC+VfDwK0AbABD9YVOSJFod0Xjp/PS1hWAOhVlIG4LDog9gzybaxB4ac
 X6uFLZZKJ/R8XLZkScv+nw+dCKhwcrAjaAx9JdD/pwVzLC8hO9QeheupBBOSStKCYPYaVrydIhs
 x53mHio64Qmt6qCoTT2v7bPq7yeh3me70ksiGp5wVLCrd+2JoALqeuKEZ1ldVL94ouy1M
X-Received: by 2002:ac2:4c08:0:b0:4f3:b1e6:4b46 with SMTP id
 t8-20020ac24c08000000b004f3b1e64b46mr420965lfq.12.1684507870272; 
 Fri, 19 May 2023 07:51:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/Q+V3MZJks1RuITYhF2XzaoqHiwWjhBAiHpMutMBSfa8rRM6pOgcfXqj0tkliV48cIc4JnA==
X-Received: by 2002:ac2:4c08:0:b0:4f3:b1e6:4b46 with SMTP id
 t8-20020ac24c08000000b004f3b1e64b46mr420952lfq.12.1684507870030; 
 Fri, 19 May 2023 07:51:10 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 j16-20020ac253b0000000b004f2391fe9a6sm620169lfh.266.2023.05.19.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:51:09 -0700 (PDT)
Date: Fri, 19 May 2023 10:51:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/40] pci: pci_add_option_rom(): refactor: use g_autofree for
 path variable
Message-ID: <5b52692f9d258d0e2637234832dc00042de03a4d.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230515125229.44836-3-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/pci/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e26e2a7e65..3a0107758c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2307,7 +2307,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
                                Error **errp)
 {
     int64_t size;
-    char *path;
+    g_autofree char *path = NULL;
     void *ptr;
     char name[32];
     const VMStateDescription *vmsd;
@@ -2349,16 +2349,13 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     size = get_image_size(path);
     if (size < 0) {
         error_setg(errp, "failed to find romfile \"%s\"", pdev->romfile);
-        g_free(path);
         return;
     } else if (size == 0) {
         error_setg(errp, "romfile \"%s\" is empty", pdev->romfile);
-        g_free(path);
         return;
     } else if (size > 2 * GiB) {
         error_setg(errp, "romfile \"%s\" too large (size cannot exceed 2 GiB)",
                    pdev->romfile);
-        g_free(path);
         return;
     }
     if (pdev->romsize != -1) {
@@ -2366,7 +2363,6 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
             error_setg(errp, "romfile \"%s\" (%u bytes) "
                        "is too large for ROM size %u",
                        pdev->romfile, (uint32_t)size, pdev->romsize);
-            g_free(path);
             return;
         }
     } else {
@@ -2384,10 +2380,8 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
     ptr = memory_region_get_ram_ptr(&pdev->rom);
     if (load_image_size(path, ptr, size) < 0) {
         error_setg(errp, "failed to load romfile \"%s\"", pdev->romfile);
-        g_free(path);
         return;
     }
-    g_free(path);
 
     if (is_default_rom) {
         /* Only the default rom images will be patched (if needed). */
-- 
MST



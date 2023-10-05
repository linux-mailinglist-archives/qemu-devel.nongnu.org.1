Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34057B9A68
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJK-0000Ls-PR; Wed, 04 Oct 2023 23:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ1-0008J2-Q9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIx-0000lv-Gu
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXZPD0CN1EMknhNwzhqLjrYqmgqO9D2C6C8XhFWkRR0=;
 b=PFN1pGeHE4CRp40JcS/TkVClkoZc3GTj3Ee1TYKaRRq6dV571Sg6mNCuHReolX+/sDr++g
 9tgUy5WcUck2TydEDANmwEWQ5vp+7BWoEo132aO0ezg/h7kQiqy44e0ITsm4ZihhuJl/RJ
 imCKd96Pacvo/VLW5KEAYWIoaV78FCY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-9YkK6oGlPxKVGbhJN3ie5Q-1; Wed, 04 Oct 2023 23:45:36 -0400
X-MC-Unique: 9YkK6oGlPxKVGbhJN3ie5Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32480c0ad52so418641f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477533; x=1697082333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dXZPD0CN1EMknhNwzhqLjrYqmgqO9D2C6C8XhFWkRR0=;
 b=mVOCkJnWum7q37aoPZCYsHzoArIKnDy10+aPby+QfdJnRKUuWpONlnaYgPC4YhsRCl
 QzQ0x3hanBLi6TAL3kzlW23KK+S+Xl3OpEPpkBHiJh4Q3nr0lNoiddMYMQCgMHswM75F
 N0lqkddhvxjznJkXFdjuygEoLTAQBAAwbRUL3ActsjXYGlmq1fTQaceRY/zxi874CoqX
 WVdQl9io3+1D5Val6oJ6TETe8FYneNeuFhqPw3IqYdt8Y62PEEYXV5ysJRn+HdbdgISb
 ntHxWg4SM+UXLV+91rAtFYeY8zL+BbTesvvXA5RM5IkXXuGmGqfLe4W/trR/88dxM1Hj
 4fqw==
X-Gm-Message-State: AOJu0Yy6T2mX/itr21UW7SXv0TZh0qR6np4eQixNfJsawJ5hHVrukSj5
 hY7SZxBK3oQ3OZhrwsamgQgblMiuwPE0g5X0KEvwkHiJ9OwRzoBR0r3CpzJCBp0Jq1yCgApX1W/
 gWJJ61VVSYQGhVEgf3VZmQ71OoU4g4xnCmxuhgxG2Kk1NPPqrRLV3nrU/JFOJzlmpsXyC
X-Received: by 2002:adf:f386:0:b0:324:84cf:11ab with SMTP id
 m6-20020adff386000000b0032484cf11abmr3502935wro.51.1696477533803; 
 Wed, 04 Oct 2023 20:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcRtaE8dgPU4SHorG/QmFYCvXLP6WAK1j/YdRcDT67L1V+PGHIfWN9G7e92MIPFemE0E2aJg==
X-Received: by 2002:adf:f386:0:b0:324:84cf:11ab with SMTP id
 m6-20020adff386000000b0032484cf11abmr3502926wro.51.1696477533546; 
 Wed, 04 Oct 2023 20:45:33 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 t11-20020a5d460b000000b003197c7d08ddsm629952wrq.71.2023.10.04.20.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:32 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 45/53] pcie_sriov: unregister_vfs(): fix error path
Message-ID: <f1a153857abc1ba8835b12a01520df9f1b64e15b.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

local_err must be NULL before calling object_property_set_bool(), so we
must clear it on each iteration. Let's also use more convenient
error_reportf_err().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20230925194040.68592-8-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 76a3b6917e..5ef8950940 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -196,19 +196,16 @@ static void register_vfs(PCIDevice *dev)
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    Error *local_err = NULL;
     uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
     uint16_t i;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
+        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        object_property_set_bool(OBJECT(vf), "realized", false, &local_err);
-        if (local_err) {
-            fprintf(stderr, "Failed to unplug: %s\n",
-                    error_get_pretty(local_err));
-            error_free(local_err);
+        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
+            error_reportf_err(err, "Failed to unplug: ");
         }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
-- 
MST



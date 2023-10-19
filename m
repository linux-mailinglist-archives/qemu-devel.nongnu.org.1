Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 392B77D01E0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:37:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhp-0001ev-Ks; Thu, 19 Oct 2023 14:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhC-0000Bx-OI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhA-0002cO-3p
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YGr1H8ijLV736mqcmWstFWaefAIRGO/VVLKqx2ky5/4=;
 b=f+xOQYp29fDj7Dy6wM+nGfaca8tcdWqPPxJMGbLKzfcCM+uFMekMUKHQ+m9S2cR9UM+Y5w
 NDgyRRBlenXGiJ2gFDIXUUPflFN1mCyUzUqI1+53E7lj2MylwzjvHuIXUy9Y7WrzRthlFj
 EAKD9Y8GwbR2PI7o9diO69o48tC/gMg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-87VvnVhANk2KdA2_9dm-7A-1; Thu, 19 Oct 2023 14:24:30 -0400
X-MC-Unique: 87VvnVhANk2KdA2_9dm-7A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so1822405e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739868; x=1698344668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YGr1H8ijLV736mqcmWstFWaefAIRGO/VVLKqx2ky5/4=;
 b=OCEPPusfaA+uc/Qc/yo/9H09QlVSL0hJ6MYMEqDVU1YcbuiBXJfY8oHUIWDQ1S18Cr
 9VruFdu55Ypv3cLBTicowi0RD60wKbejBMKPKnSdGKGOuzPMj3GH4i9hYtH2fu93VmDN
 lPu1RvAkEBubhCK+BlCGCSQo6LvK2dObu+ZBqFDgNRuH9iaKXPvaENqJwtUgsEr4HACW
 SvYWa8FRUZOVIWO6Cxy/Mv41OqQsLHHV2HJs3Yf1xwXbYfUDI7o1pf1Z96qXHcahpvSW
 k7pk2uVnWZP2Xf/UGQ9HHZjKUlU3MMC4MlH+8HHfoGjv3ucA25t7RzGEhtHpKHPy0NeY
 Na5A==
X-Gm-Message-State: AOJu0Ywz35/hNqwtp5S9OoilMWmhOWrsUNMu5EmRrPVdoMljU7Nmmq+Q
 o5Y5zOghFkuq8u2ITwmehZM5Yh3bHss8/fk2dOmhPe5ktrc4LmDcKGZ7P1SaOt5gB4669tIbkh8
 Muk8Or4iWoAjLGo9x+GLoF/sAu526rRtHNKIGYBt8b08f46sz+ykyUcDF7xxw2zgFILmH
X-Received: by 2002:a05:600c:1c29:b0:408:4cf1:e9d7 with SMTP id
 j41-20020a05600c1c2900b004084cf1e9d7mr1300766wms.20.1697739868611; 
 Thu, 19 Oct 2023 11:24:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu661INcDNvwm+2L6Gy1/2bpANGX5tPFEZY7FaN1QvF3L9iFMQOQQrd/0WUF6LnmxygUmhbQ==
X-Received: by 2002:a05:600c:1c29:b0:408:4cf1:e9d7 with SMTP id
 j41-20020a05600c1c2900b004084cf1e9d7mr1300748wms.20.1697739868228; 
 Thu, 19 Oct 2023 11:24:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c350f00b003fe1fe56202sm191581wmq.33.2023.10.19.11.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:27 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 73/78] tests/acpi: Allow update of DSDT.cxl
Message-ID: <ca5140c48f9ad7c2dd2ddd7b0c01535decc72706.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Addition of QTG in following patch requires an update to the test
data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Message-Id: <20231012125623.21101-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..9ce0f596cc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.cxl",
-- 
MST



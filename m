Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7E7B9A47
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFH6-0002kP-0e; Wed, 04 Oct 2023 23:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFH2-0002LF-Hc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGx-00009f-So
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIDUejF6EpBPfsNHFdD2Xl6gePUB6dtvvan4JQ2+wgc=;
 b=XZIncMUDOVM7KB2FElL5QpxsGM5CCV6wWk8UZnuiBdIfXDnD1dIFoX8fYJcfAgCmVxqWVS
 yRrZBEYu6rts99vt9cvME/jdA5Wt7xXWip2lu5WJDwv6kvA6GX0/jj87kkywsvUgJUtjzd
 PdTuyHVnGKQ8mXJ6LSHByLEeaHmn5g4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-THLbryMZPn2VnOHIuZaUfw-1; Wed, 04 Oct 2023 23:43:27 -0400
X-MC-Unique: THLbryMZPn2VnOHIuZaUfw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-405535740d2so3366285e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477406; x=1697082206;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CIDUejF6EpBPfsNHFdD2Xl6gePUB6dtvvan4JQ2+wgc=;
 b=vv8IPnVGFwGolXCVtGgaj7d3XjZdA8AFSNHT+rEsHV7FFHn+b94Zhk0CkpHizQlW1C
 sgYrEytdos/z85COcxuDBQKYLldXbgceRMvgCURxso3NFpjqAy/YjykYaLOxmJKLIuSC
 my1Q/Tik37+FIH279Bm29f+DQ8cEHnyL7w+iKQx3B2yG6ZQ2CNxWiCMu7la0ziC3Bk78
 b+9uTrBKjihoDF+HNEwMWYzoUnnakgbDou+Hnz5xQNlUMEdcUXEaBAsWDEfJ/CyKyXYx
 DyZp542l2mAmSEkzVwuit4SFGsJ7uIogNelFm7wICGxyfTTgBdfe+YDI+83PqhoKbvH8
 Y4Yg==
X-Gm-Message-State: AOJu0YxNgUjUxuwLykOitIXMoWY/1Fhp33mdlT0t68MsGxRbo2Ey3PG4
 dwcIRlAcH6bUSHETSTSkRE1MZ6ga1ijXbeYyNKX9CmU0lh4VyL7tTsFalzHDQQ6sN1b1ZhbpcjL
 K/7Xr5r227tJHYytBs1WbHOgUrUPZYh8bpxa3+vmR8Xk94/Q/His9YyV+xJGVaz33IfSP
X-Received: by 2002:a1c:7c17:0:b0:401:2ee0:7558 with SMTP id
 x23-20020a1c7c17000000b004012ee07558mr3772808wmc.32.1696477406058; 
 Wed, 04 Oct 2023 20:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV9EwjQZYCykbg2aSF0AuXvuBMLKz+++Kh8lXesMkgVPGZkSgriFJZ6Btp9C0F7m+HbybAPQ==
X-Received: by 2002:a1c:7c17:0:b0:401:2ee0:7558 with SMTP id
 x23-20020a1c7c17000000b004012ee07558mr3772799wmc.32.1696477405818; 
 Wed, 04 Oct 2023 20:43:25 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b004060f0a0fdbsm2776908wmi.41.2023.10.04.20.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:25 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
Subject: [PULL v2 15/53] vdpa: use first queue SVQ state for CVQ default
Message-ID: <b40eba9cdde3b041f02a9cbaa23ca0eeda9bd9c1.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

Previous to this patch the only way CVQ would be shadowed is if it does
support to isolate CVQ group or if all vqs were shadowed from the
beginning.  The second condition was checked at the beginning, and no
more configuration was done.

After this series we need to check if data queues are shadowed because
they are in the middle of the migration.  As checking if they are
shadowed already covers the previous case, let's just mimic it.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230822085330.3978829-2-eperezma@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 144b33f997..30dc7e77c9 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -509,7 +509,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
 
     s0 = vhost_vdpa_net_first_nc_vdpa(s);
     v->shadow_data = s0->vhost_vdpa.shadow_vqs_enabled;
-    v->shadow_vqs_enabled = s->always_svq;
+    v->shadow_vqs_enabled = s0->vhost_vdpa.shadow_vqs_enabled;
     s->vhost_vdpa.address_space_id = VHOST_VDPA_GUEST_PA_ASID;
 
     if (s->vhost_vdpa.shadow_data) {
-- 
MST



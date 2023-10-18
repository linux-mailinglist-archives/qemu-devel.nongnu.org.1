Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F8B7CE234
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8y0-0003jX-GM; Wed, 18 Oct 2023 12:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xs-0003ZG-S0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xr-0007pH-1n
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CD+q+G2pfg+G/fTA/dZ5jOXbDYpzOBEKZujAnzbIZdU=;
 b=S7nyNNXP09e5XWDEdTYWja0pWW4l22pcqSSiJWUGLTabwWwXHwZm6bLNYjajzRVmLFISdJ
 5lUiuKoQ12x9DxDZUzHjAd7wTBSoYgaYStUK/ATF6iZKaauO/i/CayFSZRMBFWpHHi4V1N
 AGzAEK4kGpooK00w1Z2vNuSkFTg4AHc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-ECewP4QyN62yavZFAmikzg-1; Wed, 18 Oct 2023 12:00:03 -0400
X-MC-Unique: ECewP4QyN62yavZFAmikzg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so44466485e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644799; x=1698249599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD+q+G2pfg+G/fTA/dZ5jOXbDYpzOBEKZujAnzbIZdU=;
 b=MYlDiwvtJqCzUTVoBqPo1oA2uKxB4lpWMrbzzEkS9dIik9BVNDz59jQK2sz9qszPjR
 HoW9qHgEfTIi3nAph3GLxoRG+PO4nrXhVnP9fo+L430COs4iuGjbwmt7IGRswU/JkElP
 29D0SbVshwPSFXnmgtXnfNJiXI9T17tJ0kWRj7Noy4Wy39QQYk3UycLm7IREkI670qLf
 g3fqtlUU3HMNvC6p5n6JcSdYb5Ctf/ImUrEfYZJflV4IghQFTOxJf/WRiKqxyXXQDwvv
 Taj+AkiTqsd6Haj9e2EsB8D+d7SylA25k12k4DmxdyLb6aHQwPVcpX75S9ljIyMprf4K
 oDAA==
X-Gm-Message-State: AOJu0Yy8jpPx/ZpH6wjr1wBYJaJ4MO85NkNYj8v9rJaNfI2HVa20J1cM
 +AckilShGfv6MNTa847UIRiNg30JtcIaA99YhwQF3ks5FmYFT17XovSuEIVhYQrtQmB4+8AW4X5
 BN5pNnH9R43V9ggyWOZcAE8nxJxea3m5Nw/hFpMApSxgNlOKJyTTEFvXEfjfAoB70UC5l0II=
X-Received: by 2002:a05:600c:138d:b0:401:bf87:9898 with SMTP id
 u13-20020a05600c138d00b00401bf879898mr4706380wmf.25.1697644799168; 
 Wed, 18 Oct 2023 08:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3hSvZtMiWuA7JtLAjEYZPNi28mz1xZMvzEzFpXVA5+79HUenXbsgig4yqyvISydGVVouqEQ==
X-Received: by 2002:a05:600c:138d:b0:401:bf87:9898 with SMTP id
 u13-20020a05600c138d00b00401bf879898mr4706365wmf.25.1697644798855; 
 Wed, 18 Oct 2023 08:59:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 g19-20020a05600c4ed300b003fefaf299b6sm2062905wmq.38.2023.10.18.08.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:59:58 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:59:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 82/83] MAINTAINERS: Add include/hw/intc/i8259.h to the PC chip
 section
Message-ID: <7e3fb8ca55db27393c83d4b683c84fca2621698d.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

i8259.c is already listed here, so the corresponding header should
be mentioned in this section, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20231017152625.229022-1-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9fe5aa367..2f435102ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1764,6 +1764,7 @@ F: include/hw/dma/i8257.h
 F: include/hw/i2c/pm_smbus.h
 F: include/hw/input/i8042.h
 F: include/hw/intc/ioapic*
+F: include/hw/intc/i8259.h
 F: include/hw/isa/i8259_internal.h
 F: include/hw/isa/superio.h
 F: include/hw/timer/hpet.h
-- 
MST



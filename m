Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A52A7E3893
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:14:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4w-0003OC-V6; Tue, 07 Nov 2023 05:13:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4t-0003LD-Nx
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4r-0002ny-Ia
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tb+Ihf3FZQsxjNCgYDPZDlw3xq0lYm3eqZrirVZB9V4=;
 b=GkRgdgbmwTAiPcyAGOjUvaQ0Sjwiq/ttZKWUyyls19GWCqVhCC4qN/YgO8Xj08cw4F9EKO
 /CFc1ZPDrKcOlhdq81Yg4mwSh9+4gTl+fT/OM2/dV7k2ywvyU2EpNk4YMPpQPIjGqW9TCR
 UtadQZkWfzMp3tfX0yim7ZKS5ETRXEM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-irwdLg6aMuCmh5sUPibUEg-1; Tue, 07 Nov 2023 05:12:49 -0500
X-MC-Unique: irwdLg6aMuCmh5sUPibUEg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d8d17dcbaso2824878f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351968; x=1699956768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tb+Ihf3FZQsxjNCgYDPZDlw3xq0lYm3eqZrirVZB9V4=;
 b=MlN/CqM0c40wtOxuMn+ez9l5kaftlrhK/Y9J68MtaGQniUc7LGD2H4NqfMQ20L2Rv1
 6mE9xl6gnXUsh8JKElUelzuX7MHudT9oasNDImKmqvK6t5AKFJKAzLmdoZ6XsN30nF8o
 hhJ0JXQO1jSOWw1UmItbHKl2//0sJ7zVRiAMdZi+LPdquoGuTDOBZ48VnwC7z5RgrR4U
 wSvr2Rk+j7Z6Z/3nx+rvHwUqr1Ex/M6DmixuDH5s4lvb4fRvxWwjsI0/kOw+m6Gs0lv1
 i8IzhvLNxxOuzvmXnBJDMETytQ9V7JT1jz+spka10VFdKbe4rg7B2miHe29mDABGYIeU
 i+Og==
X-Gm-Message-State: AOJu0YwYLd7ANMgpV6/Kdeh3qeUWs2YKR+B35HO46ENQ2GhZnKd2QRub
 qyOCDy+FG4Tc+Ht9EiNN+airIw/Prc6QfOX98ZOMy1eeITIiKoGlyZ8e5aoOO+6FvVvONnDdIzR
 7976vquHVSyTuwkAQCa22SfXvELWEEa45Ovd6qiXYDk+s3hgcrQ9YgqUUJR4QE+Cxypkt
X-Received: by 2002:a5d:6d82:0:b0:32f:9511:9795 with SMTP id
 l2-20020a5d6d82000000b0032f95119795mr20193263wrs.11.1699351967948; 
 Tue, 07 Nov 2023 02:12:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHstBS62lVmTW8qyFCt5VA8dMhxbgK00lckVpjPK3N3XOAP/8TIB5UGoKpEXeI9kGDLbbEcMA==
X-Received: by 2002:a5d:6d82:0:b0:32f:9511:9795 with SMTP id
 l2-20020a5d6d82000000b0032f95119795mr20193249wrs.11.1699351967646; 
 Tue, 07 Nov 2023 02:12:47 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 l2-20020a5d4bc2000000b0032da319a27asm1924053wrt.9.2023.11.07.02.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:47 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Jeongtae Park <jtp.park@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL 44/63] hw/cxl: Fix a QEMU_BUILD_BUG_ON() in switch statement
 scope issue.
Message-ID: <45234c2dd2920f16f768bda1ec8353bda8c5a929.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As _Static_assert is a declaration, it can't follow a label until C23.
Some older versions of GCC trip up on this one.

This check has no obvious purpose so just remove it.

Reported-by: Jeongtae Park <jtp.park@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20231023140210.3089-6-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 5ebd81daf3..d0245cc55d 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -305,7 +305,6 @@ void cxl_component_register_init_common(uint32_t *reg_state,
     ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
 
 #define init_cap_reg(reg, id, version)                                        \
-    QEMU_BUILD_BUG_ON(CXL_##reg##_REGISTERS_OFFSET == 0);                     \
     do {                                                                      \
         int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
         reg_state[which] = FIELD_DP32(reg_state[which],                       \
-- 
MST



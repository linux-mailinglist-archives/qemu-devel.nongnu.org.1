Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E17D019B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiD-0002C6-Ke; Thu, 19 Oct 2023 14:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhO-0000UU-09
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhM-0003EC-7E
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CD+q+G2pfg+G/fTA/dZ5jOXbDYpzOBEKZujAnzbIZdU=;
 b=OdGMgw4qk4b0ZBuRQlqOm/c4sNYkucNy9J+KcVi5FhW/z7wlWqxNgsS0W2Orj2/EJyrKfA
 GkkXl3DaCSI/ktLF1WNzhC+vfDRt/ClC77GCY6PNj/QvGEuWNW8UdeLKtN4qDkk25IiiLB
 vzmLVnkUL3WvlXbPIP7exlUaGH5oLRM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-kiWkfu6nN3a6o47rXNgujw-1; Thu, 19 Oct 2023 14:24:41 -0400
X-MC-Unique: kiWkfu6nN3a6o47rXNgujw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-407558fe418so54927665e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739880; x=1698344680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CD+q+G2pfg+G/fTA/dZ5jOXbDYpzOBEKZujAnzbIZdU=;
 b=xA1ht9+6OJ8qhfFaSS4BmMPPUHwLpV3J+0eQ7u9xP9r6oE28nu34r6gfSqDTKfCZa/
 OSCCIu22Osxx+gdqcz4LmxDdAo+6efuBtTQLqNhq7YEXGkHP93O2vslgnNWa46xOMaon
 SgEOnxvhDXkntKyE3NlsvXZqp5pnGjunHY5mO0DFOhrB0g650V+zTu5/4N0cQbdN0K7d
 gpkZ5bkULP5Tt3clIPiyo1fKkTSun5d5pIwMTYUmvou48eOqDmKhZiohCAN/+GghCVRa
 UKmNqF+GBDVETlW3HpzMCLtnFlyla5E3lxsQuyuFrXKVdVxH0TOTHt6fWAg1wAFqn/ve
 dW/A==
X-Gm-Message-State: AOJu0Yz/rss5WD117ddUp3hIjYQcICGagVVqt9hvk2Cq+6bDdVXabBM/
 uZTP4CyI9AXjIb1rBAyrzdr67NLm9MXrkEgqPNvLVNnQPPvpj5J3R+OeoGb53l6IZVltHmWLDvJ
 dANH8hgY4IcnWvjoDMCCSRVzAzj7t/xABPbUUJxjllHvf5IvDT4+XpV55YwGtSCNLF+F4
X-Received: by 2002:a5d:4f0b:0:b0:319:68ce:2c53 with SMTP id
 c11-20020a5d4f0b000000b0031968ce2c53mr1914621wru.25.1697739880140; 
 Thu, 19 Oct 2023 11:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2DoLDscRie/K5Vd4vir1XBN05QgqNE05WCBHNsiet7eFWs9TnGfJM9N3IG6D0i7Bt2XO/hQ==
X-Received: by 2002:a5d:4f0b:0:b0:319:68ce:2c53 with SMTP id
 c11-20020a5d4f0b000000b0031968ce2c53mr1914602wru.25.1697739879664; 
 Thu, 19 Oct 2023 11:24:39 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adfe486000000b0032415213a6fsm4993463wrm.87.2023.10.19.11.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:24:38 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:24:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 77/78] MAINTAINERS: Add include/hw/intc/i8259.h to the PC
 chip section
Message-ID: <edfdf14791271a12cfd1e36c3e9d59a691b69bf5.1697739629.git.mst@redhat.com>
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



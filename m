Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323BB709A70
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Qz-0007AW-BF; Fri, 19 May 2023 10:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qw-00076P-IX
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Qv-0003Vk-6X
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcZFU9WEz6IBrpIZ1MKLxB7FV3fbWZxqDG0kHJf8q0c=;
 b=XYNXSfol/PfV/cg2jlvchq3DgQLYUc3O7ph6ubNILMjj8Nl4eUm21cJXX2YleK2qqOI0Vs
 JWu6kJrH4M+mwtfvqlN5VZxDPL51hjUmQrkoX/08NcEyyT0f2WoHUkmGX2Oo0x6Q/NePHi
 zIWrIe2N5PJs7l+4GT72LBPgxo0bDWI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-Je0_I5r5M32YnwAd3Gl-CQ-1; Fri, 19 May 2023 10:50:15 -0400
X-MC-Unique: Je0_I5r5M32YnwAd3Gl-CQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f38f48be8bso2237616e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507813; x=1687099813;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dcZFU9WEz6IBrpIZ1MKLxB7FV3fbWZxqDG0kHJf8q0c=;
 b=l60q7NcniqLalCUGO+8itLYCRj/+P7LH4pc/y0TeYXVS9Tkz4MEMiyF2Ds606oBQxo
 40gDEyWrJqZnMfbctEjHU+cze9h3wHNTllAATIBuZ0HoCBS8WgQVO5YC7NLXI7G3G/aH
 tUTRA7n4SBfhosaDhlYMeHiPlZgbC4Ke/TlemAc+plVFyDX+ygEi6A9rA6JKWaq06Zyo
 taNWqfyr8JYSBodQsJQLgdOY/3CI8xjFLZFf4PqvsEgRa/P8RPQrlBa2mRZK+MVp3jJy
 yqswssbb49NFKsvsYc5wqykp4w9Y8YsxplKRvM3a0tzUKZ1fsgq5AWfizv5zNmClzsp/
 SNTQ==
X-Gm-Message-State: AC+VfDxpC5UUePjJG80nMxOc46aMyKbU0+cqWeMZZTqmy8FOaxiJdLC2
 3Huk41xDzTAYdQUd/4SBb9FOUQuexgDJqeWb8rYbH4zQ0wqwahk9TmfJhdUyt2qEvZEw3A/D/TV
 XRmgjOQvBNhDT8Wy+xdxGppyRl5mgNa820R/RH/IQ+0gPenmhQ1U8YiizGn/xsc2soSd7
X-Received: by 2002:a19:7413:0:b0:4f3:a99f:1ea7 with SMTP id
 v19-20020a197413000000b004f3a99f1ea7mr916257lfe.55.1684507813569; 
 Fri, 19 May 2023 07:50:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4qANQQRUmSyE/TwtD2r+IpS9G0Y5O23eLP02MTZn+bsKqVBPJfgYaeWMubiwF/XkW+ruYQ9A==
X-Received: by 2002:a19:7413:0:b0:4f3:a99f:1ea7 with SMTP id
 v19-20020a197413000000b004f3a99f1ea7mr916251lfe.55.1684507813323; 
 Fri, 19 May 2023 07:50:13 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 a15-20020ac2520f000000b004f393d4b51fsm620629lfl.190.2023.05.19.07.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:12 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fan Ni <fan.ni@samsung.com>
Subject: [PULL 07/40] hw/cxl: drop pointless memory_region_transaction_guards
Message-ID: <23e1248d7e3cb7331a1cee13ff109a5c52471ec2.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Not clear what intent was here, but probably based on a misunderstanding
of what these guards are for.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230421135906.3515-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-component-utils.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index b665d4f565..324be79b11 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -47,14 +47,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
         break;
     }
 
-    memory_region_transaction_begin();
     stl_le_p((uint8_t *)cache_mem + offset, value);
     if (should_commit) {
         ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
         ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
         ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
     }
-    memory_region_transaction_commit();
 }
 
 static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE974E1DF
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzvl-0000pa-AW; Mon, 10 Jul 2023 19:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvi-0000en-Ta
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzvh-0004X0-I2
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zofxrfRWOPA7vCxeFJ2sQZ2pbcHa86xzs6DzLNXbfH8=;
 b=bvuaOsAVIP3c1JKmUxkFVs2cgssalzccFB0Gz9hZhE2JHDL1AFcZ/Gllpd0r9Q2NBq0q2A
 nXAHjWWKmF1mgAy+iGi6BXa9UfJh1sbxRWOogdWIR9KZ039g0ahU/T45RJ5z//aH/lfeQY
 uA0s4hwpr/JywK9RgfAdaYGaM6YmgHo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-18V-fx-2OmO0M413xUYitg-1; Mon, 10 Jul 2023 19:04:27 -0400
X-MC-Unique: 18V-fx-2OmO0M413xUYitg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbdf34184eso31733275e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030266; x=1691622266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zofxrfRWOPA7vCxeFJ2sQZ2pbcHa86xzs6DzLNXbfH8=;
 b=GVdc/DyvXrtADRmwyRmzO4ic/rCrbN65SbnxG6Fd0m+2naEZK5uE5fSCZszrYrbztO
 +qtA8FB6HhS30FRmGKu23jesrQ/e9AxYz/CNoQtpylKx/MryC1S+IS4+1ZHBRcuByr01
 dgSPeE+Wl1hZrfribQsCj60rY2rwnz/YtSOKiMqYlnS8RhopEXJUSbEzD1s2yoCNJ3Fh
 26qE9Vg72m4K/YrSOzXrpzWwauE4nX8cltRMXj5I0vvQOr/pbknnL0dBmIOkVKw6cFNi
 96QOpRI1G6OLN2fjidISdgirbcgz1oyYCD77EEsG1SkWY4PmpOmKVLFth7bdsQuzZssT
 Q/TQ==
X-Gm-Message-State: ABy/qLbfAEe3M5iEZRzjI0YIAfbmkNBLNwgWfG3xEqECWiQF8P2AUzuu
 3KJEnKbs4zzhTIdkbh+6toWPcjtO+FI0JJfnNXyE5O7mtmi/hwi4vqt27qph+OW34J0hFsQbRw1
 znc/3gxVzQ18vOyFUDtUimpeVsolSrWPWjTIiJxj210IgY5AO/n9jwo+vZyhJmOlAYfuZ
X-Received: by 2002:a05:600c:220b:b0:3fc:85c:5ef7 with SMTP id
 z11-20020a05600c220b00b003fc085c5ef7mr7126499wml.22.1689030266153; 
 Mon, 10 Jul 2023 16:04:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCTwWDRW7TJtOfeNwXrm9xRKXdXTgUJ7N763zQj4YcdpVR+Odwc1br5W+8Z+VQWTF0p5fi6w==
X-Received: by 2002:a05:600c:220b:b0:3fc:85c:5ef7 with SMTP id
 z11-20020a05600c220b00b003fc085c5ef7mr7126476wml.22.1689030265808; 
 Mon, 10 Jul 2023 16:04:25 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 z14-20020a05600c220e00b003fbacc853ccsm939643wml.18.2023.07.10.16.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:25 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 41/66] tests/acpi: allow changes in DSDT.noacpihp table blob
Message-ID: <8d60105a5973320ffd72a48f208cfd2b041d6c0b.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Ani Sinha <anisinha@redhat.com>

We are going to fix bio-tables-test in the next patch and hence need to
make sure the acpi tests continue to pass.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230705115925.5339-2-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..31df9c6187 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/DSDT.noacpihp",
-- 
MST



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D27ED7B9D11
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:50:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNnK-0007Cg-6v; Thu, 05 Oct 2023 08:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNnI-0007AG-4D
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNnG-0003v8-Ez
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y+dk+wGnHXkxb7xuZvjp1YVJzaN1h5Ibrq8vJpUwOgE=;
 b=Hy0ibIMFne+oymPQt6FbWlWvsiwR+QxkeigsMXlPu6eeLuLPZo8LL8+ND5MOaM4t9Wpk6T
 J10s1K1lwXvCV90SpgDOC1qZ8hkB/3yuAC9QjmQ2sxoQYbeWi2xUCp0W90ZDTJT2LQiqP2
 am4xoNNNBm8n5o9L4XncWASnu8oAh4g=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-TCCJcLd0OwWtqX-wJHljOA-1; Thu, 05 Oct 2023 08:49:08 -0400
X-MC-Unique: TCCJcLd0OwWtqX-wJHljOA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a1cf3e6c04so79697766b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510147; x=1697114947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y+dk+wGnHXkxb7xuZvjp1YVJzaN1h5Ibrq8vJpUwOgE=;
 b=oEXzI7hKaRQWDDdNetTDsx/ofnpcDCfjbctXHY0uw4gmTX/xq6ssepls+EQegGEz6C
 7cA4KqBmwhD/i0lS8obDEb1+dGXv32xQ2Hatz3L+TKR7Y7BvA1EZj/Jta7vAgr/GartO
 3jmSjiM/5OnuijUaqeYRt20M7j/jlFOnezR+KuIuWBQUrAxar+v5uVei4ch0rGbtW8TX
 WGNjgpdb3RHQ99cXV6DXYDXomYz2eCy5kXcaAFXEBJWaYSd7jUbOEeQtrGtj0pi9oaII
 /LY7HbGa5R5pIPMWlG29h5oN0vfft8hwqQnMulXExksZWSdcq+SI+yf0+NtBPAHP6gW2
 HIvw==
X-Gm-Message-State: AOJu0Yx7WC47n2ujKjXq5IxTW/oO6KQVoc3deUO3LX41I9sG9Nvq7t09
 L/eyRKmDHCp8uz/O51Sp5BQ46GB057nD9OLhBVljEgF9Y0DqI79KtwRDJL4dnct7iFaMpQZwsyG
 2+STqMSPSg8oRRcB4BMPvMH6VE5B5EXKrM1YnKkx57t/5vOZ7Fby97KOcBkwpnjHxA7RAH1G7bl
 U=
X-Received: by 2002:a17:907:c205:b0:9b2:d78c:afe9 with SMTP id
 ti5-20020a170907c20500b009b2d78cafe9mr4294176ejc.49.1696510147254; 
 Thu, 05 Oct 2023 05:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnxdBFuPvp12mlpMHqJlbihvJIX2zFTS8lwTrfObFH/vZxzwp9t8WlLQ93irRLrPn0dMBNZQ==
X-Received: by 2002:a17:907:c205:b0:9b2:d78c:afe9 with SMTP id
 ti5-20020a170907c20500b009b2d78cafe9mr4294162ejc.49.1696510146863; 
 Thu, 05 Oct 2023 05:49:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170906f90b00b009b9aa8fffdasm1150239ejb.131.2023.10.05.05.49.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:49:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] cutils: squelch compiler warnings with custom paths
Date: Thu,  5 Oct 2023 14:49:05 +0200
Message-ID: <20231005124905.64750-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Setting --bindir= to an absolute path that is shorter than the
prefix causes GCC to complain about array accesses out of bounds.
The code however is safe, so disable the warning and explain why
we are doing so.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/cutils.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/util/cutils.c b/util/cutils.c
index 486acbdd673..f8030fe9f70 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -1012,8 +1012,15 @@ int qemu_pstrcmp0(const char **str1, const char **str2)
 static inline bool starts_with_prefix(const char *dir)
 {
     size_t prefix_len = strlen(CONFIG_PREFIX);
+    /*
+     * dir[prefix_len] is only accessed if the length of dir is
+     * >= prefix_len, so no out of bounds access is possible.
+     */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Warray-bounds="
     return !memcmp(dir, CONFIG_PREFIX, prefix_len) &&
         (!dir[prefix_len] || G_IS_DIR_SEPARATOR(dir[prefix_len]));
+#pragma GCC diagnostic pop
 }
 
 /* Return the next path component in dir, and store its length in *p_len.  */
-- 
2.41.0



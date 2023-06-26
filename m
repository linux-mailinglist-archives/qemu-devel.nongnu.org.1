Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2873DFED
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlK3-0000lf-V9; Mon, 26 Jun 2023 08:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlK1-0000jy-Vs
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlK0-0002X1-5Y
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Af6at3fsIEuuqbjTx7xlWdUMwOaCT0ky+V/sNrkOzw=;
 b=RbBkmZ8GYdIJ/n7TvDZvJUOpTX79gs6FfRBZf/xNAV6NwulsWAenxnL7Pa57acpaaMb6x3
 qfHjWQhOlnXwdulSV6kd2GJOyDn9IAKPUEGmOQOgaj+BTO5fthobeuZRLvZnjifJriS8un
 zh1d8qvqYcssA6MA71RyNYhgwBxhiSA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-or3VkmzUPeKGa3G1okYAww-1; Mon, 26 Jun 2023 08:27:54 -0400
X-MC-Unique: or3VkmzUPeKGa3G1okYAww-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso1071344f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782472; x=1690374472;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Af6at3fsIEuuqbjTx7xlWdUMwOaCT0ky+V/sNrkOzw=;
 b=l9ej23obwoaVXf4bahd3/Q/o7Ih6olsyjownEn6vJiXu1hwPoYGQ3rHGcBLg789Yyy
 wLELIqIUSV9AVJpENUxYEgOhM53tVNAUicWx2S6gPr4Qffidh5oQ8hUL7viuUfLKAV65
 oGShaTDfFlPnp8lwKqVcAhpbJ80vUxtxXa5UbbqrMCIYiOTsv96vWaKRie86Z1GGc4B0
 LcAMQw879ayV5HVU2jyRPBhPABjxzYX3U9H1z9x5uNKMS6cEuGqV5rd38Ntdp+aXjbzz
 fKyyfbQW/tXRU6emvS50kLI8JIkLHMAeXA2VtgMLQcRminL1oXZgS1LI0APKrfKcCBGm
 S7Sw==
X-Gm-Message-State: AC+VfDwG0oJvLXj4hQ+31oRzh826gAWT3Szfeux5KUC/gBPs3lyE/rSF
 ZcAKkYtnTQxZ5t4+Z/GlRarI5BZ7zExBSStCwzb8S3/woAJsntN3QUrXCqKUkkcLex7+HDLPBQu
 6YxEmtk8xBR2xwgUS4Znr6w4kKCt0c4GASust+mZ3+Y9pgaJVeHJswfZtCnWHu92KPBCy
X-Received: by 2002:adf:fa06:0:b0:30f:be04:5b5e with SMTP id
 m6-20020adffa06000000b0030fbe045b5emr18267180wrr.37.1687782472606; 
 Mon, 26 Jun 2023 05:27:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uMYw/TxDROijUdI1EzBOUH3Bwe5cP7iUQP4ZBE0DHkDQ/D/vBgKHO1OdQO6pC9WmowfKFnQ==
X-Received: by 2002:adf:fa06:0:b0:30f:be04:5b5e with SMTP id
 m6-20020adffa06000000b0030fbe045b5emr18267164wrr.37.1687782472295; 
 Mon, 26 Jun 2023 05:27:52 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d590a000000b0030631a599a0sm7233459wrd.24.2023.06.26.05.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:27:51 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:27:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/53] bswap: Add the ability to store to an unaligned 24 bit
 field
Message-ID: <14180d6221502bd4b9d96fa5f1065e7cda4bcf00.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ira Weiny <ira.weiny@intel.com>

CXL has 24 bit unaligned fields which need to be stored to.  CXL is
specified as little endian.

Define st24_le_p() and the supporting functions to store such a field
from a 32 bit host native value.

The use of b, w, l, q as the size specifier is limiting.  So "24" was
used for the size part of the function name.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230526170010.574-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/bswap.h        | 25 +++++++++++++++++++++++++
 docs/devel/loads-stores.rst |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 15a78c0db5..933a66ee87 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -8,11 +8,23 @@
 #undef  bswap64
 #define bswap64(_x) __builtin_bswap64(_x)
 
+static inline uint32_t bswap24(uint32_t x)
+{
+    return (((x & 0x000000ffU) << 16) |
+            ((x & 0x0000ff00U) <<  0) |
+            ((x & 0x00ff0000U) >> 16));
+}
+
 static inline void bswap16s(uint16_t *s)
 {
     *s = __builtin_bswap16(*s);
 }
 
+static inline void bswap24s(uint32_t *s)
+{
+    *s = bswap24(*s & 0x00ffffffU);
+}
+
 static inline void bswap32s(uint32_t *s)
 {
     *s = __builtin_bswap32(*s);
@@ -26,11 +38,13 @@ static inline void bswap64s(uint64_t *s)
 #if HOST_BIG_ENDIAN
 #define be_bswap(v, size) (v)
 #define le_bswap(v, size) glue(__builtin_bswap, size)(v)
+#define le_bswap24(v) bswap24(v)
 #define be_bswaps(v, size)
 #define le_bswaps(p, size) \
             do { *p = glue(__builtin_bswap, size)(*p); } while (0)
 #else
 #define le_bswap(v, size) (v)
+#define le_bswap24(v) (v)
 #define be_bswap(v, size) glue(__builtin_bswap, size)(v)
 #define le_bswaps(v, size)
 #define be_bswaps(p, size) \
@@ -176,6 +190,7 @@ CPU_CONVERT(le, 64, uint64_t)
  * size is:
  *   b: 8 bits
  *   w: 16 bits
+ *   24: 24 bits
  *   l: 32 bits
  *   q: 64 bits
  *
@@ -248,6 +263,11 @@ static inline void stw_he_p(void *ptr, uint16_t v)
     __builtin_memcpy(ptr, &v, sizeof(v));
 }
 
+static inline void st24_he_p(void *ptr, uint32_t v)
+{
+    __builtin_memcpy(ptr, &v, 3);
+}
+
 static inline int ldl_he_p(const void *ptr)
 {
     int32_t r;
@@ -297,6 +317,11 @@ static inline void stw_le_p(void *ptr, uint16_t v)
     stw_he_p(ptr, le_bswap(v, 16));
 }
 
+static inline void st24_le_p(void *ptr, uint32_t v)
+{
+    st24_he_p(ptr, le_bswap24(v));
+}
+
 static inline void stl_le_p(void *ptr, uint32_t v)
 {
     stl_he_p(ptr, le_bswap(v, 32));
diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index d2cefc77a2..dab6dfa0ac 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
 ``size``
  - ``b`` : 8 bits
  - ``w`` : 16 bits
+ - ``24`` : 24 bits
  - ``l`` : 32 bits
  - ``q`` : 64 bits
 
@@ -65,6 +66,7 @@ of size ``sz`` bytes.
 Regexes for git grep
  - ``\<ld[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
  - ``\<st[bwlq]\(_[hbl]e\)\?_p\>``
+ - ``\<st24\(_[hbl]e\)\?_p\>``
  - ``\<ldn_\([hbl]e\)?_p\>``
  - ``\<stn_\([hbl]e\)?_p\>``
 
-- 
MST



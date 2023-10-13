Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C37C7FCF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:17:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3v-0008BN-IN; Fri, 13 Oct 2023 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3t-00087x-Mg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3o-0006ld-Nd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405524e6769so11341635e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183895; x=1697788695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACmNUd64zxjCY/ANkaz/wSfLOgrw3On2aAMpHQJnPUA=;
 b=B/T0v9lL4IKt/uEyDrIG+Qh6Oo9KsMD/BCHcmlZG0BmqwABkKE4eWIUz/aPmRu5oLT
 yx9FDIv2eIwx27LqOnox9savqHwFGO5DUX1gV8Q9wtZV90CxUEFh+3j5mHYeDwPSbwPJ
 Y1iXM1zRYfL4gKZUP4CPq82os3ishB/QVrehviJ0kzXVzlpkrfVHaPWBytrWhrfzc6PB
 lCt0/Ctd8JJnFfkRmI/Ny9P1V7S9hyW+UOSSnTbFVB6NqfiN2x48hc7w4B7iM2u1HR4w
 eUA05GCurEq0ybqETbQBOgL7/vyzfa4xNEn8i3AkFEw7cyuOwxroinChI8ve0GyyF6S1
 sR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183895; x=1697788695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ACmNUd64zxjCY/ANkaz/wSfLOgrw3On2aAMpHQJnPUA=;
 b=AYBPJkL8qBesIboKdH0LhPAT65M8v1cZZOTfbYu9wtFbk2GlFNigR4Jp6TAOAdQcZf
 ZPtlPEkAmDO/GkI5ECPy16rJ/SuOrCH3HDnBkYk1h1ho6Jg0gxiYrivhhHEnoglR6P2J
 zW0HO9+4BonpNIr0H/vGUOvNiWU7D+fx/E2feckITc8vw/AcgUIJZyFgAp3Ccc1P0q8o
 ik3ePqFqMqrBZ+uJRxnWcpgyXdJpLfdr++iBehKh1QngUstaWhZH+GVjwyTw0vhdbxoy
 QcHY29LEK4uiWUEu4QGMZObhYJhMMsGWhXowpQ46ogUAD7hsh3plJwFAKl79UIHiNMEe
 UzHQ==
X-Gm-Message-State: AOJu0YxH6UY71xuc9giML6KFqmJU61pl1WJukc6r14RegNboadzCBPI0
 +BPSoCCJZWCn183A0dCY3GJ2TaV4FqVbW17/qc4=
X-Google-Smtp-Source: AGHT+IHVJqMzPHF7d3+dlnS/k0RC0hx5acLnH4x4Bo8LRGmeVLB3uTnVlGBcJnU1U8c8Bb8bX1Zq9Q==
X-Received: by 2002:a7b:c4cc:0:b0:402:f91e:df80 with SMTP id
 g12-20020a7bc4cc000000b00402f91edf80mr19191754wmk.3.1697183894880; 
 Fri, 13 Oct 2023 00:58:14 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:14 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [RFC PATCH v2 09/78] hw/acpi/aml-build.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:36 +0300
Message-Id: <7cd146bcd384f4e11754b2983008b385f80343d9.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/acpi/aml-build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index af66bde0f5..b0cf0c6073 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -292,56 +292,55 @@ static void
 build_prepend_package_length(GArray *package, unsigned length, bool incl_self)
 {
     uint8_t byte;
     unsigned length_bytes;
 
     if (length + 1 < (1 << PACKAGE_LENGTH_1BYTE_SHIFT)) {
         length_bytes = 1;
     } else if (length + 2 < (1 << PACKAGE_LENGTH_3BYTE_SHIFT)) {
         length_bytes = 2;
     } else if (length + 3 < (1 << PACKAGE_LENGTH_4BYTE_SHIFT)) {
         length_bytes = 3;
     } else {
         length_bytes = 4;
     }
 
     /*
      * NamedField uses PkgLength encoding but it doesn't include length
      * of PkgLength itself.
      */
     if (incl_self) {
         /*
          * PkgLength is the length of the inclusive length of the data
          * and PkgLength's length itself when used for terms with
          * explicit length.
          */
         length += length_bytes;
     }
 
     switch (length_bytes) {
     case 1:
         byte = length;
         build_prepend_byte(package, byte);
         return;
     case 4:
         byte = length >> PACKAGE_LENGTH_4BYTE_SHIFT;
         build_prepend_byte(package, byte);
         length &= (1 << PACKAGE_LENGTH_4BYTE_SHIFT) - 1;
-        /* fall through */
+        fallthrough;
     case 3:
         byte = length >> PACKAGE_LENGTH_3BYTE_SHIFT;
         build_prepend_byte(package, byte);
         length &= (1 << PACKAGE_LENGTH_3BYTE_SHIFT) - 1;
-        /* fall through */
+        fallthrough;
     case 2:
         byte = length >> PACKAGE_LENGTH_2BYTE_SHIFT;
         build_prepend_byte(package, byte);
         length &= (1 << PACKAGE_LENGTH_2BYTE_SHIFT) - 1;
-        /* fall through */
     }
     /*
      * Most significant two bits of byte zero indicate how many following bytes
      * are in PkgLength encoding.
      */
     byte = ((length_bytes - 1) << PACKAGE_LENGTH_1BYTE_SHIFT) | length;
     build_prepend_byte(package, byte);
 }
@@ -508,37 +507,38 @@ static void build_buffer(GArray *array, uint8_t op)
 void aml_append(Aml *parent_ctx, Aml *child)
 {
     GArray *buf = build_alloc_array();
     build_append_array(buf, child->buf);
 
     switch (child->block_flags) {
     case AML_OPCODE:
         build_append_byte(parent_ctx->buf, child->op);
         break;
     case AML_EXT_PACKAGE:
         build_extop_package(buf, child->op);
         break;
     case AML_PACKAGE:
         build_package(buf, child->op);
         break;
     case AML_RES_TEMPLATE:
         build_append_byte(buf, 0x79); /* EndTag */
         /*
          * checksum operations are treated as succeeded if checksum
          * field is zero. [ACPI Spec 1.0b, 6.4.2.8 End Tag]
          */
         build_append_byte(buf, 0);
         /* fall through, to pack resources in buffer */
+        fallthrough;
     case AML_BUFFER:
         build_buffer(buf, child->op);
         break;
     case AML_NO_OPCODE:
         break;
     default:
         assert(0);
         break;
     }
     build_append_array(parent_ctx->buf, buf);
     build_free_array(buf);
 }
 
 /* ACPI 1.0b: 16.2.5.1 Namespace Modifier Objects Encoding: DefScope */
-- 
2.39.2



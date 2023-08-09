Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA7A775669
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:30:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfVs-0004Ye-QB; Wed, 09 Aug 2023 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVn-0004Xq-17
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTfVk-0003ak-IF
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691573387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+jdDw/EKyqCYKsDK+HMFdWnVALvk9XS+pcfWaUOEKk=;
 b=iMmSN1t1bdT9QxyP6HkI1GwXTg3IqCR53ACdUDYzj1eTzLKIQVpZbYUdFleEqy+zxqyY3f
 wDX8VlNOTiL73JRMJMHL95lmu3D4hZ4pSBAxPW8XbCZW9MXo3JtH6lobsMyqxg1cq34tAJ
 ES24fydZlwABpIeBTZbfEvnIgEJTHtg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-8PjzTKUVM7qHXV0S5YqPOg-1; Wed, 09 Aug 2023 05:29:46 -0400
X-MC-Unique: 8PjzTKUVM7qHXV0S5YqPOg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9fa64db5cso70221311fa.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691573384; x=1692178184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+jdDw/EKyqCYKsDK+HMFdWnVALvk9XS+pcfWaUOEKk=;
 b=EGHYQwf2wDGGLd+RUFZ3fl18oscWg/dwFV4r/2U2857w36JdbGk5nN6+YxHYG8dQfJ
 NW5CM0fp4O0ZWyvLk1daHU4LdudCdLCVn1Tl/l4YSKTZCo/I1l9dEUqKOCxWnpQ+B2oK
 tOfXipI6XxUz5V1H0HCtXMd1bjwVlZedODgFSSr/TtFnIv2r6GrO8LPwU2eMGqeLlZ0t
 8NM/ZrjdsqMSxITega6ev0Zph+ZbWMXr2lmLOJOki2BLgsOpj3gPTu1nZFh9aHklnj3V
 q7ehOHPS3mx79GQqEQRkYOqJR48wG/Ni9Re+CtP6Vro4TAlDD+wu5DobgPN/fj3aaYoP
 oXcA==
X-Gm-Message-State: AOJu0Yy/RBj3s5xQtQJfo4ihlo/LlI0WK4qtMEzBUvK4ONOY5d3ac2GM
 a+MaqJ7MA4FvfF0/Mfw+uP+mOtHYkEaRla+N94M0qlRXEVVDbzsBx2WHyR/bhUyQ80qm2X00SMx
 Zu+/v/NRVKq6mOkGJ2CsuJ4PMhxS8WaI0yEXYvtirSIQi0Fw67vwiB09vmSXDqUsEb27Y6qyd4l
 E=
X-Received: by 2002:a2e:9216:0:b0:2b9:7513:3596 with SMTP id
 k22-20020a2e9216000000b002b975133596mr1526958ljg.5.1691573384704; 
 Wed, 09 Aug 2023 02:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNxOgOdxW2/0+Sp5UkmHi4PIS7W9SEhI98MPMRyJnWHQ1dl4oKc0nRKAVK2m8cx9GAfvkMA==
X-Received: by 2002:a2e:9216:0:b0:2b9:7513:3596 with SMTP id
 k22-20020a2e9216000000b002b975133596mr1526952ljg.5.1691573384457; 
 Wed, 09 Aug 2023 02:29:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a1ce909000000b003fc04d13242sm1449494wmc.0.2023.08.09.02.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 02:29:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 5/9] configure: never use PyPI for Meson
Date: Wed,  9 Aug 2023 11:29:29 +0200
Message-ID: <20230809092933.761524-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809092933.761524-1-pbonzini@redhat.com>
References: <20230809092933.761524-1-pbonzini@redhat.com>
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

Since there is a vendored copy, there is no point in choosing online
operation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configure b/configure
index f2bd8858d6c..f13f0662b98 100755
--- a/configure
+++ b/configure
@@ -1018,13 +1018,7 @@ fi
 python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
-mkvenv_flags=""
-if test "$download" = "enabled" ; then
-    mkvenv_flags="--online"
-fi
-
 if ! $mkvenv ensure \
-     $mkvenv_flags \
      --dir "${source_path}/python/wheels" \
      --diagnose "meson" \
      "meson>=0.63.0" ;
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3B707026
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH6-0005Kt-Lm; Wed, 17 May 2023 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLFD-0002si-EM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLFC-0004f2-2Z
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WjLgdJJv5pfwWhI+KcQ/W+YlH4SCMKiudSw5H03DTe0=;
 b=WARcQkVLhqSg9BXdAWgTkG7TJsJ32Wozy+1cuKhM6ZpU7pQ70zi79Mkr/iqJAsGPFJGGj+
 pBwQLvdvNxi8co59q8HDeriMlWkljUVaR7ksnJ1WatvQNFq6HYFrT3RVo+b7JrXGLW7Ik6
 jYI/3S70ZU9jnS83tEMLi8zxdKvd5kE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-miTNelp9P2K7YzlAopVjBw-1; Wed, 17 May 2023 13:47:12 -0400
X-MC-Unique: miTNelp9P2K7YzlAopVjBw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f42b36733aso4441825e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345630; x=1686937630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjLgdJJv5pfwWhI+KcQ/W+YlH4SCMKiudSw5H03DTe0=;
 b=laytU6aUBqV98Gf2ANxkrDyDS8nTI3mK1vQ1QnOuwXB+ZZ3HAw9/KKKtYAdYoHUNcf
 ALKozcHDJtHadAA4XiN4zxPgYd2VeTqkGxWnPank4mF6Vq3GjAcLcBDdDaOUSVgnD2/9
 M/xXLie8J7etdtOGaAtCdksSNjTBJA/Kv0IZP2Hot0kQR14t7ZgRKgzBF7efBDptchxx
 lvnL7pXcWKv04h/yKw9KHoS1CMlr5hNt/LLIDZicCcfKEQAqq+Jv1uAEJiLdoj1VqL8o
 BBH46n6U4n3ThWZgF7uT8NOe9FKU7rpmfTqaHhUsli/vRBoMsgSKAxI9Iz4yV1WtdRz+
 MsZA==
X-Gm-Message-State: AC+VfDxa0M6UK/otU1gJYqBb2sHhR8NcqzFr/RewyVSgU+/u6BOhv46F
 bQUhS7aC0kbwuCy9T54MIMOMXxbsQ63umZOeHPcKgjeFoeQDOBYlCzacpfL8WtRTuZZ97rQkbXl
 ZbbKgeQikjI0vBp1kW6wwVCz+uSl7krBxWVs0RWwUmtO/v+pnOlDpnOe7S7SNarohVBGwg+RZ7O
 4=
X-Received: by 2002:a1c:4b0c:0:b0:3f4:20bd:ba4b with SMTP id
 y12-20020a1c4b0c000000b003f420bdba4bmr26054080wma.21.1684345630580; 
 Wed, 17 May 2023 10:47:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73loZc611ydlMbh0vrMKVcshfTvaJRulfmeGLwyvCS/R8nd1Gj6k73xY4x/uHQWksTHRtqZw==
X-Received: by 2002:a1c:4b0c:0:b0:3f4:20bd:ba4b with SMTP id
 y12-20020a1c4b0c000000b003f420bdba4bmr26054071wma.21.1684345630218; 
 Wed, 17 May 2023 10:47:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a1cf705000000b003f4f1b884b3sm2842919wmh.20.2023.05.17.10.47.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 67/68] configure: remove unnecessary check
Date: Wed, 17 May 2023 19:45:19 +0200
Message-Id: <20230517174520.887405-68-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

All calls to probe_target_compiler are conditioned on
some "have_target" invocation, or inside a loop on target_list.
Therefore there is no issue with building unnecessary
firmware images and tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/configure b/configure
index 9dc17aaa7c86..7135251fdcd8 100755
--- a/configure
+++ b/configure
@@ -1324,13 +1324,6 @@ probe_target_compiler() {
   container_cross_ranlib=
   container_cross_strip=
 
-  # We shall skip configuring the target compiler if the user didn't
-  # bother enabling an appropriate guest. This avoids building
-  # extraneous firmware images and tests.
-  if test "${target_list#*$1}" = "$1"; then
-      return 1
-  fi
-
   target_arch=${1%%-*}
   case $target_arch in
     aarch64) container_hosts="x86_64 aarch64" ;;
-- 
2.40.1



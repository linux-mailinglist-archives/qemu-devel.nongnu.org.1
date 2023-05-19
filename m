Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684E70924C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvuz-0002DG-FA; Fri, 19 May 2023 04:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvuy-0002D7-04
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvuw-0000Ao-IK
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mo+ztAyGGiOip3OHpCp1FYFteyCn3B9iHVCaLmu1ZYw=;
 b=XaZ6QDKIQOPAnYGUBWW3IIm+ctD/y29OL3rpgDH/iiFkQk1Cf6ev5xKmMJPzJG3E187VPk
 L+FkkQo6WYqOPRc/o0XJ0Sq2xtijKkSfntwpBeoqn0EO2dxyJwhTKL8R4WOfSfsjDGaHFq
 XnVmwGiOXvc02ck+CB4gHQd3Rbba+ZQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-eWQTwys1NROUbFDyAYipyA-1; Fri, 19 May 2023 04:56:52 -0400
X-MC-Unique: eWQTwys1NROUbFDyAYipyA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-969f12b2818so193371966b.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486611; x=1687078611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mo+ztAyGGiOip3OHpCp1FYFteyCn3B9iHVCaLmu1ZYw=;
 b=OXPpmTJfbTFDWLSwRgYqOeJwMJ3iUHL6HqyJ9Dm9GQOTTsEI7XBF58CtnXOOn/YTMN
 5wDPMHsp7X0HYsWsD0Z0qoEzuBgsmyTYrWtJa6Ak+QM1auqp8JkfDzY4H9YUT74pOcYA
 fOwpGH9gSnxvqscbRnQvNcTuY7moimGtBgrclTCUlq1E957U0vG0PbvfL016L8XOkmSc
 xoVaEwWRM97ywCdxzddclX5noHch1MANHv/HcDG1J9ZKci+ByleoAvfPg8tR/UE1gj6N
 U/oUoy4fC2TRyoOQwYBMvmXcSnHUnWlnEifXCtvj0ohKotTOCf87AATgQhEdB+YKjdFP
 hFBw==
X-Gm-Message-State: AC+VfDwX5TAH7LYyMhSEotgdR0TvPJzgz5KIr9XDoe/RTOtxY+V9NZMN
 tmzDtVqImXhovm3VxI9La/NpARF+3eSzGUp1P/+g+RvcQ2ZUa+GgavIK08jIheZ9T7tTI0j8SOv
 uQIdOwCLbpXMCk/9iemXkzNFiGWGJe7WvCqpNBw0y66XT2hraAI7FJc9TQrUfLOaVvDbli+OEu1
 Q=
X-Received: by 2002:a17:907:930d:b0:96f:5cb3:df66 with SMTP id
 bu13-20020a170907930d00b0096f5cb3df66mr995438ejc.18.1684486610921; 
 Fri, 19 May 2023 01:56:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7sym6X6etH/PVOk7cXj1AmnxRSgkpdSLIRT+ubjNvOWuowR6fW8SVLjmMEy43s3d48s3NBdg==
X-Received: by 2002:a17:907:930d:b0:96f:5cb3:df66 with SMTP id
 bu13-20020a170907930d00b0096f5cb3df66mr995411ejc.18.1684486610489; 
 Fri, 19 May 2023 01:56:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a1709062b0900b00969dfd160aesm2012255ejg.109.2023.05.19.01.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:56:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 1/6] remove remaining traces of meson submodule
Date: Fri, 19 May 2023 10:56:41 +0200
Message-Id: <20230519085647.1104775-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519085647.1104775-1-pbonzini@redhat.com>
References: <20230519085647.1104775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 4 ----
 scripts/archive-source.sh           | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 7edb50b76035..c9f2e737c09a 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -5,10 +5,6 @@
   before_script:
     - JOBS=$(expr $(nproc) + 1)
   script:
-    - if test -n "$LD_JOBS";
-      then
-        scripts/git-submodule.sh update meson ;
-      fi
     - mkdir build
     - cd build
     - ../configure --enable-werror --disable-docs --enable-fdt=system
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 23e042dacdb3..c03532915471 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc meson ui/keycodemapdb"
+submodules="dtc ui/keycodemapdb"
 submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
-- 
2.40.1



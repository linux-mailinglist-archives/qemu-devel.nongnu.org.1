Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8ED70AA9C
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Ruf-0007Ep-MV; Sat, 20 May 2023 15:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Ruc-0007E7-5E
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rua-00006x-Nj
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mo+ztAyGGiOip3OHpCp1FYFteyCn3B9iHVCaLmu1ZYw=;
 b=TM8UjtXfH1JgbXOdPFIjy6yYNQx5CZNxhqJeU3FTRlZrivLZeSC7fLMwh221YDXMtXqZ1o
 TiMPS06OTlGX0vG5DmYq+x5wC+8IiGU4jcFs4/Ji7iDO5jrAPLbLcz1OSpRr+gw4EJD5Fd
 NCfUGvIXkhCNVqCbU3jhqLfuGjxbsl4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-n3D8VNtDMQaGXtMT6F7DjA-1; Sat, 20 May 2023 15:06:37 -0400
X-MC-Unique: n3D8VNtDMQaGXtMT6F7DjA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50bc456a94dso4375654a12.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609596; x=1687201596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mo+ztAyGGiOip3OHpCp1FYFteyCn3B9iHVCaLmu1ZYw=;
 b=S9hE5adVPZo9RpkTTb3MsE1ROAp5l4hKOQ67RblHpaFHeFNauXAh3UN8sUTdHMcTei
 zWwNeNmZuDXN7a9jSda4motS89wZceUe6zq49p6MYIA4zK3xxee0GmWBpfQChH4QbzBJ
 EwZTEkgM9JciPvF2GXaw7RrAai+ZcGcv7AB6gEEVEqmFbM9zXdjO25kqYPCBHUBfon4j
 SvJv5R1Ssl35oL1xh6kkEwRMET9agKjwmHgssYfwSj9dR3hf6B+3qJzGwHnFLY4o7+pg
 547D4/9qqPB3Vbw3i5pfvhXv5DMjpgoTtrzCqE4vQ5DEPkm4gULCK4nQZ2u+PQF65MvQ
 tbgg==
X-Gm-Message-State: AC+VfDzGPfwnOw8WAxEXKXMJFllNxNuTtMcLXs6qUeRlsHvBX7bzCyBw
 kX75h1Jzvd2koX8JdX2s4iujSIx01KJhlEc9h0zDKAgvvSEoj9GPSDtfFRaYUNy/lBmnkVWmu75
 SlDM7Qo4ln+whWYQn9fmm9/+qp4s+aS6aO5XpxSnEHfYk8mKpvAzDCDzkJPGTlz17akjtgG0oj9
 s=
X-Received: by 2002:aa7:c0d7:0:b0:50b:c971:c14b with SMTP id
 j23-20020aa7c0d7000000b0050bc971c14bmr4628175edp.11.1684609596341; 
 Sat, 20 May 2023 12:06:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pdUyIzu/7L+wUEH5pwsQMtzjVlIkqb5zWvGNQQZeeJJzN8rnoEQ9sGW9jtVRtE4y0t+t6ew==
X-Received: by 2002:aa7:c0d7:0:b0:50b:c971:c14b with SMTP id
 j23-20020aa7c0d7000000b0050bc971c14bmr4628166edp.11.1684609595961; 
 Sat, 20 May 2023 12:06:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a50cd0c000000b00510da8aa2c6sm1084699edi.69.2023.05.20.12.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] remove remaining traces of meson submodule
Date: Sat, 20 May 2023 21:06:26 +0200
Message-Id: <20230520190632.7491-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
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



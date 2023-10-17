Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AC57CC796
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsm84-0003Y1-Nv; Tue, 17 Oct 2023 11:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsm83-0003Wv-2I
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsm81-0000m6-Hx
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697557024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8eFfFK/GDcxnFhJqoMefbw20lT73E6GDjUXNX+hP1+U=;
 b=ZPF3ggvmwErbGsK/nm8J0Wzwqtoj4UzO/lK/OXjR30RWZMpOmwHc4RKlj2RKGemNg4l72B
 0z5QLsFdzItIhbcQTBHbnrpxV1tpgwe+MgjcA+KVD3UJHP2ckjDMzT7xEERiEun8HUbAMr
 rtWQAHnyHlvn+EVoJaY/URM8gsWSRSw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-n9-J197VOQSqu90O70A8-A-1; Tue, 17 Oct 2023 11:36:53 -0400
X-MC-Unique: n9-J197VOQSqu90O70A8-A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53ec72af708so2008384a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 08:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697557011; x=1698161811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8eFfFK/GDcxnFhJqoMefbw20lT73E6GDjUXNX+hP1+U=;
 b=aZOa1o375mcWXBaBwd9nzfmTqAcIPy0xMveatw+gEOlYYHE9gZSFsV5KqZ4iFBwIyw
 9JKfcWm7HCJKZI7dA7RDipLRSHKK/k5Od0bgfiHU4mkELflimsXZkZxdMBxwJjRB9Upw
 FGYxEiSgkDS3sG6Iue+pYFxn1N+FRlr1aj6Ub5o+heURinLxIRg14aTCJRSRIF/2G8X3
 5JNPmVaTxINXTH9i/ESuJAHtan5e9dThGwx6iWE5EloRGDrQA2gy/8Ibe/5Jn8c8dAkS
 e1rBvy2SnK1LCQHoaM3sahjg4IoZmYB8C2Ccx28Gz1K+Mt+C0aFu9pq2gnliHQ1kdb5X
 +5KQ==
X-Gm-Message-State: AOJu0YwqqnPwuT76B1cSfIV3PsyIn0tQRfYnvd8jeAm4SgR4VGlgmSOv
 tPaNdU49vLs5pCKtP/VYLVtCmuStfVsEuX6rG5jdrXRxHgUtXJZHmlYvL5nOB3vKYoNTiLskBVG
 hiyC83LkVTXKSZM0W/q2GsBJUvW43KwmF+80xd60co1BuLFAVIyUpgc6piz57OBG4GAPzo606Up
 M=
X-Received: by 2002:a05:6402:40d0:b0:53e:2af1:e966 with SMTP id
 z16-20020a05640240d000b0053e2af1e966mr2504663edb.1.1697557011435; 
 Tue, 17 Oct 2023 08:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ30N3g5fYa9p+WPRhr2G/WJxTo9dh6AdxqDEqiS6/j+mN74SBrsCEol/GE7g1hq/VSwn13Q==
X-Received: by 2002:a05:6402:40d0:b0:53e:2af1:e966 with SMTP id
 z16-20020a05640240d000b0053e2af1e966mr2504648edb.1.1697557011104; 
 Tue, 17 Oct 2023 08:36:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a6-20020aa7cf06000000b0053e625da9absm1425570edy.41.2023.10.17.08.36.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 08:36:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: define "pkg-config" in addition to "pkgconfig"
Date: Tue, 17 Oct 2023 17:36:49 +0200
Message-ID: <20231017153649.309128-1-pbonzini@redhat.com>
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

Meson used to allow both "pkgconfig" and "pkg-config" entries in machine
files; the former was used for dependency lookup and the latter
was used as return value for "find_program('pkg-config')", which is a less
common use-case and one that QEMU does not need.

This inconsistency is going to be fixed by Meson 1.3, which will deprecate
"pkgconfig" in favor of "pkg-config" (the less common one, but it makes
sense because it matches the name of the binary). For backward
compatibility it is still allowed to define both, so do that in the
configure-generated machine file.

Related: https://github.com/mesonbuild/meson/pull/12385
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 8827a29bf4c..b4ea78c77d8 100755
--- a/configure
+++ b/configure
@@ -1736,6 +1736,7 @@ if test "$skip_meson" = no; then
   echo "ar = [$(meson_quote $ar)]" >> $cross
   echo "nm = [$(meson_quote $nm)]" >> $cross
   echo "pkgconfig = [$(meson_quote $pkg_config)]" >> $cross
+  echo "pkg-config = [$(meson_quote $pkg_config)]" >> $cross
   echo "ranlib = [$(meson_quote $ranlib)]" >> $cross
   if has $sdl2_config; then
     echo "sdl2-config = [$(meson_quote $sdl2_config)]" >> $cross
-- 
2.41.0



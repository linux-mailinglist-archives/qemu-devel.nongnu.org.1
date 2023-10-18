Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD17CD6B1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vA-0001vV-JF; Wed, 18 Oct 2023 04:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v1-0001ta-Uy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v0-0003h5-FV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jt5quYMWBBvksWop+adbyL29xvQPeeLJ8DpSrfg08L4=;
 b=A1npGn3neGKINlP5y/TA5gm8C5EwqX13B/EVATC6JopHXVYThr0gbANS53DYgo+t3Wodg3
 BLeDWY19Naw192aa8trIyN9SqbKIxKUtK/lXio46PfZPWVXXj9xo8y5crARkthawWi9Ar6
 gzy5yroviARaVMjkZiftgv4U7LC609o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-1PMZa2ZjOPi45aWuifbcEw-1; Wed, 18 Oct 2023 04:28:30 -0400
X-MC-Unique: 1PMZa2ZjOPi45aWuifbcEw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b95fa56bd5so482926866b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617709; x=1698222509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jt5quYMWBBvksWop+adbyL29xvQPeeLJ8DpSrfg08L4=;
 b=o7pBqE1uQ1O1FKizAVuBOIjhfhCNrqKA39b/y/D+PifEUoBDYqHbK8NA0bwOxsuxsN
 GfDw/UG4z8dBJU74Yjwu3NC4ykZ6wAk/+RXejM2I+AZ38E+rbk6MUjtTzC/ITpzUJI9+
 uhNIvMZtMlrDHw9vB0SQ4QhZQbPrWyePLw0hNEWvdBIXAdQyqsO22OWKkBub/dsQWTE0
 Djl9mh9760RIYYX1JxpRk//KKufJMlcaletz2F51bOIRwpRIVlRAVYXE8TwzX1ZhHw2f
 fNDnV7C32sUZs1toAUbs1LfEGlxj5B5qKbRghvY6bHLBKCUQfpTaMtswVzVwLGIoKTK1
 9RSQ==
X-Gm-Message-State: AOJu0Yw0+0fh0pQBYTMMwiYDZh3olbrTwdmkCSKcU3tJb+Wxzpwem+l4
 maW0Et4kLtYSQXjWWCdYsa8Cmj6CXne129AFza67TWfrgPyb9Ipe7XQu12EH0cgb1vVe7lk4hEH
 F+DzDvu+LG+7Ldp+LvqiHmPTlNeuAo5az6WQfC7KI/EKDhvzLse90m58if2fkk6P1rOOhEXUtKo
 E=
X-Received: by 2002:a17:906:4fc7:b0:9bf:77ae:3aa9 with SMTP id
 i7-20020a1709064fc700b009bf77ae3aa9mr3372995ejw.24.1697617708835; 
 Wed, 18 Oct 2023 01:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7AtoMUw3C7lAHwJoSZNdSOYsuP4/g0DITA63o/LU5whGUiVWBxpAVnqwj5xXpVOU/ddcM5w==
X-Received: by 2002:a17:906:4fc7:b0:9bf:77ae:3aa9 with SMTP id
 i7-20020a1709064fc700b009bf77ae3aa9mr3372981ejw.24.1697617708432; 
 Wed, 18 Oct 2023 01:28:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 j26-20020a170906255a00b009c503bf61c9sm1162352ejb.165.2023.10.18.01.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/32] configure: clean up handling of CFI option
Date: Wed, 18 Oct 2023 10:27:38 +0200
Message-ID: <20231018082752.322306-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Avoid that --enable-cfi --disable-cfi leaves b_lto set to true.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/configure b/configure
index d6103a0141f..9f782054509 100755
--- a/configure
+++ b/configure
@@ -625,7 +625,10 @@ meson_option_build_array() {
 
 meson_options=
 meson_option_add() {
-  meson_options="$meson_options $(quote_sh "$1")"
+  local arg
+  for arg; do
+    meson_options="$meson_options $(quote_sh "$arg")"
+  done
 }
 meson_option_parse() {
   meson_options="$meson_options $(_meson_option_parse "$@")"
@@ -767,11 +770,9 @@ for opt do
   ;;
   --disable-werror) werror="no"
   ;;
-  --enable-cfi)
-      cfi="true";
-      meson_option_add -Db_lto=true
+  --enable-cfi) cfi=true
   ;;
-  --disable-cfi) cfi="false"
+  --disable-cfi) cfi=false
   ;;
   --disable-download) download="disabled"; git_submodules_action=validate;
   ;;
@@ -1845,7 +1846,7 @@ if test "$skip_meson" = no; then
   test "$werror" = yes && meson_option_add -Dwerror=true
 
   # QEMU options
-  test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
+  test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
-- 
2.41.0



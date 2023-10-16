Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 167017C9FA5
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8n-0003u5-7Q; Mon, 16 Oct 2023 02:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8l-0003tv-Uw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8k-0005S4-JB
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfoJIpN+uZGYPzQNSBF+48daw1pWErF1si+YxUUxbaQ=;
 b=ao1bUhAdHnxQRQ6CuH36i/fZUsDg9m67lUbtyFyRxRU6/7ugKHv8Gw8E1eAMIPZFuZwwRn
 4FSZEAXpyCQTzP4/BkWMcEWjV2atFpcOUMPU1oMev5/4GvLoezaKZlhDNAvUpMCSCXjkQ6
 BxaoWtwDPsoZNkbJkjBi4Am6w13TcLU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-o3YxCkVJPF25-6zrOj6ggg-1; Mon, 16 Oct 2023 02:31:39 -0400
X-MC-Unique: o3YxCkVJPF25-6zrOj6ggg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9c4485166beso31514966b.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437897; x=1698042697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfoJIpN+uZGYPzQNSBF+48daw1pWErF1si+YxUUxbaQ=;
 b=CH+YYOp3VLcbjpd5QW4I1XY0pdlwpf21iurT+IWEpwpSs9I3MA7TT1eVO2iKRZ9kTq
 BCShNPW001wMeDYrO5RYgvSWzFvWteh56Y1H1ilqcYEnFkP8AWCTHSxm1MEoASvVKKcE
 WjggU0n13jbYUKfHFIf5gYLXBpBQhy0vk/MpOxSpNlmGBQYXVHMnnji1ybmI79VsPRRO
 czglpR6aakBRY6PKHcZ/hu8Zqy+7KdZc460LHGSnwx25UidzBKdbLismfAr770V6na74
 HOAVeFxL3PAVFaDSX5HN7KrwDLuQDYOVFMnocIXb2zIDwpg49wwBQDPY1t5EIIl+JvB4
 ktPA==
X-Gm-Message-State: AOJu0Yzi6J55WrTzQqbAisCCOBzOncfA7jX2OfLNntERRgFGVQq/RgmJ
 EFenTStFwNOsZEYJfLeU8GxMbZVAlStIWZiaQwGjuLG2R7nOWtN81Fu6N1eIflZ2/1PZenxU26/
 qNpwLVGVS90Tt1In1oSA0Eh8tNBbF15l9h6lnE9XLh8OKBg4dk6Vbqrk+wpbJh7Lkvj62DYmoPQ
 U=
X-Received: by 2002:a17:906:7697:b0:9b2:b119:4918 with SMTP id
 o23-20020a170906769700b009b2b1194918mr30487811ejm.13.1697437897494; 
 Sun, 15 Oct 2023 23:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkWoMpS8vcC0SKsglKhuUpCPG+umoSznPCESBkpPHxXEa9Up5Qxuwad6KxILnf+WyMG9muEg==
X-Received: by 2002:a17:906:7697:b0:9b2:b119:4918 with SMTP id
 o23-20020a170906769700b009b2b1194918mr30487803ejm.13.1697437897179; 
 Sun, 15 Oct 2023 23:31:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 qw8-20020a170906fca800b0099bd7b26639sm3392978ejb.6.2023.10.15.23.31.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/17] configure: clean up handling of CFI option
Date: Mon, 16 Oct 2023 08:31:14 +0200
Message-ID: <20231016063127.161204-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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

Avoid that --enable-cfi --disable-cfi leaves b_lto set to true.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index bce8c57596f..3da46ed202d 100755
--- a/configure
+++ b/configure
@@ -766,11 +766,9 @@ for opt do
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
@@ -1845,6 +1843,7 @@ if test "$skip_meson" = no; then
 
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
+  test "$cfi" != false && meson_option_add "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
-- 
2.41.0



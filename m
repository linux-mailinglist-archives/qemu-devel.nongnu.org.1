Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6504F7CD6A8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1w3-0003VV-9i; Wed, 18 Oct 2023 04:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vF-0002GC-Fg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vD-0003if-Ok
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebBCBXqpGdgbZayh/BtrGgAprkQWgdMqUBQV4ATPtWI=;
 b=OPLAySYpnJ8sf5CK61dQt/uPVlbVrzZ/WpctUyjMcQKerkE5ABREX1H5eeKOaEDpU3x6Ub
 OrebetL5OdXGI72O4fW6xF0uThJR51sjbWkiTr0iHw1jcFrHC2DHXkWoAuCqp9GXpJKRYD
 h42EOeJOTrd66/jE2089vpzqlQ3RWYw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-ViUeEOKvMeqbrRHUhQINNw-1; Wed, 18 Oct 2023 04:28:53 -0400
X-MC-Unique: ViUeEOKvMeqbrRHUhQINNw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c4485166beso214109166b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617732; x=1698222532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebBCBXqpGdgbZayh/BtrGgAprkQWgdMqUBQV4ATPtWI=;
 b=Hvqds/OhmMe9QRCWK74QoJyIncifM+dx9RxnIT434ADJ2/KWhWvIM8WWWob+FN+NbR
 Mn6IxfKFh6f8eBA0kXuOkrjQ+K0q8i7ADSnuH4E0cQW65kCcnqy7uAG+EYHSP3VuykJz
 uRV9ngbJ7DUMEIGukMe2Q1G1tVIk/NStt+5rUNMc20OVVfjLcyS68wHMf2AeghqHi1my
 3igLilH6J+qJK4R5fHX4TuwNINPy0eePw8cWcyQ/iPZGRoRlZShjOvc8rlvUg0hgF4w0
 PJLEjqIcEcn5C63zvvw2W/4IovdXy3V6Y7GDz1OxO9DcUeck1pjxPyxF65DYxGzigbEc
 3pKQ==
X-Gm-Message-State: AOJu0YzqiL1zvjPS8hDLavewj6NfiB+nRPOuLwafqJ2CE7D5GGB9RlUm
 yuUms3dWNEdeXlg+FMDyIclmaXysf/clv4LvjbyPYZ+gUFUuoNJ4rpdrGgVfL+DU8TPQV2dyO9u
 EF0xMKNpJjYsuNRkIaylOCN+C7RcV4b+ZDStBL+3NQV2Z1zWtV3fsPb1i6bMsl6NkD+XGuBwzki
 4=
X-Received: by 2002:a17:907:7e98:b0:9be:30c2:b8ff with SMTP id
 qb24-20020a1709077e9800b009be30c2b8ffmr2932740ejc.61.1697617732124; 
 Wed, 18 Oct 2023 01:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFe9fkcdof0ylilG63bD19vvuwWKSVHhXBW/Lj23/WFgoqPwQs7v3SmI+DiiACE5X2NaOPzeA==
X-Received: by 2002:a17:907:7e98:b0:9be:30c2:b8ff with SMTP id
 qb24-20020a1709077e9800b009be30c2b8ffmr2932731ejc.61.1697617731815; 
 Wed, 18 Oct 2023 01:28:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a1709063ec100b009bf94de8971sm1186412ejj.70.2023.10.18.01.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 32/32] configure: define "pkg-config" in addition to "pkgconfig"
Date: Wed, 18 Oct 2023 10:27:52 +0200
Message-ID: <20231018082752.322306-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
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



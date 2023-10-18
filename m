Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6667CD673
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vJ-0002JO-BH; Wed, 18 Oct 2023 04:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v3-0001u6-EN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v2-0003hE-3T
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMUo0Uu+HhBZFMdwvQI2ABnUonV+UN1ImTyE2l0jrPg=;
 b=Rw/a4qOxUCaYFrUxeHrVpXhg2kaYaId+KKM9HCYXgK5LAAlitCO/kZNJKRGlMv9t0FTFK1
 qium3k+l3FkD/ykKCQh8riTWKQbXQNtJLDOQ5qmmLIjHqUmXVKejHpOkDrgnSl3TPKNybX
 hC4pEsRnjVkljAwm85hWV/Edvm3VwFk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-R3gahaebNVKjD9_sDAHHFQ-1; Wed, 18 Oct 2023 04:28:42 -0400
X-MC-Unique: R3gahaebNVKjD9_sDAHHFQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so486260766b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617720; x=1698222520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMUo0Uu+HhBZFMdwvQI2ABnUonV+UN1ImTyE2l0jrPg=;
 b=P+UBUwm4VWy9QRp+TYpj/YJE3WkxxxRwVASZVNQ7mYrswNm0zCWPeHHLWLfgMO9kH4
 4f6Tr6paA/DfuM48eizN29a2makrojNRToJTWQ8udL+Y6Ea2n0x5d033g1j2CtB5i5M5
 uFHLcJrBwz3Rzd5RpHt+KRV4dqgTbHAebavz1Rz7PC+YHoCzvvxIJJyYkTXCYScDVq9q
 /i2EWpbYlc1hCPYzJRZ2XdHJdZ5qLqcq8RGdCJ3naebzanpVc/OnHJh7BsnFkQUb09WL
 I0tUoK5JEQINND4O9cgoz1RVn2gaODMNy8HBkPSZdRS2qQZXX9X5lLagLp5D/SMcpWAU
 Tufw==
X-Gm-Message-State: AOJu0YzG0Sfsz4Uys0dbJpZriLvsglLL2uXcmEiEYasPGVg7WczVG5JV
 4ET9Ogb2+Lzgz52D9MzA3oAjB6XzMJFvWVXqOBTmxqLTAMble7Oy2eVR+g3NUw9GQIKqdTw4o4q
 6r/fhza3YRkEtzZrGTmYeR1bGan2+L3C673OR49bC5CwQMGtiB59z0xe7i6f5K80T9Og93MZY64
 o=
X-Received: by 2002:a17:906:4fce:b0:9be:e278:4d47 with SMTP id
 i14-20020a1709064fce00b009bee2784d47mr4325071ejw.27.1697617720333; 
 Wed, 18 Oct 2023 01:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9hY04LakArjSx0gsQSZdvGUOTLLA7Wn+i4FgRDdgiwROzh36v0VVBV3xmKrzE6UVKuOXpUQ==
X-Received: by 2002:a17:906:4fce:b0:9be:e278:4d47 with SMTP id
 i14-20020a1709064fce00b009bee2784d47mr4325053ejw.27.1697617720045; 
 Wed, 18 Oct 2023 01:28:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 rs13-20020a170907036d00b009c3f8f46c22sm1201757ejb.77.2023.10.18.01.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 25/32] configure: remove some dead cruft
Date: Wed, 18 Oct 2023 10:27:45 +0200
Message-ID: <20231018082752.322306-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

print_error is only invoked in one place, and $git is unused.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/configure b/configure
index 5c1d618f102..0994f54530c 100755
--- a/configure
+++ b/configure
@@ -94,7 +94,7 @@ quote_sh() {
     printf "%s" "$1" | sed "s,','\\\\'',g; s,.*,'&',"
 }
 
-print_error() {
+error_exit() {
     (echo
     echo "ERROR: $1"
     while test -n "$2"; do
@@ -102,10 +102,6 @@ print_error() {
         shift
     done
     echo) >&2
-}
-
-error_exit() {
-    print_error "$@"
     exit 1
 }
 
@@ -248,7 +244,6 @@ done
 
 default_cflags='-O2 -g'
 git_submodules_action="update"
-git="git"
 docs="auto"
 EXESUF=""
 prefix="/usr/local"
-- 
2.41.0



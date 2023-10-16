Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366BB7C9FA6
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8z-00040U-Dv; Mon, 16 Oct 2023 02:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8w-0003zN-7H
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8u-0005T9-Qu
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xiOvaSzl8o1kGTHwVfCqOfceYz2MAK3SLhuAOzF+c4=;
 b=AAIBqnEpUpvf0SI5vxvoZzrQcrMOor9VPjMenkiLqA2bMyqS+571t6QBduGLEYn9yEwsN6
 Lvjq4CNt9g1IlaGEmoSvgLfeksVa2+o50OA57PVkn+TMofnctIM+9dWS6ECCZsynaaRAFw
 yUifb98/dzaUrtKE0c4sHHhAc88wzVs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-oHvnGE0AMvucCql0-RjFKQ-1; Mon, 16 Oct 2023 02:31:53 -0400
X-MC-Unique: oHvnGE0AMvucCql0-RjFKQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso294018266b.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437911; x=1698042711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xiOvaSzl8o1kGTHwVfCqOfceYz2MAK3SLhuAOzF+c4=;
 b=MBHFmrNLdiGhgIUMF7aY+uUhKUC1fOvs4Qhnn2wZgIf1z9u7lOdQCAI6uj6E9PifM4
 125uBGYcm2a99E55bv+0oL4+8RYw6HhwSWDmPb8hpO8l3xhca/XTd8u8yEXeob5JLgK8
 rPyLYuXGGgyGwnHGOpuXKWMKPbmlbWjtzOcsEZZmIF+DKrWg4rTphFrHvwu6EaKlMfR2
 BHF7tyot1gt6uPNlmjoGz12EkxXGXBixoa030RZm4CvI1bhHx/l6zsaFFkiHu0lOVF6C
 5FhpKwAFZhFRf2Lpo4R1vs1IFqeIyDmh5a8qgro8R/DZu4E6xBEekeOXj3/PTVi7wedL
 ww+Q==
X-Gm-Message-State: AOJu0Ywm9tPmc6Ki4JCH9c3okwlWKj5jfjb43PdlFDCkzWDVg2tRDxjF
 oPF+fEYi5CNGLvXEpRVO2QdslkwgVVgZhupOyIOsXKadolLloZb2RauQGaplRMLSC9SFdycEicL
 whQRLLibkxQULvO2nbWQjQu0hwJToFtt5/eHGiautsp9TBs1ziQEa5gYI2g7z7Hg5PfDQ+7APYr
 E=
X-Received: by 2002:a17:906:ef04:b0:9be:b12:1423 with SMTP id
 f4-20020a170906ef0400b009be0b121423mr6485171ejs.44.1697437911595; 
 Sun, 15 Oct 2023 23:31:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4WsH4oqpVyVEszql1pDDrDZU+oYyYtk3oea8CCNQckqb7DKPoa100cbkj2BIZCbLqVyZEbQ==
X-Received: by 2002:a17:906:ef04:b0:9be:b12:1423 with SMTP id
 f4-20020a170906ef0400b009be0b121423mr6485159ejs.44.1697437911278; 
 Sun, 15 Oct 2023 23:31:51 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a170906078100b009928b4e3b9fsm3386493ejc.114.2023.10.15.23.31.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/17] configure: remove some dead cruft
Date: Mon, 16 Oct 2023 08:31:21 +0200
Message-ID: <20231016063127.161204-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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

print_error is only invoked in one place, and $git is unused.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/configure b/configure
index a713493e9e2..211591911cc 100755
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



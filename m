Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35B4710FEF
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:48:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DBd-00049G-LC; Thu, 25 May 2023 11:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2DBY-00043U-Oa
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2DBX-00041w-5p
 for qemu-devel@nongnu.org; Thu, 25 May 2023 11:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685029646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9EoTH7im9ekI17xwbmDr9tPX5keY1sbjjPY8zVTrpog=;
 b=Ur9xSDHQgeZVJ3UQVnrZVyGTmVc72iq2V3IpRONpKTYZTORkX+HaNL8teUrdSOuA1yYWIS
 TMjvXcaGRmvQERgBcDnFc6rW4EDmyaL/qlVzThfSFFKf20Un05HxO035auMIPXAkx9F0oV
 ktvQNhkepmsobxlHMRGnUTtf1zsvZfg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-6mXSjs_TOsuNRBFEq03UkA-1; Thu, 25 May 2023 11:47:22 -0400
X-MC-Unique: 6mXSjs_TOsuNRBFEq03UkA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-511b509b55bso3019271a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 08:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685029640; x=1687621640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9EoTH7im9ekI17xwbmDr9tPX5keY1sbjjPY8zVTrpog=;
 b=kcX4TzNd0Rzn5vY9LVOgfCimqWI+PKsc90AJJe5JyHHgywPKd7scA+0A/sUQ44qxAZ
 qZPU2Qpqslk1wY3UVkG6J+5+L0GRX/ZRwpE6usj0sVxx64ciC1EVesRwI//q+6H9IIh9
 1hWN1X5beXbu8d/MTMspAHdA8C6mzf9onc0hS1h8g4neAYosrZwWW2kgg7IThFVbZAAz
 KjTtFr0pPbescUHyVcjcDk1JQzLNOSwjNqKwayaZZICzdMLc7lULoi+9zSQUFhy4Qx/G
 72SQgMrqdmyIyDm9zgQvAC7844zQnh9Q3rAmWmWZnW2p/8DmOm+YrFx3sKLkLxWBRi/9
 4DiQ==
X-Gm-Message-State: AC+VfDygwkJ5tF3gpWxVWuTAnx0XQqFBzwfHCUwfVWAkoXhBKZ+B6Icn
 D79lyPJ7/3W8ETJ5o8jarAM/mH8vSKSGWK1bRs1+tH2qKlWNsH5u/eh69vgqN3Faz3X8vNriUWw
 AZ8MdJtqjSK8qQygWVg1xE0hhM92xNb+3DVxrd0ZtNV9fLB/J+ckmtnBQ56gCXcvHXK71J6G9dx
 k=
X-Received: by 2002:a17:907:86ab:b0:895:58be:957 with SMTP id
 qa43-20020a17090786ab00b0089558be0957mr1943751ejc.2.1685029640502; 
 Thu, 25 May 2023 08:47:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7zFqjS/z+hzytw8JYVTk/sKE1Yombs9Sg0+x6a3RCEqqvvnGkq5/r3kJM+CU847W4x6G9CWA==
X-Received: by 2002:a17:907:86ab:b0:895:58be:957 with SMTP id
 qa43-20020a17090786ab00b0089558be0957mr1943726ejc.2.1685029640020; 
 Thu, 25 May 2023 08:47:20 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 oy11-20020a170907104b00b0096f7e6d0063sm993456ejb.75.2023.05.25.08.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 08:47:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
	qemu-stable@nongnu.org
Subject: [PATCH] configure: unset harmful environment variables
Date: Thu, 25 May 2023 17:47:18 +0200
Message-Id: <20230525154718.355734-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Apart from CLICOLOR_FORCE and GREP_OPTIONS, there are other variables
that are listed in the Autoconf manual.  While Autoconf neutralizes them
very early, and assumes it does not (yet) run in a shell that has "unset",
QEMU assumes that the user invoked configure under a POSIX shell, and
therefore can simply use "unset" to clear them.

CDPATH is particularly nasty because it messes up "cd ... && pwd".

Reported-by: Juan Quintela <quintela@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index db1f02346e68..42861ebc6e22 100755
--- a/configure
+++ b/configure
@@ -4,9 +4,8 @@
 #
 
 # Unset some variables known to interfere with behavior of common tools,
-# just as autoconf does.
-CLICOLOR_FORCE= GREP_OPTIONS=
-unset CLICOLOR_FORCE GREP_OPTIONS
+# just as autoconf does.  Unlike autoconf, we assume that unset exists.
+unset CLICOLOR_FORCE GREP_OPTIONS BASH_ENV ENV MAIL MAILPATH CDPATH
 
 # Don't allow CCACHE, if present, to use cached results of compile tests!
 export CCACHE_RECACHE=yes
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A15A707062
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLHA-0005Wn-EU; Wed, 17 May 2023 13:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF1-00029M-OO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEz-0004ZY-UX
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPou24ScysZCFeYkKf5HYVYev95mGveP+l81GewaT7I=;
 b=WaYCrJf55ACVqsAdXN4OWapjUyfBGxDrRuMeVduFRAfzkZp2loRlQ2YjkJv5ttQQyLYNQr
 fPk+gEtEuR8M/5rYo0azDT49/MuaRNhjnC/ZcoRagOx+Br6XQ01fj4WE+umFEfieH3wpDE
 BGvzRsAlucYDK+jIZkjR1AHPjB8pqC4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-_g_03CvhOAW8Y5Csm6wBrQ-1; Wed, 17 May 2023 13:47:08 -0400
X-MC-Unique: _g_03CvhOAW8Y5Csm6wBrQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3062dedf7d9so753410f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345626; x=1686937626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xPou24ScysZCFeYkKf5HYVYev95mGveP+l81GewaT7I=;
 b=hxcVBCKr4vNg69onB9WEqXq3Vn/DYckEeb+KWEdGGoqPuebgqJSpDES4x8od8Mr3gK
 h9XqTwUzM4ByPQlc02wEpowiW8WucVU8fdAv8u76qKAPzSYLJX1wGMzfIMhhdrMhcc6J
 NQq+8QJdGyScf6bYEXrmV9b+CstSZDxPH0r7GVGGsJ8Cv9C+VYVuMi4/iO4KWnBrCovz
 L6vPM+/ju7dBdC5n4mAdcM2awQUbruJHWOh1QdkUrh/s58BxQwvh93ToPI7qf7WxVdtt
 OVyEK7jtnnxWxcsWOc+vbi8ES9G+kGwO5ZCVjuEbvCxVVGfPFoLw45luCNIlrT67NFcC
 ajJw==
X-Gm-Message-State: AC+VfDz7iGeXhpU5AobzO7XgPGreqXczFQ4WYK8sVMyyZ5ofpz4KCrqt
 1PiI/AbvTqxPIdWGqVKd7CYzI3WXWIAbWALlFG8pfIYA2f/zTbUpAc8Nk1VZ6X3BxvmbS0t3xic
 3yX8ARkh4D7MoD266uPu7Zy/bwCJxSJWxfk/9uU1vpD2wZ+B85f/3amgRefjpaM5UYhb5g+J1Er
 s=
X-Received: by 2002:a5d:694a:0:b0:309:44ed:ccff with SMTP id
 r10-20020a5d694a000000b0030944edccffmr944218wrw.1.1684345626502; 
 Wed, 17 May 2023 10:47:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dSrk1obeUsN4oXWhzS/eET2HCf8sVX4eiabZWU1wzr6KkrDz0+XqN8VgX307ySNpQ99gKtQ==
X-Received: by 2002:a5d:694a:0:b0:309:44ed:ccff with SMTP id
 r10-20020a5d694a000000b0030944edccffmr944209wrw.1.1684345626150; 
 Wed, 17 May 2023 10:47:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d6a07000000b003062c0ef959sm3325432wru.69.2023.05.17.10.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:47:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 64/68] configure: do not rerun the tests with -Werror
Date: Wed, 17 May 2023 19:45:16 +0200
Message-Id: <20230517174520.887405-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

Tests run in configure are pretty trivial at this point, so
do not bother with the extra complication of running tests
both with and without -Werror.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/configure b/configure
index 4a986e6fa89c..d0febe7cdfea 100755
--- a/configure
+++ b/configure
@@ -124,41 +124,8 @@ lines: ${BASH_LINENO[*]}"
   $compiler "$@" >> config.log 2>&1 || return $?
 }
 
-do_compiler_werror() {
-    # Run the compiler, capturing its output to the log. First argument
-    # is compiler binary to execute.
-    compiler="$1"
-    shift
-    if test -n "$BASH_VERSION"; then eval '
-        echo >>config.log "
-funcs: ${FUNCNAME[*]}
-lines: ${BASH_LINENO[*]}"
-    '; fi
-    echo $compiler "$@" >> config.log
-    $compiler "$@" >> config.log 2>&1 || return $?
-    # Test passed. If this is an --enable-werror build, rerun
-    # the test with -Werror and bail out if it fails. This
-    # makes warning-generating-errors in configure test code
-    # obvious to developers.
-    if test "$werror" != "yes"; then
-        return 0
-    fi
-    # Don't bother rerunning the compile if we were already using -Werror
-    case "$*" in
-        *-Werror*)
-           return 0
-        ;;
-    esac
-    echo $compiler -Werror "$@" >> config.log
-    $compiler -Werror "$@" >> config.log 2>&1 && return $?
-    error_exit "configure test passed without -Werror but failed with -Werror." \
-        "This is probably a bug in the configure script. The failing command" \
-        "will be at the bottom of config.log." \
-        "You can run configure with --disable-werror to bypass this check."
-}
-
 do_cc() {
-    do_compiler_werror "$cc" $CPU_CFLAGS "$@"
+    do_compiler "$cc" $CPU_CFLAGS "$@"
 }
 
 compile_object() {
-- 
2.40.1



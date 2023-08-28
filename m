Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A746A78AC7C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:41:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZec-0003NT-9m; Mon, 28 Aug 2023 06:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeN-0003Mp-JG
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeL-00056L-Gq
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+jdDw/EKyqCYKsDK+HMFdWnVALvk9XS+pcfWaUOEKk=;
 b=G7aWNWkR4H5ceAbg/0XORziIQpVT5lHUBhI9wfAnfUiHMEPdBC01zu8aqXbQRPL+Btso5A
 vrsNVkoVGjgGciFQTuBjuwgf+/kd90WqlTvu6kwyO61psdRqshhp/JiBZPPRtTEGrVUvgk
 m2Yn54yJ7NolFSUZvk6w/1hWMmksab8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-jFvxfeX8OhmWjXtmorRd0A-1; Mon, 28 Aug 2023 06:39:11 -0400
X-MC-Unique: jFvxfeX8OhmWjXtmorRd0A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3ff00714328so22810425e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219150; x=1693823950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+jdDw/EKyqCYKsDK+HMFdWnVALvk9XS+pcfWaUOEKk=;
 b=jj3RgZTrCZig5hM53PG6oip7cjf6WyKca3DCkgtquBlDITGuOIIYFXFvMgtSNDL+QL
 9gaH+2yJYswkLfgToDjnpnPCMRg04Ud8R5YKfo847FIUU2NyXmIZ10aunxN1AzfX+3MZ
 AYC+YysCwe0oPNcn1rdDpZfRP8FIlyNCLHPoSPwYRLMNEcvA4Bg/LJxiSSC1XgMjlCaP
 bsjOZVLBnyqIsLv9ofd3NrSLOocuAUzWqS4iw112MOpyWWnrQOQU6+bmpUtnQZZvSYbj
 aQeqeJB+w7hMxKh4zFbjbfvsiRYDlodMqfv+tOGq/1tZU6jr2stJvt6NZR/E6OOPRYMr
 2AWA==
X-Gm-Message-State: AOJu0YzZebS52h+KZpzCoGVkboMRe8T82d43wIiWBhGfvPiANs8qn5N7
 c2mG4gaUFaQ2ksGDWHxMIZQWPsR7DCbTtrEcW1MJR8Il9M/TQj6TZe4y/oT3zLDKLeRNBknsGQz
 anaquq4rw4Pd78qcCfC1WNy/gkJzK0h5hyx2DhgN0Yc++NjKsODPRh83bZLPaOc4h8mU6FZQFs8
 E=
X-Received: by 2002:a05:600c:3799:b0:3fe:5053:1a0b with SMTP id
 o25-20020a05600c379900b003fe50531a0bmr20980879wmr.11.1693219149965; 
 Mon, 28 Aug 2023 03:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSQQ8G+VxpfQuijCxJWMKIvkB3AHBWxglQ4tNenBd507xAxQlWYR9xAjlTPNLpVYcjY79uGA==
X-Received: by 2002:a05:600c:3799:b0:3fe:5053:1a0b with SMTP id
 o25-20020a05600c379900b003fe50531a0bmr20980864wmr.11.1693219149644; 
 Mon, 28 Aug 2023 03:39:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 k4-20020a05600c0b4400b003fe0a0e03fcsm13450298wmr.12.2023.08.28.03.39.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] configure: never use PyPI for Meson
Date: Mon, 28 Aug 2023 12:38:46 +0200
Message-ID: <20230828103856.46031-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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

Since there is a vendored copy, there is no point in choosing online
operation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configure b/configure
index f2bd8858d6c..f13f0662b98 100755
--- a/configure
+++ b/configure
@@ -1018,13 +1018,7 @@ fi
 python="$python -B"
 mkvenv="$python ${source_path}/python/scripts/mkvenv.py"
 
-mkvenv_flags=""
-if test "$download" = "enabled" ; then
-    mkvenv_flags="--online"
-fi
-
 if ! $mkvenv ensure \
-     $mkvenv_flags \
      --dir "${source_path}/python/wheels" \
      --diagnose "meson" \
      "meson>=0.63.0" ;
-- 
2.41.0



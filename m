Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 939757133B3
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2qEW-0007Zs-8v; Sat, 27 May 2023 05:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEU-0007Zj-RD
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qET-0007Xq-I4
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685179744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKzFivjbMYBh77Fl2PI+Y2JzmVZLzbCiNeid3eWmHow=;
 b=hCgecy5WpAGrn4AjWhDpPm1wihlD4aGTmRspUV/JAtV5VlSfjTIfDg95mAZ1k7CLvowuiu
 GZSfJzc0hBi5O1OOlTrxK3ddiY7pPzvJUbYz09VHXO4RvlZULHhEMnYnoooMbXPbcBTlHC
 H+tNwy5wTTmkutyil5BIunJInxLqRx4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-f-pP2XBWMVifbPf1a56oGg-1; Sat, 27 May 2023 05:29:03 -0400
X-MC-Unique: f-pP2XBWMVifbPf1a56oGg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso138916466b.3
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 02:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685179742; x=1687771742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WKzFivjbMYBh77Fl2PI+Y2JzmVZLzbCiNeid3eWmHow=;
 b=dVYVRfSKljPEb2oBpcFDHggCeUvoyjAbw1HXz+JEvBxhZ8QU9Y32xMGYXjSdnOJmNU
 Ea1rkIW7pd2oxq00BiGkthSjBA0XutSaBNiYSO8WdZ1P0Y9kyJQL224ryr7CBIcqYj6i
 dWaaFS5bf5bdjzvDyf6zbmgNAnwWtY+aaat/Ez71tV2WsofiMNJIqaaW19lYp/lXa+BN
 owEPcpCjoTx6g6MV3moaSyhvhUIIUqYiq2fx4yJ2MKdYzR3NrDunQEow34kiM2AmwOsW
 /mZO4XmGNi4TvGh0cYtDxjPScwJd901nGm7EJ0URYEr9Zbdt711U9j4q5l9pmqb6pEcl
 QHlg==
X-Gm-Message-State: AC+VfDyBSMzDHLUa6fc8ePy0ysJT7Is3lYdGwVnjM6cgNdK26jo3sjkm
 jKt6DWm3fSGeayGR5JQoITKE2RPVM5FQv0/9sj/+N6+Lg6TBBMsAcElny8fWqATp116PMsh/jIw
 o7ZEvOlNJSUff6Jc671+cS9Hi2+k2X4nkSJjVoFZQ1GeC+MKVK/WbhcCwTHcQDSsZrtwnCIG13I
 8=
X-Received: by 2002:a17:907:7209:b0:933:868:413a with SMTP id
 dr9-20020a170907720900b009330868413amr4837972ejc.15.1685179741999; 
 Sat, 27 May 2023 02:29:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mr/UAIseP+lhWUM4sk7s7k4kCcHFwb86JhR7sXoT5OiWHjk96kBbzc6gdGUsJxDaI0au5kA==
X-Received: by 2002:a17:907:7209:b0:933:868:413a with SMTP id
 dr9-20020a170907720900b009330868413amr4837958ejc.15.1685179741761; 
 Sat, 27 May 2023 02:29:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m22-20020a1709066d1600b0096f777fc1ccsm3132738ejr.200.2023.05.27.02.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 02:29:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 4/5] configure: check for SLOF submodule before building
 pc-bios/s390-ccw
Date: Sat, 27 May 2023 11:28:50 +0200
Message-Id: <20230527092851.705884-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SLOF is required for building the s390-ccw firmware on s390x,
since it is using the libnet code from SLOF for network booting.

If SLOF is absent and submodules are not updated, pc-bios/s390-ccw
cannot be built.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 1d1b8736c0eb..c92a3b30b9a4 100755
--- a/configure
+++ b/configure
@@ -1662,7 +1662,8 @@ fi
 
 # Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
 # (which is the lowest architecture level that Clang supports)
-if have_target s390x-softmmu && probe_target_compiler s390x-softmmu; then
+if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
+    ( test "$git_submodules_action" != ignore || test -f roms/SLOF/VERSION ); then
   write_c_skeleton
   do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
   has_z900=$?
-- 
2.40.1



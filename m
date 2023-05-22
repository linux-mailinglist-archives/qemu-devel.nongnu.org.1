Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC33F70B65F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0zpA-0007KM-Vj; Mon, 22 May 2023 03:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0zp8-0007KB-7i
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0zp5-0006H8-VS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684739951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CbaiOJ+X9dPem4hTQLiSjkY45220lj4bM9vCCks40hU=;
 b=XqQHJAAgBbdKPKgHMFbSNygxaHYyXp2G++XeXWN87L60yuPyGMYfaw3gDcr9ZABD/jy88g
 68IHc+Q5Yfn+QS52UjgO+vaKHRbQNXZZnHGDlVINCt5ZrWG5fPztMHKPgLfGOeyE/rv3bk
 qbxxvFWgXJlt2g0Ti3jfy/lgpvRyeSY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-eAY_Db1RMmSpaqRKo6-mVg-1; Mon, 22 May 2023 03:19:10 -0400
X-MC-Unique: eAY_Db1RMmSpaqRKo6-mVg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso555568766b.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 00:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684739948; x=1687331948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CbaiOJ+X9dPem4hTQLiSjkY45220lj4bM9vCCks40hU=;
 b=XX0UBdWia8c07fVLSwqC1KhHcKoJhE50wY06diOO7TbmOTooYHiUvCcTIeF2oN6DIs
 b1lldK96Sp1Xcn8hOcRdeUVnfsnkAPqaV1SXUBCm/QcT9bqBnal04DbJHYNoaXyHsotj
 qSOgnxeNAyEdVKkPWmLAG59s8YIp52Dq3kqJx9pk48hpywr2TOZOviGhOGpAsCI1Asvp
 pqrANDg98ghTr1cc1/EeKjCKqdvJzwXUVIJkzqDD0C0GdD6obGGHIuwJN9TqCUP6LBZ8
 /1PvH6WJp1RDZiwRK5bfkf2Jzu2O1FnOjuqMIQptkunRUrbkF6etEk1pmYJ0ZYdCxTav
 HcGw==
X-Gm-Message-State: AC+VfDyAVLd/4/4rEVj7mTkHRYwgnt0YWWDQPw8SRifPUgf12pwX4PkH
 JBmibsFx360f9YscqT8nz0Ec0UAHl5zmLDnO3VOEW1ym5JDhf9tyfAx0HahzzIkjiWM2yCwoXcr
 M4ISot85ZlWd+ZdxnL9UhdPV3GOa3hC19RDwxNblmfm007DAtjY91krYpygLEOGFi7NvPeGYULW
 M=
X-Received: by 2002:a17:906:7945:b0:958:4c75:705e with SMTP id
 l5-20020a170906794500b009584c75705emr8141979ejo.17.1684739948561; 
 Mon, 22 May 2023 00:19:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7JjShsIOFnB6t7PLvrCTrmM6b6k0ZiTVckJa+8mFsghHMW5njVQD5+nZZwfS47XL3ihmOmYA==
X-Received: by 2002:a17:906:7945:b0:958:4c75:705e with SMTP id
 l5-20020a170906794500b009584c75705emr8141964ejo.17.1684739948124; 
 Mon, 22 May 2023 00:19:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a17090664da00b0096f7105b3a6sm2775229ejn.189.2023.05.22.00.19.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 00:19:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: fix rule for qemu-ga installer
Date: Mon, 22 May 2023 09:19:06 +0200
Message-Id: <20230522071906.59766-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

The bindir variable is not available in the "glib" variable, which is an internal
dependency (created with "declare_dependency").  Use glib_pc instead, which contains
the variable as it is instantiated from glib-2.0.pc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index 622b5f94a232..d3291b4376cb 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -154,7 +154,7 @@ if targetos == 'windows'
                               qemu_ga_msi_arch[cpu],
                               qemu_ga_msi_vss,
                               '-D', 'BUILD_DIR=' + meson.project_build_root(),
-                              '-D', 'BIN_DIR=' + glib.get_variable('bindir'),
+                              '-D', 'BIN_DIR=' + glib_pc.get_variable('bindir'),
                               '-D', 'QEMU_GA_VERSION=' + config_host['QEMU_GA_VERSION'],
                               '-D', 'QEMU_GA_MANUFACTURER=' + config_host['QEMU_GA_MANUFACTURER'],
                               '-D', 'QEMU_GA_DISTRO=' + config_host['QEMU_GA_DISTRO'],
-- 
2.40.1



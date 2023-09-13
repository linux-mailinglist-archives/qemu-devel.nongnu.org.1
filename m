Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FFB79E79C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOg0-0000qM-Cg; Wed, 13 Sep 2023 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfa-0000as-Em
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOfS-0002WN-Bm
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694606905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Duv3WTUPmNOxBbgXwneonaFDBEq781hw8hfcDxXttQ=;
 b=aezOB2Ioq9/AnVf69KWx8g5ZVqFx1SpbTZ6BOza182Lh9IZlH+dHuyZc8X1nYXZNVrOYWO
 t1heSJ+NjuEf1lTeDRrT6nLuzIwgIyyx2hn3inuwu+7bKRH2L6Esc6+ZonyRzg7Oohnxmv
 DFnQnuGBoDx0AmWqvb8gobMVeuX0aE0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-OMY1gtI2NdGlc_a7mqhJ4w-1; Wed, 13 Sep 2023 08:08:23 -0400
X-MC-Unique: OMY1gtI2NdGlc_a7mqhJ4w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-402ccac9b1eso49946305e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694606902; x=1695211702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Duv3WTUPmNOxBbgXwneonaFDBEq781hw8hfcDxXttQ=;
 b=EgFTRJ5s52Ww98N4mb5h29QoxgkCwQk204aG2jgVacS3eVdqS/JpGtlAqRN/mFaR1q
 UMnbT1f5h3CJeKBKchXyvF3/lFSHGD6sU7nBaedNfAoNzl3rszvg9ZmXpVddWloGwfcE
 pNIOAgVUfLcf0Yz+JSkwYH/DpY+ZxQKMeuUy8icYfOPJZ6TLWkLEBv9oVQsTs9BJs5HC
 8Ntw7yHXsFa4hmHz0whkEGldhEJt0pGyAF20qqSw9W2kCsD/sM/k2+PQO1C26Dq5YLVC
 X7hYMtxddMfYkI5lMjercLqJNn+zDwFm1QoWRkOAIuTfnfu7AFdWl19HPbNA0p5t64mx
 G0Kg==
X-Gm-Message-State: AOJu0YxF6PDzLDvOL6lDCVrBOaS6psYXq9sWXD+TtnzecL6XgdaG+ici
 YiESOslfwnKWjdsbXljCjednbwZ3aV6XSNkqhGKfa7wmYYCi0+grU3UxelcARgx+kKYIxDuED/K
 5qUBKfCoB7ySX0bVgm5AqgmcbfaQnRfg3ZzRBIScYwJjIh51onBXl5s35RuKK6fvI6SFtzD+UFA
 Y=
X-Received: by 2002:a05:600c:2194:b0:401:b1c6:97dc with SMTP id
 e20-20020a05600c219400b00401b1c697dcmr1775882wme.23.1694606901842; 
 Wed, 13 Sep 2023 05:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHjU6d/jqGfFNLNuo3WjTFPakH1VBIDaDFnTUfyiLWL9DrQGUlVsWqtAFlIuFharRRcRFjzw==
X-Received: by 2002:a05:600c:2194:b0:401:b1c6:97dc with SMTP id
 e20-20020a05600c219400b00401b1c697dcmr1775860wme.23.1694606901309; 
 Wed, 13 Sep 2023 05:08:21 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a1c4b0f000000b00402ff8d6086sm1853586wma.18.2023.09.13.05.08.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 05:08:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Build fix patches for 2023-09-13
Date: Wed, 13 Sep 2023 14:08:16 +0200
Message-ID: <20230913120820.969262-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:

  Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d04740243604389b6f05baa28fe3a28f016ed37b:

  target/i386: Call accel-agnostic x86_cpu_get_supported_cpuid() (2023-09-13 12:16:41 +0200)

----------------------------------------------------------------
* target/i386: fix non-optimized compilation on clang
* fix detection of Solaris/IllumOS

----------------------------------------------------------------
Jonathan Perkin (1):
      meson: Fix targetos match for illumos and Solaris.

Philippe Mathieu-Daudé (3):
      target/i386: Check kvm_hyperv_expand_features() return value
      target/i386: Drop accel_uses_host_cpuid before x86_cpu_get_supported_cpuid
      target/i386: Call accel-agnostic x86_cpu_get_supported_cpuid()

 meson.build       |  4 ++--
 net/meson.build   |  2 +-
 target/i386/cpu.c | 46 ++++++++++++++++++++++------------------------
 3 files changed, 25 insertions(+), 27 deletions(-)
-- 
2.41.0



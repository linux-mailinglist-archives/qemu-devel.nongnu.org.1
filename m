Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A374E709256
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvuy-0002DF-RW; Fri, 19 May 2023 04:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvux-0002Cv-6V
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzvuv-0000Ah-Cf
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QJ5uXtbHBSXEriPm76vUF3RNo0wtbvx0i6MBijRshIc=;
 b=Oy08i1QnUzSdHaJ86HkbvQkjL47jdSnQMfMwvjFFWdQa+jyOpr0F03+k43amfDnHi0npZq
 goOZolRoJYANgBiGz5y5ey7r+N5SnkJSfZvGoCVjByIH8uORoR7Ue8GevsaCT0ARsvoGaH
 ntBg7Whr8gkConQT0Tm7qe1UeI/N9Ls=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-jpXAkM-PPGWN3xbU72DuTQ-1; Fri, 19 May 2023 04:56:50 -0400
X-MC-Unique: jpXAkM-PPGWN3xbU72DuTQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-510dc46e130so2915603a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486609; x=1687078609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJ5uXtbHBSXEriPm76vUF3RNo0wtbvx0i6MBijRshIc=;
 b=asiZrQqrl59M2hjXWjRtUUzDIR9/k19UHCHEG75W+4vxkwkYX6XlqHRNpnFHbFSW2K
 Nvf16I3CEf68+3DfMgX0oVoQnQMckO0FLibmlsbhG+wNvPbRvDQv9z+nF84ly9nTL68/
 bzDHfrnZbiJOU14hbFTKBVRtRsiP7LvBkbEBbMAUqpJxYRJfEZxTdavRIh44vD4QCJ2C
 vIbH4G/ETqhrmaqPrty5qgVohr6Hxjwk/NkDpEPZNTXTImWM9ZOYp2axMytO8V9K0d8b
 AyqdVc/j89dF4KLuBG7w2ss+tKj1E7NwJCI8k4cQKuv+glskRqx2fSnLfopgx6CRq9ha
 uVOQ==
X-Gm-Message-State: AC+VfDxYgUF5DLVlw9ST8eXgxJReUyaH7o54xi7HCi/z3uSZIqgdtHmE
 cLF68P7XPDxw+PlOCQdga5Q9rG9UAAhn9vzqmgEum7O91WOT3nqVGi+A6POw+VywgkcaczmopgB
 HPMRtdYAuWNG+FvJbVFKpZ8lJys7v9tqOkK2r3vSABFS828e6JGNJFF6c/ZVOA/dqJvniMwYhlw
 M=
X-Received: by 2002:aa7:d38c:0:b0:510:d6b3:a1ac with SMTP id
 x12-20020aa7d38c000000b00510d6b3a1acmr1198246edq.13.1684486609220; 
 Fri, 19 May 2023 01:56:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lRmlO6u9aMzMepDA7p9I9Ze6lXaY7anJrWkky0zVHzvkycIfZ9LaaKK5D0RiY04c+zs0N0Q==
X-Received: by 2002:aa7:d38c:0:b0:510:d6b3:a1ac with SMTP id
 x12-20020aa7d38c000000b00510d6b3a1acmr1198229edq.13.1684486608738; 
 Fri, 19 May 2023 01:56:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 u24-20020aa7d0d8000000b00510da8aa2c6sm1433659edo.69.2023.05.19.01.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:56:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v2 0/6] meson: use subprojects for bundled projects
Date: Fri, 19 May 2023 10:56:40 +0200
Message-Id: <20230519085647.1104775-1-pbonzini@redhat.com>
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

QEMU bundles a copy of dtc and keycodemapdb.  They both support meson,
so we can run their build system via subproject() instead of hardcoding
their contents.

In fact, now that QEMU's configure script knows how to install missing
Python dependencies, we can replace submodules altogether with .wrap
files, which have several advantages, either immediate or potential:

* option parsing and downloading is delegated to meson

* the commit is stored in a text file instead of a magic entry in the
  git tree object, and can be a branch name or a version number as well

* we could stop shipping external dependencies that are only used as a
  fallback, but not break compilation on platforms that lack them.
  For example it may make sense to download dtc at build time,
  controlled by --enable-download, even when building from a tarball.
  This is _not_ done in this patch series, but Marc-André has tried
  it before[1].

* we could also add .wrap files for other dependencies that are missing
  on the GCC compile farm machines.  People who build on Windows might also
  enjoy getting the mandatory dependencies (pixman, zlib, glib, possibly
  SDL?) via wraps.

It is possible to use subprojects also for berkeley-softfloat-3
and berkeley-testfloat-3.  This would require moving the corresponding
parts of tests/fp/meson.build to an overlay file.

Paolo

[1] https://patchew.org/QEMU/20230302131848.1527460-1-marcandre.lureau@redhat.com/20230302131848.1527460-5-marcandre.lureau@redhat.com/


Paolo Bonzini (6):
  remove remaining traces of meson submodule
  meson: simplify logic for -Dfdt
  meson: use subproject for internal libfdt
  meson: use subproject for keycodemapdb
  configure: rename --enable-pypi to --enable-download, control
    subprojects too
  meson: subprojects: replace submodules with wrap files

 .gitignore                          |  2 -
 .gitlab-ci.d/buildtest-template.yml |  5 +-
 .gitmodules                         |  9 ----
 configure                           | 71 ++++++-----------------------
 dtc                                 |  1 -
 meson.build                         | 56 ++++++-----------------
 meson_options.txt                   |  1 +
 scripts/archive-source.sh           | 11 ++++-
 scripts/make-release                |  5 ++
 subprojects/.gitignore              |  6 +++
 subprojects/dtc.wrap                |  4 ++
 subprojects/keycodemapdb.wrap       |  4 ++
 subprojects/libvfio-user            |  1 -
 subprojects/libvfio-user.wrap       |  4 ++
 ui/keycodemapdb                     |  1 -
 ui/meson.build                      |  8 ++--
 16 files changed, 68 insertions(+), 121 deletions(-)
 delete mode 160000 dtc
 create mode 100644 subprojects/.gitignore
 create mode 100644 subprojects/dtc.wrap
 create mode 100644 subprojects/keycodemapdb.wrap
 delete mode 160000 subprojects/libvfio-user
 create mode 100644 subprojects/libvfio-user.wrap
 delete mode 160000 ui/keycodemapdb

-- 
2.40.1



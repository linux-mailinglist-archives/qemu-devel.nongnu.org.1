Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4707F77BF
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:26:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2X-0004dP-6x; Fri, 24 Nov 2023 10:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2U-0004cc-Qp
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2S-000472-6x
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cxuLNpmAzbuFyRo7THQqRG+T1naoZQK9EhRZkqLbTjc=;
 b=G2Q6EdeClNCCmLIAxyC91u5ovW8nQS/W5uQ6C8g3iPSobABWhus0RGgXTOL0P7x6xtNNTP
 dRWh9o0/YfcUXsMZ1OjYZOgVem6tr0XK9T+l0P8VZWmkOy/5dyEhDgjvkgi7ZUdxI6Lp/m
 StBh2JoQvALnjBtztEm9soV8M6BdynA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-0rKXiz0mMpmNlLklSGojeA-1; Fri, 24 Nov 2023 10:24:12 -0500
X-MC-Unique: 0rKXiz0mMpmNlLklSGojeA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-677fb25cfe5so24989246d6.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839451; x=1701444251;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxuLNpmAzbuFyRo7THQqRG+T1naoZQK9EhRZkqLbTjc=;
 b=f06PR/fnQFi7nS5gcumQjZIz6kaTC32akWdYXDcN+b26BqpTPnuK0yKzInt9ARux39
 SU7vF5fVzEpIO///a1QqqPqbYWwEPYiHVfiEEMRMwikQjDRCeomW+dzfjPqOKr+GBp6h
 UZqcDlnpnnxR6er2AFouUBCHcX/spLZ/By/EvDGZxopSyHa48O0XEvV8SmT1Uroifw7v
 Cct9hswQzB2G8lU/A8xYpzDHxUtE7LL9EF21+exa4MAKX9QdSiwNNOS4agPABFb2guZF
 Erjo3W7QXgPoROIXzJYpxU5bOOElOgO3aJbqMqX+bgluUE7un64+9DBobasByFsRGlZe
 LqKA==
X-Gm-Message-State: AOJu0YwwDI95ixKjyYhHAUmQhed0MCVCPqEzDEkcsUsv1DDFy3pdb/0C
 4Lx9Cl/TH6hXK7Q1hFx1WGa3RUxtd1/ZbDzakGGVcG+nL7JIQvdbtFQzmxlY0Op3vWKLeedpohe
 Z9WNhWfsQLU5WdupNHL2H/Udx85OkbmpqlNBdUdHZT9lGa04QaS8JFPYC+vPhz+0z5zabHh1vuq
 U=
X-Received: by 2002:a05:6214:2ae:b0:67a:2217:119e with SMTP id
 m14-20020a05621402ae00b0067a2217119emr438519qvv.12.1700839451708; 
 Fri, 24 Nov 2023 07:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNoFba8szYLNjmTnB7Rl3d/Vn1MVU1R0hDR4JNMZH0vQXG1NLce6f5BZRLcOzDUbYxTVq9Ww==
X-Received: by 2002:a05:6214:2ae:b0:67a:2217:119e with SMTP id
 m14-20020a05621402ae00b0067a2217119emr438477qvv.12.1700839451311; 
 Fri, 24 Nov 2023 07:24:11 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 jy3-20020a0562142b4300b0067a0f6878ecsm958580qvb.43.2023.11.24.07.24.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Misc bug fixes for QEMU 8.2.0-rc2
Date: Fri, 24 Nov 2023 16:23:58 +0100
Message-ID: <20231124152408.140936-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This pull request is based on https://patchew.org/QEMU/20231123155620.3042891-1-alex.bennee@linaro.org/.

The following changes since commit 6ef164188d005d7636f7ed8a1033cc4083498301:

  tests/tcg: finesse the registers check for "hidden" regs (2023-11-23 14:10:06 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 81a541e9f0838753d06d61b026688bea1eba7c0b:

  scripts: adjust url to Coverity tools (2023-11-24 12:08:13 +0100)

----------------------------------------------------------------
* document what configure does with virtual environments
* bump known good meson version to v1.2.3
* upgrade macOS to 13 (Ventura) and Add manual testing of macOS 14 (Sonoma)
* use simple assertions instead of Coverity models
* miscellaneous fixes
* adjust URL to Coverity tools

----------------------------------------------------------------
Akihiko Odaki (2):
      audio: Free consumed default audio devices
      configure: Make only once with pseudo-"in source tree" builds

Paolo Bonzini (3):
      tests: respect --enable/--disable-download for Avocado
      docs: document what configure does with virtual environments
      scripts: adjust url to Coverity tools

Philippe Mathieu-Daudé (4):
      buildsys: Bump known good meson version to v1.2.3
      .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)
      disas/cris: Pass buffer size to format_dec() to avoid overflow warning
      system: Use &error_abort in memory_region_init_ram_[device_]ptr()

Vladimir Sementsov-Ogievskiy (1):
      coverity: physmem: use simple assertions instead of modelling

 .gitlab-ci.d/cirrus.yml                     |  16 +++++
 .gitlab-ci.d/cirrus/macos-14.vars           |  16 +++++
 audio/audio.c                               |   5 +-
 configure                                   |  21 +++----
 disas/cris.c                                |  26 ++++----
 docs/devel/build-system.rst                 |  88 +++++++++++++++++++++++++++-
 python/scripts/vendor.py                    |   4 +-
 python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
 python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
 pythondeps.toml                             |   5 +-
 scripts/coverity-scan/model.c               |  88 ----------------------------
 scripts/coverity-scan/run-coverity-scan     |   4 +-
 system/memory.c                             |   4 +-
 system/physmem.c                            |  22 +++++++
 tests/Makefile.include                      |   2 +-
 tests/lcitool/libvirt-ci                    |   2 +-
 tests/lcitool/refresh                       |   1 +
 17 files changed, 180 insertions(+), 124 deletions(-)
-- 
2.43.0



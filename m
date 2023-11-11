Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4947E8B61
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pvU-0003kp-4s; Sat, 11 Nov 2023 10:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvQ-0003kA-Pr
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvP-0008HW-0r
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eyVBHZoVfm8EMfxRwLoZxDpZNzBaCBfHNHhpGyzgJtA=;
 b=AaFIc63ifpFFEpZxmJo6oO3kb7UyihluIpDCgkHUo1hWJbBp7yN/hey2EffV2OiCF9TjPN
 OquXMpKzmo9U7+iMNbBN5jY+Vntat2lK6wcpfWi2oRXO/gFBMg8eeYre6ykdp8unNV8mRy
 wdy0UfJu8FksqGUTOW+1lG2oMjG4dto=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-LASHo4p_PfycJMFcNMumrA-1; Sat, 11 Nov 2023 10:29:27 -0500
X-MC-Unique: LASHo4p_PfycJMFcNMumrA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079630993dso2985895e87.1
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716565; x=1700321365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eyVBHZoVfm8EMfxRwLoZxDpZNzBaCBfHNHhpGyzgJtA=;
 b=ZZ4KMi8zri5bwdmlA4XG+UQMeo+MVKULAeljsjDxSxwgF2Z9Hpjc09jKqakw3Ka/H/
 7cHZEDeyornQzcupkBf0Yhd52ytO8Bv/9tLHKktaD9I866ZrnL7gX9wPp+ZWgW0q0JRs
 8CLETuVeDINaTK1tkbZpH2GBu3HfmLwzsHKjkkN7LmFi1z0GBC4Agoi/68p+lTindPSA
 sKvkd+BxBz7Vp+RhtCT53OSaxa7PYj9IhOJmBySzXHUY+QBaAT3/envhkDBxYZaHxfPP
 7M0e/pKtr+KCb4XEYra9fh+Rg44Lis6ug5FIcgXfXpr4uK/LI6iBqPSceNgLvSzpAjEA
 2FKg==
X-Gm-Message-State: AOJu0YyBquteFlGJ7nUOv+3zjArkIXfDei7ZhjZhc8mhV8E6KwYBbXAl
 GMF06FgdRTrfxb3AVOZKBuDmRJ0d+vcWfs2HcXpLv7YYK1PYi6WTwy6jTwfGwdYokCUwJrdeYmy
 F0bStPJDWvuoVMwb4OdsEffaC8pH7U0lEJDXotpZn4vAxZnCtvU1C86+z7F9K3w6CiICQ0LNTlG
 s=
X-Received: by 2002:a05:6512:1087:b0:500:8f66:5941 with SMTP id
 j7-20020a056512108700b005008f665941mr2006844lfg.50.1699716565376; 
 Sat, 11 Nov 2023 07:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW6b4d0v0eYqf+nFIJtht1bqU7d8wyZ3zdRZnqpUgs0jCYTSR6zXKqQ6Rf0Es42nUtiDYUMQ==
X-Received: by 2002:a05:6512:1087:b0:500:8f66:5941 with SMTP id
 j7-20020a056512108700b005008f665941mr2006827lfg.50.1699716564766; 
 Sat, 11 Nov 2023 07:29:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a50d481000000b0053e5f67d637sm1134253edi.9.2023.11.11.07.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Biuld system and CI changes for 2023-11-10
Date: Sat, 11 Nov 2023 16:29:17 +0100
Message-ID: <20231111152923.966998-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit ad6ef0a42e314a8c6ac6c96d5f6e607a1e5644b5:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2023-11-09 08:26:01 +0800)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 1d802d050caeff83add1054bee1fc9f98e59a3f2:

  .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma) (2023-11-10 10:39:05 +0100)

----------------------------------------------------------------
* document what configure does with virtual environments
* Bump known good meson version to v1.2.3
* Upgrade macOS to 13 (Ventura) and Add manual testing of macOS 14 (Sonoma)
* use simple assertions instead of Coverity models

----------------------------------------------------------------
Paolo Bonzini (2):
      tests: respect --enable/--disable-download for Avocado
      docs: document what configure does with virtual environments

Philippe Mathieu-Daudé (3):
      buildsys: Bump known good meson version to v1.2.3
      .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
      .gitlab-ci.d/cirrus: Add manual testing of macOS 14 (Sonoma)

Vladimir Sementsov-Ogievskiy (1):
      coverity: physmem: use simple assertions instead of modelling

 .gitlab-ci.d/cirrus.yml                            |  22 +++++-
 .../cirrus/{macos-12.vars => macos-13.vars}        |   2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                  |  16 ++++
 configure                                          |   9 ++-
 docs/devel/build-system.rst                        |  88 ++++++++++++++++++++-
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-0.63.3-py3-none-any.whl        | Bin 926526 -> 0 bytes
 python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 0 -> 964928 bytes
 pythondeps.toml                                    |   5 +-
 scripts/coverity-scan/model.c                      |  88 ---------------------
 system/physmem.c                                   |  22 ++++++
 tests/Makefile.include                             |   2 +-
 tests/lcitool/libvirt-ci                           |   2 +-
 tests/lcitool/refresh                              |   3 +-
 14 files changed, 157 insertions(+), 106 deletions(-)
 rename .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} (95%)
 create mode 100644 .gitlab-ci.d/cirrus/macos-14.vars
 delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
-- 
2.41.0



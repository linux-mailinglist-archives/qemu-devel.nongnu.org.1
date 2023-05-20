Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C55CE70AA99
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Rud-0007E9-Ps; Sat, 20 May 2023 15:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rub-0007Dz-DT
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0RuZ-00005h-IM
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XnIYaMvydXyiD9hAKGO/S/el6VNMBjn3mT7cJPLsDbg=;
 b=eHCvQiJ1cbQKLWKzugGOlrFamIBNvAcKZ0Fi1x9NV1T5c6liuhW9amiamfsnYC52cUSoIj
 elIpJpiCWG0obakAzUdwnBrs3b+AG73Fw8iBZ6H6jn1+DTfuPMR+hfF0RRUlIjRXU5WU5x
 SBhgqBQuF/a+Ov61P3nApNNW1PXGq3k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-BUq0L9zoPhKtf3fIkUheIA-1; Sat, 20 May 2023 15:06:36 -0400
X-MC-Unique: BUq0L9zoPhKtf3fIkUheIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96faa650a3fso41449866b.0
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609595; x=1687201595;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XnIYaMvydXyiD9hAKGO/S/el6VNMBjn3mT7cJPLsDbg=;
 b=KOmCRA3AgWbLvCwQK3LYf9utvHUOGiBL4AieaQviHFplKa565xswnZlP1ceXZ0CEou
 mC8anOd/9huUDktGKt/Uysrxa9N1op8bTIzbZagZgxz9tA1fNlwakoOZwEQYUYOWzTG+
 r8IgweEEZDHYAsp7xzvJXl9UXRUo73sQ3gYdQanP86NOw5XrtmIw9ZXBnyhn3SuNvt5u
 KOapZTx/iVd+Wd5oJixfyoZYsowkeP8zYeXa+oQT1ZJvOt7b+kBmWPiJZH8p+pt0yQsA
 sGGojJ/dB9TynM7ln+/0QUXc6WqJpqUR8kb6pcmoVRbt/OPC+JcJ9sscyQotdDmQ4H5F
 V+ww==
X-Gm-Message-State: AC+VfDySZGZ7IbktYJuXoHsUiY6xznA+MVc5KdMW+y1DtH7p10Bolfqt
 dVAwujiWVRk78ZyrQMCXJjaANyL9G1XizzR3DrJuqzGHQewIe4OUOfJSM6fxT4Rbqcc5w1Pqed1
 YYS9+vaHd1FD+UXrJr1pSN6x+DY4MsA1rF757F9cs2CBNQMTIH0mESMIjJ52KohghBmxbGYMVQ3
 c=
X-Received: by 2002:a17:907:980b:b0:966:3de0:89ac with SMTP id
 ji11-20020a170907980b00b009663de089acmr7728868ejc.30.1684609595129; 
 Sat, 20 May 2023 12:06:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7R7gQryeqH/I+tcK9JigkH4wr+KIVB/AwfkarAz+mORfnjGZ0B6uhoXkXMKtN9oYmywfWQdA==
X-Received: by 2002:a17:907:980b:b0:966:3de0:89ac with SMTP id
 ji11-20020a170907980b00b009663de089acmr7728833ejc.30.1684609594588; 
 Sat, 20 May 2023 12:06:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a170906480b00b0096f82171bdesm1051464ejq.215.2023.05.20.12.06.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Python fixes and related patches
Date: Sat, 20 May 2023 21:06:25 +0200
Message-Id: <20230520190632.7491-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

The following changes since commit f0b95ab6b8192d84338496a0b6fd8f2c08a4a3a8:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-05-18 07:52:12 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream-urgent

for you to fetch changes up to 4b424c757188f7a47630a4d8edcf4ad9f19255bc:

  scripts: make sure scripts are invoked via $(PYTHON) (2023-05-19 20:40:29 +0200)

----------------------------------------------------------------
Fixes for Python venv changes

----------------------------------------------------------------
Paolo Bonzini (7):
      remove remaining traces of meson submodule
      mkvenv: replace distlib.database with importlib.metadata/pkg_resources
      build: rebuild build.ninja using "meson setup --reconfigure"
      configure: fix backwards-compatibility for meson sphinx_build option
      mkvenv: pass first missing package to diagnose()
      gitlab: custom-runners: preserve more artifacts for debugging
      scripts: make sure scripts are invoked via $(PYTHON)

 .gitlab-ci.d/buildtest-template.yml |   4 -
 .gitlab-ci.d/custom-runners.yml     |   4 +-
 Makefile                            |   6 +-
 configure                           |  10 ++-
 python/scripts/mkvenv.py            | 150 +++++++++++++++++++++---------------
 python/setup.cfg                    |   6 --
 scripts/archive-source.sh           |   2 +-
 scripts/meson-buildoptions.py       |   0
 scripts/modinfo-collect.py          |   0
 scripts/modinfo-generate.py         |   0
 scripts/probe-gdb-support.py        |   0
 11 files changed, 106 insertions(+), 76 deletions(-)
 mode change 100755 => 100644 scripts/meson-buildoptions.py
 mode change 100755 => 100644 scripts/modinfo-collect.py
 mode change 100755 => 100644 scripts/modinfo-generate.py
 mode change 100755 => 100644 scripts/probe-gdb-support.py
-- 
2.40.1



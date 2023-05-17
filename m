Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E53706FEA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFq-0003DT-HJ; Wed, 17 May 2023 13:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEG-0008Ob-OR
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEF-0004JL-6Y
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=duMUMALcqKz2nMROTx+bWkd+2EM8rTwuu0z6XDzhroY=;
 b=ZZH1lT6kcVTvOEg05V7hlLZSFDPPvP6I3tU+3L22hzhgfnANqYcUG+viu7g3n8Taz//1UW
 cCvsaKmz7nvCaSmU9BqrXeFn2wjHIXnFh1PMgnYsmBEkl1HwYatRmGK/VN4C6EMFV15Aot
 I0Lhucn+0n5bpM+8bB8dKyBfm2Yloio=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-zscNjIxoNqajHJafxVJy6g-1; Wed, 17 May 2023 13:46:21 -0400
X-MC-Unique: zscNjIxoNqajHJafxVJy6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f419a053c5so1705445e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345580; x=1686937580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=duMUMALcqKz2nMROTx+bWkd+2EM8rTwuu0z6XDzhroY=;
 b=My5G5Mr36xpTtABcs5eB9LS8Kt7sRFYmNj8POal/sLqljMI6eEAVECFqVOJcAaIOe+
 rGLxrbsD2P0azYy49cgyBeG8JaF80LjwVmJHRLz/zI/bvH0kuiq6TFjpiPq1igT7GZP0
 53mSQR7D6VqkYapSQMbuHpkK/QWS4jkoANWT8Ng+7ciOcFaX7MVcVX+t+xxM+dmOj2dd
 FghSGPimB6HhhXewv4Of9j71FtC8vKU8gku8hdW7SfGNsCHadDP+yri7ShmgUmn3Tic0
 XkbPQaGbeTySPZ4+ELENavrYi18VxbgnWIQsMGOuwkOn82RmB94MGh+JRKtlvF4tQAD7
 Qhxg==
X-Gm-Message-State: AC+VfDzDO5wtU8bSajKt1T/zJnIXaejEUKjSOdZHBEJsmtMzmRfyjBkS
 Q/N67y0JtCDy5VK+RuQXak+3NpPDbjVC7Zo+odiBdC61GBtuw3aq4yAz+5BRZ/wEzzn0e3B5lUa
 5LvEi8JaM3vuWjtNy98DNTR2j977IHB5yrfPcNtKWKc4drS0FDHLNVDVCtCf1exyeg9Vk/0dU1g
 8=
X-Received: by 2002:a7b:c7c9:0:b0:3f4:2aeb:30d with SMTP id
 z9-20020a7bc7c9000000b003f42aeb030dmr2432376wmk.4.1684345579697; 
 Wed, 17 May 2023 10:46:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pqlJsLz0cCmvHaoyzgtDSK9UuDwfcOVsibLj4ivq7VkDQepipyTeUqfro4/SY420eSUFD2g==
X-Received: by 2002:a7b:c7c9:0:b0:3f4:2aeb:30d with SMTP id
 z9-20020a7bc7c9000000b003f42aeb030dmr2432362wmk.4.1684345579344; 
 Wed, 17 May 2023 10:46:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c024d00b003f42813b315sm2835227wmj.32.2023.05.17.10.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 34/68] python/wheels: add vendored meson package
Date: Wed, 17 May 2023 19:44:46 +0200
Message-Id: <20230517174520.887405-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

In preference to vendoring meson source, vendor a built distributable
("bdist" in python parlance). This has some benefits:

(1) We can get rid of a git submodule,
(2) Installing built meson into a venv doesn't require any extra
    dependencies (the python "wheel" package, chiefly.)
(3) We don't treat meson any differently than we would any other python
    package (we install it, end of story, done.)
(4) All future tarball *and* developer checkouts will function offline;
    No git or PyPI connection needed to fetch meson.

Note that because mkvenv prefers vendored packages to PyPI, as mkvenv is
currently written we will never consult PyPI for meson. (Do keep in mind
that your distribution's meson will be preferred above the vendored
version, though.)

```
jsnow@scv ~/s/q/python (python-configure-venv)> python3 scripts/vendor.py
pip download --dest /home/jsnow/src/qemu/python/wheels --require-hashes -r /tmp/tmpvo5qav7i
Collecting meson==0.61.5
  Using cached meson-0.61.5-py3-none-any.whl (862 kB)
Saved ./wheels/meson-0.61.5-py3-none-any.whl
Successfully downloaded meson
```

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-17-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/wheels/meson-0.61.5-py3-none-any.whl | Bin 0 -> 862509 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 python/wheels/meson-0.61.5-py3-none-any.whl

-- 
2.40.1



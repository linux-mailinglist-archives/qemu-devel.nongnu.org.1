Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA02799165
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 23:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeihu-00089B-Dx; Fri, 08 Sep 2023 17:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.perkin@gmail.com>)
 id 1qefYK-0003Ai-VF
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:45:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonathan.perkin@gmail.com>)
 id 1qefYH-0004TB-WE
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:45:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso1522110f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694195151; x=1694799951; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=29LkzB5Kuay4nZqBnGUUhywj1VSt3J+AHJY9O7mmnSM=;
 b=J9yDrBdq+anXgh+UVcbUb4xHhap9ZJhY7pezb3Xr/OQ5pTMKcJ12PCCD/1g/S9W93d
 DWRRS8sMX7yYKkaCPm9iHiJD207ZLYDvyx4itmIp6oUUk2QsavCszehRNDEn+Fo4SmaC
 YWjBej7J3H/s91NhzVXVWCP4OpEX+seOUaSHah38Nndbb/Z3C/gU4+JoR89ntgvkac2e
 xDgLYonSHm0fN+WuK0TelJdXk4616eE8hU7FDbVkKwwte3NX+VaYRthFegvgC6d0gKL9
 w2b+ZP1U4go7hEjKh4CnN28JqBj8uTatVooVD3jNnIsFAetu7e5EpNNXLxaTVMSbCiEo
 sJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694195151; x=1694799951;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29LkzB5Kuay4nZqBnGUUhywj1VSt3J+AHJY9O7mmnSM=;
 b=ORsVjWMJXIAFxpqKKBWJ/w/T4BUjHroSViexWzALz4KUzXU2Y+QSnFf3vYlBu5qOf1
 uyNESbnXumcxFAwR/8XqV2L/yvgY5oWhYtaxNE/TchHYttLrtNE1ird/ytagGJw4uRj2
 g/+5Ev4uruV6SEeIdVFXbPmkBbutpDHsjuyx2ZhOp17QpoHCoRfT2etAtkHDaq2wU/1Q
 QIA/UsC+poQ5ETH7osOePlZdpx3sxYhJNfg82zRsieOrAoZAGEmWivZeqWxnxMpQpkoI
 0DwdHV52nFAMZUULqmSS2vrKAO0VV2crmYOCzd8Br7sGff7yHxTyBFg1NM6pc8OoWoWp
 CqSA==
X-Gm-Message-State: AOJu0Yz3hLosnw6nU5Ib86vXb7zI+fBc5fElgtoNFz++3B96BEIDJRxN
 s3/pYvAeh/M7HOXcDKxhe/c89RHIeuu+CA==
X-Google-Smtp-Source: AGHT+IEXPr/RN8F2OQBLfkLDH6Zvr0F8gpDdbTQNV1vlf4Blf3JEI0bBgLTyyW6NsB/CtP6dVpsGeg==
X-Received: by 2002:a5d:6885:0:b0:314:314e:fdda with SMTP id
 h5-20020a5d6885000000b00314314efddamr4793032wru.23.1694195150771; 
 Fri, 08 Sep 2023 10:45:50 -0700 (PDT)
Received: from perkin.org.uk (95.82.155.90.in-addr.arpa. [90.155.82.95])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a05600001c300b0031f07d1edbcsm2637663wrx.77.2023.09.08.10.45.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:45:50 -0700 (PDT)
Date: Fri, 8 Sep 2023 18:45:42 +0100
From: Jonathan Perkin <jonathan@perkin.org.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: Fix targetos match for illumos and Solaris.
Message-ID: <ZPtdxtum9UVPy58J@perkin.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jonathan.perkin@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Sep 2023 17:07:55 -0400
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

qemu 8.1.0 breaks on illumos platforms due to _XOPEN_SOURCE and others 
no longer being set correctly, leading to breakage such as:

   https://us-central.manta.mnx.io/pkgsrc/public/reports/trunk/tools/20230908.1404/qemu-8.1.0/build.log

This is a result of meson conversion which incorrectly matches against 
'solaris' instead of 'sunos' for uname.

First time submitting a patch here, hope I did it correctly.  Thanks.

Signed-off-by: Jonathan Perkin <jonathan@perkin.org.uk>
---
  meson.build     | 4 ++--
  net/meson.build | 2 +-
  2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 0e31bdfabf..5150a74831 100644
--- a/meson.build
+++ b/meson.build
@@ -226,7 +226,7 @@ if targetos == 'darwin'
    if compiler.get_id() == 'gcc'
      qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
    endif
-elif targetos == 'solaris'
+elif targetos == 'sunos'
    # needed for CMSG_ macros in sys/socket.h
    qemu_common_flags += '-D_XOPEN_SOURCE=600'
    # needed for TIOCWIN* defines in termios.h
@@ -2048,7 +2048,7 @@ have_slirp_smbd = get_option('slirp_smbd') \
  if have_slirp_smbd
    smbd_path = get_option('smbd')
    if smbd_path == ''
-    smbd_path = (targetos == 'solaris' ? '/usr/sfw/sbin/smbd' : '/usr/sbin/smbd')
+    smbd_path = (targetos == 'sunos' ? '/usr/sfw/sbin/smbd' : '/usr/sbin/smbd')
    endif
    config_host_data.set_quoted('CONFIG_SMBD_COMMAND', smbd_path)
  endif
diff --git a/net/meson.build b/net/meson.build
index d2d70634e5..51caa42c9d 100644
--- a/net/meson.build
+++ b/net/meson.build
@@ -47,7 +47,7 @@ elif targetos == 'linux'
    system_ss.add(files('tap.c', 'tap-linux.c'))
  elif targetos in bsd_oses
    system_ss.add(files('tap.c', 'tap-bsd.c'))
-elif targetos == 'solaris'
+elif targetos == 'sunos'
    system_ss.add(files('tap.c', 'tap-solaris.c'))
  else
    system_ss.add(files('tap.c', 'tap-stub.c'))
-- 
2.42.0



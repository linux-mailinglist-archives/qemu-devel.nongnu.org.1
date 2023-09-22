Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F27AAE8E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcir-00020e-Tn; Fri, 22 Sep 2023 05:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcim-0001zo-FS
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcih-00063Q-9B
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4XQjh4AZYQRbCXpkKA3DAgg1RJuCYACiXhEt75mFOA0=;
 b=GO2F5BiyjvO0Uk7re2rdOG2NAxUxad/5dYveLPyS/mH/DR2St2lTKpIw8HJQtoeSArR6of
 KMy9F0hjC9tow9ABNH2CRrxI9T5RLU+zcpyIysYQTOaqIDZy5na8W/GAtuuuVpkg8PzoK9
 dLppygJ+EZt3IMojANI2HBZzn33IGlg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-HdbNAhMeN3SrJbYOfEcI2Q-1; Fri, 22 Sep 2023 05:45:03 -0400
X-MC-Unique: HdbNAhMeN3SrJbYOfEcI2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401bdff6bc5so14627685e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375902; x=1695980702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XQjh4AZYQRbCXpkKA3DAgg1RJuCYACiXhEt75mFOA0=;
 b=Mh6dtf6P9PyFYhzzi2k9vf60vT7Z+eMdRpdolPh8iVchT89I21K+Fy86D2AkJWSEw6
 72LetaTtBjYtgVCXan7ACK1jmtQk7/+pOLeF2gBxQyf0UdFKzTEyud76lmKiTA+NIfXu
 dK5fZKt5wZyhw5U71I1FUEE2FLmZYBk+mYWkWJeN3qNJIG/5AmIUrC+PaALTi9qX8rA0
 rLn3RcEOemtCoeNEf+YL3FusOMWcqhRwbjUH55dZz05id7FLOjRy97Dw70eMgOwIGc9A
 78gs9uMIce2U8YXQ7FTe/2hAtaE1SOSbV2iazbm6XL0qrzLOF5vc06FXQ6kNqP2oDhk/
 SEwQ==
X-Gm-Message-State: AOJu0YxN9j0Sf1EwbAF7Cz93A1Ri/iHuO82R5PQxHwP8PzHBx4YXD/7/
 +63Qn8/Oq2xmpezg6wtO/FLakCjCK2DB/MwyrL4EKmESXX2MJwwa+EGdX4h6vfoEec3ydvmhng6
 K0OUOpiTH0cFBcXEqVWanjSvPEBOdxwVcCEqRCN7LqyotGygCnp3qxZSQ1iWwHXF+BWB5KZyKUl
 M=
X-Received: by 2002:adf:e7c9:0:b0:317:3f70:9dc4 with SMTP id
 e9-20020adfe7c9000000b003173f709dc4mr6433769wrn.31.1695375901712; 
 Fri, 22 Sep 2023 02:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6D15qZdbAzbit7AUjLskrlv5tMNSEV5nreFMrqOElNLMNUhycEDiOYMOxpGIukSY7ajRwzQ==
X-Received: by 2002:adf:e7c9:0:b0:317:3f70:9dc4 with SMTP id
 e9-20020adfe7c9000000b003173f709dc4mr6433755wrn.31.1695375901350; 
 Fri, 22 Sep 2023 02:45:01 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adffd84000000b0031f34a395e7sm3954965wrr.45.2023.09.22.02.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 0/9] audio: make sound cards require the audiodev property
Date: Fri, 22 Sep 2023 11:44:50 +0200
Message-ID: <20230922094459.265509-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is the remaining part of Martin's patches to remove the deprecations
connected to audio backend configuration.  With these patches, all sound
cards have to be configured with an audio backend; only embedded cards
get the luxury of a default backend that emits or records no audio at all.
Fortunately, this is easy to do with the existing "-audio" option.

Apart from some rebasing changes, the changes are:

- the "-M" option for the embedded audiodev is only added to machines
  that need it, and renamed from "default-audiodev" to just "audiodev".

- the embedded audiodev is also accessible by specifying "-audio DRIVER"
  without a model

- the audiodev option is also configurable with -readconfig

- MIPS fuloong2e and PPC pegasos2 need changes in order to expose
  the embedded audiodev, too

Paolo

Based-on: <20230922093126.264016-1-pbonzini@redhat.com>

Martin Kletzander (6):
  audio: Add easy dummy audio initialiser
  Introduce machine property "audiodev"
  hw/arm: Support machine-default audiodev with fallback
  hw/ppc: Support machine-default audiodev with fallback
  audio: Make AUD_register_card fallible and require audiodev=
  audio: Be more strict during audio backend initialisation

Paolo Bonzini (3):
  vl: support -audio BACKEND without model
  vt82c686: Support machine-default audiodev with fallback
  vl: recognize audiodev groups in configuration files

 audio/audio.c                        | 177 +++++++++++----------------
 audio/audio.h                        |   4 +-
 docs/about/deprecated.rst            |   6 -
 docs/about/removed-features.rst      |  11 +-
 docs/config/q35-emulated.cfg         |   4 +
 docs/config/q35-virtio-graphical.cfg |   4 +
 hw/arm/integratorcp.c                |  10 +-
 hw/arm/musicpal.c                    |  11 +-
 hw/arm/nseries.c                     |   4 +
 hw/arm/omap2.c                       |  10 +-
 hw/arm/palm.c                        |   2 +
 hw/arm/realview.c                    |  11 ++
 hw/arm/spitz.c                       |  12 +-
 hw/arm/versatilepb.c                 |   7 ++
 hw/arm/vexpress.c                    |   4 +
 hw/arm/xlnx-zcu102.c                 |   5 +
 hw/arm/z2.c                          |  14 ++-
 hw/audio/ac97.c                      |   6 +-
 hw/audio/adlib.c                     |   6 +-
 hw/audio/cs4231a.c                   |   6 +-
 hw/audio/es1370.c                    |   5 +-
 hw/audio/gus.c                       |   6 +-
 hw/audio/hda-codec.c                 |   5 +-
 hw/audio/lm4549.c                    |   8 +-
 hw/audio/pcspk.c                     |   4 +-
 hw/audio/sb16.c                      |   6 +-
 hw/audio/via-ac97.c                  |   6 +-
 hw/audio/wm8750.c                    |   5 +-
 hw/core/machine.c                    |  28 +++++
 hw/display/xlnx_dp.c                 |   6 +-
 hw/input/tsc210x.c                   |  10 +-
 hw/isa/vt82c686.c                    |   2 +
 hw/mips/fuloong2e.c                  |  12 +-
 hw/ppc/pegasos2.c                    |  10 +-
 hw/ppc/prep.c                        |   6 +
 hw/ppc/sam460ex.c                    |   2 +
 hw/usb/dev-audio.c                   |   5 +-
 include/hw/boards.h                  |   7 ++
 softmmu/vl.c                         |  25 +++-
 39 files changed, 315 insertions(+), 157 deletions(-)

-- 
2.41.0



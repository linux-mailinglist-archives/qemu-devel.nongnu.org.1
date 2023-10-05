Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A727B9D22
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 14:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNvs-0007QR-2s; Thu, 05 Oct 2023 08:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNvp-0007O7-Q7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNvo-0007i8-9D
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1raQsL2QqbhKzV1guKRCoSwnyVNHJAKVg/RTwTuKOUw=;
 b=i1fxmKfJTHOnkFHH5suEj8aasKdiYzgiVeKA/ISWIyfHKslnWUbe7ByfuOtaSoVOddm7ud
 6Lnqj8zKa6VdHBnJWrNTMu2/m4hKOwAALgGLQgmWZ9srIzowLEU7rlPX/e6bBF81I3L8Gu
 4W6UKAFUd5TuQwAYFiHIHXL2ca+ut+U=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-j6TBIxRBMyGYfmMJ_CXv_Q-1; Thu, 05 Oct 2023 08:58:18 -0400
X-MC-Unique: j6TBIxRBMyGYfmMJ_CXv_Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a1cf3e6c04so80481866b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510697; x=1697115497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1raQsL2QqbhKzV1guKRCoSwnyVNHJAKVg/RTwTuKOUw=;
 b=P0dLniKBoNkACcMM/EL6CkfbQ1qXxN3o5OyuAriJeaxq6yo2iZR15hObAeJegqlShI
 +sxJOkjLgEtIz82Klglq7skAIKD0s4c99+5PxYX+GgjAqYAuX1SCivp7jJs7elGYkiyF
 q00sBpake+ze8zjfR0F8k5GqdCQ/khjtWFTyyTbLvAzyO9jgbU+8KIiFZpSVWgwzWpph
 TaiKbW2ACH0rFdfB20JuH0RvRRi/Db1dRsdaFFUz11otRBdamay2XecMWsQSlv9uY0sz
 jAr0mqki7lsdYMJ/hPYjoeGyZESfTEOGq08dPtGnNhnwDj99dXhaTWT2jikwL0sWKea/
 ZXHA==
X-Gm-Message-State: AOJu0YwYJqG38CfbJV++yMWQODt+OwT4iqk6HmypWj8ZDmIWdfG84yOF
 70dFNVUW4ggKuOCou0hPWK54UwhAZBbdmXnRYC3Vf3Z4y5NynBI21ld4h7LGWeN2zPTDT4r5ox3
 x2cJyJNuF723UMwErHlYDzPIMCQ3iSRkHbK8ZBIADjOVmhe+Q/AyzGl6Efv0zEJpNek5vcepIDD
 8=
X-Received: by 2002:a17:906:7383:b0:9ae:6196:a4d1 with SMTP id
 f3-20020a170906738300b009ae6196a4d1mr5001095ejl.68.1696510696771; 
 Thu, 05 Oct 2023 05:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSuB/wUXXFB2eBYI+C9y1Cqe+zPL6TQSyai3xz7DRwm97I+s3cszPF7JGqLWJqpk1+G+f1+A==
X-Received: by 2002:a17:906:7383:b0:9ae:6196:a4d1 with SMTP id
 f3-20020a170906738300b009ae6196a4d1mr5001073ejl.68.1696510696342; 
 Thu, 05 Oct 2023 05:58:16 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fi10-20020a170906da0a00b009ad8796a6aesm1169188ejb.56.2023.10.05.05.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 0/7] audio: redo default audio backend creation
Date: Thu,  5 Oct 2023 14:58:08 +0200
Message-ID: <20231005125815.66082-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, AUD_register_card picks the audio backend from either:

- the first audiodev that was created

- the audio_prio_list[] array, which can be customized at
  configure time

This series instead extends -audio to define a default audio
backend if no "model" is used.  This preserves simple command line
use where a single "-audio" option applies to all audio devices
and captures, and also uses a single QAPI-based configuration
syntax for both -audio and -audiodev.

The current hack to use the first -audiodev as a default audio
device is removed.  For migration purposes, the first audiodev
is suggested in case of an error:

  ./qemu-system-x86_64 -device sb16 -audiodev pa,id=default
  qemu-system-x86_64: -device sb16: no default audio driver available
  Perhaps you wanted to set audiodev=default?

VNC is changed to reintroduce use of the default audio backend;
still, compared to before the cleanup effort this will not be
enabled if -nodefaults is use, which is an improvement as it
removes magic.

Paolo


Paolo Bonzini (7):
  audio: error hints need a trailing \n
  audio: disable default backends if -audio/-audiodev is used
  audio: extract audio_define_default
  audio: extend -audio to allow creating a default backend
  audio: do not use first -audiodev as default audio device
  audio: reintroduce default audio backend for VNC
  audio, qtest: get rid of QEMU_AUDIO_DRV

 audio/audio.c                   | 85 +++++++++++++--------------------
 audio/audio.h                   |  3 ++
 docs/about/deprecated.rst       |  6 ---
 docs/about/removed-features.rst | 14 ++++--
 qemu-options.hx                 | 29 +++++++----
 system/vl.c                     | 34 ++++++++-----
 tests/qtest/libqtest.c          |  4 +-
 ui/vnc.c                        |  2 +
 8 files changed, 93 insertions(+), 84 deletions(-)

-- 
2.41.0



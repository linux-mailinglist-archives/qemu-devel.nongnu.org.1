Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C77348B3
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0Iv-0002nN-MV; Sun, 18 Jun 2023 17:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0It-0002n9-Lq
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Is-0006VI-9R
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eTvsUyBzVUJB/vgigpBgevWqbSQcJ2mnehWDGuBWZk0=;
 b=IpGqu6kjAI68Oo8uA6fjHxlavDy6iN3LhpWSOz4n3GY3ci/UJwQiapzp79rCQoKzcC0pfV
 rkhANnFN3kmnDjOEc7s0nS8OZSDyIQ5XTYpI3TK9Z92+EFb3bjB/fix7njV+gGJ7Qcinm5
 YIZwTyHW5tpwkFgMH8Tsl9+Xj7YjNM8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-TG8STAhDMQ616y_9MHhEgA-1; Sun, 18 Jun 2023 17:51:18 -0400
X-MC-Unique: TG8STAhDMQ616y_9MHhEgA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso196245566b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125076; x=1689717076;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTvsUyBzVUJB/vgigpBgevWqbSQcJ2mnehWDGuBWZk0=;
 b=Cw8rIXHBT8qXM+sXOi0OJoVV4b0CkW2VBUIaKXZ917lGtLp+24OOQy1tqBZObtXzpX
 YCilsLm0qgaHkIbCZpr7Ae1C2LfNFjxexJcPEBkNW8ZxAQfnDkg/zoj4IVHrVdxU7KnJ
 FcBV1GqlCKDpSzfbukEErhwKXndsV7LpAppFnOwKKEdJb+xX0fMD+6iFur7Ty2ttUBMo
 mHoTYqEJTLar8fk+46dB+MQ+Y9lv1jdr5WWqZWNBHmPaZz0/FF/5LeL7reWvH6ZbnL4q
 /o5mYkcZVj4hx2i5O3WZ/19euYR0Bz/94G3a88CiQonrZfX2IooJRYjwek5p21LhLYdn
 4kSw==
X-Gm-Message-State: AC+VfDxiRXZSfMVlOcg1l9zHiruXLA5HT+Rjl7ANovOjnfnbCa+G9lck
 f5TJWKubRuXb64TLgyjink3YgBSd1v8FEEeArHGqhMUQruYDOiKhlRaJC8w/8AWl0yF6DObAI8/
 a0U9ObgQ1lV2Wrjaf4VSspCRWN7EIbHJ348KCUacBPV3VP+2uiGayqwWtv+nmx9qSTEa+/6hsJU
 uzXg==
X-Received: by 2002:a17:907:9484:b0:974:326b:3362 with SMTP id
 dm4-20020a170907948400b00974326b3362mr7405808ejc.44.1687125076757; 
 Sun, 18 Jun 2023 14:51:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wZ+cJN2h8JvfGGRSdSo83Q2mSguiLnBzI5Au25xZR9voEJ0bYz9Jo6rkhi0CdMSYBRNec9Q==
X-Received: by 2002:a17:907:9484:b0:974:326b:3362 with SMTP id
 dm4-20020a170907948400b00974326b3362mr7405797ejc.44.1687125076305; 
 Sun, 18 Jun 2023 14:51:16 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 rv22-20020a17090710d600b0098882200623sm1138316ejb.82.2023.06.18.14.51.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] target/i386: add a few simple features
Date: Sun, 18 Jun 2023 23:51:07 +0200
Message-Id: <20230618215114.107337-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

TCG is not reporting a few features that are actually already implemented,
or that are easy to implement.  Add them.

Paolo

Paolo Bonzini (7):
  target/i386: fix INVD vmexit
  target/i386: TCG supports 3DNow! prefetch(w)
  target/i386: TCG supports RDSEED
  target/i386: TCG supports 32-bit SYSCALL
  target/i386: TCG supports XSAVEERPTR
  target/i386: implement RDPID in TCG
  target/i386: implement WBNOINVD in TCG

 linux-user/i386/target_cpu.h   |  8 ++++++++
 linux-user/x86_64/target_cpu.h |  1 +
 target/i386/cpu.c              | 27 +++++++++++++++++++--------
 target/i386/helper.h           |  2 +-
 target/i386/tcg/misc_helper.c  | 21 +++++++++++++++------
 target/i386/tcg/translate.c    | 33 ++++++++++++++++++++++++++-------
 6 files changed, 70 insertions(+), 22 deletions(-)

-- 
2.40.1



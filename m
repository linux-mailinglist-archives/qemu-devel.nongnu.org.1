Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA0770962
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 22:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS153-0005CJ-P8; Fri, 04 Aug 2023 16:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qS152-0005Bp-B0
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 16:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qS150-0005gY-7G
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 16:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691179640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/3mz5LZ1FjkHlUKVtEoJ1nx3YGdKo8Ra8XOmjm2/Z+A=;
 b=OQbF5/ere7CZuqYJPbfFlSxPoCVFY6jdJJTKhNQsGccs7kTWKEvq5YfIpUTfaeXt7Jkty3
 In3KZCve8ALZUuO+58ujTTEPk3m/Pthm21toIUyeJfM5mYWewnSH7H6L+nZiJUbBzdfA6t
 zhRsyxVzJq/wMGvvfNUyq0TzAVjoVY8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-m_T4InjHPxOCNQ1HUIAWow-1; Fri, 04 Aug 2023 16:07:19 -0400
X-MC-Unique: m_T4InjHPxOCNQ1HUIAWow-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso163202966b.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 13:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691179637; x=1691784437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3mz5LZ1FjkHlUKVtEoJ1nx3YGdKo8Ra8XOmjm2/Z+A=;
 b=Z3LmTIdRAsCaALrAhqKmqSNisoYWs4QsFOZZiJjGDS9uWizt4PrDiH7FNWt/8P9Vfh
 JS0pggwiAx1vEFM38wqD6qn25uANmYyy6ByUV+qgivAiF5oEs45PXjqb52KAEdqpvT4R
 YCgAcEnG3u5oZB5f/5367kKZyZuPHc6v1TbANdVQ+BSpizwgAUGKpSSXjQm4B/0WJwyd
 v0Nt70MlLpAEQczt66cwICenUkEMWRtawAnSJwYVfxw1KBKfCcs2F9/PLevextyognnG
 wwUVaUz7Koa3ZmKe94mKQbakeqaJrHyJcXL+1HPwAOjxHDa3tB+TrE/uXaR/CCMW1hNu
 ttAQ==
X-Gm-Message-State: AOJu0Yyw4nNd7qDQJkp52eSRHTP9QKTsgJAn3jpViPiTDrgoS+rBM81v
 yKsy6SLDGgZLxaa0jUP3mGD2PvQy5nKF1D6FYPjuGdC2Coi8gNB+zE1nw4+i95pTnk+CeQp8WEv
 H25RK7tPExIQZGbHNdWSXFJNJ7vVt+K0Xhi75e7Y0RCDgCO3N0+UFaFRUJaIhXhJeTcsGGNTlzR
 k=
X-Received: by 2002:a17:906:108:b0:99c:570a:e23e with SMTP id
 8-20020a170906010800b0099c570ae23emr2562192eje.24.1691179637684; 
 Fri, 04 Aug 2023 13:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDDm+l+ASi3KwWw5BLyt4KSOEwcTd5F9k3j/F1dPoyW0EKdguEv5XNrBjgYadtrJFAjj++Jg==
X-Received: by 2002:a17:906:108:b0:99c:570a:e23e with SMTP id
 8-20020a170906010800b0099c570ae23emr2562177eje.24.1691179637316; 
 Fri, 04 Aug 2023 13:07:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 la1-20020a170906ad8100b0099b5a71b0bfsm1733287ejb.94.2023.08.04.13.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 13:07:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Fixes for x86 TCG and CirrusCI
Date: Fri,  4 Aug 2023 22:07:13 +0200
Message-ID: <20230804200715.430592-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit c26d005e62f4fd177dae0cd70c24cb96761edebc:

  Merge tag 'hppa-linux-user-speedup-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2023-08-03 18:49:45 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to d9ab1f1f4d79683b2db00b0995fa65530c535972:

  ci: install meson in CirrusCI KVM build environment (2023-08-04 13:56:17 +0200)

----------------------------------------------------------------
* fix VM build jobs on CirrusCI
* fix MMX instructions clobbering x87 state before raising #NM

----------------------------------------------------------------
Matt Borgerson (1):
      target/i386: Check CR0.TS before enter_mmx

Paolo Bonzini (1):
      ci: install meson in CirrusCI KVM build environment

 .gitlab-ci.d/cirrus/kvm-build.yml |  2 +-
 target/i386/tcg/decode-new.c.inc  | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)
-- 
2.41.0



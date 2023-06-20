Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA4737037
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6N-0003S0-0Q; Tue, 20 Jun 2023 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6C-0003Oq-6g
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6A-0007Pk-GZ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KvTOKNcDStO3HwXtu33Jy57IjnZYhsJTnWl12h+vY2w=;
 b=NI+04f/dYwS9BChTQBzXKSncWX/L6gQ5BJnX0LF51NY3qpzuihq4+UhxIpFzGVxiTPfDBV
 1ckd8M6SIf/DCF5sYG3aHpmJ/jsnxu64cVk3Qx/FI5rq1LSxqUn9OAoZfb9sH1Dy+B3Cwa
 LVlS4x0erkARK1h+lmzEaOAyGdGgkMk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-QQ3AvKuINBqdJi9_rRdcug-1; Tue, 20 Jun 2023 11:16:45 -0400
X-MC-Unique: QQ3AvKuINBqdJi9_rRdcug-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-982180ac15cso377669866b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274196; x=1689866196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvTOKNcDStO3HwXtu33Jy57IjnZYhsJTnWl12h+vY2w=;
 b=TUu+fGpTPzpwJlVNJOLzxWPyqs9VTXhkl6jGodQb5lMjL/D+K/sRsF+7xbczzoMZ0V
 NbeMiz9SFbUZlE4v7rcRa3yES8nl19NjUX4lfsRQur+N7QDMfWKskzzM7gsL2ctpep+y
 oFcjMxV3T4/dyQl3ROhkRL1cGjYN3K6Iw7JxcCgg5vBq6VnX58RFIwIqiuU49BKN7yhy
 LjkItnZNSJ6xfv1SlagZBcf9u5daqzBd6JT6mDDrBwgV/4ZwLnTdQTLYh7hbwe+inaSW
 iYTIzi8zKF5xCNPPyqy/eCIKIBuzz1O5ev5faGpwjogW4x58V9S0iJ+mSsofFcPH+NnX
 w2jw==
X-Gm-Message-State: AC+VfDxm/1uJVYz5GWbvp9NglIzbO/FktdYkhMgiSWzvQUpXZlXFYQYR
 Fyn+FN5mZ0nFZK5DkbLNcHjKJ76J8t9ImwQnbz/jwDBEiGVZQifsHW2BjRRK/rfFb9LYlqn9CqU
 JsdronCBQFtp4v00fT+K/LPH7d12MPGgpJ2gZ0GJn48P+v5wurOUXsi3KqddO9/Lv/VUpsPvuNC
 8=
X-Received: by 2002:a17:907:9449:b0:988:b58d:5e0 with SMTP id
 dl9-20020a170907944900b00988b58d05e0mr4391417ejc.16.1687274196497; 
 Tue, 20 Jun 2023 08:16:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rFvnBU+gunbeJ/r6LLvNNAOtJ3NkUE3rHbkQnSUbEyEVkUbetls0ZDjZZHXgNX/a6OGT4lg==
X-Received: by 2002:a17:907:9449:b0:988:b58d:5e0 with SMTP id
 dl9-20020a170907944900b00988b58d05e0mr4391403ejc.16.1687274196138; 
 Tue, 20 Jun 2023 08:16:36 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a1709062cd000b00982c5bc1e8asm1549972ejr.114.2023.06.20.08.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 00/10] target/i386: add a few simple features
Date: Tue, 20 Jun 2023 17:16:24 +0200
Message-Id: <20230620151634.21053-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v1->v2:
- fix WBNOINVD vmexit
- correctly implement 32-bit SYSCALL and SYSENTER
- do not include linux-user/ from target/

Paolo Bonzini (10):
  target/i386: fix INVD vmexit
  target/i386: TCG supports 3DNow! prefetch(w)
  target/i386: TCG supports RDSEED
  target/i386: TCG supports XSAVEERPTR
  target/i386: TCG supports WBNOINVD
  target/i386: Intel only supports SYSCALL in long mode
  target/i386: sysret and sysexit are privileged
  target/i386: implement 32-bit SYSCALL for linux-user
  target/i386: implement 32-bit SYSENTER for linux-user
  target/i386: implement RDPID in TCG

 linux-user/i386/cpu_loop.c          | 54 +++++++++++++++++++++++++++--
 meson.build                         |  1 +
 target/i386/cpu.c                   | 44 ++++++++++++++++++-----
 target/i386/cpu.h                   |  1 +
 target/i386/helper.h                |  6 ++--
 target/i386/tcg/misc_helper.c       | 23 ++++++++----
 target/i386/tcg/seg_helper.c        | 33 ------------------
 target/i386/tcg/sysemu/seg_helper.c | 33 ++++++++++++++++++
 target/i386/tcg/translate.c         | 32 ++++++++++++-----
 target/i386/tcg/user/seg_helper.c   | 18 ++++++++--
 10 files changed, 182 insertions(+), 63 deletions(-)

-- 
2.40.1



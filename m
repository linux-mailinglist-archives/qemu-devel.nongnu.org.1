Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8897423DD
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEokJ-0000AZ-R4; Thu, 29 Jun 2023 06:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokI-0000A8-8m
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokG-0005mV-Nl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=erq+b41DbOTMeMT0lM2hZTBXbgKRcHsrg4aISi2fFY8=;
 b=ARzJFmjpe6kEsRv8YBPR/QHw1uFUl92TEzpmWr6J3jhSYlHUzTkjxPdMPktjFwg5b8aEQu
 fGgeWcyLUkGnX6fCEbfQ3d+Y9NtB5OyzGyNEIjBDPZsBnxtr3mWBur/hdLFRvo2W/7H0Dd
 qu1+YdlkuxSCaOQu0K4/V5B6Iyg8OFU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-FJCMsVMvPH6b6c3TnacdxQ-1; Thu, 29 Jun 2023 06:19:21 -0400
X-MC-Unique: FJCMsVMvPH6b6c3TnacdxQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9835bf83157so45234066b.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033960; x=1690625960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=erq+b41DbOTMeMT0lM2hZTBXbgKRcHsrg4aISi2fFY8=;
 b=ls9V0BgWGZ7HT7LvJ2PoUwL061+8LTSUMP6oFt5qlnntb4m5Ku9s26aAXEzfP+EU1o
 7RcqCe3kZkJ/C9nkAzBMEM1yd7t8NACXP/PvLAFntLWqPuHN4G5Y1yJvpElXu7eunjRq
 y17iuu3IQWApEHEL8cN7Y6NuuyHzh/z7sYWvNZ2xsCrJPAUe7JtDBb1wnkpQK+2d0c5B
 lLpeQkD0CN+xTJXjsQZHCIOqj+YBmn4O9bKqQCmJMWSyeAkrOHwTj9rR5s2aWJ0ZwL3a
 vgTTd2I+6lki9i/uCoq+3q0lo2Ab6b/jn9HGzeuEPiu3cvQHvUKTQhR7kUz9/PDP+q9P
 b8Qw==
X-Gm-Message-State: AC+VfDwBne39jPEUmw4zxKddakJHWMhobedsgAdh65zzgwNdqvrVUe7W
 SO3LxWb4pRKcN39Au1Ma65FAVtuCMOIvmAE+EdyiaIRuiQ+qjxbUIWXXU9qAwTJnA8WAxKeIqm1
 kZLcGDpmENDV5N2oGOWdgzNnchGsPh4BASAb8zJckdwUM7bmzMfl/o+hrEbmAZec87HAtYwQWq9
 0=
X-Received: by 2002:a17:906:da87:b0:982:870f:9e8f with SMTP id
 xh7-20020a170906da8700b00982870f9e8fmr29470229ejb.62.1688033960347; 
 Thu, 29 Jun 2023 03:19:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DTiwBavxhN7YOi9TcMgDANe9vUZ8T5cAyXA7Nco5jtNEiMINwpqDavRzPlHMxup7muuWZCQ==
X-Received: by 2002:a17:906:da87:b0:982:870f:9e8f with SMTP id
 xh7-20020a170906da8700b00982870f9e8fmr29470219ejb.62.1688033959927; 
 Thu, 29 Jun 2023 03:19:19 -0700 (PDT)
Received: from [192.168.10.81] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 bm4-20020a170906c04400b00973ca837a68sm6694858ejb.217.2023.06.29.03.19.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 03:19:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] x86, main loop changes for 2023-06-29
Date: Thu, 29 Jun 2023 12:19:13 +0200
Message-ID: <20230629101918.9800-1-pbonzini@redhat.com>
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

The following changes since commit 4329d049d5b8d4af71c6b399d64a6d1b98856318:

  Merge tag 'pull-tcg-20230626' of https://gitlab.com/rth7680/qemu into staging (2023-06-26 17:40:38 +0200)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 40a205da415e9c10ff02505078700e14ead77092:

  target/i386: emulate 64-bit ring 0 for linux-user if LM feature is set (2023-06-29 10:49:43 +0200)

----------------------------------------------------------------
* Make named CPU models usable for qemu-{i386,x86_64}
* Fix backwards time with -icount auto

----------------------------------------------------------------
Nicholas Piggin (1):
      icount: don't adjust virtual time backwards after warp

Paolo Bonzini (3):
      target/i386: ignore ARCH_CAPABILITIES features in user mode emulation
      target/i386: ignore CPL0-specific features in user mode emulation
      target/i386: emulate 64-bit ring 0 for linux-user if LM feature is set

Pawan Gupta (1):
      target/i386: Export MSR_ARCH_CAPABILITIES bits to guests

 linux-user/i386/cpu_loop.c  |  57 +++++++++++------------
 softmmu/icount.c            |   9 +++-
 target/i386/cpu.c           | 107 +++++++++++++++++++++++++++++++++++++++-----
 target/i386/tcg/translate.c |   6 ++-
 4 files changed, 135 insertions(+), 44 deletions(-)
-- 
2.41.0



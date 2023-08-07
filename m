Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE24771D6A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwqj-0001du-MS; Mon, 07 Aug 2023 05:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqY-0001Lr-BN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqV-0003Lm-Jl
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691401693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fo1wn8Sz03Ritla3HnrsfAq9ZoqSDrJoE848s/QBP3c=;
 b=En+FhpRPdrbTsqtGgJgdudIYaxVM0Z1wz1s61psPFkwAVbFf3P5ao0gotd+u0KS7gkJYWi
 bsnkzUbKuad5Ydvap4Ka/5y4o8qKiE6VFedMTtNF9w5YqlBfdL9jgqH3dmft5EU/KjdNX/
 +2mbWHSGzrNGBhgDQ88rsCqfYCJwfTo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-AVFj9a8ZPq282qw1wb7-rg-1; Mon, 07 Aug 2023 05:48:12 -0400
X-MC-Unique: AVFj9a8ZPq282qw1wb7-rg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe4bda379fso15992075e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691401691; x=1692006491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fo1wn8Sz03Ritla3HnrsfAq9ZoqSDrJoE848s/QBP3c=;
 b=UGabSfr/6syfxsviqWIg1bBgNYbaOf+N46VgEOarAmIwATPLhbADu7/pDTmo8Nc4/W
 N8KATcUZJoRwbPL/IHQUTRY0+MFP6GzAzCqAEL1tZ9b78UpgP83g96X9rmpVr5AzkMKP
 cNxNfHrjSe2Bx4NeYVu9Q0BwToe/5cOe0D3cAz5QpmoYaEa5KY6F3lfT1u9uyjFyd7MT
 0Kw2GPzf44oYktrwQsuH61KkdtpquMkSEw/U7QSEgEByxvHNj1NJD7KogK1nwDfUtlBh
 8F6BGirhikMr5az9tYvYNLXcSHhB6AzXt1x2MkM6ME7vGb3+sLUldNAMvbW/sLnAyEC/
 G0UA==
X-Gm-Message-State: AOJu0YxuUJEKC2gI6MEvuv9UUm+Aid0IRbAUvNwuctWWmttM4ZU0Yxa4
 e3Or3kVKSsenOdeWcHeod6g0kZ3mTjO+IoSH1dObbtP1gDtSxE0HDSCcVXbRCRqtcy5AYExaqmk
 TYrEDTlcc3/C627BKa2s9MEM9eknnesmOHkKtCNMAUeAcGREYqq/0HA4L6fk1Wpu79qEGXuijN/
 Y=
X-Received: by 2002:a1c:7912:0:b0:3fb:e2af:49f6 with SMTP id
 l18-20020a1c7912000000b003fbe2af49f6mr6278734wme.39.1691401691059; 
 Mon, 07 Aug 2023 02:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS2kFcvCEmI4Bnv/8WUmOUb7IRTsvhMEmFmyj9GRo3kFNgM3ddSIJgtBo42wzyQOQ7wxkmIw==
X-Received: by 2002:a1c:7912:0:b0:3fb:e2af:49f6 with SMTP id
 l18-20020a1c7912000000b003fbe2af49f6mr6278721wme.39.1691401690732; 
 Mon, 07 Aug 2023 02:48:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a1c7208000000b003fe11148055sm10089617wmc.27.2023.08.07.02.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:48:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [PATCH 0/3] linux-user, configure: fix CPU canonicalization
Date: Mon,  7 Aug 2023 11:48:04 +0200
Message-ID: <20230807094807.471646-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The CPU model has to be canonicalized to what Meson wants in the cross
file, to what Linux uses for its asm-$ARCH directories, and to what
QEMU uses for its user-mode emulation host/$ARCH directories.  Do
all three in a single case statement, and check that the Linux and
QEMU directories actually exist.

At a small cost in repeated lines, this ensures that there are no hidden
ordering requirements between the case statements.  In particular, commit
89e5b7935e9 ("configure: Fix linux-user host detection for riscv64",
2023-08-06) broke ppc64le because it assigned host_arch based on a
non-canonicalized version of $cpu.

While doing this, I noticed that linux-user won't work on x32, alpha
and 32-bit s390 these days, due to missing common-user/ fragments.
The first two patches clean up the directories.

Paolo Bonzini (3):
  linux-user: fix detection for x32
  linux-user: cleanup unused linux-user/include/host directories
  configure: unify case statements for CPU canonicalization

 configure                                   | 157 +++++++++++---------
 linux-user/include/host/alpha/host-signal.h |  55 -------
 linux-user/include/host/s390/host-signal.h  | 138 -----------------
 linux-user/include/host/x32/host-signal.h   |   1 -
 4 files changed, 87 insertions(+), 264 deletions(-)
 delete mode 100644 linux-user/include/host/alpha/host-signal.h
 delete mode 100644 linux-user/include/host/s390/host-signal.h
 delete mode 100644 linux-user/include/host/x32/host-signal.h

-- 
2.41.0



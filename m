Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5856C773A06
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 14:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLR6-0007tE-9m; Tue, 08 Aug 2023 08:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTLR4-0007sF-J6
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTLR2-00035h-CN
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 08:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691496212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JdOxGm3VPCwEzl5Hd1ShKJnELtD7UVW40tUG2cvgEew=;
 b=iTS+8AemfnCtbGY5xtk4VxBirl9xXTwKsY5AOObqCduiD7/8SB9xrBxQcsNjJGazTtW6BJ
 bL4DiBIh9wo1iqucJmhLJN5IzmkS5Xe0o7Vj2Y6ercMcPZaU17VO4pNj3DaoXujPKrxL7d
 syraCxZ1qe3zG0Ksv0GLTCw5k748q4s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-VpCuc0w0MfO1En3xbixvgw-1; Tue, 08 Aug 2023 08:03:30 -0400
X-MC-Unique: VpCuc0w0MfO1En3xbixvgw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe517ca810so16458465e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 05:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691496209; x=1692101009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdOxGm3VPCwEzl5Hd1ShKJnELtD7UVW40tUG2cvgEew=;
 b=Jh1v6fXx8rmdwEP7dU+ReY0FmK7IIG8D/pSNc3XrcbHWBQLQiljDjNyPLmkWyBA4rZ
 LIbqR0fURSQ8bsFZxmLyZkUgwOP5TZYqVqzBcvHWAlMYnfblovuGkZbPLWkaY+wuS956
 IteJRAJ4yxGxP946i67TInQzxDCI3XAHphJyYPN9/oSqrQegV0Kf3G8m03JrUokoZ3xJ
 9+ZwPBCNbNz+oC2yLgp7/QgxKO6mI/xGRpLh22i5lQrfGZwFz5eY+ytEXhMor/YK5lFt
 U2w+Cr8+BixzXilY474uiSiLtS9scvfk8mPMNF0W+wSPURyhUOfdmpJY13PT2UE4rJMN
 x9wQ==
X-Gm-Message-State: AOJu0YxPANlqXnoscmquhYEDF5Qt2G44YHh8rccDdkVyeu+A/eyXLoXE
 QBUA9DWby1QZBVobsvhfqhHA03Nc8lRdwwpDpmXcTReY88vnSI/dpUll4H3JlYDqLWGNY3FkwLi
 d1wnIkLVHuojZ5GoW5OdagF9O1T8GcRgF4KnAQwGqMr1QMeTresX02o1kUYZen0yuCLxsrhULWT
 k=
X-Received: by 2002:a1c:6a1a:0:b0:3fe:2813:6130 with SMTP id
 f26-20020a1c6a1a000000b003fe28136130mr7623437wmc.22.1691496208812; 
 Tue, 08 Aug 2023 05:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7/25F2o7zfL4Uon/XI4BcEBKmROEVKyqUqAfzaUlpHz2JpqRVQzE5764go2tPCFeVzV4yfg==
X-Received: by 2002:a1c:6a1a:0:b0:3fe:2813:6130 with SMTP id
 f26-20020a1c6a1a000000b003fe28136130mr7623418wmc.22.1691496208460; 
 Tue, 08 Aug 2023 05:03:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 22-20020a05600c22d600b003fe2de3f94fsm13574137wmg.12.2023.08.08.05.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 05:03:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	iii@linux.ibm.com
Subject: [PATCH v2 0/3] linux-user, configure: fix CPU canonicalization
Date: Tue,  8 Aug 2023 14:03:00 +0200
Message-ID: <20230808120303.585509-1-pbonzini@redhat.com>
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

v1->v2: fix s390x compilation; rearrange case terminators


Paolo Bonzini (3):
  configure: fix detection for x32 linux-user
  linux-user: cleanup unused linux-user/include/host directories
  configure: unify case statements for CPU canonicalization

 configure                                   | 173 ++++++++++++--------
 linux-user/include/host/alpha/host-signal.h |  55 -------
 linux-user/include/host/s390/host-signal.h  | 138 ----------------
 linux-user/include/host/s390x/host-signal.h | 139 +++++++++++++++-
 linux-user/include/host/x32/host-signal.h   |   1 -
 5 files changed, 240 insertions(+), 266 deletions(-)
 delete mode 100644 linux-user/include/host/alpha/host-signal.h
 delete mode 100644 linux-user/include/host/s390/host-signal.h
 delete mode 100644 linux-user/include/host/x32/host-signal.h

-- 
2.41.0



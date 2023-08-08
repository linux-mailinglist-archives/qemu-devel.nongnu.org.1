Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 383857740C2
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDS-0001V8-As; Tue, 08 Aug 2023 13:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDG-0001Hi-Ph
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDF-0003Cp-5E
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317798b359aso4514044f8f.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514579; x=1692119379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ggRJAM5XkfiPFNC2+f6BETCMMowQTEp6r6VAdCe9kZo=;
 b=BETGDb+t1MY53DOszbuF7XiURxUuiZlOaIOt2hh9R11UE3eYQwx0pMAL6J1/08xcL4
 pR9kgPdBVwq5WFWyliYSQ4M1dKfQLaYgrKrrd94XOlYaC+DyFzT+UhWIp3gX50QzEtxw
 W2tZuxEM2Uz7z0q5IzndrORCNn6ZQq7ob66MsePw2uyBNfrYPKpxN6bFt+8mN5CVhDQ5
 uR+WsT5kHmB1EhBv3LmKbeRmt1s3Gaogl2zOrZcZkJkBGIaRUtYVyti9E94ptP0sJgy7
 wVVp9djpr2ygkpZrK8Q5kDbwoYQObqAGbnBlVAIjW2judigB3i06IGhva1MtavQ31+l0
 CFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514579; x=1692119379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ggRJAM5XkfiPFNC2+f6BETCMMowQTEp6r6VAdCe9kZo=;
 b=FWlr3n82tuveLUO7nhP2WP1ZBxPg3ENoGI2EC7gN2d+uUeJlJDBABGccZKQ3ctVqbB
 gb6u4a8T2bRWt5ft6y67hnKC/22bI/JGq+qHBMcn64uy51q9S1M079nXZwQP81lW4iXQ
 hWnlCdCxX43/bRB3mp++u+dO9adQPYA0y9VQayWASg81we+utjXQ3GAUndbC/kpbS5nd
 7Lu20bKer39pDjaAAnRsvkKnJ/R32CqUWC7HBat9bwlIKjtjql6nyjIjQ1Mh+fUitF9D
 pjdOn7PiHMuvLRjvSPKZvvFi7g+c8FoE4eBoJO51uL30bDBwKGayqtrQIZseOSy+v8Mf
 BMCA==
X-Gm-Message-State: AOJu0YzRJm8hMjGr6aNJyAjfhNv5PbJvyLcxG771zShZvAcA/0ZlJmH/
 mYm9VwNq24IMLvQFISxrD1VHRVNDCs24rg==
X-Google-Smtp-Source: AGHT+IG5q3LrOwxyj3tUua3HsQZGsynosSHObqSKojX5pbzIaRlfj4R8Fh9kuv9tdqxSVU7DVLW/GQ==
X-Received: by 2002:adf:e84b:0:b0:317:6fff:c32b with SMTP id
 d11-20020adfe84b000000b003176fffc32bmr26823wrn.53.1691514578563; 
 Tue, 08 Aug 2023 10:09:38 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 00/33] Implement the stat system calls for FreeBSD.
Date: Tue,  8 Aug 2023 08:07:42 +0200
Message-Id: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Upstream the implementation of the stat system calls from the
qemu-bsd-user fork, the following system calls are implemented:
stat(2), lstat(2), fstat(2), fstatat(2), nstat, nfstat, nlstat
getfh(2), lgetfh(2), fhopen(2), fhstat(2), fhstatfs(2), statfs(2)
fstatfs(2), getfsstat(2), getdents(2), getdirentries(2), fcntl(2)

Karim Taha (1):
  Add os-stat.c to the build

Kyle Evans (2):
  Disable clang warnings arising from bsd-user/qemu.h
  Define safe_fcntl macro in bsd-user/syscall_defs.h

Michal Meloun (9):
  Forward declare functions defined in os-stat.c
  Add struct target_stat to bsd-user/syscall_defs.h
  Add struct target_statfs to bsd-user/syscall_defs.h
  Implement h2t_freebsd_stat and h2t_freebsd_statfs functions
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls

Mikaël Urankar (1):
  Implement do_freebsd_realpathat syscall

Stacey Son (13):
  Declarations of h2t and t2h conversion functions.
  Add struct target_freebsd11_stat to bsd-user/syscall_defs
  Add structs target_freebsd11_nstat and target_freebsd11_statfs to
    bsd-user/syscall_defs.h
  Add struct target_freebsd_fhandle and fcntl flags to
    bsd-user/syscall_defs.h
  Implement host-target convertion functions
  Implement host-target convertion functions
  Implement host-target convertion functions
  Implement host-target convertion functions
  Implement stat related syscalls
  Implement stat related syscalls
  Implement stat related syscalls
  Implement stat related syscalls
  Implement stat related syscalls

Warner Losh (7):
  Move _WANT_FREEBSD macros to include/qemu/osdep.h
  Update the definitions of __put_user and __get_user macros
  Rename target_freebsd_time_t to target_time_t
  Add glue to call the following syscalls to the freebsd_syscall
    function:
  Add glue to call the following syscalls to the freebsd_syscall
    function:
  Add glue to call the following syscalls to the freebsd_syscall
    function:
  Add glue to call the following syscalls to the freebsd_syscall
    function:

 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-stat.c    | 325 +++++++++++++++++
 bsd-user/freebsd/os-stat.h    | 663 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 121 ++++++-
 bsd-user/freebsd/qemu-os.h    |  50 +++
 bsd-user/qemu.h               | 113 +++---
 bsd-user/signal.c             |   5 +-
 bsd-user/syscall_defs.h       | 222 +++++++++++-
 include/qemu/osdep.h          |  13 +
 9 files changed, 1447 insertions(+), 66 deletions(-)
 create mode 100644 bsd-user/freebsd/os-stat.c
 create mode 100644 bsd-user/freebsd/os-stat.h
 create mode 100644 bsd-user/freebsd/qemu-os.h

-- 
2.40.0



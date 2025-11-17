Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF93C66507
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Nov 2025 22:43:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL702-0005ND-4U; Mon, 17 Nov 2025 16:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vL6zz-0005Kk-Hj
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 16:42:59 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vL6zu-0002FP-UA
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 16:42:56 -0500
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so32821155e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 13:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763415760; x=1764020560;
 h=subject:date:cc:from:message-id:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/+te80I8sgddXLErqTzP/l6ZHhk9Xa0nCDVyqJQOE/U=;
 b=KLNTuUGZB+b0JSYjGCACgdRqaPmS8Xv3r+dArnzPyfabzHzUwhVeb7mZpzEaReTSgt
 uDcx9fbJtENM8v9INB+cL4aTmSbH5yzDLAffIS8mA4kv6xdpUGRAutFyIwnVzdtioI7I
 T8Uk34BEDmM/Xa1zYg3mHHHtUVCApVCpI/XuPVME2lC7ZgQDPBdVoJ+UTxLoVgjFqU7l
 1tqeYfRPZ+hTE1ugvOxW83F+NkxdXWuqY4yxa+gj7d9FOo8ZS/pDE80EKSnDSYhfpz5d
 30BUxyByrxd+C98JY6OBXpaPSoGa1z7sDYtZpjXM+oyvqK3y9XOoe+IUyQZUrBsVy8X8
 Q+OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+SzhYQvHD+B1opAwMVMxBnO2JtMfFs1VbMq5CJMX1TmiO0hpqcBtDabbXaU6jNunHpWrtrfaC+dY7@nongnu.org
X-Gm-Message-State: AOJu0YyPkLOH4yurSABl+GcN5W1Gw6nWza3tS74ga/N/i/dgUWUPjzkl
 xy0bvkE8wNMSkTjtltfyPG4iTcP5in7FuaCtaZSogJEfHYEFjA5sKkihmYG9T/zm
X-Gm-Gg: ASbGncuWKl+NroxbDvDT7Bi0zVm0Wfg6tafA0vlLwGMMKpOSCnoxSpsSNnLoFj3J75s
 8x4gX9guYVVh+gVE78VW8t++zqn/Rr0iogkmcLSzuOhCAbg9valfP6Js22M4d/j4qvS4IHdHC0l
 UnFtNRAA0UVaveENvgNq8/NFwQ06w/aQ7SfB9qptdXt9lsQUTcRzE3gsOeKwTSVMu2hpzL1v7f5
 r4utDIdikEL5D/OMIZUw0i6ld+8T4cl3f/WiM6emUC4HgwypW/L7qp9hYWOBkrBTgtCt9X1XBP+
 TUbOMQ3FfGhGJf5nD2LUDOzczJJ5YK6sUsv12InTbToZlQrtYqHqTvozOFvW8kEMOSpQg5BXwWt
 smwAeCpnqGRvHpy74emAaq+7dDMMV7o4O4otlBCMPZslWDvELwm3UWTXvnxUFn22vu3ebzTGDGh
 vPrw2wmE93HIT6zAwfvff/tq1n7e0uLcRCI0HO5sSDqYPS
X-Google-Smtp-Source: AGHT+IGlGoJCjQRJ0oqkfeyD/76+6BWBiEWA06Aa5xHTs8iXfkD05n17bjj6lYFapwhBAs6dPVwCWA==
X-Received: by 2002:a05:600c:4f4d:b0:471:665:e688 with SMTP id
 5b1f17b1804b1-477a9512ec8mr9407615e9.17.1763415759672; 
 Mon, 17 Nov 2025 13:42:39 -0800 (PST)
Received: from localhost (95C85BDA.dsl.pool.telekom.hu. [149.200.91.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19664sm28906460f8f.36.2025.11.17.13.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 13:42:38 -0800 (PST)
Message-ID: <d5a526b02171bfe76d36d6cb698e6387.rbalint@gmail.com>
CC: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, "Marc-André Lureau" <marcandre.lureau@redhat.com>, "Daniel P. Berrangé" <berrange@redhat.com>, "Philippe Mathieu-Daudé" <philmd@linaro.org>, "Alex Bennée" <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
Date: Mon, 17 Nov 2025 18:20:24 +0100
Subject: [PATCH v2 0/1] user: add runtime switch to call safe_syscall via libc
Received-SPF: pass client-ip=209.85.128.41; envelope-from=rbalint@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Balint Reczey <balint@balintreczey.hu>
From:  Balint Reczey via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

qemu-user implements calling signal-race-safe syscalls for the guest
in assembly directly to the kernel instead of going through the host's libc.

The proposed patch adds a switch to go through libc, which allows interposition
of libc's syscall(), even when the guest program is statically linked.

The motivation behind the change is intercepting statically linked binaries [1]
with firebuild [2], a build accelerator implemented in userspace.

Since v1 I found out that faketime can also benefit greatly from -libc-syscalls,
since some time related calls are wrapped in safe_syscall, such as
clock_nanosleep. Faketime did not cover the syscall, but I patched it [3],
and it is getting closer to fully faking time for static binaries, too,
if qemu's support is there.

I have tested the Linux changes, but not not BSD ones.
I think they are trivial enough to work and I'd like to port firebuild
to BSD, too, in the future.

I understand from the previous review that signal handling should be as
perfect as it can be in qemu, but I hope that now that the changes don't
affect qemu's behaviour unless they are specifically enabled at build time,
they may be acceptable.

Changes in v2:
- Moved signal handling closer to the syscall call, addressing one
  review point.  
- Minimized the changes
- Introduced CONFIG_LIBC_SYSCALLS to isolate the changes to take effect
  only if qemu-user is configured to enable using libc-backed safe-syscalls.
- Introduced --{enable|disable}-libc-syscalls configuration option

Cheers,
Balint

[1] https://github.com/firebuild/firebuild/pull/1334
[2] https://github.com/firebuild/firebuild
[3] https://github.com/wolfcw/libfaketime/pull/522

Balint Reczey (1):
  user: add runtime switch to call safe_syscall via libc

 bsd-user/main.c               | 20 +++++++++++
 common-user/meson.build       |  4 +++
 common-user/safe-syscall.c    | 66 +++++++++++++++++++++++++++++++++++
 docs/user/main.rst            | 30 ++++++++++++++--
 include/user/safe-syscall.h   | 19 +++++++++-
 linux-user/main.c             | 15 ++++++++
 meson.build                   |  1 +
 meson_options.txt             |  4 +++
 scripts/meson-buildoptions.sh |  4 +++
 9 files changed, 160 insertions(+), 3 deletions(-)
 create mode 100644 common-user/safe-syscall.c

-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 651A183065B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:59:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5US-0001js-Nn; Wed, 17 Jan 2024 07:57:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ56w-0007do-FR
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:33:38 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ56v-0000Ry-3K
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:33:38 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-36198fc846fso647545ab.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 04:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494816; x=1706099616; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sLHG0SOMAj5aV+QlUE+O+/A+FAq0hvW1YKlJWJfdZ2A=;
 b=XU3LuewW+8rK+xzIMMTLUJjKcVAWpjUUmeNqTUNVkAyfueDuoeKYd2tnXN6Ml/6xWt
 skglwk8asaq9wVEXzuItLV/DYKKsRZLMerQjyZt9RO05sra7/JrZCpNT5PPn8wXzPCs7
 Z1e0GnLK7Frza2RZriDSEaPCzh2pFiTvg7Ptkg6rZgB7FFzCwf5itialb99ctJ1jzDEu
 yglaGL/5C98gw9ni+dP5y1ms5nkv/NtCgdOBLyUmoBfeRNsnm7A6ybneK1jVYKajE6ol
 1t0cmv5ZNSJlEmm11DYBL6Vzk7vH3oEJcf2Ald8j0iFg07XVSODjR44duOktcVorOpOa
 fPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494816; x=1706099616;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sLHG0SOMAj5aV+QlUE+O+/A+FAq0hvW1YKlJWJfdZ2A=;
 b=b+NPTy/vprjB+ZSGhWUeEsdYWF9zGV44vllA+Cj6ruBGZNBHgkBiYXqf8CQAWUuqzC
 bR4VWLvEe0Aw2UywygJj+pRP+5u2PnPF4C/9ciG5VAfxCmxSy4CicTN37wtnFY3PpIoQ
 mJhUKl0O1CvAtt/cev/VZ0P527F8Q1ZNL8Qt/5RGFzPqrUacmwTYjkBU2vvatLx4R9eZ
 sms9L0tfxfHiPcPDwQDdDqKyIgoUKbGNAnglBj3Q8AuGnKbMV+6MTpyi3HdyAvzqqZfZ
 GwBlbE8Ml/CsximiIsFpIkwcN74HgQ1oGd3Q6sDjkt9SsiIIg8i1ACqGNEzobYK7M+ky
 oBLQ==
X-Gm-Message-State: AOJu0YziTvMaUE64wFUyxhvR2rmo0riXxPUXxCJEgG5iDUXOND1rpXKV
 mEzqSY10MLzWRji3J0z5fTILcVpKvyMY2G62CE2VAtUco/c=
X-Google-Smtp-Source: AGHT+IHEDTLaCqFj0qiuZ8bCfYW9O6lMpqcOqald8Uo//J8zzpQgLp5XbFq9lzJv1mnasl6MW4Mz/Ky7f5X3F8d/t70=
X-Received: by 2002:a92:c68e:0:b0:360:29f:b7a6 with SMTP id
 o14-20020a92c68e000000b00360029fb7a6mr10557395ilg.18.1705494815979; Wed, 17
 Jan 2024 04:33:35 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 13:33:31 +0100
Message-ID: <CAHP40m=n8SJ5w_1d+WwCKonXyqkufBqr_q0XfBFUT0qBe2PJyQ@mail.gmail.com>
Subject: [PATCH 4/4] Add the GNU/Hurd as a target host
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 07:57:54 -0500
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

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index c36ce1f7e2..d4648af96a 100755
--- a/configure
+++ b/configure
@@ -354,6 +354,8 @@ elif check_define __NetBSD__; then
   host_os=netbsd
 elif check_define __APPLE__; then
   host_os=darwin
+elif check_define __GNU__; then
+  host_os=hurd
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
--
2.43.0

root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu#
root@hurd:~/qemu# cat 0004-Add-the-GNU-Hurd-as-a-target-host.patch
From 5d7bf83c00168cede72a03d87d7546a0018b82a5 Mon Sep 17 00:00:00 2001
Message-ID: <5d7bf83c00168cede72a03d87d7546a0018b82a5.1705439227.git.manolo.demedici@gmail.com>
In-Reply-To: <cover.1705439227.git.manolo.demedici@gmail.com>
References: <cover.1705439227.git.manolo.demedici@gmail.com>
From: Manolo de Medici <manolo.demedici@gmail.com>
Date: Tue, 16 Jan 2024 20:12:50 +0100
Subject: [PATCH 4/4] Add the GNU/Hurd as a target host

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index c36ce1f7e2..d4648af96a 100755
--- a/configure
+++ b/configure
@@ -354,6 +354,8 @@ elif check_define __NetBSD__; then
   host_os=netbsd
 elif check_define __APPLE__; then
   host_os=darwin
+elif check_define __GNU__; then
+  host_os=hurd
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
--
2.43.0


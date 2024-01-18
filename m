Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC7831D30
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:04:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUsQ-0002o2-0h; Thu, 18 Jan 2024 11:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUsC-0002lm-4E
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:04:08 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUs9-0005VS-Ls
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:04:07 -0500
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7bee8858a8aso297650039f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705593844; x=1706198644; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6cjpotfiriIAMF1zsQzKyT06v91ATIBjlMrjLwqyqwg=;
 b=GjbI9IQYOFlck1+LS1tDN+tztEAO92iKzOuWirvzJmw+WY5c1oFhONE20vKAE2aSFC
 ey8jHTO50doDp4RVrEB+Uv3d5PJTMs3PZ6MAHRflF3lNWISTjn5z7xJ7XI6gjMJUi0HY
 rutwOReteYKNT7a3iYeIgvplYNbX3EIL88zobFsT/FeOEc1xIGjI7kDSjIExlzmRqiVr
 x8dmLE06YBVZ1l0vQiwHvlW3IyFYNCTMx5Eqrgzjb+akpNQ7OKH22NW6a5pqjoUpzyiM
 CQRHDqvnEZm7hFovpBLsbu+LWqlV7FDRC8Gmc6VoMhJPrDIzb41K9QDuDKdfeMGcoWj1
 PC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705593844; x=1706198644;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cjpotfiriIAMF1zsQzKyT06v91ATIBjlMrjLwqyqwg=;
 b=XAqWzCPfe3CPB4yclUwy2uBsEDTfB3WXst6X6e2+xFZDideYhsiEdzP6JjNZ60R5Dk
 Sj/ZzEXbYrGLp/cWjFnGxnLcUt2Q+n6fpwr7j6xnL8zx5xUwvQea2esO2WRJZwI/gjQv
 pY+C1wAdv2ftHcfBCjQw2CpnoeBl7oJtaf/4eYnZVsBBs20yXFgnEafw9DGdmdQ2Fy0p
 9ZvNkITFYoJAqrB8fasm2C8Cg+BV4NBM4DWgTh45yVoCEnNmFt+Zgk7Ha3wLW3dfyH//
 JUSium6Q0JDeh3WGnb38Tt4VrN+27LIaoVPky6H7j9JKf1cdrq6kZLLF6WKYvo55Xtc7
 zftw==
X-Gm-Message-State: AOJu0YztgsnL4hFb1O/ttmwjd8GeDT/SbojYlzJKhAo5JwqKjD794/4r
 5OS9Bx6aqA/Xcrdi102hXmkg4REcoJQcUR7ze5TkdBDbWnniTJFH5jQU4J1NZNNdKe2GSWDke4e
 K/bVYM3PolW8TqmygL/0CLq3VeCjZGy3W3Dw=
X-Google-Smtp-Source: AGHT+IFOzqzClBE2jCpFi1RizYkmTyZ2dIjIif6CiNX6HzaapsvecDtXbpv/dev8XzwS55W7npUw8irPu8uwFRig0bo=
X-Received: by 2002:a92:8743:0:b0:360:7828:c653 with SMTP id
 d3-20020a928743000000b003607828c653mr1103018ilm.1.1705593844617; Thu, 18 Jan
 2024 08:04:04 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Thu, 18 Jan 2024 17:03:59 +0100
Message-ID: <CAHP40mkKDyvxXaK6L3RcfhSY6JKXV4qSu677TDkr-KCBJ+oquA@mail.gmail.com>
Subject: [PATCH v2 3/4] Add the GNU/Hurd as a target host
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d33;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 21ab9a64e9..fb11ede5b2 100755
--- a/configure
+++ b/configure
@@ -353,6 +353,8 @@ elif check_define __NetBSD__; then
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


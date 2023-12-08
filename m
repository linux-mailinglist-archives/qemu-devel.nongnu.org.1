Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0480AFCB
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 23:43:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBjY0-0007W7-Ky; Fri, 08 Dec 2023 17:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wptzZQMKCvktdxhpphmf.dpnrfnv-efwfmopohov.psh@flex--scw.bounces.google.com>)
 id 1rBjXy-0007Vv-Rp
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:42:14 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wptzZQMKCvktdxhpphmf.dpnrfnv-efwfmopohov.psh@flex--scw.bounces.google.com>)
 id 1rBjXx-0007eh-Cg
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:42:14 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-dbc1f00dc35so3354506276.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 14:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702075331; x=1702680131; darn=nongnu.org;
 h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nR/6Gm4cCsmWGcgeLIo3+sjciyvtVDyTL3CXBtrQfcU=;
 b=jGHOqovd3dkLeR3ZYenSjT8Vk4D6NKysZNZbSkIUAXGqLl3+o50Bi6KQH5oQxeCXob
 KDNWdSxbfZiiwcgTnLdNzILyOP6K2fCi4G2Pad73WbqMNvsiVdNCs1OIoMwVBk/lHSPI
 u+mN+mt6h0hQJ5O8sM+JujhFGwFoESuHnh8FoeGJ+lJ4w2LRfGAx0y4a4fhY87eO3zy5
 qSv1JFkXIkmEWzoZqxtP29HDrG3kJgH6/BV2v1cXuaCzl9LS5fEo/xApyjb4jNMAtXMY
 zSrT81FyYeyNM8PLRqQNCFammDCrMX37UkEtR/68XBDbZXg5xhag/d3NFqH9XwXT269J
 WBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702075331; x=1702680131;
 h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nR/6Gm4cCsmWGcgeLIo3+sjciyvtVDyTL3CXBtrQfcU=;
 b=fmCocyq06Cs9juj7TPJOw8o0bHZU5geFkhLDoWWDJNtcWkAaSFyy+J3stahfKgpH2v
 Bs2AwmqvkUg1oMp3P704wooZ+Nj3KA9iYU1F3J+mMWXnV9YoDKYJviEzXySEGFH6hXUD
 BH9cExLf8b04tiRhgnmLUUdo9qsZ3l+xDlzYIVUVSo3aUE+X6Ca6ZQcjmqPoOd9djXEY
 KueYLf37IMYHjGlaasrGxdPBqD2/I0s3mcIDlzW9jm1eaE9SzoXLVQfoa+27SscBuQl8
 Gq2gux2sznGR+UViO4B92I8OKFmBDWkmWb5BQ8hNcCnBN4aMgKEnsOFfN0HZQd3gXvwh
 S9Hg==
X-Gm-Message-State: AOJu0YxhteYFOqU8H5NaVwXzHbPYMvqYRoXcaOMSbOY9pxiEzmz/X1Ad
 nP/cY8igfZJhmWp6ctoaub3YuKtPU9pReKVECPFDirSlhliMozmvcqqUvBTGEx7lEH9Qo77R9y3
 LbmsH7zhZmJQL907aSfbqVtZ2t2cXXwh4uylxaRuNx+K0u0yQmzlM
X-Google-Smtp-Source: AGHT+IHHbh9AzcpA+cN4CYNJnSXe/4zRr/h6LCxJdE0FK5KNs8N+rNDd5EBlag4733uTvvbuY3m6KPw=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:37bb:5740:1ec:48f2])
 (user=scw job=sendgmr) by 2002:a25:db94:0:b0:db4:7ac:fea6 with SMTP id
 g142-20020a25db94000000b00db407acfea6mr5559ybf.7.1702075330740; Fri, 08 Dec
 2023 14:42:10 -0800 (PST)
Date: Fri,  8 Dec 2023 14:42:05 -0800
Message-Id: <20231208224207.613445-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v3 0/2] linux-user: openat() fixes
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3wptzZQMKCvktdxhpphmf.dpnrfnv-efwfmopohov.psh@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Since v2:
 - More robust handling of `readlink()`

Since v1:
 - Eliminate static buffers in do_guest_openat()

Shu-Chun Weng (2):
  linux-user: Define TARGET_O_LARGEFILE for aarch64
  linux-user: Fix openat() emulation to not modify atime

 linux-user/aarch64/target_fcntl.h |  1 +
 linux-user/syscall.c              | 47 +++++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 9 deletions(-)



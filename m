Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C61D3800206
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 04:23:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8u6M-0002w8-HN; Thu, 30 Nov 2023 22:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3VFFpZQMKCs0BvFz77z4x.v759x5D-wxEx4676z6D.7Az@flex--scw.bounces.google.com>)
 id 1r8u6J-0002vu-TN
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:21:59 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3VFFpZQMKCs0BvFz77z4x.v759x5D-wxEx4676z6D.7Az@flex--scw.bounces.google.com>)
 id 1r8u6I-0002eA-8F
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:21:59 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-db54e86b2d1so88576276.1
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701400916; x=1702005716; darn=nongnu.org;
 h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RK7ehh6hhttWxnoToGq8a43jLBWiTgE1n2p3tol/wpw=;
 b=gWh8zRQcpW58GAU3mCpNtHxVI549Lgrd80BxSLJh9CqfYbhLsBfJEsM9DEp+N+nJXS
 ZqFtjYFPmTQ36VTTzMjHF4Z3b5c2+LqDS9+FTEgVIF7rIvzke4rAXGET+APbsNsynSWA
 Jo73CLINwYiTM6AIu+UzUOKz3v9sTAU8lzA/tAGcfDtzvWa/D8fyTai9K7ZOEju+l4vu
 1jkemdOwHoHV/k8x5ZiglWhUgYBhu7UCW+ZvDMBOzFJ69irT4P0zdouNgxcZg3Esq4xp
 EZpXTIkUSa6r0PvWWHuDtam0mz6LzN0icDds0/fLacItBIhtSVCAafKefWD7SG/2Zyw4
 hJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701400916; x=1702005716;
 h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RK7ehh6hhttWxnoToGq8a43jLBWiTgE1n2p3tol/wpw=;
 b=Whr5zcb7eqkntbVmavi6J8eHL8iSzUg+mvsMDdK1XRsnb/ZQr7jnQscadTAfmtXHvq
 2pqXs5pIn4j6slyToP+VfI7fNOaCfXhirDHO8uX9vdCqcHuIimKG6f76uRogBUOgRfvu
 gEmyRmbCxzUdHZ2JdgXKZYEv4pkII+Ji2uqOFiZw2P1zvfvvAqtumYGmgQKmRtFAdvf/
 rf4uvSw3K0K6hC/T3QVSfMaA3UfbhJTmp6AYra4mGNgJOJmUvvk2YSyUlxnHIPc2QPqR
 PNITCxOhjqs0BOOnhyxBR2fCP9rwQivCyAxja0g2zDoS3hIOnpy6YMXk3KecE4bJuMi6
 /gpw==
X-Gm-Message-State: AOJu0YxAfm2/0Ykc9AukluJ1c5490QTjGuZH8mDLCasFTfW6K/0ZeJNZ
 oNmG7TLofTUY6d1pzQc1B8oIIaUfXoBlceNUHko3hbRpoSazNTVSUXdv4XecxivCYWYcTcfsQIE
 0XVYdZo+6wiwtARuBdWvTigKtCCV+eKpa8OFwzg199nWkVZtt5UcE
X-Google-Smtp-Source: AGHT+IFRADLmN7LqA9iZCyKjv4Amt40ap787WSDVcnycGUay+cdLrhvuc7bM+TtFxNxnqjFv1mJU0T0=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:73b4:ef07:4b25:48e5])
 (user=scw job=sendgmr) by 2002:a25:3055:0:b0:ca3:3341:6315 with SMTP id
 w82-20020a253055000000b00ca333416315mr828708ybw.0.1701400916402; Thu, 30 Nov
 2023 19:21:56 -0800 (PST)
Date: Thu, 30 Nov 2023 19:21:38 -0800
Message-Id: <20231201032140.2470599-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH 0/2] linux-user: openat() fixes
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3VFFpZQMKCs0BvFz77z4x.v759x5D-wxEx4676z6D.7Az@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Shu-Chun Weng (2):
  linux-user: Define TARGET_O_LARGEFILE for aarch64
  linux-user: Fix openat() emulation to not modify atime

 linux-user/aarch64/target_fcntl.h |  1 +
 linux-user/syscall.c              | 42 ++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 9 deletions(-)



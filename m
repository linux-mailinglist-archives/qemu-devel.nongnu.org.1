Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A681FB80
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:18:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyhf-0007M4-SW; Thu, 28 Dec 2023 17:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HfSNZQMKCnAgQkUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--scw.bounces.google.com>)
 id 1rIyhd-0007LE-QH
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:18:09 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HfSNZQMKCnAgQkUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--scw.bounces.google.com>)
 id 1rIyhc-0007d8-8S
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:18:09 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5e74c97832aso89966827b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703801886; x=1704406686; darn=nongnu.org;
 h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z4fR8amUcwHFtPDCFuyUe4tqU2GtcN3VdRJJ9r5yMNs=;
 b=OruVa8t0wGseiijmY0GqXf05uQCEjvp27NDkNN9ZkCegqBcgHdjUq75Dwey4ncydDr
 J+NgCBl+4/leK1zvo2mjUhSZTXRpZqWCqxIpRE18uoZNCLPfYrrWd+SKp8bGBnj6rowk
 c6BNeCoW3xeXQmvyw3M3GEeBQS49O+pD2/jT7VHMwwg6xVvMkQmg9ErIuT75L0JH5QNv
 6iJMwCssHW6/u7CQdviszsWGvzzY+K4JLrhpFiNBVsbHnhlOcQca/oeyeqhcLFGLoKG6
 rXKu4cfchQAD/dmtQFOqy+YPSAulI+BDzQsWQPwrkX1BLRAj30N/jQ4ubWWsyenoG5be
 x5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801886; x=1704406686;
 h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z4fR8amUcwHFtPDCFuyUe4tqU2GtcN3VdRJJ9r5yMNs=;
 b=i0K1cZOcXrAp4KsAe5LtlQWDC/e/RtPf4GZJlbOeEG4pUtsY2MrGVfXVSTKvUqT0xU
 8EOkuFlD7DCk2qyoFWuY9SM9jl6IHJlxarUWQ5Honm5xM4aSma010UwPg/zuYz+JJt9b
 jBWGHjQODOBdRKZ3QxvJLMYFFLLqEOWFx9TMK+26NX1bzcM6Vuw83ucQL4vpx4iK+kg3
 Ggt5mEgOx8/Dsw0b/mwX/BXaMMLb4XrGZFJxQQpEePg/nCNXFRiLWcDgcBYDGXtqBzDg
 pDIjEaMyf7LoMUFjzRnRoFAgZ5P3k5ILBNuaj83SyYRej980Sn9QEV4aKoIqY18u+QSC
 Q53w==
X-Gm-Message-State: AOJu0YwgI8/b/hyHTgNp95p4+ctK8bXEu0BWRi0KGamnx6dxTiTs56N7
 +A3CQHJ1mgKTd/4HfcTwbXHVBHbeEryRkFTA576cY8XoskrcTWgmJFMc7jXEIFONZzEZky5rxwX
 9QUdqnlzNV7mmOoIKJAU8+9G8A4a8QXAIJXy1cddfssC3Ikk25RLUtB0GhtA=
X-Google-Smtp-Source: AGHT+IFqTTvR6glmxH5MOuiQZPqyn4YElEofDw7P965k+59GFE34XcIRJW6m1c+fRzltW8x9tnf3sn8=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:ed19:b942:6cb6:d8bc])
 (user=scw job=sendgmr) by 2002:a05:690c:a85:b0:5e6:28b2:8bf2 with SMTP id
 ci5-20020a05690c0a8500b005e628b28bf2mr4502241ywb.0.1703801885818; Thu, 28 Dec
 2023 14:18:05 -0800 (PST)
Date: Thu, 28 Dec 2023 14:17:57 -0800
Message-Id: <20231228221759.2839009-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v4 0/2] linux-user: openat() fixes
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3HfSNZQMKCnAgQkUccUZS.QcaeSai-RSjSZbcbUbi.cfU@flex--scw.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

Since v3:
 - Fix build error: ignoring return value of 'readlink' declared with attribute
   'warn_unused_result' [-Werror=unused-result]

Since v2:
 - More robust handling of `readlink()`

Since v1:
 - Eliminate static buffers in do_guest_openat()

Shu-Chun Weng (2):
  linux-user: Define TARGET_O_LARGEFILE for aarch64
  linux-user: Fix openat() emulation to not modify atime

 linux-user/aarch64/target_fcntl.h |  1 +
 linux-user/syscall.c              | 50 +++++++++++++++++++++++++------
 2 files changed, 42 insertions(+), 9 deletions(-)



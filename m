Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9878B80AE46
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 21:51:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBhnV-0000zc-43; Fri, 08 Dec 2023 15:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3eIFzZQMKCnsrbvfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--scw.bounces.google.com>)
 id 1rBhnQ-0000z1-MJ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:50:05 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3eIFzZQMKCnsrbvfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--scw.bounces.google.com>)
 id 1rBhnO-0005sb-KK
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:50:04 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5d98fde753eso31458507b3.2
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702068601; x=1702673401; darn=nongnu.org;
 h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=27lZYcN4dnHCc1tiVArf31JRPBph89VDH9lbQ8Qm7KM=;
 b=lvHhqToqGPmcrIc+DdeZgMBx64LTx/y2BKeCw8LmhDQwehdETf53nxqltv7yJ3ulAJ
 8nWBYp00CQi4ku8i/j2gPXk3/B6Cfpg6B5ap28vxRNGNgXcbfI7fqaFyhRuS5AEacuwq
 BkO3nDW0ZjqH5yVt8q/w0E9bSIfWYKUgdue/RDht3ZrN5jmOSMb8zIqIPqsrpXrlEU4+
 8QulQIEmDHX6D+xQ7TiAow5+rgnkM5OL6mxT5qS/kjH9xAn068dFZJh5ru4BOimAxgYO
 QU7B8l7THIAPGp3ga/inLLD/1IuEO2xS2upHe5SjlNmZNVHonsH/XMyVBXgyjO0uSSzO
 KtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702068601; x=1702673401;
 h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=27lZYcN4dnHCc1tiVArf31JRPBph89VDH9lbQ8Qm7KM=;
 b=EOsp3IhLK59geOgW5b3mkBTk1qXdidyRCv42kphYtmOpp+LzU5GVT3LUyk223Byd/j
 Fuv+tIHFYSGbUKL7edl+pUrDX9LGQhLDygQ90/WXQWam2/TjRVcZ78WrRdoDXYmuefo3
 ZKXZmI+KDjaGrA+VXhDQlcyMPRLesw2Z1LlGR2ElwkEAxQZCh5LUpT+8GhIVbFNRSE2f
 jkVZufLq/UcQqZ9jQumWFi2ekP1vytoeJ0Yd+W3zHo6zDqTLY1b3DNUO0yFxhkGJ3uNj
 7Yde6Ou2XZX6HxezmSGCjNA2TWxOkrO0OlGArnTE9WhwwIkZfPp/vGJSL5V3GtsDBwla
 da1A==
X-Gm-Message-State: AOJu0YwmfRdVN3WiDt6laK5+Ds3kMvq9gBZ20t3zsnzZ/m8ZogzleKJR
 36HkR/TlPsIfNQFyl0I7hUA+VrCQNJTTnzaetjZ65xPdhxDKEpSSPR1L35MEDy9soqbTZUpCZBx
 DUWZwQVSNB7XrmXs1TgiOuo/xWL9JrLnR6+h1dZbyD0Va4CtS30jm
X-Google-Smtp-Source: AGHT+IGPyU/IsZ8ObccUM6pcuWejuJG+N0vmvuUcXxINFywGmol4lUAIfPJVPHLkg7ApC7G6qZd5mm8=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:37bb:5740:1ec:48f2])
 (user=scw job=sendgmr) by 2002:a05:690c:e18:b0:5d4:1846:3124 with SMTP id
 cp24-20020a05690c0e1800b005d418463124mr7627ywb.10.1702068600208; Fri, 08 Dec
 2023 12:50:00 -0800 (PST)
Date: Fri,  8 Dec 2023 12:49:49 -0800
Message-Id: <20231208204951.552837-1-scw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v2 0/2] linux-user: openat() fixes
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3eIFzZQMKCnsrbvfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--scw.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

Since v1:
  - Eliminate static buffers in do_guest_openat()

Shu-Chun Weng (2):
  linux-user: Define TARGET_O_LARGEFILE for aarch64
  linux-user: Fix openat() emulation to not modify atime

 linux-user/aarch64/target_fcntl.h |  1 +
 linux-user/syscall.c              | 47 +++++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 9 deletions(-)



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7201581FB82
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 23:18:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIyhj-0007Nt-Ca; Thu, 28 Dec 2023 17:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3IvSNZQMKCnUlVpZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--scw.bounces.google.com>)
 id 1rIyhg-0007Mz-R3
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:18:12 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3IvSNZQMKCnUlVpZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--scw.bounces.google.com>)
 id 1rIyhf-0007eQ-Ai
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 17:18:12 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5e20c9c4080so106460897b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 14:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1703801890; x=1704406690; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G3yL+/JS3JWx1cPp71KUfWtGLWSAB5UNwfPttx6LtRs=;
 b=ogBF+DBfWRC+ixf4IKrlnqzv7tVVTY70AhDd3vBNQUoypMWudCgKclX0X/SSomaIpT
 XDhQh/MXOz14XRcyOlu7RCYFEG3psx4tB1InolJ3os7187+bwj0/ua3FcrjGySarMIJy
 6NgILLsdCMOQ+ganzsLDG6MR+GtefCS1aQe2RUZmTri0j5ZMLsmQ2IwWd5f0D7NIei+2
 kFBSbG5FgSZAOFy7gfJY11Us/1fekTb2iwDoYzWYjTm2tGo+KqlnV84OM+wmXZjshuPJ
 6tqY3kyVSCpdB/ZJdc68zSlt8g+BMM9G8jurJ/XI9Wvxpv6wQ0oL1oIZdinUPFgG2ZJ3
 Eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703801890; x=1704406690;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3yL+/JS3JWx1cPp71KUfWtGLWSAB5UNwfPttx6LtRs=;
 b=Xhj5MSdBddiLXtNSrx5g5c22UUFbByi3VdJKH15j403Tbyli/lVza4Cp9LN1IVPkgS
 Te618rC2Gon37Zowvt5L9a5TsTLiTvETS6F+ZcQ+6qbrQW741oJo18jz19ZWDbWkys9n
 TE8Qulblg62/cNB2uqIKH4P42MonWivdOAmU2BV1wBYZAognyqiZR7ogUvyG8PHhDDzx
 fHWa0Fz1mCAyrZPvoqyss1pjg320b7vuKcxxekapp1nrT+TcHEy+HnuDvY9J7HYRMivK
 KTQMX3hathsUbo/ptxIyBTmd8OXtimxb9k2OyhUj1WV0IuuEa+EFV+SZ4vN8qz/15agf
 DD7w==
X-Gm-Message-State: AOJu0YwY7QUEdKKlcHYPj3QfGllZ3Q9vlYzknnoo7ivx+p+GelCw9CT8
 iFCtFkcpz5UpyfFTVYN3UGpk01fFhWN3NH1OGS9xDhUmprF/dsKyXvaVPyOzye0e3RrQdYW3efQ
 TndaPLKCXlY/lZ5wpcsFysbk49Vc+lQ8uJL3H9ziyf0d/tLTjbUXCJB6Tu/U=
X-Google-Smtp-Source: AGHT+IE4kfK+U8homqeMEqxsTWHO6hainghMcwR6jZdPLUBzulKR7ZhlTx+U/Rirwquwug7IOlIrXoY=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:ed19:b942:6cb6:d8bc])
 (user=scw job=sendgmr) by 2002:a05:690c:4493:b0:5e6:68a8:be40 with SMTP id
 gr19-20020a05690c449300b005e668a8be40mr5426507ywb.2.1703801890160; Thu, 28
 Dec 2023 14:18:10 -0800 (PST)
Date: Thu, 28 Dec 2023 14:17:58 -0800
In-Reply-To: <20231228221759.2839009-1-scw@google.com>
Message-Id: <20231228221759.2839009-2-scw@google.com>
Mime-Version: 1.0
References: <20231228221759.2839009-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v4 1/2] linux-user: Define TARGET_O_LARGEFILE for aarch64
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3IvSNZQMKCnUlVpZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--scw.bounces.google.com;
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

In 050a1ba, when moving the macros from preprocessor-guarding to
file-based definition, TARGET_O_LARGEFILE appeared to have been
accidentally left off.

This may have correctness implication, but so far I was only confused by
strace's output.

Fixes: 050a1ba69a ("linux-user: move arm/aarch64/m68k fcntl definitions to [arm|aarch64|m68k]/target_fcntl.h")
Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
index efdf6e5f05..55ab788a7c 100644
--- a/linux-user/aarch64/target_fcntl.h
+++ b/linux-user/aarch64/target_fcntl.h
@@ -11,6 +11,7 @@
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+#define TARGET_O_LARGEFILE     0400000
 
 #include "../generic/fcntl.h"
 #endif


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2227B71AD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkwx-0004sA-5G; Tue, 03 Oct 2023 15:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwk-0004qt-0N
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkwR-0004dJ-U9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:20:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5c91bece9so10445825ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696360813; x=1696965613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4OPqum188XMIDb5aXYhUEallrUuFRh7JykmjZpdIEEM=;
 b=Hj1DHvX+KcNr/tPdAjnac/2+A8qhRj49XVvxzfM2L9p9ETJJrcYkC+2YBif7WYiQVu
 qAExuIUAU3lZ95/EuVo7sgvG/3YTR2iX/NcJqeCwopMN8pmLA2QlSM3q+OY8tf9B4uo4
 eqELsh2G3FljkDl5lsFec+Z/+t5p8wk4FCcQT1FSZBUDW6sMvtY+LXcvhilLfxF2HfbW
 LTwSi09BuDODjYZNnQm24MlDggj4RLTfeASVtJLjqqKhkuJLnQVn4x7dqF++srvLgmyu
 JwhHm9zk3AW59fniDTFMRisdOkIBOpqVzSWowTNh15YmSNaZlfLYjnh09fGKRNFCbqFG
 Slfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696360813; x=1696965613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OPqum188XMIDb5aXYhUEallrUuFRh7JykmjZpdIEEM=;
 b=jusjQ3eev64ysh7mqL8zEGhudXJ3FZvwiFoN8JfEzdfIcgCTSDMNSG9iIRDO6rzx4A
 fLH8c5VfPOLa/z4A61xlWEVLXpJWVyFPvgICzxYZ90LL7nYqD/ex01hQBY5FZAvueEjS
 Av5aCxJwOhd1QnuYW9x6dswZof+fOHRWV2bELy1SUpDGhhNnIxLKeIgiiiqIbJMS5X2L
 2MbXvFf9ChxyrDgX5I4zSqCwSKpAxn8MDS0wIlZVEp4KyKe2idiOFlq32z+a3+pTv8O9
 q9lS/ny+YDPViV56kcgQnSGi0OfEjkstelanAAgRMvaJLBpLfZNEG260IMf5poFBVKDI
 oLNg==
X-Gm-Message-State: AOJu0YyaYNKflPId6gwquvP+KbhphuIxeL+hsomAEZ4jqHzXu0GdglHC
 rjYI1s7rc6WAEK0YHT9VlI9edFifa2iR9GpNfso=
X-Google-Smtp-Source: AGHT+IGqvYJzYVcx68HXqshlxTMBHr76xokl1LtKLQ0J2rsQlQo0J6ou9OquT19OqCTFDHO5X7IwcA==
X-Received: by 2002:a17:903:1c1:b0:1c7:61a1:9695 with SMTP id
 e1-20020a17090301c100b001c761a19695mr600981plh.20.1696360813487; 
 Tue, 03 Oct 2023 12:20:13 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w5-20020a170902d3c500b001c5fd2a28d3sm1978497plb.28.2023.10.03.12.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:20:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	deller@gmx.de
Subject: [PATCH v5 0/9] linux-user: Detect and report host crashes
Date: Tue,  3 Oct 2023 12:20:03 -0700
Message-Id: <20231003192012.1674888-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

More signal cleanups.  Mostly tested by temporarily adding an
abort, divide by zero, undefined instruction, null dereference,
within the implementation of a guest syscall to induce an error.

Changes for v5:
  * Remap guest abort, which means we need to try less hard on
    the host side to handle assertion failures.
  * Drop the backtrace.  Since backtrace_symbols only looks at the
    dynamic symbol set, we don't much that's useful -- we still
    need to use the debugger.


r~


Helge Deller (1):
  linux-user: Detect and report host crashes

Richard Henderson (8):
  linux-user: Split out die_with_signal
  linux-user: Exit not abort in die_with_backtrace
  linux-user: Only register handlers for core_dump_signal by default
  linux-user: Map unsupported signals to an out-of-bounds value
  linux-user: Simplify signal_init
  linux-user: Split out host_sig{segv,bus}_handler
  linux-user: Detect and report host SIGILL, SIGFPE, SIGTRAP
  linux-user: Remap guest SIGABRT

 linux-user/signal.c | 452 +++++++++++++++++++++++++++++---------------
 1 file changed, 296 insertions(+), 156 deletions(-)

-- 
2.34.1



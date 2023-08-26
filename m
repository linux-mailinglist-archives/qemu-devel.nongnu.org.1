Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004EE7899DA
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 01:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa2dw-0000Rs-Ic; Sat, 26 Aug 2023 19:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dj-0000RE-CV
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa2dg-00066E-Iu
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 19:24:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68c0d4dbc7bso1376050b3a.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693092258; x=1693697058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eehHozumwI8ErsQbkPO4g6WF7bsQGI9CHoJ/kmxPIfU=;
 b=T0DJfAGN0FiE9VdaKYGh+V+RpWLImS9gKb9FY+NKhrozJPzQuan9Jyfh7OI7YYRFe/
 CVYswtbjCRv50OPQLtlx8bViS5f88vofqYOGAsRcBy06npKA5rQjnM2N/OvptHV2zt1w
 aHYdu+3iVrqf9RsPeSXMRKHoT+K5jSJzrQM7B7hBCnqLVgGlXM4B6VLCADQvUsm98cT9
 adiib1fXwERvdCUlwM/tagyyNooTjZUM0sjwmdhxZxBV1wE54yhhub1FNxfI6h5RKAM5
 bD3L4zS0J5EdJ1RFH5MwgydaLH5bqU9Cjhd+SlkDpv4jSS77EvunKBz2fxiN0fxIOYR4
 ppjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693092258; x=1693697058;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eehHozumwI8ErsQbkPO4g6WF7bsQGI9CHoJ/kmxPIfU=;
 b=QsTRlbRa1oPlfKMqUNJNaHdxLdkxbgf0womoDtm3PRXZRlazFU4QRW4joARRt7xImd
 kXnskN7e4fs5WOWhDc2ltfK18/rrJbZG+8Y6RWBan4jWY1Ininc+3BjxlIlnwyWO7AVx
 DdWNcsFv8UM1lcGtpdUNTa67WXXEcbDL7DL8es+vv8NHdt3haf0vUNlgKD392UJpN4Ya
 q+uH9L2qowbaTn0rLxtmq5b3+7FkdZB4QfkADC5COrdJVhFtI8ZvCw/5ZBdtjIWNP2UV
 6tjqybvGYDPzypaU1u9ib343n+ARRsyUTAZTChdH+L6bC99viSE17Gt2KqFpAMw4pb/y
 SSlQ==
X-Gm-Message-State: AOJu0YwDXcentNyJNd53CgeXmnVdHk5oL7nPFNW0S4mlNy6V5Sv5utUL
 VVow8JoReV4jPdVCKGBG1rhE4LJxlurLW7Dp7Rk=
X-Google-Smtp-Source: AGHT+IFQMB/hexX6IcQEBfXdlXLosh61J6T3T9JoNxTYZh2ZM7N++IFnKPDecTYEwCQbDS3plVfnqQ==
X-Received: by 2002:a05:6a00:39a3:b0:68c:479:b4f with SMTP id
 fi35-20020a056a0039a300b0068c04790b4fmr7064618pfb.33.1693092258328; 
 Sat, 26 Aug 2023 16:24:18 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 u9-20020a63a909000000b005633311c70dsm4226472pge.32.2023.08.26.16.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 16:24:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	pbonzini@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 0/3] softmmu: Use async_run_on_cpu in tcg_commit
Date: Sat, 26 Aug 2023 16:24:12 -0700
Message-Id: <20230826232415.80233-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This seems like something that simply hasn't been updated for MTTCG,
since the last functional change appears to be:

commit 79e2b9aeccedbfde762b05da662132c7fda292be
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Jan 21 12:09:14 2015 +0100

    exec: RCUify AddressSpaceDispatch

and the MTTCG work starts to appear in September 2015.


r~


Richard Henderson (3):
  softmmu: Assert data in bounds in iotlb_to_section
  softmmu: Use async_run_on_cpu in tcg_commit
  softmmu: Remove cpu_reloading_memory_map as unused

 include/exec/cpu-common.h   |  1 -
 accel/tcg/cpu-exec-common.c | 30 ----------------------
 softmmu/physmem.c           | 50 +++++++++++++++++++++++++++----------
 3 files changed, 37 insertions(+), 44 deletions(-)

-- 
2.34.1



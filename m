Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AF67B702D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRI-0003Ao-TY; Tue, 03 Oct 2023 13:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRF-00035b-DR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjR9-0001Md-Qz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c737d61a00so9221995ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355038; x=1696959838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MlW5OvOtIJp4v6vHO2wYOYknyyk1hdgfS1cGeCkqVN8=;
 b=Js4wzRhoTk+BvemdQZe0rP1Lb3sTGmVTx4Aq2p1ZoSwx558JtszVmVauTCf1Rxf7om
 m5cLNC4oRQOO14oU5PmU0/+pxVdKmPgmsg3fSNF46sQ1Nw9/qiacLfQd6cXQdV6eIVK3
 sPn0raNLXV+xcxo/9KModb8uHrFhKtevAU3RUhTuAjdix1vtT15FS130yXi2hxLadf7u
 B9m6Fh0khHfxrBt2E4TZnaFWrQoVRo3MAdo9kjfuxJTa0FHqVrWKKMg5/h4DlMd6axn8
 rzpa7s2kRTTA+dSKmLhlF0TvpQQ+DvTDkm0lcM9mfMk0x5J195ZAvLyPHRzx7A/ApnbA
 XgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355038; x=1696959838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MlW5OvOtIJp4v6vHO2wYOYknyyk1hdgfS1cGeCkqVN8=;
 b=XtcFW5VuPAy5g9iO38pykOQEtNT2KEBI0z+yOFMo4cYJfYLNUDWgtnBHR/VmHeteOZ
 +XZZ28UC3trxcXuxjaK5dBK57xlE2lEO8Qjno3kdE1mJyEp7X3dWrjR6KRGMKvVwFqfI
 asTwrz4+un7ujVKn22Kpi91q253VY7DJgEAuj5+tNtImPoZrb2dwP7loE+eotySYUyoy
 sIsEuYlcfgtu+13FBCkpIMK6n2UeySxy/8gM6pn+z7DzTizgP6qDf2le8GCu3UTX0idU
 O5x8NVogVHO6bzxfTLJKDfoHb+6XmImhW6PcwTT/4r5k8/gE+32xSXJ+NFRm7biCXxKV
 cZpA==
X-Gm-Message-State: AOJu0Yz2pF+ONNiDgConAHy7HrMDuEA0ayQhp+VHUif7JbVyL8gstWqq
 EBh6nmdV4mHb4W2lqc8RZNGpBNiCWNC+g77aEis=
X-Google-Smtp-Source: AGHT+IGylJ7n3K4HWe+QKPz6625MiayAQ784qU6I4SuM9pGn27V77CLccHS9eHeotDhxZOwt3JxLbg==
X-Received: by 2002:a17:902:dacd:b0:1c7:54ee:c53c with SMTP id
 q13-20020a170902dacd00b001c754eec53cmr299050plx.57.1696355037998; 
 Tue, 03 Oct 2023 10:43:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.43.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:43:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] tcg: Allow softmmu for user-only
Date: Tue,  3 Oct 2023 10:43:46 -0700
Message-Id: <20231003174356.1602279-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Based-on: <20231003173052.1601813-1-richard.henderson@linaro.org>
("[PULL 00/47] tcg patch queue")

Introduce a global variable that can be set at startup to select
between softmmu and flat mapping.  So far the accel/tcg side is
not yet updated, so the new functionality is unused.


r~


Richard Henderson (10):
  tcg: Introduce tcg_use_softmmu
  tcg: Provide guest_base fallback for system mode
  tcg/arm: Use tcg_use_softmmu
  tcg/aarch64: Use tcg_use_softmmu
  tcg/i386: Use tcg_use_softmmu
  tcg/loongarch64: Use tcg_use_softmmu
  tcg/mips: Use tcg_use_softmmu
  tcg/ppc: Use tcg_use_softmmu
  tcg/riscv: Use tcg_use_softmmu
  tcg/s390x: Use tcg_use_softmmu

 include/tcg/tcg.h                |   8 +-
 tcg/tcg-op-ldst.c                |  14 +-
 tcg/tcg.c                        |  13 +-
 tcg/aarch64/tcg-target.c.inc     | 177 ++++++++++---------
 tcg/arm/tcg-target.c.inc         | 203 +++++++++++-----------
 tcg/i386/tcg-target.c.inc        | 184 ++++++++++----------
 tcg/loongarch64/tcg-target.c.inc | 126 +++++++-------
 tcg/mips/tcg-target.c.inc        | 231 ++++++++++++-------------
 tcg/ppc/tcg-target.c.inc         | 284 ++++++++++++++++---------------
 tcg/riscv/tcg-target.c.inc       | 189 ++++++++++----------
 tcg/s390x/tcg-target.c.inc       | 161 +++++++++---------
 11 files changed, 790 insertions(+), 800 deletions(-)

-- 
2.34.1



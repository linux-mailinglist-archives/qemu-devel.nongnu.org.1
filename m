Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0746977A6C0
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpy-0008HZ-2J; Sun, 13 Aug 2023 10:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpm-0008DA-WA
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpl-0000v2-C8
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso3127856f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935964; x=1692540764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1p1EbelIrl574LxcCV2hZyhTqJPEK2mCoLPeGMnT7c=;
 b=DUZ71VreAVvpRiotLDLvlSh9QqDkPUJ5Zhui1vg8P2oK/2Y8PMJQK2ppooQA0vHAwA
 uaEkzLgH4HGpfDX9dD8LDFravh1bE6A/+9uNjs1WpabuMyyzEyAVAg7sG3CWSjJUFFK2
 CqCChQKyXZJKSE4Wm9t9UObcMx0IPgTAZr7y0ZxO/rF+FocUdvzupC4ojjsUByH5dH3y
 +NKu8uaP1WYQkwLkH8yoFrz5KvY6ibr9RyHw6QvuUXjuql+/ZVs2whL8zbPeGdu1OeSv
 YItFmQZTZ7sOGyaXvKZh48svRNsvKyc0jcq2mdrTigybvuxd9etpzoQk6J32VQHV9PbI
 7NWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935964; x=1692540764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1p1EbelIrl574LxcCV2hZyhTqJPEK2mCoLPeGMnT7c=;
 b=RiooqLTarv3kd/YlvNT9kjVNxMynhZHLyti8Rz2eaRpWZYC4075ZZdJ6tkAYZLp0J1
 Tap8ZYtcM4MZQyQ7ne0Td8usujCQWMM33LzTOxtnMchlPFj6FNZTnZyUuUajcz0W7+AL
 AWG5ZGnKRc2aoJhqDiutt2qKgJj2EEhnMQUyGAvU2rbtWngLDBM/df3rvcwUvd6a6h6h
 IHqZvtlARYl+Soqpo+eqxethQ9EZs3ZE4jcoX4tO2WXsHEnoyTvLZpzT+lcC/jEk7Ptj
 0idS3VvAywTkjzPl4XybVo6ZSnt+7cV0TsvyGFm/zwCFDMMkJB5KJAaoe5jSFRQwNF8R
 FZcQ==
X-Gm-Message-State: AOJu0YxxHQfShCkoHuRFt4LCrz4Ma82DKUmwHSkPlprS08M6UdiJuJu6
 pY6s0+l+J6IsmMHjRN2sYdPZCPE+v4c=
X-Google-Smtp-Source: AGHT+IEnBDh1ebTz0kNS3/Y1dpTBDauyCs5K8A+afGjH3CubMwGrAzF6yIoANJfaAgXsWB4y2H1saQ==
X-Received: by 2002:a5d:6341:0:b0:319:6e58:7096 with SMTP id
 b1-20020a5d6341000000b003196e587096mr2234223wrw.66.1691935962427; 
 Sun, 13 Aug 2023 07:12:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 28/32] Add os-stat.c to the build
Date: Sun, 13 Aug 2023 05:10:09 +0200
Message-Id: <20230813031013.1743-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index f87c788e84..f2f047cca3 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,4 +1,5 @@
 bsd_user_ss.add(files(
+  'os-stat.c',
   'os-sys.c',
   'os-syscall.c',
 ))
-- 
2.40.0



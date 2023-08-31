Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC15978E4F2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY1h-0003XY-Fq; Wed, 30 Aug 2023 23:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY1f-0003X6-W7
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:07:20 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY1d-00012h-Ql
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:07:19 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso2570545ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693451236; x=1694056036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=5jv2+o/B1cTYH25aaMEaBjme7IEo1fF2dHAw0qWfKgU=;
 b=grqfwBIzZhjjMxNM9d6UIEixiKP5a0JYrsmB79gST6YYEVtL24XlrGVGl4a/R2sAv4
 kcSsebofVjcCszj7gAg5HgOeUhoNN+smkT3oHKD4bPAHx24D+ugNPuHvykOrVUEJ8u8c
 Ch3bOfjAVqlokbTKDO2xycVnXgQGEmIhE3Z7ChJeK6ggR7B2VxSxNAXAuYXsCDltyQKZ
 I39ckOpDEjQ9QQ/7tCZtRUi+/RmEfv59R+7ZAUKl802RY3hKfO3iYZ041gtfj2vlDjNQ
 2oLzlVwwkdz/xfWYhdnJcOV7AM0NjgtjEBloOCMq9BkLs++WoC4mowwO0Gx3RJ90AmQB
 S3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451236; x=1694056036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jv2+o/B1cTYH25aaMEaBjme7IEo1fF2dHAw0qWfKgU=;
 b=CkS74wRm2AYKcuMAWQqR4U5sIgN7XW50V3wSF2g6wtIWm9LoJsqtVlZnyjfGxlZI+t
 HH2W3vQLvGyHefybzEY6jPSbWKJhhLI02+lyhRo5dDnWw3YyeZp5SCu+3J4GhD1qyX8T
 9sVHPLOjfb0P9zNeT0G2VJibd9ObUE2hjRHm/2LLat7bHYH4E3u2Iwi/MAHrAf8vGlgy
 p5RIJuJmSKk0r7WezfYtU+ySU+Z9gn1EBN75SerQHCLggQabmG+FDLc3dIC+gnqxXU5r
 Zl9duQVwzZKXCuYY7kYeaYMNHKiA2eA5DF9Kx+NS4kxXsM2aP3KXdaNQrDSAHF4VNRHD
 FA7g==
X-Gm-Message-State: AOJu0YysNonpxSR1iFT1Ykir+B+cQdL2H/VSvvi/jbvNgkAo7Dmt5XDx
 gKt4RbQxzQPVqdGz17TasJ8Cah1v6DIgk+I0v/E=
X-Google-Smtp-Source: AGHT+IFkc3eLsiM3Ru15RoDGNxB9S130nCgjgEJVNNtwDlqmU0UT6GvU33b2WiPdbtX/+2DaEZb1yQ==
X-Received: by 2002:a17:903:187:b0:1bd:b7ad:a584 with SMTP id
 z7-20020a170903018700b001bdb7ada584mr5214542plg.44.1693451236227; 
 Wed, 30 Aug 2023 20:07:16 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 ju19-20020a170903429300b001b8c689060dsm228847plb.28.2023.08.30.20.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:07:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] tcg: Streamline vector load/store
Date: Wed, 30 Aug 2023 20:07:12 -0700
Message-Id: <20230831030714.1194595-1-richard.henderson@linaro.org>
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

We have tcg_gen_qemu_{ld,st}_i128, which can be used to implement
load/store of vectors to guest memory.  But at present we have to
split into, or concatenated from, two i64 to reference the guest
vector register backing store within env.

Provide tcg_gen_{ld,st}_i128, which can avoid the trip through i64.

This does require that the target store i128 in host byte ordering,
which is true of i386 (and some other backends) but not arm or s390x.
There is definitely further cleanup possible.


r~


Richard Henderson (2):
  tcg: Add tcg_gen_{ld,st}_i128
  target/i386: Use i128 for 128 and 256-bit loads and stores

 include/tcg/tcg-op-common.h |  3 ++
 target/i386/tcg/translate.c | 61 ++++++++++++++++---------------------
 tcg/tcg-op.c                | 22 +++++++++++++
 3 files changed, 52 insertions(+), 34 deletions(-)

-- 
2.34.1



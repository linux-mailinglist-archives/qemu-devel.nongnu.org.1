Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3440477E474
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:59:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHwC-0006Gt-3p; Wed, 16 Aug 2023 10:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHw8-00061n-JM
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHw6-0002Nt-67
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6887c3aac15so798962b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692197748; x=1692802548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zyqUCUHqfvIXDrMJ9hDoSMv/Q2I/y7hduUSvZh4AFh0=;
 b=PJZpGxxQ3Yfx9Vw3D3+bbaXRu13klBQmHtYJ+rC46pHJ98vMKnqh2wt9ZAQTANUvao
 C55IsbQber38zS8yuOEzIZM13W83y4EjcC2ZQ5mBhK+N0hWg7geIhOcCydjJ00KCVTVZ
 cM+3xQnh/DaS1SO6896ElGzOEyYzkoK7AYJCxZ4PYcKwlbGC+ke1+rU82+VvYS92/j/t
 NmI3Sc3l/f2XvL3ZX0YOw66njfcCSAULb6DIdjeF7idRjv2pWH/+y/um4tGBEUhh1rib
 xuV8n2yJ6w/mo/Ff3J6JcPfPx3fR54V1Gd9KF/RP/EJRaNqwFmccBFAamoSdfoZoZ9Ot
 3ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197748; x=1692802548;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zyqUCUHqfvIXDrMJ9hDoSMv/Q2I/y7hduUSvZh4AFh0=;
 b=JWDNuWH/Jlgq9KnTB0kzxVU5EcTqhX/iekGG2j6n3sisJmd2e4ZJctAGaSW785MrNY
 rooRvMuB8y5v8TivXpqNq6cSTbcSpKeDMPqxs/70jtZQ9jvh1pmXbY/6bngp+lZt3UMS
 GUOVimSRsCBPe9YfIUzzZoNgwCLXiJl7bBSxxhQe9/GPO0VSd7E0JpxWvEIG9sLTGhIN
 eAEh50ps59j10EQBIQf/ss9SrgwXmDwlycn1YifdjmXJ1paZeKtx37maxgVfbNl6Yj9s
 mGMc0FwYIRbu9QYO74TRNA2wSu3qVu7sqVUydSu3CU0DEH9FmsZ//9bTNL/qVKOL4A9c
 nIHA==
X-Gm-Message-State: AOJu0YwHr8dCSYIVZS6pRTuvlELssqN6SW5g7cDktTfmXrispg2AAe+Y
 jov59Fx1Q/49ZoaCwg3GN4G7x+BGc1q0l7MVKlg=
X-Google-Smtp-Source: AGHT+IH47UYtoLkeRCyS4S6KRdGE2PP924gsJ6KS4/3qReCUoaZDl5jDaeziYF32J8DIrEkPF7/+kg==
X-Received: by 2002:a05:6a20:7da1:b0:13f:52f1:fe67 with SMTP id
 v33-20020a056a207da100b0013f52f1fe67mr2870340pzj.23.1692197748592; 
 Wed, 16 Aug 2023 07:55:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 fe22-20020a056a002f1600b00682a0184742sm11619069pfb.148.2023.08.16.07.55.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:55:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tcg/i386: Improvements to deposit
Date: Wed, 16 Aug 2023 07:55:44 -0700
Message-Id: <20230816145547.477974-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Richard Henderson (3):
  tcg/i386: Drop BYTEH deposits for 64-bit
  tcg: Fold deposit with zero to and
  tcg/i386: Allow immediate as input to deposit_*

 tcg/i386/tcg-target-con-set.h |  2 +-
 tcg/i386/tcg-target-con-str.h |  1 -
 tcg/i386/tcg-target.h         |  4 ++--
 tcg/optimize.c                | 35 +++++++++++++++++++++++++++++++++++
 tcg/i386/tcg-target.c.inc     | 31 ++++++++++++++++++++++++-------
 5 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.34.1



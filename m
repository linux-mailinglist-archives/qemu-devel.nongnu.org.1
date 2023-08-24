Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7227878778A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 20:13:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZEpA-00067L-BJ; Thu, 24 Aug 2023 14:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZEoy-00066M-4l
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:12:41 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qZEov-0001js-JN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 14:12:39 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-564b6276941so15320a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692900755; x=1693505555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TxMphK1OinU6mx7AvenQI20mFtn8ziMDAb1dXUvtaNU=;
 b=tor6HsZxFlzqm9Q/6t3jidMccDB2CRAi8xmPWupzerTnJtC7sQVHSBbulWdQxWry7d
 huoYNKYWMNh/Me6dNxB7peCiNWvjns0QdW+VxfuJENYJnLR4EEtWO7UPHUhna/ONlQzx
 i6Uc1G3IKUxW8mXdkFP8INenJNUOQmn2O0XDpJVPEWNCBjg0QyPeNbaRxd4Nseg+30Sv
 a1qg+I5kvZG43bXAr7/clZ1KmfZoJ0Wnd+EDBTLLfFaPUhHMkhyrFE3IlUy7o5H/dCjv
 SVE4RILrSy8E/chbyno1rg5JyZOMNpOwpvDYCLlMGKsRrYbjhKx92iHMWH2pL3WtF8OP
 keRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692900755; x=1693505555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TxMphK1OinU6mx7AvenQI20mFtn8ziMDAb1dXUvtaNU=;
 b=F8PqAg+EHUHrn8N2nTpIP+1WG17OajHcy7hcKLON+U9Sg6WRhIpOuNH1S2ExjE9zeX
 KLt3saDETNwSHO+PA9Zw38CdV05NAJ2KUoGkeYcE0E+IsxaANUao90hKdRpX0LAGf7nf
 egUEyNICLJ/nKazaiTY6YG5nWet6gF6J9+l77/tdpNcIJLm45M9l4yBVUwiWbcBFyps/
 bw8IUXXaDAJKpYbOr9RWiLV+Rrlw+3rkSp593DkOk9acUWgfS/OQFBi13qFHgBBOurb4
 hB7LtcVRQxHsjZJ0HvCPy3YI3Qq8wqrtcFsl1hcSVnTE0Bdvpj+Kcw3goON5O6Tab+4f
 IvhA==
X-Gm-Message-State: AOJu0Yx/J9UXYrADunc76GTAKj3bBELPPGVEuQpc24oAW6JOt9hrQIBS
 yKi3E4lbLjMccFGe4+qS247iziguEM2FlYTjK54=
X-Google-Smtp-Source: AGHT+IFDMkA+fJITplE4Yeb/LKLU5Ee5zhMS/Y7SsbbOXYgaZYmPLLooiLpxlqz/K4ev6BFY9jqLwA==
X-Received: by 2002:a17:90a:420d:b0:268:1d1e:baaf with SMTP id
 o13-20020a17090a420d00b002681d1ebaafmr15845396pjg.17.1692900755323; 
 Thu, 24 Aug 2023 11:12:35 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:5418:3064:bd46:c048])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a17090ade9400b0026cecddfc58sm1880544pjv.42.2023.08.24.11.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 11:12:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [RFC PATCH 0/2] target/sh4: Disable decode_gusa when plugins enabled
Date: Thu, 24 Aug 2023 11:12:31 -0700
Message-Id: <20230824181233.1568795-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Alex, perhaps this will DTRT for your plugin test case.

r~

Richard Henderson (2):
  accel/tcg: Add plugin_enabled to DisasContextBase
  target/sh4: Disable decode_gusa when plugins enabled

 include/exec/translator.h |  2 ++
 accel/tcg/translator.c    |  1 +
 target/sh4/translate.c    | 41 +++++++++++++++++++++++++++------------
 3 files changed, 32 insertions(+), 12 deletions(-)

-- 
2.34.1



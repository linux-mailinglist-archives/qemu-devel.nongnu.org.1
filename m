Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A5784B82
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 22:35:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYY50-0002bI-0Z; Tue, 22 Aug 2023 16:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY4y-0002ak-MP
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYY4w-0005B5-GZ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 16:34:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a3236a414so2786846b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692736457; x=1693341257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vHFcmjcc+xFod4NZnYYYOVWxCUXpN8+UIY4f3jj8UbI=;
 b=XJingoqdVuaES0Cu36kEjTLa3Mfpo2H0I5K8ft8lmkU8NDjt1PvePVOP8SHcIK3PTt
 CZRauHC/MAz+tqUet9yazrxXNtvcJhT+h1nQqbpAYxc/ibUXqC2e5t8fw7NceWExB4us
 wYd7vRX3HlXffmEac5DB+b1vzam5RnFYEmIQSyc0Jhi20eXO72VLrhsoQ3wEPbp4ZnCo
 q5mEcNcd2CQtIbTIolu8ypdojEg7Yl2tWLIHv7Wn4OwX9od1dLrV4YFZGpCAx+j4xOY9
 xcgr5tPfyR4M+taIO97vbSxW+Q8wNQNce+I1RLAEaTMZzyhPPrpdVK2fcLyHg2u7TMrw
 052A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692736457; x=1693341257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHFcmjcc+xFod4NZnYYYOVWxCUXpN8+UIY4f3jj8UbI=;
 b=cwTE6fsvpTo94eCgkprhFbhtECAMX2uimG2SjqBMMc4mAtRxOPHqTHkIF9LlNp0jgS
 UdUyGNgeuskS7lZ/wqKXRCIjkH4VRESyjy3TcVjATOKdl70bnT+xph8Pgg+YoFvIsGdr
 QW2yYrRAe4NAoi0nTrZx0AifL38y+j4EgPp1zq3j0UHZqhOZK9fMjmWusYasOGjFAnYH
 YVEB6FSu6lp94Jmvj+V4azLNLZjHrlLqjpEKln0ltPRaSZxACG32pLtNP3WonClmkule
 TYL5ENvSU8rZp6st2rQsz6jNB4kTKXTwZEeqj21LwxdAJUsKYZWf/dSmY9xAItZqCInm
 Fzkw==
X-Gm-Message-State: AOJu0Yx5SBrhkKDsiL9u4tmgR8Dx7fNxNQXJplt2JYw74WUM/n03qj0H
 dWT2+gdEbmA22jlzA3w8yxLLXyhq4D90ctyCdeM=
X-Google-Smtp-Source: AGHT+IHv04FJIM8t7KUTA3h6ec7ZIGZcwixsdDwjXwUL3/TAPSR0yHBSYlQy9pouYUFy6lJQhcN5+Q==
X-Received: by 2002:a05:6a20:650:b0:147:ecf6:c4e1 with SMTP id
 16-20020a056a20065000b00147ecf6c4e1mr11427133pzm.27.1692736456651; 
 Tue, 22 Aug 2023 13:34:16 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 i25-20020a633c59000000b00564aee22f33sm8311823pgn.14.2023.08.22.13.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 13:34:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 0/3] linux-user: Detect and report host crashes
Date: Tue, 22 Aug 2023 13:34:12 -0700
Message-Id: <20230822203415.1184491-1-richard.henderson@linaro.org>
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

Supercedes: 20230812164314.352131-1-deller@gmx.de
("[PATCH] Fix signal handler to detect crashes in qemu-linux-user")

Fixes the issues I pointed out vs Helge's v2.


r~


Helge Deller (1):
  linux-user: Detect and report host crashes

Richard Henderson (2):
  linux-user: Split out die_with_signal
  linux-user: Exit not abort in die_with_backtrace

 linux-user/signal.c | 106 +++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 30 deletions(-)

-- 
2.34.1



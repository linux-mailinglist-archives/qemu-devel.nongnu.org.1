Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774867922B9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdVKt-00033x-9v; Tue, 05 Sep 2023 08:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVKq-00033h-6o
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdVKn-0003TV-W7
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:39:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so24589945e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693917548; x=1694522348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QKZuOwWHX/Y/0n72ulQF5W3vLIVvN6KyH48iJki67Jw=;
 b=hDMQCv9W8EtC4oCwYm0bbrma1IWRh/1k6G4belweurg37gtpQG8K4tJ2L/UvKNQbLo
 UTLY7wN6r5tUyeJBxemeg1+rQqGdMtofEoGWU3SGWIpHBEqGvHa/rNFxKH1OK9oafuaz
 spKhZinX6b7P7iXsma7b+VvmD2cK0K8qSu9L5RBuzL8M7WC549f4MXPe6ASDYGzTc7H0
 ENPmhohnoavu+zxQEPkNEpk3oaSN658yiAo6fDpPR8QMCUy+kcetayZ6/imNVI8eaQju
 wpBaiG+7tvb3978c7eg0Yk3gOV3Dep3ol1PoRIvWD8oo19AhA4hheLeWY9v2gTL24+4N
 d7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693917548; x=1694522348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QKZuOwWHX/Y/0n72ulQF5W3vLIVvN6KyH48iJki67Jw=;
 b=DrV+z9XeLK06//YeacN1ZkPeL34UVkL7Hz4sRKeqvgETn73dvkyPDaLgyUxNOigdKP
 sO9cWrngTPGjcD429fUmUhdurAO9VD9zgqc3XODj/L1XVR3jYipp1s1EJG7b1xYU4vlf
 zoHrQcV0nLBEmKHI+i+kzgGsTy0rUj7J2XVq1KMwDP6ibVZ6Iyog1w+V2rQDoFvTtCKK
 GaDxt4j/qLtyMBOMhmRQt+vPPzGbXf/oPIgd6QGV9t4QWg5FR+6te7onEF29MvOD5elo
 bY0ixgEtyOsqeH85by2WJHyEUTdsmumxfHj9g/c6EZa9i2cPNMtpRd9+vto2xdUSWBoz
 W5Gg==
X-Gm-Message-State: AOJu0YzmlMvQAvjofDOez19fpSNUJebgMACjjeyYl6DEQm2CcUohOu+v
 epnxsseN8R+EnVK6QsVltXpvJfVpGKuM/0bUWpU=
X-Google-Smtp-Source: AGHT+IFCpQXZn+22p3bRJCmALwj5FNG4unTm241xAVV9n9/G3dww52UEKKpPMN2pyutXaTVdul0/HA==
X-Received: by 2002:a05:600c:b58:b0:401:aa8f:7570 with SMTP id
 k24-20020a05600c0b5800b00401aa8f7570mr9116760wmr.1.1693917548121; 
 Tue, 05 Sep 2023 05:39:08 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a5d54cc000000b00315af025098sm17421121wrv.46.2023.09.05.05.39.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:39:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] sysemu/accel: Simplify sysemu/hvf.h
Date: Tue,  5 Sep 2023 14:39:04 +0200
Message-ID: <20230905123906.6880-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Trivial cleanups which simplify "sysemu/hvf.h".

Philippe Mathieu-Daudé (2):
  target/i386/hvf: Remove unused includes in 'hvf-i386.h'
  sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86 targets

 include/sysemu/hvf.h       | 3 ---
 target/i386/hvf/hvf-i386.h | 6 +-----
 target/i386/cpu.c          | 1 +
 3 files changed, 2 insertions(+), 8 deletions(-)

-- 
2.41.0



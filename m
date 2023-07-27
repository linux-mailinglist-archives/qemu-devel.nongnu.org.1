Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7B76606C
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 01:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAV3-0008S1-TQ; Thu, 27 Jul 2023 19:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAV0-0008RC-DS
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:26 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qPAUy-0001D3-FA
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:34:26 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso2548571e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690500862; x=1691105662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PAJsXMjmi5UE49MX6yiwGG8bG/5vYFEG3sGt/otEiE4=;
 b=GRI2g6jsSOgdqzYC7N8eU4vU2GxH9VkUcxWs7XqS2sgWKpkRzPbSmVRrWKlElLVwnn
 YwSZ3S3kksRUdvPC/Lx0d+SGdrHi0zrtBdlkHXi+757iSZM969+3aRaRHvNp2upJ8lvG
 ThxABjy48s/StGCULJmzpWmYpy3RfOiiS5aNz8ZEIDsUW4e2H3ebi+SRrfXEQFbhHg9+
 U60WfIHKHDzf9agNtV3bSJNM+n2sIXJOa3unqo5AzQGK1jcA6jIIFtMwj6hdG6g/SdoU
 ojLlN/Xga7dbJi8GASgbmIJS2guKmdMBNgwUTQaD47d5+VbWYYL+WuAmwSR3rN9PAtGt
 kXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690500862; x=1691105662;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PAJsXMjmi5UE49MX6yiwGG8bG/5vYFEG3sGt/otEiE4=;
 b=PO2xB8lpxxXassz7Hjd0NKSgJ/ZCgvv1KO4h9ZHYAgS9ksOuV1sFd+/KoGQGqCwPvg
 j/6m5JZEFN88DcSrCCpgpJY2CEE/6lwlLROKNC8pV72HMReClyT2Lv+1mG3cs2FfbW+F
 Kwf5HO4aMD1K/MqFj4mbFoinFErVbA0SfvQ+OGjyUPq1UaZFx94aYCVQeHrC7Q+dECza
 Q1P+Low4HPvPCebSFRkEfw9eF5hFkhJO/pzoAPiLiZZ3fErFvkzhu/Tyl8UQf6FoedPj
 HjytSAL8VcaTStglcbZ/eGVdTWn2GUFEqFaQwphQ6MeYHIlaVRZCF2xNg3e7wjkCM27A
 iw6Q==
X-Gm-Message-State: ABy/qLZ2dSovlXDG64yz6+lR58upFjQIC4ein1/y9jUeODJ1vXZejMIO
 thBwiicXjHoGM43lDvN6MCTlvUZfi+wOWg==
X-Google-Smtp-Source: APBJJlGXNwHOf8v4VEdfPe8IsJv40or6HKGX9OWY7st8sdXB/wdu6wSsmPCCcuZslMdTCNo/c7PX5g==
X-Received: by 2002:a19:e044:0:b0:4f9:6528:fb15 with SMTP id
 g4-20020a19e044000000b004f96528fb15mr399598lfj.12.1690500861597; 
 Thu, 27 Jul 2023 16:34:21 -0700 (PDT)
Received: from localhost.localdomain ([185.9.78.206])
 by smtp.gmail.com with ESMTPSA id
 h16-20020ac25970000000b004fe0de39fddsm528241lfp.290.2023.07.27.16.34.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jul 2023 16:34:21 -0700 (PDT)
From: Mike Maslenkin <mike.maslenkin@gmail.com>
To: 
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, stefanha@redhat.com,
 Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: [PATCH 0/3] hw/ufs: fix compilation warnings
Date: Fri, 28 Jul 2023 02:34:02 +0300
Message-Id: <20230727233405.35937-1-mike.maslenkin@gmail.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patchset contains a trivial compilation fixes for UFS support
applied to block-next tree.

Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Mike Maslenkin <mike.maslenkin@gmail.com>



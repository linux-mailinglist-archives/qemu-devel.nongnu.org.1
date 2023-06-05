Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA1722DCB
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6EDO-0007sl-Ub; Mon, 05 Jun 2023 13:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EDK-0007s8-IY
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:41:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EDI-0006QP-AN
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:41:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4dffaso44827625e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685986910; x=1688578910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fc1je/dmcmZqzQTdqWWAuG19Gsj/2MphL3YckDyog2s=;
 b=SWqXK3Pfazm5SWexxGrs9ZFFkOYjnHg2LccfYTDIhL0XQsmDjTEUG4Dl2F0iuxjlBZ
 /dBF21ffMVLihfecWZYfkSH1HQTD9PJvJO/Q04Q1lZTWtPamGopIBnQfeNOLRVRtaNfD
 fkgwAeNubGQSuEUT4qba/nSbyRSCqozxG5I3LrA9Maq/27iE8sknPSwpSDB3Sze4nHus
 Q++9LI1wNuwTSBHOMtZHff1ercfyA5Nv6/xZBDWu8NN+S3WgIlgMhAhd5koxylnFS4oh
 u8g8G4IMl54+O3UjS7ciFqjWY56gRk1cgw2Q5zunjyH4j0p3A33t2MdTCtYYZlXxvj/I
 BHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685986910; x=1688578910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fc1je/dmcmZqzQTdqWWAuG19Gsj/2MphL3YckDyog2s=;
 b=Stj2LdHB5Vj39aTO/zGFdSMF3dn7WfQ+7cm4GDzkikTNJwWCLIKTJXSsymzzyxXe1m
 BHiqJqwRpS6K8yRODJcHaVC2HCveKw91+UwZkfwIezyaGsXosIGAhtAWa4Gv7sf25Cmh
 rMMZO/9ITx9kVbtzgOC5I8xJvq9PH5rQwvPj9+SfWIk/vmsCkuVP0RiDOBlp2povlW30
 8E913Dh3h6HI/MVFoOA9e+2ljSsFKbmu9X8zAvsj9znaXpWT2yF93zVShAG3HP0aJRZd
 tKLBudfowcvHfnSOwy4z22jK0feZh2+kj96IlkDClw22wlUvzI60rnH323Q4oyDrDjuN
 UX1g==
X-Gm-Message-State: AC+VfDzDYE4/r3b8W8Zm1dc3rl3RLZSDPPgnNFzDIMKDGjP7UBToXMbO
 2PR26kwXrW2JAyC91Fg+wCnG0a+E9rAmurm6mVM=
X-Google-Smtp-Source: ACHHUZ7rw+A3MyAMHzSXoHSaBiLCNvIdL1oRYpCNmAYSbTtDAbFB+71c3a9mVheN55/a384oVRLU5g==
X-Received: by 2002:a05:600c:24cd:b0:3f6:11cb:4926 with SMTP id
 13-20020a05600c24cd00b003f611cb4926mr7738853wmu.22.1685986909971; 
 Mon, 05 Jun 2023 10:41:49 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a7bc8c4000000b003f7e717c770sm1970283wml.23.2023.06.05.10.41.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:41:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/2] scsi/qemu-pr-helper: Drop 'old' lib and use default
 config helpers
Date: Mon,  5 Jun 2023 19:41:44 +0200
Message-Id: <20230605174146.87440-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The 'old' lib check was added for CentOS 7 which we don't support
anymore.

We don't need to implement particular [get/set]_multipath_config()
helpers: use the defaults.

Philippe Mathieu-Daudé (2):
  scsi/qemu-pr-helper: Drop support for 'old' libmultipath API
  scsi/qemu-pr-helper: Use defaults [get/set]_multipath_config() impl

 meson.build           | 19 ++-----------------
 scsi/qemu-pr-helper.c | 18 +-----------------
 2 files changed, 3 insertions(+), 34 deletions(-)

-- 
2.38.1



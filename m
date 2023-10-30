Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 891327DBBF8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:41:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTRC-0001NF-8q; Mon, 30 Oct 2023 10:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTR9-0001Mz-KE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTQz-0001bh-NH
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so33348025e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676802; x=1699281602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=niBNf+TyWYzsuNRRJa73BCYeP8vLtDybQJD3Qrkr9Dg=;
 b=jX2YcC4PdnWAWgu3x58Rkdq1VbdTlEyPEtZ3jKLCvgsk9bJfA4va/5oCCq8sssNVcr
 Y+dDu0mUpLZ9ImnZapcIKQ0JuZxFkdHd6eXovEc5Ad/POPmlxX6nbKCe0Kuq0ksmtA/d
 G8CUmW/sthG1Kb4kJ12Ah4FgplXf8sx2nqLVJD4XFus5re36/nO4rtJ9AzwUPlQwFYS1
 abKoRZULdAgmU7RQeOUWmOrH4zEbxT7jq0A4BuczfpnhpPWBX1X/b77pagvduUVGqI+V
 srE+j5kxkjRkSMVNkHFe0dDDnfWkIiCclltjx0UL7VtdQSWyrQenr9SCT2MjcOEqYeHP
 S9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676802; x=1699281602;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=niBNf+TyWYzsuNRRJa73BCYeP8vLtDybQJD3Qrkr9Dg=;
 b=Dm38+jEidSZjvw64LYEloLoGIKq42vNlDMvBeJu0BUv2m4a2N8hhIErWtPzuLztLdY
 YIrLqgmOSqryPWujZRJ8B2VEIDXQId61FjyOc3QxK26omfywdIWiM9b0jUwK6OznFkpp
 UNMF8OhHE4kVx/m5mROoeZ1oTDlSRszTb3PhpmBJuvz1lD8bxmwRvnJ+urJvttcQQLRW
 xbOY9BP2QpFbLA1OqfrolVycDc+5RUSzagO4sh4znQwcnrFPDS1TFLj9TXP2is7vuRvp
 EdDNBw76m9CAhVRvhhakGJbMQVz840NaApFDKEh9m4owcVryjjdV4NoVLgDM8B0cBLr8
 gXlA==
X-Gm-Message-State: AOJu0YwJMdbuURM3mdZnPkvZeiHUvE5aWuQXKfgQeUz6tPsK3AUkalwb
 AzEXEN3owIRr2XoZJNVDZeqRd6A1ZSpqfTHhodQ=
X-Google-Smtp-Source: AGHT+IH/E9TzuBtqXEDhpX6K6nTL/AY8Ajp6zVHe75+jCc7Of+LXy0IkkQ9wFGFjaWBaETqp+PnuPg==
X-Received: by 2002:a05:600c:46cd:b0:405:3dbc:8823 with SMTP id
 q13-20020a05600c46cd00b004053dbc8823mr9051179wmo.12.1698676801546; 
 Mon, 30 Oct 2023 07:40:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a05600c314a00b003fe1fe56202sm9423258wmo.33.2023.10.30.07.39.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 07:40:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/5] hw/ppc/e500: Pass array of CPUs as array of canonical
 QOM paths
Date: Mon, 30 Oct 2023 15:39:51 +0100
Message-ID: <20231030143957.82988-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Following the discussion with Peter on my "cpus: Step toward
removing global 'first_cpu'" series [*], we now pass the array
of CPUs via property. Since we can not pass array of "link"
properties, we pass the QOM path of each CPU as a QList(String).

Tagged as RFC to discuss the idea of using qdev_prop_set_array
with qlist_append_str(object_get_canonical_path). Personally I
find it super simple.

Regards,

Phil.

[*] https://lore.kernel.org/qemu-devel/CAFEAcA9FT+QMyQSLCeLjd7tEfaoS9JazmkYWQE++s1AmF7Nfvw@mail.gmail.com/

Kevin Wolf (1):
  qdev: Add qdev_prop_set_array()

Philippe Mathieu-Daudé (4):
  hw/ppc/e500: Declare CPU QOM types using DEFINE_TYPES() macro
  hw/ppc/e500: QOM-attach CPUs to the machine container
  hw/ppc/e500: Inline sysbus_create_simple(E500_SPIN)
  hw/ppc/e500: Pass array of CPUs as array of canonical QOM paths

 include/hw/qdev-properties.h |  3 ++
 hw/core/qdev-properties.c    | 21 +++++++++++
 hw/ppc/e500.c                | 11 +++++-
 hw/ppc/ppce500_spin.c        | 69 ++++++++++++++++++++++++++----------
 4 files changed, 84 insertions(+), 20 deletions(-)

-- 
2.41.0



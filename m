Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7128392F3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:36:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSIoT-0005qv-3q; Tue, 23 Jan 2024 10:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSIoN-0005mM-Kx
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:35:40 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rSIoK-0007Bq-Aq
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:35:38 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2cf16f2445bso6106341fa.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706024134; x=1706628934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s/J4tsLSL0aEqtuj8VgaeQb+iNRarLVsTDjDI3HEwpE=;
 b=dOAlUBFG6SJQNOTJbVOLHNcngOg/FYtTLXkW94bZ3XoKxQ5fZ8PSy0KPSb7z69ydGc
 RhzqN3aTWhttkKO4+Du9Wl8b4fsJv/aRXKtpQqv710Auqr7yO9POyflDQXGIM0thELWJ
 210m1IuX2MfFEpZ60lL0ayvSSy+E6BuEhYGYOz9kphibsIQs67T4Dnno6IVq8faNZWCb
 YAsdCQj6H08g067teoG8M9+Bs4/WIl8cmqBzpAM8km/iI4TaZUJVeanBkalMLqIs7Rc5
 ixoygIymsgdRWcAAH2a6Qn4GuiDp6ak5rGpPurUV7BIJHMwa1YooFxqjWXWybPhpH2fH
 AehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706024134; x=1706628934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/J4tsLSL0aEqtuj8VgaeQb+iNRarLVsTDjDI3HEwpE=;
 b=otnp7nw0G2gPoAm5ftId4/wZWPKVHU3D13Mxr7PF0HXkg7IqqhDks1I4NOPxDRegvr
 GfJCfrHFfJUKLGJ0rIHmXhh1N/SoIYKT7RvXFS9K8zekDTCe72fZmswftOWdCVuypWjh
 TDwCPZNirZLkM515nvvyna2KBlj/vsO7qGk/fBPNDk7v3YzhKu4DB5W6NptG36QL2VzY
 sD7Wq6HBtKduXUkujF2RGZEkM7vLwvFeuClXufd1Yn3GKLh0Muryb3o2SWgY/VzNrdmy
 zij+uJrg4mwtH+pYsuB92hdA3GyBL4dLtKfIs+Gxii1Nh48iMvshxWE9RCYOj/k6S+dn
 1dDw==
X-Gm-Message-State: AOJu0Yxdo4jt7DmFeQelobsu0qe+selwIuLeYlYs9KhZaXplj2uYSoni
 BiMWsgG3RptoVVJWfuoa6QN/81tvaHao9d+Z3h9i6Mgvm6vrXHE4hb0nfbIyNOW9U+zZKJ/mt14
 IwGA=
X-Google-Smtp-Source: AGHT+IE7wDUK14d4B6VvwaJZNFM8y9U/agebZrxCstIlWfm+n+U0q/VVG9hpIONRnVDVF3WlYuz1hA==
X-Received: by 2002:a2e:3618:0:b0:2cf:1174:44a with SMTP id
 d24-20020a2e3618000000b002cf1174044amr707701lja.13.1706024134114; 
 Tue, 23 Jan 2024 07:35:34 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 cf15-20020a0564020b8f00b0055c903e61easm484663edb.82.2024.01.23.07.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 07:35:33 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 0/2] hw/block/block.c: improve confusing error
Date: Tue, 23 Jan 2024 17:35:29 +0200
Message-Id: <cover.1706023972.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In cases where a device tries to read more bytes than the block device
contains with the blk_check_size_and_read_all() function, the error is
vague: "device requires X bytes, block backend provides Y bytes".

This patch changes the errors of this function to include the block
backend name, the device id and device type name where appropriate.

Version 2:
- Assert dev is not NULL on qdev_get_human_name
    (thanks Phil Mathieu-Daudé <philmd@linaro.org>)

Manos Pitsidianakis (2):
  hw/core/qdev.c: add qdev_get_human_name()
  hw/block/block.c: improve confusing blk_check_size_and_read_all()
    error

 hw/block/block.c         | 25 +++++++++++++++----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 hw/core/qdev.c           |  8 ++++++++
 include/hw/block/block.h |  4 ++--
 include/hw/qdev-core.h   | 14 ++++++++++++++
 7 files changed, 44 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  15b15d6d4f ! 1:  5fb5879708 hw/core/qdev.c: add qdev_get_human_name()
    @@ hw/core/qdev.c: Object *qdev_get_machine(void)
      
     +char *qdev_get_human_name(DeviceState *dev)
     +{
    -+    if (!dev) {
    -+        return g_strdup("");
    -+    }
    ++    g_assert(dev != NULL);
     +
     +    return dev->id ?
     +           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
    @@ include/hw/qdev-core.h: const char *qdev_fw_name(DeviceState *dev);
      
     +/**
     + * qdev_get_human_name() - Return a human-readable name for a device
    -+ * @dev: The device
    ++ * @dev: The device. Must be a valid and non-NULL pointer.
     + *
     + * .. note::
     + *    This function is intended for user friendly error messages.
     + *
     + * Returns: A newly allocated string containing the device id if not null,
    -+ * else the object canonical path if not null. If @dev is NULL, it returns an
    -+ * allocated empty string.
    ++ * else the object canonical path.
     + *
     + * Use g_free() to free it.
     + */
2:  e3701762ed ! 2:  8e7eb17fbd hw/block/block.c: improve confusing blk_check_size_and_read_all() error
    @@ Commit message
         This patch changes the errors of this function to include the block
         backend name, the device id and device type name where appropriate.
     
    +    Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
         Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## hw/block/block.c ##

base-commit: 09be34717190c1620f0c6e5c8765b8da354aeb4b
-- 
γαῖα πυρί μιχθήτω



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EF282A345
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNg66-0001hY-Em; Wed, 10 Jan 2024 16:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lAufZQcKClsDHFEH6B9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--komlodi.bounces.google.com>)
 id 1rNg64-0001hJ-TD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:48 -0500
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lAufZQcKClsDHFEH6B9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--komlodi.bounces.google.com>)
 id 1rNg63-0000zr-D0
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:48 -0500
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-1d542680c9cso25528005ad.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704922004; x=1705526804; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dU+hTjFQki9V+zYCTqhEgkrtvsU2lL19PVTCNmmDEhc=;
 b=iAiSiDYAF6pA8ymHZEDFq27AXcQDQKNnCPqrPVXxiZHDtuvTt+LLzau5blgv53zj3r
 qz/JeHJhlrB3JDu4EPuwc3plPg3VqWGYxnrXHrtm6RKv0me2if0qYdZ5K1IfiRito2xT
 wkjDSUYnD8mycWeeIYNx1Lj5DJkCxZZcn34pPnr/0IOZnEOZmmn74nESo9GeY7gHcMcb
 ZV50UBwGGt6iZAPwJ3t0hFtzV+fm/nHYJImA+He01dkYY+6sIK2h3gCz/7MDD3i0HdM8
 E1/zEGqO31/ZA4rrJRAs5zGKrwDoxhkrGkn6x68Ja1fogkO3PxQ2O3icRpuTDy+6SW4e
 0f6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704922004; x=1705526804;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dU+hTjFQki9V+zYCTqhEgkrtvsU2lL19PVTCNmmDEhc=;
 b=QmcIrayVnIGSGe80KA1zZRCqALzuM10aYqjWBt8ZNr71o4+EgtYtmp+dnW9sosUstb
 ExOUNJCRadjQxH4GpRmEb375tyukMOR4IWjW/zDtMNVl2caatnZF6SjiGH7opy0iccnU
 MfX08R1Rt4gFk4zmzBOW5L9GsJkDHVJpp3roUqxxXxbReaZRrnmyRrhWJ9CX/VKjtUkk
 nPaj+Bw26qyztAlRZ6p9vGA+HRAXmbdPccOw0PWSaA4gpkP4D6LZzMMHIEwrnVG89nYh
 eDPWRjx3x7Pd37KxbIS2Jsz0Z5kD33gOIDaJ0EsninkUP1pqBeT9fZEnl9K26jQTERbv
 uWPQ==
X-Gm-Message-State: AOJu0YyFXXKkDxBhgr+UA+idQuTB39S8JPMVKOP84Bz1SHEfnm8NjhtM
 PR+AL2NinSZBMf4VsM9tlGQZF6et4rJWxN0H70zCoMZ3TMAcFmH0D2NEQDxwlm1mpyc8f56dx5t
 0lMPHZiBkOxYYgUIkcL3kLx8ROhQvuAX7f2mLdYe6JeHf9SmODqDDSlNkTPY6J0npnKBRoQ==
X-Google-Smtp-Source: AGHT+IHkdCvDZhQSdh+rO27mmFMzCzurJ510AxOIWdLDrhsCX/edjA/SyO6NF7gsTWpwdEuNQfFUKCFAa01b
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:902:cec3:b0:1d5:72f3:e310 with SMTP id
 d3-20020a170902cec300b001d572f3e310mr809plg.2.1704922004154; Wed, 10 Jan 2024
 13:26:44 -0800 (PST)
Date: Wed, 10 Jan 2024 21:26:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110212641.1916202-1-komlodi@google.com>
Subject: [PATCH 0/4] hw/i2c: smbus: Reset fixes
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, cminyard@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3lAufZQcKClsDHFEH6B9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi all,

This series adds some resets for SMBus and for the I2C core. Along with
it, we make SMBus slave error printing a little more helpful.

These reset issues were very infrequent, they would maybe occur in 1 out
of hundreds of resets in our testing, but the way they happen is pretty
straightforward.
Basically as long as a reset happens in the middle of a transaction, the
state of the old transaction would still partially be there after the
reset. Once a new transaction comes in, the partial stale state can
cause the new transaction to incorrectly fail.

Thanks,
Joe

Joe Komlodi (4):
  hw/i2c: core: Add reset
  hw/i2c/smbus_slave: Add object path on error prints
  hw/i2c: smbus_slave: Reset state on reset
  hw/i2c: smbus: mux: Reset SMBusDevice state on reset

 hw/i2c/core.c                | 30 +++++++++++++++++++++++++-----
 hw/i2c/i2c_mux_pca954x.c     |  5 +++++
 hw/i2c/smbus_slave.c         | 20 ++++++++++++++++++--
 include/hw/i2c/i2c.h         |  6 +++++-
 include/hw/i2c/smbus_slave.h |  1 +
 5 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog



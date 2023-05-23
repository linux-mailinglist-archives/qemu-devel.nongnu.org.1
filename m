Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA270E41F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:06:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WO9-0006qK-MG; Tue, 23 May 2023 14:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1WO6-0006pC-7J; Tue, 23 May 2023 14:05:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1WO4-0007Qa-Ki; Tue, 23 May 2023 14:05:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E6A51228C4;
 Tue, 23 May 2023 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684865129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rubn4y2VxTZNjvxZ18t8B1AWaqKVCWyagyFyjHMSmSc=;
 b=NVms8bxItmMKnIIWADhXkRxe2at3DC3jGxM+sWTvU1d4jSj3ghjdWgOoA8S4mTx+tKDYvz
 7OozPhMDPFylja1ZSqYGYI++rawrnyvVaCq4FpY6dw3VBHYTuvQSXlyDgFh4KRXxgfxAtu
 Y1HQpczbzQGd5R8ucBZ2pU2RD3vpSo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684865129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rubn4y2VxTZNjvxZ18t8B1AWaqKVCWyagyFyjHMSmSc=;
 b=dY0hX6eGPhwaYIGunKSGcKyLvLVSaNX8TBVCzfBs3uUCpA4gjNSQawiXWCLYJOpCvqN0xF
 Gv6xZBXW1YQ60eAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B6FE13A10;
 Tue, 23 May 2023 18:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ze8GNWcAbWQMQwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 18:05:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 0/3] arm/Kconfig: Some convenience changes
Date: Tue, 23 May 2023 15:05:22 -0300
Message-Id: <20230523180525.29994-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

These are some changes that people asked for/suggested during the
review of previous Kconfig series that I haven't had an opportunity to
prepare until now.

CI run: https://gitlab.com/farosas/qemu/-/pipelines/876384304

Fabiano Rosas (3):
  target/arm: Explain why we need to select ARM_V7M
  arm/Kconfig: Keep Kconfig default entries in default.mak as
    documentation
  arm/Kconfig: Make TCG dependence explicit

 configs/devices/aarch64-softmmu/default.mak |   6 +
 configs/devices/arm-softmmu/default.mak     |  40 +++++++
 hw/arm/Kconfig                              | 123 +++++++++++++-------
 target/arm/Kconfig                          |   3 +
 4 files changed, 131 insertions(+), 41 deletions(-)

-- 
2.35.3



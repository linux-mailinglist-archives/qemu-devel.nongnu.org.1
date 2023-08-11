Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E337787D9
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 09:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUMFY-00048y-5I; Fri, 11 Aug 2023 03:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qUMFT-00047k-0P
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:07:52 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qUMFL-0008Hg-2a
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:07:49 -0400
Received: from pasha-ThinkPad-X280.lan02.inno (unknown [188.162.65.26])
 by mail.ispras.ru (Postfix) with ESMTPSA id ACB6740F1DF7;
 Fri, 11 Aug 2023 07:07:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru ACB6740F1DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1691737655;
 bh=vAvIaNRUqu9NGrp3ckaGr/N9hJOEIPzeCwm1CSPW9P0=;
 h=From:To:Cc:Subject:Date:From;
 b=VMjYIA2ctE8+lUnmo4m0OBa8/OmBfKI5cZ4sRCjCdQXfymmXUjKxlJAG6MZQNqkav
 aUub+o++9zMs3R1T59uFcd9gmVP79rT4vObXUsyEkIsWmsK2WSw80OYltprhzdnekv
 3mp6Tyy64H+XKqgo74CX0WvHCjtvY+QwrIEVbDY8=
From: pavel.dovgalyuk@ispras.ru
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com, rafael.pizarrosolar@epfl.ch,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Subject: [PATCH 0/3] Record/replay patches
Date: Fri, 11 Aug 2023 10:06:05 +0300
Message-Id: <20230811070608.3383343-1-pavel.dovgalyuk@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

The set of patches include the following modifications:
 - fix for allowing record/replay with virtio-net
 - fix of the record/replay test

Pavel Dovgalyuk (3):
  replay: improve determinism of virtio-net
  virtio-net: added replay blocker for guest_announce
  tests/avocado: fix waiting for vm shutdown in replay_linux

 hw/net/virtio-net.c           | 13 +++++++++----
 tests/avocado/replay_linux.py |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.34.1



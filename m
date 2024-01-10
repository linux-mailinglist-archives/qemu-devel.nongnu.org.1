Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 623F8829405
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 08:10:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNSiz-0006H4-SE; Wed, 10 Jan 2024 02:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSiw-0006Gq-9H
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:10:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSiu-0005RY-I3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 02:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2dPlD4b7y06PPkcjBMYTnPZ6PfuCJ5mp3/yge0IguUo=; b=z3lsfG7/zG7e2K6CJiACmkRzAt
 V+qobZrRyb9eTrF+NyPjvO+tIFAdqHP1PZRJAfY+ERzq1H807QtKCm75eDGs2lI/7N+2Pp4gXI3So
 tbJcopQLEPaROCpRblyyG0IIl/JeV1lX6cGsEdLMI0lXv0vT9/gt+nHML/NknMDhotPsPEANiwbcB
 Bb2XeRaGI0hWz49o1z1k8gEPEpCTNDksh29YiZkPcW0uYca/mJtcyIqm6Y5+n0ysJiwcmb2VlqNbV
 L3pNViOSWcnziagP96R3GLDLnoEulVU0R3LDE485g5edxN0U6fY/vsRWIT0HB5RdpANWacfa22xLp
 1hh9cXfls2iAgwWKl3JUtEpY1ihPUqHRBXrjTnAOQvVAk9BnOz78BShYftoP2PV1axtXiQ3ZfkLSV
 ytReMp8OrlznsqswtGmf6icaZXHF9oyZGpYpg8uIdPW3j9aBuPsLr8XZK926d6UgnFv21g9hqHkNV
 LU+yMGPcJZf3UQ/RcJG5ZkHH+8+Br3k2zTwR8f51dys8b5sCnVeVVM+8+tVjWiDggAXDG38ETVv83
 raO9c076HjN7odNBCasf61WOI8XxbLc8DlqCK4nLzpiWqenjZL/aw6x7kTKnpzaP7I+jSaFWLXCDL
 vSyChRv4i5CoNMnGXA5+CDwAx1tAszfeWovUMiOB8=;
Received: from [2a00:23c4:8bb1:9800:b804:1635:e423:adbd]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNSiL-0001XX-QB; Wed, 10 Jan 2024 07:09:29 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Wed, 10 Jan 2024 07:08:06 +0000
Message-Id: <20240110070808.369516-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:b804:1635:e423:adbd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 0/2] qemu-sparc queue 20240110
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 9468484fe904ab4691de6d9c34616667f377ceac:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-01-09 10:32:23 +0000)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20240110

for you to fetch changes up to 995d8348eb3d8ddf24882ed384a5c50eaf3aeae9:

  util/fifo8: Introduce fifo8_peek_buf() (2024-01-10 06:58:50 +0000)

----------------------------------------------------------------
qemu-sparc queue
- introduce fifo8_peek_buf() function

----------------------------------------------------------------
Philippe Mathieu-Daudé (2):
      util/fifo8: Allow fifo8_pop_buf() to not populate popped length
      util/fifo8: Introduce fifo8_peek_buf()

 include/qemu/fifo8.h | 37 ++++++++++++++++++++++++++++++++-----
 util/fifo8.c         | 28 +++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 10 deletions(-)


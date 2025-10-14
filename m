Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC6ABDA9F6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 18:33:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8hxJ-0006xO-P8; Tue, 14 Oct 2025 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v8hxF-0006x5-5R
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:32:53 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1v8hxB-0000lO-EI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 12:32:52 -0400
DKIM-Signature: a=rsa-sha256; bh=UDp/uBdp4frOBwYdxCn2FPWUi1Hr3uNtjn/xiCYmmbg=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1760459564; v=1;
 b=eB6XFoEf3/tSsxUSXdmSiTd55YYr1YI9hv2kNOtHDpVS0tq58ac7vCSoeTKBkuj/RRGsZisA
 1mY9iEEbuElLDk8qMc24eN9iUASQ1SnG1EBMW4J83owYcFOM/TTdRgFzVb7DPNMjDKg9xBlz5t8
 nOXdatkxL9MndRYbiAggFZqFbwVZ/desiV/BkDHINrcwOafnLIa6HvDHnkR/IyRxXxlotjiZkKd
 9CQqUh7xuCKBP62b+aYY0emN5tACWfjZJwTtDKRBrHa1ImU0KMhvHWoFR/nfod22y08kGYTPkaM
 4j8vblUSLM7mj0KlR1nlAvVhGsMSZGJMAUSAkIraQj3Lg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 40EDA238F4;
 Tue, 14 Oct 2025 16:32:44 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Tue, 14 Oct 2025 16:32:44 +0000
Subject: [PATCH qemu v8 0/1] Honor guest PAT on x86, absent Bochs display
MIME-Version: 1.0
Message-ID: <176045956423.5579.13349691093596703310-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~myrslint <myrskylintu@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This revision rectifies the mistake I had made in preparing v7. Comment
formatting was also corrected.

As with the previous versions of the patch it is intended to address the
following issue: https://gitlab.com/qemu-project/qemu/-/issues/2943

myrslint (1):
  Honor guest PAT on x86, absent Bochs display

 accel/kvm/kvm-all.c        |  1 +
 accel/stubs/kvm-stub.c     |  1 +
 hw/display/bochs-display.c | 17 +++++++++++++++
 include/system/kvm.h       |  9 ++++++++
 target/i386/kvm/kvm.c      | 42 +++++++++++++++++++++++++++++++-------
 5 files changed, 63 insertions(+), 7 deletions(-)

-- 
2.49.1


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F2B2848F
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Aug 2025 19:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umxn1-00078S-BT; Fri, 15 Aug 2025 13:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umxmy-00078C-Nl
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:00:24 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1umxmv-00017U-Qc
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 13:00:24 -0400
DKIM-Signature: a=rsa-sha256; bh=rBmMlMr8n63XWDUOwjTK6eZjIsZSgGGz7DOfpB1HehY=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1755277216; v=1;
 b=bAvnGT9sC5gX6jOF2a4EyHPi+PMsgf/twwMRUPd70+Pqs6f6Md40JnD5OHJq1vS/7tHel4Hk
 dO5mkqRFm9MsOYrImmoKtPHg9HoOmELNuzNkS8vsd/GvTLnrWo6lQW0Hxhn/62eKsZAVtoOENgj
 xHT36xWe6kTRz12xlFetpgsppI7EVV5JgTUhVssg1buu/u0bO/VyelJ4snj72vPTqqFpE2jrTol
 NzvAddJUHdTbhPIRaTrAb0WkrL7l1Ccgm8qaPdVmW4IoJe0U1HD+gDVjBWyqie4ejW0OJimuCKF
 B+z7RyiaY14AFieUiEYa6hF69zJKqYrloKd+Tt57Ufu6w==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 7236622F00;
 Fri, 15 Aug 2025 17:00:16 +0000 (UTC)
From: ~myrslint <myrslint@git.sr.ht>
Date: Fri, 15 Aug 2025 17:00:16 +0000
Subject: [PATCH qemu v4 0/1] Default disable ignore guest PAT quirk
MIME-Version: 1.0
Message-ID: <175527721636.15451.4393515241478547957-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Per Dmitry Osipenko's <dmitry.osipenko@collabora.com> advice remove
#ifdef since QEMU ships its own set of kernel headers which will always
have the checked value defined.

myrslint (1):
  Default disable ignore guest PAT quirk

 target/i386/kvm/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.49.1


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B27547BB05C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 04:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoaxY-000721-80; Thu, 05 Oct 2023 22:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1qoaxW-00071t-K0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 22:52:58 -0400
Received: from mail-4022.proton.ch ([185.70.40.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1qoaxK-00005C-Go
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 22:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail; t=1696560763; x=1696819963;
 bh=qK8d1Ri8G2B1nCCJ9IiKmbeP0NT7MUXafASMHHITXJY=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=euvyqFjStI0z7VEOdiMJLfSkN6XncpBIL6yheR9lVLZNzQcHjLurGsAIqpz3qzU6o
 24/weE8sHYt2uIlLOFO0uN3APZiOSGNySRWvp1l+M4zDx7uxYdmrkFR2rU16kAERk9
 1KLLtA6ffFnJp9fmDe2FT+knxmf4LFHK4Sg1TsthnK3dbZZlCQyOaiwE0Eceg2Mb7z
 3nq8MIgxkW846ih/f9tXhEE7W9PQiCpfB9fpLcQlfkLhTrCshoFvYv4OneoSDHN9NQ
 kSojjb3OSV43HioJX4kn2fwVGLqI6xAK6yKPIbxOq2wa9uvDaud4C9hseII72NNXBe
 JkaP/zcf1/8bQ==
Date: Fri, 06 Oct 2023 02:52:38 +0000
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, mjt@tls.msk.ru
From: Damien Zammit <damien@zamaudio.com>
Subject: [PATCH] hw/ide: Add command to sync cache on ATAPI
Message-ID: <a33916ee-24a7-56d3-f991-b7e1ff706ea9@zamaudio.com>
Feedback-ID: 43209410:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.22; envelope-from=damien@zamaudio.com;
 helo=mail-4022.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Bumping this thread[1] as it seems to have gotten lost:

[1] https://lists.gnu.org/archive/html/qemu-block/2022-03/msg00586.html

Damien



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE5F741652
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXzl-0002u4-TZ; Wed, 28 Jun 2023 12:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1qEXzg-0002t0-KX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:26:12 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1qEXzd-0005K1-0f
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:26:12 -0400
Date: Wed, 28 Jun 2023 16:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1687969563; x=1688228763;
 bh=X2HQklAyQAa+y+rSjbGWvsVctbuP2gE5lxtc/Wanv2M=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=XbH8jEbMA2j13In1MC6SOEFXWQPGxZFUBpy2nR5ZnpvzJk0KdFGcjfCal7zVm/LQk
 FOPCLAQfoqEyegeLWd7lNaZX2IA30sUk4fo3IUzlwI5ZLuHay4aOsE994YAYXA9Njn
 40lZHmyBI0MfyV2g8KrKp+RA4ku3xGeVGMg6XdphSvwC5JPH6Ay8LPM7r/9UiTOMsu
 XewI/BJFInEeBp12v4zXN+HmXbOmYznOjC9j/sxAS4eqQPKrgbP1GQPZlQlmhW+SJY
 UByRBS+mL3OFOsW1LhFfqok4Ktsmv/gCfeTFyLiDXoSZa0RrOSWXT0QSYHoIcIzYnX
 YkGlcpOVf0lzQ==
To: qemu-devel@nongnu.org
From: Anton Kochkov <anton.kochkov@proton.me>
Cc: Anton Kochkov <anton.kochkov@proton.me>
Subject: [PATCH v2 0/2] contrib/plugins: Migrate to the Meson build
Message-ID: <20230628162451.147419-1-anton.kochkov@proton.me>
Feedback-ID: 53490844:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.16;
 envelope-from=anton.kochkov@proton.me; helo=mail-4316.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Makefile made a lot of assumption regarding the system to compile for.
It was also limited to the Linux (and possibly BSD) only, without the way
to compile for macOS or Windows.

Changes since v1:
- Remove Makefile

Anton Kochkov (2):
  contrib/plugins: add meson build file
  contrib/plugins: remove Makefile

 contrib/plugins/Makefile          | 46 -------------------------------
 contrib/plugins/meson.build       | 31 +++++++++++++++++++++
 contrib/plugins/meson_options.txt |  1 +
 3 files changed, 32 insertions(+), 46 deletions(-)
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build
 create mode 100644 contrib/plugins/meson_options.txt

--
2.41.0




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD179C8625
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 10:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBW9P-0007ZZ-K7; Thu, 14 Nov 2024 04:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1tBW9J-0007ZG-3x
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:28:25 -0500
Received: from forward101a.mail.yandex.net ([178.154.239.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1tBW9G-00049e-Rx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:28:24 -0500
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2e15:0:640:bcf8:0])
 by forward101a.mail.yandex.net (Yandex) with ESMTPS id 2FC1160E33;
 Thu, 14 Nov 2024 12:28:14 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id CSIlutPOkeA0-GDZxKeCw; 
 Thu, 14 Nov 2024 12:28:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1731576493; bh=+fimC/mOFq4BgxpMhbp3ybLTs7sM1PXm3o65T/2kStA=;
 h=Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
 b=VUOx/+oWEsBOc4qq/DLoNkukkJmutJC3ectu+CNU1McxdYlgcOMBVrcVqdNgPc6qG
 CYxoezU8dpAoZniTveNZ4qsaPH6YrFoOKHYiMyHuzUSQe5FaaFyaOAk/krjQvVxiJv
 D7YcgCeIhAddT5IwQ5jCCsfz6RRFXc0qpVVR90lM=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
Message-ID: <2932b992b411497ccd3bbbb717621473e06a96b7.camel@maquefel.me>
Subject: Re: [PATCH v17 00/16] TCG code quality tracking
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: richard.henderson@linaro.org
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org, "Vanderson M. do Rosario"
 <vandersonmr2@gmail.com>
Date: Thu, 14 Nov 2024 12:28:12 +0300
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=178.154.239.84;
 envelope-from=nikita.shubin@maquefel.me; helo=forward101a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Richard and Vanderson !

Any news on this series ? It's been 26 spins already (yep i am counting
Vanderson series also).

While it's a really great idea in general, it also has great
educational purpose.

I've rebased v17 on the top of current master branch, but maybe we can
hope for another spin ? Especially with graphs, which are missing in
latest series.

---
Yours,

Nikita Shubin


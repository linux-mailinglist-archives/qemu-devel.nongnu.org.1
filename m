Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 144CE7AF5A3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 23:17:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlFQ7-0002PU-A7; Tue, 26 Sep 2023 17:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qlFQ5-0002P7-8H
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 17:16:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qlFQ3-0007SS-JS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 17:16:37 -0400
Received: from mail-nwsmtp-mxback-corp-main-58.myt.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-58.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4a2d:0:640:8ef0:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 87E9560C90;
 Wed, 27 Sep 2023 00:16:33 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c12:3e1e:0:640:3d50:0
 [2a02:6b8:c12:3e1e:0:640:3d50:0])
 by mail-nwsmtp-mxback-corp-main-58.myt.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id 44Xl1C0OwKo0-SW1V6rfV; Wed, 27 Sep 2023 00:16:33 +0300
X-Yandex-Fwd: 2
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695762993;
 bh=KJrKknGWQgbvd2JR/7mlQrFC1WTcw2TycDS/SjhYKDk=;
 h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
 b=GnQQrb2bMDSwuUvv5rkh4FXzVM9g+MFjTErLgUnwuyOnSzilYZps7U92iIL1hJYLp
 c+wNMKHyVw9kN55dgqs4wCujrnW5kg3TKh78BYHYb4nDhwKtDZ5AXuqm7NQ8JNS+tF
 aE66FcUGPavfgnHhzhQ9QM7O5XGRDzpEubSLC58Y=
Authentication-Results: mail-nwsmtp-mxback-corp-main-58.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from mail-sendbernar-corp-main-90.vla.yp-c.yandex.net
 (mail-sendbernar-corp-main-90.vla.yp-c.yandex.net
 [2a02:6b8:c15:2e85:0:640:fe53:0])
 by mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id XCX4i90OwGk0-UU6VS0ho
 for <d-tatianin@yandex-team.ru>; Wed, 27 Sep 2023 00:16:23 +0300
Received: by mail-sendbernar-corp-main-90.vla.yp-c.yandex.net with HTTP;
 Wed, 27 Sep 2023 00:16:22 +0300
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
In-Reply-To: <ZRNGspuTX84gStfe@x1n>
References: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
 <ZRNGspuTX84gStfe@x1n>
Subject: Re: [PATCH 0/2] i386/a-b-bootblock: zero the first byte of each page
 on start
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 27 Sep 2023 00:16:32 +0300
Message-Id: <1801695762902@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

<div>27.09.2023, 00:02, "Peter Xu" &lt;peterx@redhat.com&gt;:</div><blockquote><p>On Thu, Sep 07, 2023 at 10:29:42PM +0300, Daniil Tatianin wrote:</p><blockquote> This series fixes an issue where the outcome of the migration qtest<br /> relies on the initial memory contents all being the same across the<br /> first 100MiB of RAM, which is a very fragile invariant.<br /> <br /> We fix this by making sure we zero the first byte of every testable page<br /> in range beforehand.</blockquote><p><br />What's the difference between this one and:<br /><br /><a href="https://lore.kernel.org/r/20230907193051.1609310-1-d-tatianin@yandex-team.ru" rel="noopener noreferrer">https://lore.kernel.org/r/20230907193051.1609310-1-d-tatianin@yandex-team.ru</a><br /><br />?</p></blockquote><div>There's a v2 version of this series that adds a fix for a similar issue in s390x as well, please look at that one instead.</div><blockquote><p>Thanks,<br /> </p>--<br />Peter Xu<br /> </blockquote>


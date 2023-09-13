Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1979EB8A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRB7-0000LZ-Ks; Wed, 13 Sep 2023 10:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qgRB3-0000LG-Fd
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:49:15 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qgRB0-0000DO-0B
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:49:13 -0400
Received: from mail-nwsmtp-mxback-corp-main-74.iva.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-74.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b27:0:640:c95d:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 71E8C5EF11;
 Wed, 13 Sep 2023 17:49:03 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c0c:aa10:0:640:6f9e:0
 [2a02:6b8:c0c:aa10:0:640:6f9e:0])
 by mail-nwsmtp-mxback-corp-main-74.iva.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id slgvM70Ox4Y0-o0hxDEeu; Wed, 13 Sep 2023 17:49:03 +0300
X-Yandex-Fwd: 2
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694616543;
 bh=NXkZnFhC70hNqAeVE30dgi2e1KfIaMSgl9WPTuBkmc0=;
 h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
 b=KoqG7ZmOXX8uroZ3vx7svhJuxYMM36nAQMWJZ+eHajlKfjgV9sJVyAce9omt5Dp8n
 QxbrlYYtkWZpB70REefd9oDcaHhq2Co/pUmoPxiqwLVpRMdGZFraH0vOS2Q4eHgbEe
 SUObDg9KLgtQSYxtEL0WXzp31kEq70a+3b872dQU=
Authentication-Results: mail-nwsmtp-mxback-corp-main-74.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from mail-sendbernar-corp-main-46.myt.yp-c.yandex.net
 (mail-sendbernar-corp-main-46.myt.yp-c.yandex.net
 [2a02:6b8:c12:300c:0:640:15fc:0])
 by mail-nwsmtp-mxback-corp-main-54.myt.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id Fmg1L30OsqM0-Z2Izzvdp
 for <d-tatianin@yandex-team.ru>; Wed, 13 Sep 2023 17:48:53 +0300
Received: by mail-sendbernar-corp-main-46.myt.yp-c.yandex.net with HTTP;
 Wed, 13 Sep 2023 17:48:52 +0300
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
In-Reply-To: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
References: <20230907193051.1609310-1-d-tatianin@yandex-team.ru>
Subject: Re: [PATCH v1 0/2] i386/a-b-bootblock: zero the first byte of each
 page on start
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 13 Sep 2023 17:49:02 +0300
Message-Id: <237551694616515@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

<div>ping</div><div> </div><div>07.09.2023, 22:31, "Daniil Tatianin" &lt;d-tatianin@yandex-team.ru&gt;:</div><blockquote><p>This series fixes an issue where the outcome of the migration qtest<br />relies on the initial memory contents all being the same across the<br />first 100MiB of RAM, which is a very fragile invariant.<br /><br />We fix this by making sure we zero the first byte of every testable page<br />in range beforehand.<br /><br />Daniil Tatianin (2):<br />  i386/a-b-bootblock: factor test memory addresses out into constants<br />  i386/a-b-bootblock: zero the first byte of each page on start<br /><br /> tests/migration/i386/a-b-bootblock.S | 18 +++++++++++++++---<br /> tests/migration/i386/a-b-bootblock.h | 16 ++++++++--------<br /> 2 files changed, 23 insertions(+), 11 deletions(-)<br /> </p>--<br />2.34.1<br /> </blockquote>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F07AF59D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 23:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlFKY-0008Va-Rg; Tue, 26 Sep 2023 17:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qlFKX-0008VP-3P
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 17:10:53 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qlFKU-0005Mf-3X
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 17:10:52 -0400
Received: from mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:1106:0:640:c3cf:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 61B9560704;
 Wed, 27 Sep 2023 00:10:45 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c08:1080:0:640:5c52:0
 [2a02:6b8:c08:1080:0:640:5c52:0])
 by mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id jAX0O90MrGk0-cVGDfr94; Wed, 27 Sep 2023 00:10:45 +0300
X-Yandex-Fwd: 2
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695762645;
 bh=jSUesqFFyloLf6gB5A0xHegnX+4UOwtw6VHgQXFq/bA=;
 h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
 b=L+tR7mfTEbYS87Vc/vW58EvBa4tLv5hHFaxEu648CaYTO6+47Q/1qzbMU0gYR60M+
 6Uf2DhgDPeO3d2DaHE2FDnNVDZnN5JVc+XyG97Lp/RYPQDbY4eQyY4szF4qmwg+FSq
 Y4RNxR2mCjVWKI9NydLVe716H9HffNUK4RzM1yzU=
Authentication-Results: mail-nwsmtp-mxback-corp-main-97.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from 37xqqk2lbnvsssvy.sas.yp-c.yandex.net
 (37xqqk2lbnvsssvy.sas.yp-c.yandex.net [2a02:6b8:c08:a383:0:640:a965:0])
 by mail-nwsmtp-mxback-corp-canary-59.sas.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id YAXEZ90OuCg0-N1bcfk5x
 for <d-tatianin@yandex-team.ru>; Wed, 27 Sep 2023 00:10:34 +0300
Received: by 37xqqk2lbnvsssvy.sas.yp-c.yandex.net with HTTP;
 Wed, 27 Sep 2023 00:10:34 +0300
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
Date: Wed, 27 Sep 2023 00:10:44 +0300
Message-Id: <381651695762568@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/html; charset=utf-8
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

<div>27.09.2023, 00:02, "Peter Xu" &lt;peterx@redhat.com&gt;:</div><blockquote><p>On Thu, Sep 07, 2023 at 10:29:42PM +0300, Daniil Tatianin wrote:</p><blockquote> This series fixes an issue where the outcome of the migration qtest<br /> relies on the initial memory contents all being the same across the<br /> first 100MiB of RAM, which is a very fragile invariant.<br /> <br /> We fix this by making sure we zero the first byte of every testable page<br /> in range beforehand.</blockquote><p><br />What's the difference between this one and:<br /><br /><a href="https://lore.kernel.org/r/20230907193051.1609310-1-d-tatianin@yandex-team.ru" rel="noopener noreferrer">https://lore.kernel.org/r/20230907193051.1609310-1-d-tatianin@yandex-team.ru</a><br /><br />?</p></blockquote><div>I think i initially forgot something and had to resend, but not sure. Anyway, disregard that one.<br /> </div><blockquote>--<br />Peter Xu<br /> </blockquote>


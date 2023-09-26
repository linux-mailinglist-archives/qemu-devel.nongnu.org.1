Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B477AE8A3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 11:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql43l-0001ff-Dn; Tue, 26 Sep 2023 05:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ql43W-0001fI-SQ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:08:36 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1ql43R-0002SI-6f
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 05:08:31 -0400
Received: from mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net
 (mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:33a2:0:640:ecef:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 96CE5609A2;
 Tue, 26 Sep 2023 12:08:24 +0300 (MSK)
Received: from mail.yandex-team.ru (2a02:6b8:c18:461c:0:640:9290:0
 [2a02:6b8:c18:461c:0:640:9290:0])
 by mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id L8LXf50Ot4Y0-jSO40ofh; Tue, 26 Sep 2023 12:08:24 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695719304;
 bh=rHJiFptmZ9Uhlxf4DfZIRSmXL9U+AQhNKZXFWIKpM7Q=;
 h=References:Date:Message-Id:Cc:Subject:To:From:In-Reply-To;
 b=vYRNoYXMOKFoHnCBeQaQRyQ0BKBnvgQVilOz5/l7GfYeF1nbExNkR85KdnNCTBxj9
 xORiDy14K+C6ZgBaIXm3bUJsne7CZP019dA/ojX/cBC+wkW7rKMJ+r6+xgfOo3WYY4
 UBbFOlVhb3Ce+3eNQdk2RZFXk88vCd3JoYEyUqcM=
Authentication-Results: mail-nwsmtp-mxback-corp-main-12.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from ij3urkvf4buhbqq7.myt.yp-c.yandex.net
 (ij3urkvf4buhbqq7.myt.yp-c.yandex.net [2a02:6b8:c12:3e1e:0:640:3d50:0])
 by mail-nwsmtp-mxback-corp-main-17.myt.yp-c.yandex.net (mxbackcorp/Yandex)
 with HTTP id A8LbL60OwOs0-RRKRtQ34
 for <d-tatianin@yandex-team.ru>; Tue, 26 Sep 2023 12:08:14 +0300
Received: by ij3urkvf4buhbqq7.myt.yp-c.yandex.net with HTTP;
 Tue, 26 Sep 2023 12:08:14 +0300
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
References: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
Subject: Re: [PATCH v2 0/3] migration-qtest: zero the first byte of each page
 on start
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 26 Sep 2023 12:08:24 +0300
Message-Id: <6711695719168@mail.yandex-team.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/html
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTML_MIME_NO_HTML_TAG=0.377, MIME_HTML_ONLY=0.1, PYZOR_CHECK=1.392,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

<div>ping :)</div>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC9682D1DA
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 19:29:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rP5D2-0000fa-D5; Sun, 14 Jan 2024 13:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rP5Ci-0000en-S3
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 13:27:29 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rP5Cg-0004xy-IX
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 13:27:28 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id CC91C40F1DE3;
 Sun, 14 Jan 2024 18:27:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru CC91C40F1DE3
Date: Sun, 14 Jan 2024 21:27:00 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
cc: qemu-devel@nongnu.org, Mikhail Romanov <mmromanov@ispras.ru>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] Optimize buffer_is_zero
In-Reply-To: <ZZ1XQtNctZiHwFlh@redhat.com>
Message-ID: <74b96ca0-c751-eced-d8f7-f306d997207b@ispras.ru>
References: <20231027143704.7060-1-mmromanov@ispras.ru>
 <e0ae3a3e-f02c-0031-a85f-5645c7480f8f@ispras.ru>
 <ZZ1XQtNctZiHwFlh@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-808616816-1705256820=:31487"
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-808616816-1705256820=:31487
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


On Tue, 9 Jan 2024, Daniel P. Berrangé wrote:

> On Thu, Nov 09, 2023 at 03:52:38PM +0300, Alexander Monakov wrote:
> > I'd like to ping this patch on behalf of Mikhail.
> > 
> >   https://patchew.org/QEMU/20231027143704.7060-1-mmromanov@ispras.ru/
> > 
> > If this needs to be split up a bit to ease review, please let us know.
> 
> Sorry, my asm knowledge isn't strong enough for me to review this.
> Reading the commit message though, how it describes 8 separate changes
> does make me believe this should be done as a series of 8 patches.

(I'm not sure where the number 8 comes from, the enumeration in the commit
message goes up to eleven)

> It would make it easier to review and/or spot any accidental
> regressions, etc .

Paolo and Richard, can you please confirm if you'll be more likely to engage
with this optimization when it's resent in a broken-up form?

Thanks.
Alexander
--8323328-808616816-1705256820=:31487--


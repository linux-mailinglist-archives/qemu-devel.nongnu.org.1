Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96998BCC41D
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 11:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v791D-0002Id-Hw; Fri, 10 Oct 2025 05:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7918-0002Hi-V9; Fri, 10 Oct 2025 05:02:27 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7913-00062B-OI; Fri, 10 Oct 2025 05:02:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 42EEC80474;
 Fri, 10 Oct 2025 12:02:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a89::1:23] (unknown
 [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id E2H7XK1FOOs0-ewwkk6Zg; Fri, 10 Oct 2025 12:02:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760086934;
 bh=GJw61OjnbfRiNcNgiN66+nNA8XujQOXryMpq1m+VUfA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BUTYr5sj4snxpx+Z4REbK1rbQa3dpYrlmXXpUSZmbSwOV0k28lWU1pcsqa6xChF4Y
 oPAw6PVxkKfA2hpQJ1fUpnQTwPbEuY8X3vopCNZt7CPjoWJ4KfhO/TRPBFa69r4n+x
 wQgIolTtGsWLAaHej26hE1i9d3sEf1uV+HJ8lAIw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7503ba0e-2596-4919-b4ea-bc61e469564a@yandex-team.ru>
Date: Fri, 10 Oct 2025 12:02:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] remove deprecated 'reconnect' options
To: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jasowang@redhat.com,
 devel@lists.libvirt.org, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, qemu-trivial@nongnu.org
References: <20250924133309.334631-1-vsementsov@yandex-team.ru>
 <877bx4p3at.fsf@pond.sub.org>
 <5063033a-9d83-49da-9f15-cc492d124a68@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <5063033a-9d83-49da-9f15-cc492d124a68@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.10.25 10:52, Michael Tokarev wrote:
> On 10/9/25 17:17, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>
>>> They were deprecated in 9.2, now we can remove them.
>>> New options to use are reconnect-ms.
> 
> Speaking of the option itself.. I'd not remove it, instead,
> I'd de-deprecate it, and allow units to be specified for it,
> like reconnect=10ms (defaults to s).  Or reconnect=0.1 (in
> fractions of second).  But it's just me, it looks like :)

QAPI is not for humans) So simple milliseconds integer is better,
then parse the variety of suffixes. And it better fit into json
(number is number, not a string)

> 
> Also, `has_reconnect_ms` becomes redundant after applying this
> patch, - it should be enough to use just reconnect_ms, which
> defaults to 0.  But this can be done in a subsequent cleanup.
> 

You mean just use sock->reconnect_ms instead of explicit

    int64_t reconnect_ms = sock->has_reconnect_ms ? sock->reconnect_ms : 0;

?

I believe that QMP will zero-initialize everything. But I'm not sure
that we do zero initialize this structure on all paths.. Keeping also in mind
handling other fields here like

     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;

To drop this, we should check for all paths, that incoming structure is
zero-initialized. And no guarantee that it does not break in future.

Probably, we can implement a new QAPI feature "value with default to zero",
so that we can avoid existence of .has_foo field at all for such fields.
No field - no problem.. But not in this series)

-- 
Best regards,
Vladimir


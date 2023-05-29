Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCF71463D
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 10:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Y7E-0002Al-7E; Mon, 29 May 2023 04:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3Y74-00028B-W2; Mon, 29 May 2023 04:20:24 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q3Y72-0005GK-73; Mon, 29 May 2023 04:20:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 6CBAF61C9E;
 Mon, 29 May 2023 11:20:05 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b64e::1:1e] (unknown
 [2a02:6b8:b081:b64e::1:1e])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4KGdqb3OiuQ0-93o4kUbD; Mon, 29 May 2023 11:20:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1685348404; bh=5Es5aQg6q6Y9kWAHLD6oIucR0bhhTYv8B4eWte4O4Wc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ys1FvufMA88SvRyp/nRTW43vsl3ugagSzm+3KqraO3FDDvpE7g722A79nmZphgsYo
 oGk45skKowUFNKmo60Sy8kGd5fDEHsQlVv0RXMJZ3v5hWICdWyhlRdBo1PPdRtHTMw
 qi0XAYUc2WBQEGEOvWGlGRuvoTy12sLfVAFA2+Us=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ba8005db-16fc-ba86-7f77-0ffe479282bf@yandex-team.ru>
Date: Mon, 29 May 2023 11:20:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 01/14] nbd/client: Use smarter assert
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, "Dr . David Alan Gilbert" <dave@treblig.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230515195343.1915857-1-eblake@redhat.com>
 <20230515195343.1915857-2-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230515195343.1915857-2-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15.05.23 22:53, Eric Blake wrote:
> Assigning strlen() to a uint32_t and then asserting that it isn't too
> large doesn't catch the case of an input string 4G in length.
> Thankfully, the incoming strings can never be that large: if the
> export name or query is reflecting a string the client got from the
> server, we already guarantee that we dropped the NBD connection if the
> server sent more than 32M in a single reply to our NBD_OPT_* request;
> if the export name is coming from qemu, nbd_receive_negotiate()
> asserted that strlen(info->name) <= NBD_MAX_STRING_SIZE; and
> similarly, a query string via x->dirty_bitmap coming from the user was
> bounds-checked in either qemu-nbd or by the limitations of QMP.
> Still, it doesn't hurt to be more explicit in how we write our
> assertions to not have to analyze whether inadvertent wraparound is
> possible.
> 
> Fixes: 93676c88 ("nbd: Don't send oversize strings", v4.2.0)
> Reported-by: Dr. David Alan Gilbert<dave@treblig.org>
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FFB4A5DB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Sep 2025 10:47:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvu0U-0006Hm-Ey; Tue, 09 Sep 2025 04:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvu05-0006B5-3P; Tue, 09 Sep 2025 04:46:54 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvu00-0003pW-9J; Tue, 09 Sep 2025 04:46:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B28EDC0196;
 Tue, 09 Sep 2025 11:46:37 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id akEOIQ2GwiE0-AAHOqtcd; Tue, 09 Sep 2025 11:46:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757407597;
 bh=HttkUanbHmZ0Tg0v81CB/VB6m/qrIwO3DSpg6QiQp+0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xgyPF57YR4FSmxB+ss0siMICFL405z2+E8FfanxYx8uZk0EMDGSeR7r8mLKQlFHnf
 DtO3PuScEPFQQveYXR+uWMgwHCzARnAvmzZXzd4hXC6Lqx71aOFP3HuZtH7fLpKADa
 kRvJBZU9TeZEx6wgrCVcKiSaCyz78tU/KxEgiGfM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3ffa98e4-38f2-484a-a7b6-d59fbb418c44@yandex-team.ru>
Date: Tue, 9 Sep 2025 11:46:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] char-socket: rework tcp_chr_recv()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-3-vsementsov@yandex-team.ru>
 <aL_njFMhsCazHxUf@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL_njFMhsCazHxUf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 09.09.25 11:38, Daniel P. Berrangé wrote:
> On Wed, Sep 03, 2025 at 12:44:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> First, qio_channel_readv_full() already guarantees BLOCKING and
>> CLOEXEC states for incoming descriptors, no reason call extra
>> ioctls.
>>
>> Second, current implementation calls _set_block() and _set_cloexec()
>> again on old descriptors on failure path - we fix this too.
>>
>> Finally, handling errors exactly after qio_channel_readv_full() call
>> looks more readable.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   chardev/char-socket.c | 37 +++++++++++++------------------------
>>   1 file changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 1e8313915b..5b9b19ba8b 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -293,6 +293,18 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>>                                        0, &err);
>>       }
>>   
>> +    if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> +        errno = EAGAIN;
>> +        return -1;
>> +    } else if (ret == -1) {
>> +        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
>> +        error_free(err);
>> +        errno = EIO;
>> +        return -1;
>> +    }
>> +
>> +    assert(ret >= 0);
> 
> Moving this logic to here means that in the blocking I/O, and/or error
> paths, we are not clearing out the previously read s->read_msgfds_num
> These should be considered obsolete at the point we start a new read
> call, regardless of its success, hence why we had the code ordered in
> this way.

Oops, thanks! That's not obvious, I'll add a comment.

> 
> 
>> +
>>       if (msgfds_num) {
>>           /* close and clean read_msgfds */
>>           for (i = 0; i < s->read_msgfds_num; i++) {
>> @@ -307,30 +319,7 @@ static ssize_t tcp_chr_recv(Chardev *chr, char *buf, size_t len)
>>           s->read_msgfds_num = msgfds_num;
>>       }
>>   
>> -    for (i = 0; i < s->read_msgfds_num; i++) {
>> -        int fd = s->read_msgfds[i];
>> -        if (fd < 0) {
>> -            continue;
>> -        }
>> -
>> -        /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
>> -        qemu_socket_set_block(fd);
>> -
>> -#ifndef MSG_CMSG_CLOEXEC
>> -        qemu_set_cloexec(fd);
>> -#endif
>> -    }
> 
> This for(){} removal is fnie.
> 
>> -
>> -    if (ret == QIO_CHANNEL_ERR_BLOCK) {
>> -        errno = EAGAIN;
>> -        ret = -1;
>> -    } else if (ret == -1) {
>> -        trace_chr_socket_recv_err(chr, chr->label, error_get_pretty(err));
>> -        error_free(err);
>> -        errno = EIO;
>> -    } else if (ret == 0) {
>> -        trace_chr_socket_recv_eof(chr, chr->label);
>> -    }
>> +    trace_chr_socket_recv_eof(chr, chr->label);
>>   
>>       return ret;
>>   }
>> -- 
>> 2.48.1
>>
> 
> With regards,
> Daniel


-- 
Best regards,
Vladimir


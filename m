Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EB733828
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 20:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAECJ-0005c2-7Y; Fri, 16 Jun 2023 14:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qAECD-0005bF-Ty; Fri, 16 Jun 2023 14:29:18 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qAECA-0007sa-SI; Fri, 16 Jun 2023 14:29:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1421:0:640:53a0:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id CECFE6055E;
 Fri, 16 Jun 2023 21:29:02 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4af::1:5] (unknown
 [2a02:6b8:b081:b4af::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 1TixUi0OqW20-nwbW17Ky; Fri, 16 Jun 2023 21:29:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686940142; bh=4i3qGBXX++Ig3BKNMb6l06Yzy1meRy7hyzPj0z4ZC2k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qvLbp693KdXwZ60KmzAEi9uK6WZJYkzfGJOs92hpd3fEEhbBAXe2I78dtyOHUeXmc
 1FjXtxUMXqVcfEBXRH0/biQUjYvWYbOjZT2x5iFZw5ZVCg3LQAwHAlitCovCWEo6YF
 lLwgM1VY0HOhYiJtilSm9+LUxstON+Evf4uQEyG8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <cedff69f-8fb2-16c3-f7ec-d78c5877e1c3@yandex-team.ru>
Date: Fri, 16 Jun 2023 21:29:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Libguestfs] [PATCH v4 13/24] nbd/server: Refactor handling of
 request payload
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: libguestfs@redhat.com, qemu-block@nongnu.org
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-14-eblake@redhat.com>
 <f6pzwl5mat6b7axgi4jalhfacxnxsnzix5r7urp4sbmwsg2phj@c5fuaartjd7d>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <f6pzwl5mat6b7axgi4jalhfacxnxsnzix5r7urp4sbmwsg2phj@c5fuaartjd7d>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08.06.23 21:29, Eric Blake wrote:
> On Thu, Jun 08, 2023 at 08:56:42AM -0500, Eric Blake wrote:
>> Upcoming additions to support NBD 64-bit effect lengths allow for the
>> possibility to distinguish between payload length (capped at 32M) and
>> effect length (up to 63 bits).  Without that extension, only the
> 
> Technically, the NBD spec does not (yet) have a documented cap of a
> 63-bit size limit; although I should probably propose a patch upstream
> that does that (I had one in my draft work, but it hasn't yet made it
> upstream)
> 
>> NBD_CMD_WRITE request has a payload; but with the extension, it makes
>> sense to allow at least NBD_CMD_BLOCK_STATUS to have both a payload
>> and effect length (where the payload is a limited-size struct that in
>> turns gives the real effect length as well as a subset of known ids
>> for which status is requested).  Other future NBD commands may also
>> have a request payload, so the 64-bit extension introduces a new
>> NBD_CMD_FLAG_PAYLOAD_LEN that distinguishes between whether the header
>> length is a payload length or an effect length, rather than
>> hard-coding the decision based on the command.  Note that we do not
>> support the payload version of BLOCK_STATUS yet.
>>
>> For this patch, no semantic change is intended for a compliant client.
>> For a non-compliant client, it is possible that the error behavior
>> changes (a different message, a change on whether the connection is
>> killed or remains alive for the next command, or so forth), in part
>> because req->complete is set later on some paths, but all errors
>> should still be handled gracefully.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> v4: less indentation on several 'if's [Vladimir]
>> ---
>>   nbd/server.c     | 76 ++++++++++++++++++++++++++++++------------------
>>   nbd/trace-events |  1 +
>>   2 files changed, 49 insertions(+), 28 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 4ac05d0cd7b..d7dc29f0445 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -2329,6 +2329,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>>                                                  Error **errp)
>>   {
>>       NBDClient *client = req->client;
>> +    bool extended_with_payload;
>> +    unsigned payload_len = 0;
>>       int valid_flags;
>>       int ret;
>>
>> @@ -2342,48 +2344,63 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>>       trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
>>                                                nbd_cmd_lookup(request->type));
>>
>> -    if (request->type != NBD_CMD_WRITE) {
>> -        /* No payload, we are ready to read the next request.  */
>> -        req->complete = true;
>> -    }
>> -
>>       if (request->type == NBD_CMD_DISC) {
>>           /* Special case: we're going to disconnect without a reply,
>>            * whether or not flags, from, or len are bogus */
>> +        req->complete = true;
>>           return -EIO;
>>       }
>>
>> -    if (request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
>> -        request->type == NBD_CMD_CACHE)
>> -    {
>> -        if (request->len > NBD_MAX_BUFFER_SIZE) {
>> -            error_setg(errp, "len (%" PRIu64" ) is larger than max len (%u)",
>> -                       request->len, NBD_MAX_BUFFER_SIZE);
>> -            return -EINVAL;
>> +    /* Payload and buffer handling. */
>> +    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
>> +        (request->flags & NBD_CMD_FLAG_PAYLOAD_LEN);
>> +    if ((request->type == NBD_CMD_READ || request->type == NBD_CMD_WRITE ||
>> +         request->type == NBD_CMD_CACHE || extended_with_payload) &&
>> +        request->len > NBD_MAX_BUFFER_SIZE) {
> 
> I'm still debating about rewriting this series of slightly-different
> 'if' into a single switch (request->type) block; the benefit is that

I vote for switch!) Really, seems it would be a lot simpler to read.

> all actions for one command will be localized instead of split over
> multiple lines of if, the drawback is that some code will now have to
> be duplicated across commands (such as the buffer allocation code for
> CMD_READ and CMD_WRITE).
> 

-- 
Best regards,
Vladimir



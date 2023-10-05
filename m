Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6737BA405
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQow-0005DZ-2F; Thu, 05 Oct 2023 12:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoQog-00055i-EH; Thu, 05 Oct 2023 12:03:12 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoQoc-0007cN-B2; Thu, 05 Oct 2023 12:03:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 3C63961C11;
 Thu,  5 Oct 2023 19:03:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4bf::1:10] (unknown
 [2a02:6b8:b081:b4bf::1:10])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id x2b4pl2Oca60-QZvr3MOB; Thu, 05 Oct 2023 19:02:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696521779;
 bh=S6fq39+o/6zpU2IXdxFpl6eUCnZ4BJNlyRFjj1togTU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wDD9+cid9xTEb4zzzhO3ZfHoN3PMfRKeEy5eotM/Va1vmvhjW4OqKmAQxfNYwe58u
 8iaSfq5/WKwpmLlwRs0tijZXOeIfiZOIJl997HJzlXumFg5E2pqBwTD+FvIT/khSue
 OGAeIUJNx9BiDOvT8083GNQYPjw4QQ7D53lC3psM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3e6b1cae-b73c-45f4-a5f9-112c00cb880a@yandex-team.ru>
Date: Thu, 5 Oct 2023 19:02:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Libguestfs] [PATCH v7 01/12] nbd/server: Support a request
 payload
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-15-eblake@redhat.com>
 <ck34pqcdui6vpzncmvjchzy7vjgdb32apfpau3nztlsfwdd32n@4xuctbm2ycdb>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ck34pqcdui6vpzncmvjchzy7vjgdb32apfpau3nztlsfwdd32n@4xuctbm2ycdb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 05.10.23 18:38, Eric Blake wrote:
> On Mon, Sep 25, 2023 at 02:22:31PM -0500, Eric Blake wrote:
>> Upcoming additions to support NBD 64-bit effect lengths allow for the
>> possibility to distinguish between payload length (capped at 32M) and
>> effect length (64 bits, although we generally assume 63 bits because
>> of off_t limitations).
> [...]
> 
>> +++ b/nbd/server.c
>> @@ -2322,9 +2322,11 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>>                                                  Error **errp)
>>   {
>>       NBDClient *client = req->client;
>> +    bool extended_with_payload;
>>       bool check_length = false;
>>       bool check_rofs = false;
>>       bool allocate_buffer = false;
>> +    bool payload_okay = false;
>>       unsigned payload_len = 0;
> 
> Pre-existing type mismatch caught as a result of Vladimir's review of
> 12/12, but:
> 
>>       int valid_flags = NBD_CMD_FLAG_FUA;
>>       int ret;
>> @@ -2338,6 +2340,13 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>>
>>       trace_nbd_co_receive_request_decode_type(request->cookie, request->type,
>>                                                nbd_cmd_lookup(request->type));
>> +    extended_with_payload = client->mode >= NBD_MODE_EXTENDED &&
>> +        request->flags & NBD_CMD_FLAG_PAYLOAD_LEN;
>> +    if (extended_with_payload) {
>> +        payload_len = request->len;
> 
> this can assign a 64-bit number into a 32-bit variable, which can
> truncate to 0,...
> 
>> +        check_length = true;
>> +    }
>> +
>>       switch (request->type) {
>>       case NBD_CMD_DISC:
>>           /* Special case: we're going to disconnect without a reply,
>> @@ -2354,6 +2363,15 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>>           break;
>>
>>       case NBD_CMD_WRITE:
>> +        if (client->mode >= NBD_MODE_EXTENDED) {
>> +            if (!extended_with_payload) {
>> +                /* The client is noncompliant. Trace it, but proceed. */
>> +                trace_nbd_co_receive_ext_payload_compliance(request->from,
>> +                                                            request->len);
>> +            }
>> +            valid_flags |= NBD_CMD_FLAG_PAYLOAD_LEN;
>> +        }
>> +        payload_okay = true;
>>           payload_len = request->len;
> 
> ...the pre-existing code is safe only as long as request->len cannot
> exceed 32 bytes (which it can't do until later in this series actually
> enables extended requests).  Switching the type now is prudent...
> 
>>           check_length = true;
>>           allocate_buffer = true;
>> @@ -2395,6 +2413,14 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>>                      request->len, NBD_MAX_BUFFER_SIZE);
>>           return -EINVAL;
>>       }
>> +    if (payload_len && !payload_okay) {
>> +        /*
>> +         * For now, we don't support payloads on other commands; but
>> +         * we can keep the connection alive by ignoring the payload.
>> +         */
>> +        assert(request->type != NBD_CMD_WRITE);
>> +        request->len = 0;
> 
> ...otherwise, this check is bypassed for a request size of exactly 4G
> if check_length is false and thus the previous conditional for
> request->len vs. NBD_MAX_BUFFER_SIZE didn't trigger (prior to this
> patch, payload_len was only set for CND_WRITE which also set
> check_length).  Thus, I'm squashing in:
> 
> diff --git i/nbd/server.c w/nbd/server.c
> index 5258064e5ac..1cb66e86a89 100644
> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -2327,7 +2327,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
>       bool check_rofs = false;
>       bool allocate_buffer = false;
>       bool payload_okay = false;
> -    unsigned payload_len = 0;
> +    uint64_t payload_len = 0;
>       int valid_flags = NBD_CMD_FLAG_FUA;
>       int ret;
> 
> 

OK, agree

-- 
Best regards,
Vladimir



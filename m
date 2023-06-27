Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D073FF8E
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAUJ-0006de-3n; Tue, 27 Jun 2023 11:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEAUG-0006dI-Q8; Tue, 27 Jun 2023 11:20:12 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEAUC-0006jV-M9; Tue, 27 Jun 2023 11:20:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 56B3060180;
 Tue, 27 Jun 2023 18:19:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tJN9Q50OfGk0-hjoDvhkF; Tue, 27 Jun 2023 18:19:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687879195; bh=k/hLuuV5g4E+hInvgx4kDlYB88uThru5XWHvSuE3Ku8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VK3adJORBC7i3nQNWKoV3CYtghjFZLpLk01e135MkpkYWp4S2iRDkLHy0lcWH/yy7
 PgnO/Ir7EfZcMQyleRkaLPBGLsOk0A19d2nL3jn1DMJRxy9FiZ/UAuVTHHMJwmUsIK
 hA7ENxq7d4zdN04zojiJtEmCApEPF7NR5HKTXx/I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <399962eb-b05a-b7c8-ffa9-a09c94e0a22c@yandex-team.ru>
Date: Tue, 27 Jun 2023 18:19:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Libguestfs] [PATCH v4 23/24] nbd/server: Prepare for per-request
 filtering of BLOCK_STATUS
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 libguestfs@redhat.com, qemu-block@nongnu.org
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-24-eblake@redhat.com>
 <r3yru7q3g27ou4r4f3fmdxlilmhmvliksy6zovyh5zia35j3in@cijsy333zbvr>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <r3yru7q3g27ou4r4f3fmdxlilmhmvliksy6zovyh5zia35j3in@cijsy333zbvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 08.06.23 22:15, Eric Blake wrote:
> On Thu, Jun 08, 2023 at 08:56:52AM -0500, Eric Blake wrote:
>> The next commit will add support for the optional extension
>> NBD_CMD_FLAG_PAYLOAD during NBD_CMD_BLOCK_STATUS, where the client can
>> request that the server only return a subset of negotiated contexts,
>> rather than all contexts.  To make that task easier, this patch
>> populates the list of contexts to return on a per-command basis (for
>> now, identical to the full set of negotiated contexts).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
> 
>> +++ b/nbd/server.c
>> @@ -2491,6 +2491,8 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req, NBDRequest *
>>               error_setg(errp, "No memory");
>>               return -ENOMEM;
>>           }
>> +    } else if (request->type == NBD_CMD_BLOCK_STATUS) {
>> +        request->contexts = &client->contexts;
>>       }
> 
> THere are paths where request->contexts is left NULL but request->type
> was set...
> 
>> @@ -2841,6 +2848,11 @@ static coroutine_fn void nbd_trip(void *opaque)
>>       } else {
>>           ret = nbd_handle_request(client, &request, req->data, &local_err);
>>       }
>> +    if (request.type == NBD_CMD_BLOCK_STATUS &&
>> +        request.contexts != &client->contexts) {
>> +        g_free(request.contexts->bitmaps);
>> +        g_free(request.contexts);
>> +    }
> 
> so I think this also needs to be tweaked to check that
> request.contexts is non-NULL before dereferencing to free bitmaps.
> 

agree (and I missed this during my review :)

suggest:

if (request.contexts && request.contexts != &client->contexts) {
   g_free(..)
   g_free(..)
}


-- 
Best regards,
Vladimir



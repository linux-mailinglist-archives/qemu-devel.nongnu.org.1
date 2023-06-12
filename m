Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5A72C395
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8gDG-0001Y6-0h; Mon, 12 Jun 2023 07:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8gD4-0001Rm-Co; Mon, 12 Jun 2023 07:59:48 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8gD1-0002tn-HT; Mon, 12 Jun 2023 07:59:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a49a:0:640:edd6:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 032DE5EDAD;
 Mon, 12 Jun 2023 14:59:32 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8910::1:11] (unknown
 [2a02:6b8:b081:8910::1:11])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VxXRYA1OjeA0-MrQw1uB9; Mon, 12 Jun 2023 14:59:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686571171; bh=vfY3EV2GEsvqz4lwsl+fB32jeq14UqBNHnPrEiZX6/c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=om3R6lo6vSQoeEZaxXT6PGHRQWZyxKSpjI9IFNTuYDHgbNVbeyy703+jBINoO8lj9
 Y4wT7SVZTgMbyWXFYJ9eRxSS8YcQ1Oxa+MPfx5qcbQMUTF77z4iH514cVVh6Q/yeTP
 1urIV5Ii4DZpO1rd6oT1S+wmLb05gXqvrSd5gVb0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <800e121f-e5be-9207-fdbc-492524ce0119@yandex-team.ru>
Date: Mon, 12 Jun 2023 14:59:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Libguestfs] [PATCH v4 02/24] nbd: Consistent typedef usage in
 header
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 libguestfs@redhat.com, qemu-block@nongnu.org
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-3-eblake@redhat.com>
 <jo2eqbij3xyku4n5hm2ftahzymkimjulpm6kmjh47lbec4t3ov@y4m4ypbhm4ie>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <jo2eqbij3xyku4n5hm2ftahzymkimjulpm6kmjh47lbec4t3ov@y4m4ypbhm4ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 08.06.23 17:17, Eric Blake wrote:
> On Thu, Jun 08, 2023 at 08:56:31AM -0500, Eric Blake wrote:
>> We had a mix of struct declarataions followed by typedefs, and direct
> 
> declarations
> 
>> struct definitions as part of a typedef.  Pick a single style.  Also
>> float a couple of opaque typedefs earlier in the file, as a later
>> patch wants to refer NBDExport* in NBDRequest.  No semantic impact.
> 
> The curse of writing a commit message and then rebasing to a different
> idea; in patch 22, I had originally intended to make NBDMetaContexts a
> concrete type in nbd.h (which depends on NBDExport*, and would be
> directly used in NBDRequest, which in turn is declared before the
> pre-patch mention of NBDExport), but then changed my mind to instead
> have NBDMetaContexts itself also be an opaque type with NBDRequest
> only using NBDMetaContexts*.  And I missed floating the typedef for
> NBDClientConnection to the same point, because we somewhat separated
> opaque types along the lines of which .c files provide various
> functions and opaque types.
> 
>> @@ -26,24 +26,25 @@
>>   #include "qapi/error.h"
>>   #include "qemu/bswap.h"
>>
>> +typedef struct NBDExport NBDExport;
>> +typedef struct NBDClient NBDClient;
>> +
> 
> Preferences on how I should tweak that aspect of this patch?  Options:
> 
> - Don't float NBDExport or NBDClient, and drop that part of the commit
>    message.  However, the later patch that adds the typedef for
>    NBDMetaContexts still has to do it earlier than the definition of
>    NBDRequest, rather than alongside the other opaque types relevant to
>    server.c
> 
> - Also float NBDClientConnection up here, and reword the commit
>    message along the lines of: Also float forward declarations of
>    opaque types to the top of the file, rather than interspersed with
>    function declarations, which will help a future patch that wants to
>    expose yet another opaque type that will be referenced in
>    NBDRequest.

Sounds good to me. Anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> 
> - something else?
> 

-- 
Best regards,
Vladimir



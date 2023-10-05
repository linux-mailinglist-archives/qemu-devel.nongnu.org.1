Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02F7B9FAC
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPJQ-0008B9-NB; Thu, 05 Oct 2023 10:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoPJK-00088I-7i; Thu, 05 Oct 2023 10:26:42 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoPJF-0003Eg-Vq; Thu, 05 Oct 2023 10:26:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b9a4:0:640:eb37:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id DA5F65EC90;
 Thu,  5 Oct 2023 17:26:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b584::1:2f] (unknown
 [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XQZMsd4OlGk0-kvGVyRDo; Thu, 05 Oct 2023 17:26:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696515993;
 bh=F0xGKcT9FolsiJLX31ZRIvm27qd1zNrhAHDHtLs5rOw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VEEYUp3SKjNLSCacQX2pfooGWu8wNttDQO7c5DHv8QMlfAHklIR5710Inlb5iIIBP
 vUdUv2vZyepfpHBSrbZa3cvCBa1UFNdnOxxgPTJehPqB5XyLRFE3jKq2GpPHO3w3I8
 nhcoULKsPugYtfNnJ4SSqD8GtF0/igN6An8GOdmE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c16ed175-db4f-4900-82be-294ad81f643c@yandex-team.ru>
Date: Thu, 5 Oct 2023 17:26:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Libguestfs] [PATCH v7 12/12] nbd/server: Add FLAG_PAYLOAD
 support to CMD_BLOCK_STATUS
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, libguestfs@redhat.com
References: <20230925192229.3186470-14-eblake@redhat.com>
 <20230925192229.3186470-26-eblake@redhat.com>
 <6b380866-b707-89d5-7478-476582cdd255@yandex-team.ru>
 <bhi75jjd4pv2va73e2h6ypkfuo4wdzpl4s7dqesalsqkrda5ec@js77c4frs25o>
 <dlaxybxq6zrujpqfztz26rbr4kyru6upy5wdiv3c7j3akaijhg@twyctydbcg6g>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <dlaxybxq6zrujpqfztz26rbr4kyru6upy5wdiv3c7j3akaijhg@twyctydbcg6g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 05.10.23 16:49, Eric Blake wrote:
> On Wed, Oct 04, 2023 at 04:55:02PM -0500, Eric Blake wrote:
>>>> +static int
>>>> +nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
>>>> +                                 Error **errp)
>>>
>>> [..]
> 
>>>> +    for (i = 0; i < count; i++) {
>>>> +        id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
>>>> +        if (id == NBD_META_ID_BASE_ALLOCATION) {
>>>> +            if (request->contexts->base_allocation) {
>>>> +                goto skip;
>>>> +            }
>>>
>>> should we also check that base_allocation is negotiated?
>>
>> Oh, good point.  Without that check, the client can pass in random id
>> numbers that it never negotiated.  I've queued 1-11 and will probably
>> send a pull request for those this week, while respinning this patch
>> to fix the remaining issues you pointed out.
> 
> I'm squashing in the following. If you can review it today, I'll
> include it in my pull request this afternoon; if not, we still have
> time before soft freeze to get it in the next batch.
> 
> diff --git i/nbd/server.c w/nbd/server.c
> index 30816b42386..62654579cbc 100644
> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -2478,19 +2478,22 @@ nbd_co_block_status_payload_read(NBDClient *client, NBDRequest *request,
>       for (i = 0; i < count; i++) {
>           id = ldl_be_p(buf + sizeof(NBDBlockStatusPayload) + sizeof(id) * i);
>           if (id == NBD_META_ID_BASE_ALLOCATION) {
> -            if (request->contexts->base_allocation) {
> +            if (!client->contexts.base_allocation ||
> +                request->contexts->base_allocation) {
>                   goto skip;
>               }
>               request->contexts->base_allocation = true;
>           } else if (id == NBD_META_ID_ALLOCATION_DEPTH) {
> -            if (request->contexts->allocation_depth) {
> +            if (!client->contexts.allocation_depth ||
> +                request->contexts->allocation_depth) {
>                   goto skip;
>               }
>               request->contexts->allocation_depth = true;
>           } else {
> -            int idx = id - NBD_META_ID_DIRTY_BITMAP;
> +            unsigned idx = id - NBD_META_ID_DIRTY_BITMAP;
> 
> -            if (idx > nr_bitmaps || request->contexts->bitmaps[idx]) {
> +            if (idx > nr_bitmaps || !client->contexts.bitmaps[idx] ||

Oops, I didn't notice: s/>/>=/, as nr_bitmaps is length of array.

> +                request->contexts->bitmaps[idx]) {
>                   goto skip;
>               }
>               request->contexts->bitmaps[idx] = true;
> diff --git i/nbd/trace-events w/nbd/trace-events
> index 3cf2d00e458..00ae3216a11 100644
> --- i/nbd/trace-events
> +++ w/nbd/trace-events
> @@ -70,7 +70,7 @@ nbd_co_send_chunk_read(uint64_t cookie, uint64_t offset, void *data, uint64_t si
>   nbd_co_send_chunk_read_hole(uint64_t cookie, uint64_t offset, uint64_t size) "Send structured read hole reply: cookie = %" PRIu64 ", offset = %" PRIu64 ", len = %" PRIu64
>   nbd_co_send_extents(uint64_t cookie, unsigned int extents, uint32_t id, uint64_t length, int last) "Send block status reply: cookie = %" PRIu64 ", extents = %u, context = %d (extents cover %" PRIu64 " bytes, last chunk = %d)"
>   nbd_co_send_chunk_error(uint64_t cookie, int err, const char *errname, const char *msg) "Send structured error reply: cookie = %" PRIu64 ", error = %d (%s), msg = '%s'"
> -nbd_co_receive_block_status_payload_compliance(uint64_t from, int len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%x"
> +nbd_co_receive_block_status_payload_compliance(uint64_t from, uint64_t len) "client sent unusable block status payload: from=0x%" PRIx64 ", len=0x%" PRIx64
>   nbd_co_receive_request_decode_type(uint64_t cookie, uint16_t type, const char *name) "Decoding type: cookie = %" PRIu64 ", type = %" PRIu16 " (%s)"
>   nbd_co_receive_request_payload_received(uint64_t cookie, uint64_t len) "Payload received: cookie = %" PRIu64 ", len = %" PRIu64
>   nbd_co_receive_ext_payload_compliance(uint64_t from, uint64_t len) "client sent non-compliant write without payload flag: from=0x%" PRIx64 ", len=0x%" PRIx64
> 
> 
> 

-- 
Best regards,
Vladimir



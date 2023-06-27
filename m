Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92E73FEFD
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEA1p-00032A-De; Tue, 27 Jun 2023 10:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEA1l-00031E-DS; Tue, 27 Jun 2023 10:50:45 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEA1h-0007iZ-JW; Tue, 27 Jun 2023 10:50:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:1421:0:640:53a0:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 8AB4D60623;
 Tue, 27 Jun 2023 17:50:26 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PoM0l50OimI0-f1OI98kW; Tue, 27 Jun 2023 17:50:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687877426; bh=wwe05Y9/eUaZWp0sgaVsL3ZoM/Ib/cEMVTyl0TWoASk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IXfLQPAL86nNwrXQM6yP0OPKzcYf9a75iZAVMm13HPMY0Is8DQ6nNasDKPOIT+cYF
 Ovkje0VUAVJe1G72b5uiufF4v8ayFV9D86OB4SCS146eXvnGrz+LY9pbQNoHNWgWbW
 zrelks0SR2QH0RUNBm7coKK+4dG9jkSFsvcP+C3g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8eb6b1df-7d76-d3f3-b789-23d2986fd51a@yandex-team.ru>
Date: Tue, 27 Jun 2023 17:50:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 20/24] nbd/client: Accept 64-bit block status chunks
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-21-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-21-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 08.06.23 16:56, Eric Blake wrote:
> Once extended mode is enabled, we need to accept 64-bit status replies
> (even for replies that don't exceed a 32-bit length).  It is easier to
> normalize narrow replies into wide format so that the rest of our code
> only has to handle one width.  Although a server is non-compliant if
> it sends a 64-bit reply in compact mode, or a 32-bit reply in extended
> mode, it is still easy enough to tolerate these mismatches.
> 
> In normal execution, we are only requesting "base:allocation" which
> never exceeds 32 bits for flag values. But during testing with
> x-dirty-bitmap, we can force qemu to connect to some other context
> that might have 64-bit status bit; however, we ignore those upper bits
> (other than mapping qemu:allocation-depth into something that
> 'qemu-img map --output=json' can expose), and since that only affects
> testing, we really don't bother with checking whether more than the
> two least-significant bits are set.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[..]

> +     * count at 0 for a narrow server).  However, it's easy enough to
> +     * ignore the server's noncompliance without killing the
>        * connection; just ignore trailing extents, and clamp things to
>        * the length of our request.
>        */
> -    if (chunk->length > sizeof(context_id) + sizeof(*extent)) {
> -        trace_nbd_parse_blockstatus_compliance("more than one extent");
> +    if (count != wide ||
> +        chunk->length > sizeof(context_id) + wide * sizeof(count) + len) {

this calculation is done twice. I'd put it into expected_chunk_length variable.

> +        trace_nbd_parse_blockstatus_compliance("unexpected extent count");
>       }
>       if (extent->length > orig_length) {
>           extent->length = orig_length;
> @@ -1123,7 +1136,7 @@ nbd_co_receive_cmdread_reply(BDRVNBDState *s, uint64_t cookie,
> 
>   static int coroutine_fn
>   nbd_co_receive_blockstatus_reply(BDRVNBDState *s, uint64_t cookie,

[..]

-- 
Best regards,
Vladimir



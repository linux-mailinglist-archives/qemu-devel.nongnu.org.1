Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3BE72C68D
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hzu-0003Bn-O2; Mon, 12 Jun 2023 09:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8hzs-0003BR-ML; Mon, 12 Jun 2023 09:54:16 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q8hzp-00086p-JU; Mon, 12 Jun 2023 09:54:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 3D2615EE4B;
 Mon, 12 Jun 2023 16:54:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8910::1:11] (unknown
 [2a02:6b8:b081:8910::1:11])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wrZs9T1OkuQ0-kRyKBAMQ; Mon, 12 Jun 2023 16:53:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686578039; bh=PW2hM1EgaP8iyiCCmIGq7e3QyKoi2Af4ltVPBUE/hd0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XqbSo2y4qoF9ZM9mWoBCt2gk4vljT1s+dYVipV5/90Od1ojtji3Vp8xu43rDSvGv+
 DcgwCChUo0QO8pUykbo7V2VelTTTlGif11KfX1VamCHgMrx1DdOyrDLlp/CAKlCcs6
 PC3jLXlgmLj8FRvBRUTLOBwiNeZt51LFp4aByg+Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6042078f-7815-b2f4-2d63-96cc9f3a02ab@yandex-team.ru>
Date: Mon, 12 Jun 2023 16:53:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 03/24] nbd/server: Prepare for alternate-size headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-4-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-4-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 08.06.23 16:56, Eric Blake wrote:
> Upstream NBD now documents[1] an extension that supports 64-bit effect
> lengths in requests.  As part of that extension, the size of the reply
> headers will change in order to permit a 64-bit length in the reply
> for symmetry[2].  Additionally, where the reply header is currently 16
> bytes for simple reply, and 20 bytes for structured reply; with the
> extension enabled, there will only be one extended reply header, of 32
> bytes, with both structured and extended modes sending identical
> payloads for chunked replies.
> 
> Since we are already wired up to use iovecs, it is easiest to allow
> for this change in header size by splitting each structured reply
> across multiple iovecs, one for the header (which will become wider in
> a future patch according to client negotiation), and the other(s) for
> the chunk payload, and removing the header from the payload struct
> definitions.  Rename the affected functions with s/structured/chunk/
> to make it obvious that the code will be reused in extended mode.
> 
> Interestingly, the client side code never utilized the packed types,
> so only the server code needs to be updated.
> 
> [1]https://github.com/NetworkBlockDevice/nbd/blob/extension-ext-header/doc/proto.md
> as of NBD commit e6f3b94a934
> 
> [2] Note that on the surface, this is because some future server might
> permit a 4G+ NBD_CMD_READ and need to reply with that much data in one
> transaction.  But even though the extended reply length is widened to
> 64 bits, for now the NBD spec is clear that servers will not reply
> with more than a maximum payload bounded by the 32-bit
> NBD_INFO_BLOCK_SIZE field; allowing a client and server to mutually
> agree to transactions larger than 4G would require yet another
> extension.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C7773FCD8
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:27:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8ir-0005SY-Ho; Tue, 27 Jun 2023 09:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE8im-0005QC-F9; Tue, 27 Jun 2023 09:27:04 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qE8ii-0004XY-EI; Tue, 27 Jun 2023 09:27:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id A05A86018A;
 Tue, 27 Jun 2023 16:26:46 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jQLaw30OiiE0-KGNaJton; Tue, 27 Jun 2023 16:26:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687872406; bh=Z2nO4klap8Wir7sqkd7Xq6iRyPcKQFzIaOwpUT5FU/g=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wvjIfI+7/lvpwRpiYjg3MWuQ6who4pRKqFblSo3J7kLk/D3HLQ/QaObrPhSoqnlqt
 H7CvAGylwqzT4eWNMcNMoVDLfnjlbQD64cn6f+M8OFpEfC3CyDOzPIsxhmaOevmA/U
 QEsajkbeI7Sj2FZQDwa4wJFQ33Jro6xolX+zFoxI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e6b8699b-3bd3-0cf0-2b3b-5baab2c55555@yandex-team.ru>
Date: Tue, 27 Jun 2023 16:26:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 17/24] nbd/server: Enable initial support for extended
 headers
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-18-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-18-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
> Time to start supporting clients that request extended headers.  Now
> we can finally reach the code added across several previous patches.
> 
> Even though the NBD spec has been altered to allow us to accept
> NBD_CMD_READ larger than the max payload size (provided our response
> is a hole or broken up over more than one data chunk), we are not
> planning to take advantage of that, and continue to cap NBD_CMD_READ
> to 32M regardless of header size.
> 
> For NBD_CMD_WRITE_ZEROES and NBD_CMD_TRIM, the block layer already
> supports 64-bit operations without any effort on our part.  For
> NBD_CMD_BLOCK_STATUS, the client's length is a hint, and the previous
> patch took care of implementing the required
> NBD_REPLY_TYPE_BLOCK_STATUS_EXT.
> 
> We do not yet support clients that want to do request payload
> filtering of NBD_CMD_BLOCK_STATUS; that will be added in later
> patches, but is not essential for qemu as a client since qemu only
> requests the single context base:allocation.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



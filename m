Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C227337FF
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 20:17:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qADzk-0003LC-Jk; Fri, 16 Jun 2023 14:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qADzi-0003Kt-EO; Fri, 16 Jun 2023 14:16:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qADzg-0005jO-3Z; Fri, 16 Jun 2023 14:16:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:168f:0:640:3294:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 2C1E660300;
 Fri, 16 Jun 2023 21:16:08 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4af::1:5] (unknown
 [2a02:6b8:b081:b4af::1:5])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7GisGi0OqmI0-W7GNCTby; Fri, 16 Jun 2023 21:16:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686939367; bh=OIfLyEcbtNn9Fjj+xRz1iDFR6Mil8NrsM0/gGNJgq6k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hl/vDQaXJOLmJU2L9U7sPoGKwXUqb0K88QqXT2SYbPZCZDMUkGGwDgGNJcCGq09xE
 ZHsgGxH9+VnJzTmk98zAUBUc8Nhol256h2fv3ZFIQ0oYnUQXkoGvmySI1AKpnL30VA
 i5xArYJWcHQrtqNAuedIEMCetH92MpbAZAdixUMU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4ff051de-11f9-1605-2bb1-8a4b4be8560c@yandex-team.ru>
Date: Fri, 16 Jun 2023 21:16:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 12/24] nbd: Prepare for 64-bit request effect lengths
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-13-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-13-eblake@redhat.com>
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

On 08.06.23 16:56, Eric Blake wrote:
> Widen the length field of NBDRequest to 64-bits, although we can
> assert that all current uses are still under 32 bits, because nothing
> ever puts us into NBD_MODE_EXTENDED yet.  Thus no semantic change.  No
> semantic change yet.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

assertions about NBD_MAX_BUFFER_SIZE worth a note in commit message?

trace eventsjk nbd_co_request_fail, nbd_co_request_fail, nbd_co_request_fail missed an update to 64bit

Also, some functions use size_t. Should we move them to uint64_t for consistancy?

  - nbd_co_send_sparse_read
  - nbd_co_send_chunk_read
  - nbd_co_send_simple_reply

but that may be another story



-- 
Best regards,
Vladimir



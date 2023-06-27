Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855873FF56
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAM0-0001gF-0f; Tue, 27 Jun 2023 11:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEALx-0001fc-Bl; Tue, 27 Jun 2023 11:11:37 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qEALt-0004ST-9u; Tue, 27 Jun 2023 11:11:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:1d86:0:640:2a41:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 0E39161A39;
 Tue, 27 Jun 2023 18:11:21 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68e::1:39] (unknown
 [2a02:6b8:b081:b68e::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id JBNvn60OreA0-M6Nn9Qih; Tue, 27 Jun 2023 18:11:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1687878680; bh=kqAijolt8QRPrKQtNBeWi2hkpMSsDPZmc0SI4iJXR0Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WaEdSfIDPwKD9G75Pgg5bHAuNDm04507caUOTx+utUd5x1IFzvNoxMGGsuFlaaurm
 GSbVrNrexHX4kH7P7M1vg1skf311yN1s68Iur3ifmRDPzJYOGrQHtGaUY/hFFEWiBP
 /odMKbYbQmsXEcFuu2gVNc1KJB+xT3MRFtsRprfQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b1ec5fb5-561a-a958-eeca-0dad1d6d4dc7@yandex-team.ru>
Date: Tue, 27 Jun 2023 18:11:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 22/24] nbd/server: Refactor list of negotiated meta
 contexts
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, libguestfs@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20230608135653.2918540-1-eblake@redhat.com>
 <20230608135653.2918540-23-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230608135653.2918540-23-eblake@redhat.com>
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
> Peform several minor refactorings of how the list of negotiated meta
> contexts is managed, to make upcoming patches easier: Promote the
> internal type NBDExportMetaContexts to the public opaque type
> NBDMetaContexts, and mark exp const.  Use a shorter member name in
> NBDClient.  Hoist calls to nbd_check_meta_context() earlier in their
> callers, as the number of negotiated contexts may impact the flags
> exposed in regards to an export, which in turn requires a new
> parameter.

Hmm, a bit of semantic change: we drop context in nbd_check_meta_export() even when we report error. Pre-patch we call nbd_check_meta_export() only on success path.. Still, it seems even more safe.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

   Drop a redundant parameter to nbd_negotiate_meta_queries.
> No semantic change intended.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


-- 
Best regards,
Vladimir



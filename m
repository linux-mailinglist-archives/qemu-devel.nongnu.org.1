Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223D791BCC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:54:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCpE-0001Cx-Qb; Mon, 04 Sep 2023 12:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdCpC-0001CI-0S; Mon, 04 Sep 2023 12:53:18 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qdCp8-0000Sb-Qn; Mon, 04 Sep 2023 12:53:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9412:0:640:7d12:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id E19065F747;
 Mon,  4 Sep 2023 19:53:10 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b518::1:22] (unknown
 [2a02:6b8:b081:b518::1:22])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ArZTJS0OqCg0-EXNVWSzp; Mon, 04 Sep 2023 19:53:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1693846390;
 bh=Vbxd03CWfynC660/90u+fLqnDGlmqxzGIB1meFJzm90=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ltQqPCWT7atyryoz4eE3x7d9S7MfQLpDS7rHx3BkPdpmScAyNCC8L9SC/1zfnXF1Z
 K9SRTBogAVQqZdo02MEr/5WdWTv76jEQGNpReFwmv1XF64LQGOwRwGDlNCmIAnv3UH
 VL/sdFa2nqmcDoC+2CYgcKCK7C328HncQwtITeQM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2ad497a6-7432-4ffd-138f-1c96ce7e3fce@yandex-team.ru>
Date: Mon, 4 Sep 2023 19:53:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 05/17] nbd/server: Refactor handling of command sanity
 checks
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20230829175826.377251-19-eblake@redhat.com>
 <20230829175826.377251-24-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230829175826.377251-24-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.08.23 20:58, Eric Blake wrote:
> Upcoming additions to support NBD 64-bit effect lengths will add a new
> command flag NBD_CMD_FLAG_PAYLOAD_LEN that needs to be considered in
> our sanity checks of the client's messages (that is, more than just
> CMD_WRITE have the potential to carry a client payload when extended
> headers are in effect).  But before we can start to support that, it
> is easier to first refactor the existing set of various if statements
> over open-coded combinations of request->type to instead be a single
> switch statement over all command types that sets witnesses, then
> straight-line processing based on the witnesses.  No semantic change
> is intended.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir



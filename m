Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB2EB38115
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 13:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEMP-0007Ts-7N; Wed, 27 Aug 2025 07:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1urEM1-0007F2-JC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:30:13 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1urELt-00033N-GE
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:30:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:90aa:0:640:b805:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E91A088402;
 Wed, 27 Aug 2025 14:29:53 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c63::1:9] (unknown [2a02:6bf:8080:c63::1:9])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qTXAk00GieA0-PhbTEcDQ; Wed, 27 Aug 2025 14:29:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756294193;
 bh=3RpF98/HjRKQzAeBxtPbTDSSXZlijzAEJz2KF/T/EIc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=HqQ672kI/S2JuVIke0JiGl790wkS2gqLWipjbuidyjcLAotA57KRnPEhHLdPkQLgY
 6ouQ2V7eVEnsy7/fMM7l/8uEFfSsHHVFvhzRxLzaLFeTq/BpljLTpoo7TBEcvkW3Yi
 OUD5b2RGX+yNnwc+AQEsTXyqAkK/5JB5gQeIuVio=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9de70bbe-4cb0-495e-91b5-6b64bf634bdd@yandex-team.ru>
Date: Wed, 27 Aug 2025 14:29:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 3/8] vhost: reset vhost devices for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <1752777568-236368-4-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <1752777568-236368-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 17.07.25 21:39, Steve Sistare wrote:
> When preserving a vhost fd using CPR, call VHOST_RESET_OWNER prior to CPR
> in old QEMU.  Otherwise, new QEMU will fail when it calls VHOST_SET_OWNER
> during vhost_dev_init.
> 

But, is there a benefit in passing vhostnet fd to target QEMU? As I understand,
we anyway need a full renitialization of vhost device, as it's just reset
on RESET_OWNER. So, is passing this fd better then reopen /dev/vhost-net
on target?


-- 
Best regards,
Vladimir


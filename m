Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38523945BD2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Aug 2024 12:10:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZpEL-0007Tg-9n; Fri, 02 Aug 2024 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZpEH-0007SQ-W2; Fri, 02 Aug 2024 06:09:46 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sZpED-0007DR-KR; Fri, 02 Aug 2024 06:09:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a52d:0:640:f75d:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E1A5460DE9;
 Fri,  2 Aug 2024 13:09:29 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b725::1:34] (unknown
 [2a02:6b8:b081:b725::1:34])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id S9VYLp7GcmI0-akNGDv1E; Fri, 02 Aug 2024 13:09:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1722593369;
 bh=T/tGnBhEqsCOjqkeIcEPwU2ALP5Vm4/LmJQINXk5VFA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=kbMXL7VTCkE7UmeDc/dOAJ8T+MXiC/Lxf2rrOKuS6YL/1USfxHn8IemGwwIl8lth4
 3UfvUlEMU439SUnqwKa8FiWsTxJUuJrj0p9Osq8Do7KWjYVnr5JkvAGe1Dp6o/laCu
 kcfQ4CXDJ0E111rZwqnNVohp79FaQyuZ56mK2uAY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <494268b9-b4d9-4c4a-bde2-573e533fbc62@yandex-team.ru>
Date: Fri, 2 Aug 2024 13:09:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] block: get type of block allocation in commit_run
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
 <20240713215644.742244-2-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240713215644.742244-2-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 14.07.24 00:56, Vincent Vanlaer wrote:
> bdrv_co_common_block_status_above not only returns whether the block is
> allocated, but also if it contains zeroes.
> 
> Signed-off-by: Vincent Vanlaer<libvirt-e6954efa@volkihar.be>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D2B33823
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Aug 2025 09:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqRw9-0004EE-Vg; Mon, 25 Aug 2025 03:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uqRw5-0004CK-5l
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:48:13 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uqRw3-0004KF-2x
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 03:48:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:360b:0:640:ab69:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 18121C00BA;
 Mon, 25 Aug 2025 10:48:06 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a99::1:22] (unknown
 [2a02:6bf:8080:a99::1:22])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5mRlLR1GnqM0-Ka42aDB6; Mon, 25 Aug 2025 10:48:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756108085;
 bh=xQo8oOsGE9dqH46pwNKFMDg7T2H7TeJLlcXdFMvRREI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NxHQpXjLgVlE9vOLHLaqwZLFmNl8uUt0qn2i+jh5jl3gRHkaQxzTsdzFF6Pr/iEB6
 Xo66t8j83FBKzAbto7aq7/7lWhAUDE79s5gQVhYJZTmIV3HHI6ObvjrlD5/WL209lF
 5h98LpFBjUpBcziJizk/LHy5rvNZE2vjkbgNZzSc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3d3d1b50-d1f2-49d0-b409-e78a272b339b@yandex-team.ru>
Date: Mon, 25 Aug 2025 10:48:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] TAP initialization refactoring
To: Lei Yang <leiyang@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, steven.sistare@oracle.com
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
 <CAPpAL=zM-SG62X8OUv4szDGKgHVnXdhs18fhz5zOnfmG0mv2SQ@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAPpAL=zM-SG62X8OUv4szDGKgHVnXdhs18fhz5zOnfmG0mv2SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 25.08.25 06:26, Lei Yang wrote:
> Tested this series of patches with virtio-net regression
> tests,everything works fine.
> 
> Tested-by: Lei Yang<leiyang@redhat.com>

Thanks!

-- 
Best regards,
Vladimir


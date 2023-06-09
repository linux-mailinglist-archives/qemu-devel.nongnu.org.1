Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C362C729F10
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 17:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cEX-0002Py-FM; Fri, 09 Jun 2023 09:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q7cEU-0002Pq-EU
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:32:50 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q7cES-0002Pd-Gk
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:32:50 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 8596D5F4CF;
 Fri,  9 Jun 2023 16:32:41 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b727::1:d] (unknown
 [2a02:6b8:b081:b727::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eWWACI0OriE0-3CkLvQ10; Fri, 09 Jun 2023 16:32:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686317560; bh=sdeg4jqVB4Qp0psbtZ0TZDDoXER1G0+v4kcaRrrbBkE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=xbpvtrvUKp2DyA3gpLWTSm3ShZ+L+WqDUhpfRC6rBIMoZDJD84Wz604BEQdoWSwu4
 gi+RMRFIgetpi5RGYDuiB5A4AvWWsEjAmqXUzvQABAQiHp8V5v5SYvAt0MkPNrSEzG
 n7wQGLmVQG+Bh6oIJ8LlME5cwyb6oRSRoJN4vkZ0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5a9ed961-0356-33d0-21a4-42032621c13a@yandex-team.ru>
Date: Fri, 9 Jun 2023 16:32:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 0/1] ROM migration
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 david@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
 den-plotnikov@yandex-team.ru, lersek@redhat.com, kraxel@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com
References: <20230522201740.88960-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230522201740.88960-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

ping.

On 22.05.23 23:17, Vladimir Sementsov-Ogievskiy wrote:
> v4:
> preparation patches are already merged to master
> 01: fix false-positive "error: ‘size’ may be used uninitialized",
>      keep r-bs
> 
> Vladimir Sementsov-Ogievskiy (1):
>    pci: ROM preallocation for incoming migration
> 
>   hw/pci/pci.c | 79 ++++++++++++++++++++++++++++++----------------------
>   1 file changed, 46 insertions(+), 33 deletions(-)
> 

-- 
Best regards,
Vladimir



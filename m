Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 990287E52EA
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 10:54:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fG6-0003hW-9a; Wed, 08 Nov 2023 04:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0fG4-0003h7-R1
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:54:00 -0500
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1r0fG2-00024z-6W
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 04:54:00 -0500
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:4e29:0:640:d42a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id CD87861C5C;
 Wed,  8 Nov 2023 12:53:56 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b423::1:d] (unknown
 [2a02:6b8:b081:b423::1:d])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id srZ8c00Ok0U0-LrZqYSnA; Wed, 08 Nov 2023 12:53:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1699437236;
 bh=pPTcO3UVLzjFbtzmv2zsBjV64mG/6bp7sjpyeDdOhm4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hvoKK2/uZkzHV/uduAFRjcL6BFmV8iuspoQE+FUEg7fD24/yMy1THkvtD3Mw8fjMS
 ZVxsc5/sKSGtEtP3RDkj9T+CrPEhgc+m2thAm3g5WiE1KkmyYlUYW6+C3t53OuyBvQ
 X4sqiJ/QspXDIBl2NN7o2XqbIR+evBBRfgVi3Qv0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a7ef159d-1a47-4b20-8217-144a71d3414d@yandex-team.ru>
Date: Wed, 8 Nov 2023 12:53:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] virtio: add VIRTQUEUE_ERROR QAPI event
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, dave@treblig.org, armbru@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20231017123955.803724-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231017123955.803724-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

ping :)

On 17.10.23 15:39, Vladimir Sementsov-Ogievskiy wrote:
> For now we only log the vhost device error, when virtqueue is actually
> stopped. Let's add a QAPI event, which makes possible:
> 
>   - collect statistics of such errors
>   - make immediate actions: take core dumps or do some other debugging
>   - inform the user through a management API or UI, so that (s)he can
>    react somehow, e.g. reset the device driver in the guest or even
>    build up some automation to do so
> 
> Note that basically every inconsistency discovered during virtqueue
> processing results in a silent virtqueue stop.  The guest then just
> sees the requests getting stuck somewhere in the device for no visible
> reason.  This event provides a means to inform the management layer of
> this situation in a timely fashion.
> 
> The event could be reused for some other virtqueue problems (not only
> for vhost devices) in future. For this it gets a generic name and
> structure.
> 
> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
> here, it's not the only call to VHOST_OPS_DEBUG in the file.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
> 
> v4: add spacing between @arguments in qapi doc
>      add a-b by Markus

-- 
Best regards,
Vladimir



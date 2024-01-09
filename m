Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B6C82871D
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:31:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNCBh-0001Sg-5f; Tue, 09 Jan 2024 08:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rNCBJ-0001SC-SZ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:30:20 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rNCBG-0006eU-Qq
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:30:13 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:4da0:0:640:817e:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 5969C617E8;
 Tue,  9 Jan 2024 16:30:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b59d::1:13] (unknown
 [2a02:6b8:b081:b59d::1:13])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2UhWXv87ZOs0-i6hcgazg; Tue, 09 Jan 2024 16:30:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1704807003;
 bh=oOVn6fbFI3cKaNyLKiaKDxuNAUmqjT0KLSxC/CVA/18=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=bbqScRKbNX1T7rfke/++su0kDwls77lT68TQ7gIvAcFRqr5rJ9lGcr2UpvPjD1U/W
 Ek8yYY0Prt2ss5D9N5aVPZKh2kZQ8eu58z6g/t4pvneKJK1uUF7pR57pEK7NWDWN7Z
 EhnUR1D5zCj9NvC5VdH26fO4mbBYT3C0vbZtLxdM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <decf944a-b610-480d-9ec8-a022ffd5ab3d@yandex-team.ru>
Date: Tue, 9 Jan 2024 16:30:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] virtio: add VIRTQUEUE_ERROR QAPI event
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, dave@treblig.org, armbru@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, eduardo@habkost.net, eblake@redhat.com,
 yc-core@yandex-team.ru, den-plotnikov@yandex-team.ru
References: <20231017123955.803724-1-vsementsov@yandex-team.ru>
 <a7ef159d-1a47-4b20-8217-144a71d3414d@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <a7ef159d-1a47-4b20-8217-144a71d3414d@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping2 )

On 08.11.23 12:53, Vladimir Sementsov-Ogievskiy wrote:
> ping :)
> 
> On 17.10.23 15:39, Vladimir Sementsov-Ogievskiy wrote:
>> For now we only log the vhost device error, when virtqueue is actually
>> stopped. Let's add a QAPI event, which makes possible:
>>
>>   - collect statistics of such errors
>>   - make immediate actions: take core dumps or do some other debugging
>>   - inform the user through a management API or UI, so that (s)he can
>>    react somehow, e.g. reset the device driver in the guest or even
>>    build up some automation to do so
>>
>> Note that basically every inconsistency discovered during virtqueue
>> processing results in a silent virtqueue stop.  The guest then just
>> sees the requests getting stuck somewhere in the device for no visible
>> reason.  This event provides a means to inform the management layer of
>> this situation in a timely fashion.
>>
>> The event could be reused for some other virtqueue problems (not only
>> for vhost devices) in future. For this it gets a generic name and
>> structure.
>>
>> We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
>> here, it's not the only call to VHOST_OPS_DEBUG in the file.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>
>> v4: add spacing between @arguments in qapi doc
>>      add a-b by Markus
> 

-- 
Best regards,
Vladimir



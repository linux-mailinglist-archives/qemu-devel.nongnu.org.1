Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499957CDC08
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 14:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt5qJ-0004QS-J6; Wed, 18 Oct 2023 08:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt5qF-0004PG-B8; Wed, 18 Oct 2023 08:40:03 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qt5qB-0001dG-P6; Wed, 18 Oct 2023 08:40:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1bac:0:640:75a2:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id E8AA462670;
 Wed, 18 Oct 2023 15:39:53 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b667::1:1d] (unknown
 [2a02:6b8:b081:b667::1:1d])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qdkM9xAOg4Y0-cnkRFFAG; Wed, 18 Oct 2023 15:39:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697632793;
 bh=YQeaLbHq7z2y4xXl6TJplywZGN0cmHngFUwPVDBnzpc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GlfoLsiyyJrcCR7SOUBAxAZfsI2R9cqX12JGAT559eYLt/sh2GmDq0D2TiMoyORio
 8JpcpmykFLn0xHPDgBVIUsOoVqCuafIONZl1xxNaTWSXXCOlV2UbBAy4awJv52xYZp
 2t6t7U8/nCkZ15J2lt5PSh+fAHbGbTGdQB9rLZsY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <87a2b829-3622-4c5d-a449-73fedfebf7ed@yandex-team.ru>
Date: Wed, 18 Oct 2023 15:39:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, eblake@redhat.com, dave@treblig.org,
 eduardo@habkost.net, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, raphael.norwitz@nutanix.com, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
 <877cnkzasr.fsf@pond.sub.org>
 <a55e8b57-3411-4587-affd-3bc0635af4fe@yandex-team.ru>
 <878r80tdyd.fsf@pond.sub.org> <20231018064912-mutt-send-email-mst@kernel.org>
 <ZS+6g+vtYz9Uh6G3@redhat.com> <87o7gwp29r.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87o7gwp29r.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.10.23 15:02, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Wed, Oct 18, 2023 at 06:51:41AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Oct 18, 2023 at 12:36:10PM +0200, Markus Armbruster wrote:
>>>>> x- seems safer for management tool that doesn't know about "unstable" properties..
>>>>
>>>> Easy, traditional, and unreliable :)
>>>
>>>>> But on the other hand, changing from x- to no-prefix is already
>>>>> done when the feature is stable, and thouse who use it already
>>>>> use the latest version of interface, so, removing the prefix is
>>>>> just extra work.
>>>>
>>>> Exactly.
>>>>
>>>
>>> I think "x-" is still better for command line use of properties - we
>>> don't have an API to mark things unstable there, do we?
>>
>> Personally I like to see "x-" prefix present *everywhere* there is
>> an unstable feature, and consider the need to rename when declaring
>> it stable to be good thing as it sets an easily identifiable line
>> in the sand and is self-evident to outside observers.
>>
>> The self-documenting nature of the "x-" prefer is what makes it most
>> compelling to me. A patch submission, or command line invokation or
>> an example QMP command, or a bug report, that exhibit an 'x-' prefix
>> are an immediate red flag to anyone who sees them.
> 
> Except when it isn't, like in "x-origin".
> 

Interesting how many such stable x-FOO things we have? Probably we could deprecate and than rename them?


-- 
Best regards,
Vladimir



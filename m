Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9F77CC187
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:08:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qshud-00061s-Ra; Tue, 17 Oct 2023 07:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qshuP-0005k3-GP; Tue, 17 Oct 2023 07:06:45 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qshuI-0003A1-Kr; Tue, 17 Oct 2023 07:06:44 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:ba1:0:640:375a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 87B1A6236F;
 Tue, 17 Oct 2023 14:06:30 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8006::1:24] (unknown
 [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id R6i4ZkHOoa60-9x3X1mXp; Tue, 17 Oct 2023 14:06:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697540789;
 bh=8pvqoR2EfmQWgc2zL6d3konBLE9CeojvJ7dEECO+zKI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=mAJGCL56B+8FlWNsSY9hzfAlPMZqv4AyxyzLrvbDvvwt8QrESZl3rpO3M/6K9/vFX
 7UiZ+o9MiD4UyHBo8k535KDyKW9aK+mG9OrVhuK9d8RBNL76DQniG5+m6dlyy/3/lT
 0d2flneZc9YiW9k38jVuQ8VjShayk2OQrICp4pbM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0b07407b-06bc-40b1-af1b-3c8023cb6bdc@yandex-team.ru>
Date: Tue, 17 Oct 2023 14:06:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] Python patches
Content-Language: en-US
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
References: <20231013190941.3699288-1-jsnow@redhat.com>
 <20231016192101.GA161375@fedora>
 <CAFn=p-aO0ADr-oD3XvQs=8keNs27p3b5LGHzvZxeoMWLbu-KpQ@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CAFn=p-aO0ADr-oD3XvQs=8keNs27p3b5LGHzvZxeoMWLbu-KpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 17.10.23 02:44, John Snow wrote:
> On Mon, Oct 16, 2023 at 3:21 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any user-visible changes.
> 
> Hi Vladimir: all done!
> 

Thanks!

> I've created a MR to backport your changes to the standalone repo
> here: https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/30

Looks good to me.

> - please give it a quick glance to make sure I didn't butcher anything
> in transit.
> 
> Thanks,
> --js
> 

-- 
Best regards,
Vladimir



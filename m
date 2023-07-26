Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E760B7635C9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 14:03:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOdDF-0002p4-V4; Wed, 26 Jul 2023 08:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOdDC-0002n8-1I
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOdD9-0006JR-RS
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 08:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690372906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHllnsJY7KTdE4g0Q2X5WtaWVb43QctJsx2vmeUNkAQ=;
 b=C+Mje9hHnK49tLCWdEq/L7g54iAqzPhYe93sggtunXPWRthHvn+7Q1cCYLvdTezT/ma0ce
 uaywOgCi1J5Eubxktuqk+YEbvNOknQtG5EZmKRwjUlFsBj56XUDrVOq7ueHO84faO9sIg5
 TBRc0PuVkiNjGujdqw2I5jYYAisxuV0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-h17yx6n7Mmmh-yc8Wjdz4g-1; Wed, 26 Jul 2023 08:01:43 -0400
X-MC-Unique: h17yx6n7Mmmh-yc8Wjdz4g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BA63281BDC3;
 Wed, 26 Jul 2023 12:01:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93BA0492CA6;
 Wed, 26 Jul 2023 12:01:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 772C421E668C; Wed, 26 Jul 2023 14:01:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PULL 1/5] qapi/block-core: Tidy up BlockLatencyHistogramInfo
 documentation
References: <20230726112855.155795-1-armbru@redhat.com>
 <20230726112855.155795-2-armbru@redhat.com>
 <a86c0dc4-a5dc-48cb-57af-92ecdf27ac81@yandex-team.ru>
Date: Wed, 26 Jul 2023 14:01:34 +0200
In-Reply-To: <a86c0dc4-a5dc-48cb-57af-92ecdf27ac81@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 26 Jul 2023 14:33:36 +0300")
Message-ID: <87pm4e6fvl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 26.07.23 14:28, Markus Armbruster wrote:
>> Documentation for member @bin comes out like
>>      list of io request counts corresponding to histogram intervals.
>>      len("bins") = len("boundaries") + 1 For the example above, "bins"
>>      may be something like [3, 1, 5, 2], and corresponding histogram
>>      looks like:
>>
>> Note how the equation and the sentence following it run together.
>> Replace the equation:
>>
>>      list of io request counts corresponding to histogram intervals,
>>      same number of elements as "boundaries".  For the example above,
>
> not same, but one more. N points break the line into N+1 intervals

Thanks for catching this.

What about "one more element than @boundaries has"?

>>      "bins" may be something like [3, 1, 5, 2], and corresponding
>>      histogram looks like:
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Message-ID: <20230720071610.1096458-2-armbru@redhat.com>



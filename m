Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0497B2C8D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm7Cs-0000qf-JW; Fri, 29 Sep 2023 02:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Ck-0000NS-DL
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm7Ci-0007oJ-Nd
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 02:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695969743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5IVOGrxtCgexnQZUCH3CtFz8zetzt0dE8VGCt2JscM=;
 b=Bjx2Q/ca65x8Bfi98lGGi5hwj7YSwra1EhuxGG1ycBFqedPO74iC9MNOsq9fhsRuNsGrO0
 3diNiTmZVefKcgtMHunHaznjIV+8U1UTvuYNKR0bVoWanc4iYvQISctpWZPIbJiG9KBqs/
 WSa4QxSrqiBN9s2kSt6HT/qLoh8Tdmg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-jWkKF_9nNjqU2erIuctTjw-1; Fri, 29 Sep 2023 02:42:20 -0400
X-MC-Unique: jWkKF_9nNjqU2erIuctTjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9076929AA3B2;
 Fri, 29 Sep 2023 06:42:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CEA9176EA;
 Fri, 29 Sep 2023 06:42:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E07921E6904; Fri, 29 Sep 2023 08:42:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v2 00/22] (few more) Steps towards enabling -Wshadow
References: <20230904161235.84651-1-philmd@linaro.org>
 <87fs2xlfyj.fsf@pond.sub.org>
Date: Fri, 29 Sep 2023 08:42:19 +0200
In-Reply-To: <87fs2xlfyj.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 29 Sep 2023 07:13:24 +0200")
Message-ID: <87il7tiipg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
>> Since v1:
>> - Addressed review comments
>> - Added R-b tags
>> - More patches
>>
>> For rational see Markus cover on
>> https://lore.kernel.org/qemu-devel/20230831132546.3525721-1-armbru@redha=
t.com/
>>
>> This series contains few more, my take.
>>
>> Based-on: <20230831132546.3525721-1-armbru@redhat.com>

Correction...

> Queued except for:

  PATCH 10: Clashes with a patch from C=C3=A9dric, picking C=C3=A9dric's

> PATCH 11: I asked for John Snow's opinion on a matter of taste.
> PATCH 18: Review comment from Peter Maydell is pending.
>
> Thanks!



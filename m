Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E006797300
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeFoU-0006PW-J5; Thu, 07 Sep 2023 10:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qeFoS-0006PJ-Qx
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qeFoQ-0005TK-NY
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694096208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rDWKriDUW5BjrrmFyShcR6v79WeS7VczQ5PPdV49IU=;
 b=aNmSlUPYaZs4I5JBXM8v8zgIcFBWTG9pkLNZ5Li9Y76r1nOPtnHcXdhPAKA/Qgs7VQFFnY
 SY3hh8aJkifozDB+IFev7IyITp5Fqnl+yt0stTfnj6KhzLLHIlGszceXS9WkpnrE3DpUet
 OBAMD9UHGTVy4uF2pfeFsEhBvFAQmWk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-D23bC-avOkKKnj8Q-BvoyA-1; Thu, 07 Sep 2023 10:16:43 -0400
X-MC-Unique: D23bC-avOkKKnj8Q-BvoyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E454594B526;
 Thu,  7 Sep 2023 14:16:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC53A1121318;
 Thu,  7 Sep 2023 14:16:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C32EF21E6936; Thu,  7 Sep 2023 16:16:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 William Tsai <williamtsai1111@gmail.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Eduardo
 Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
 <ZPnJRVnC13X25orb@redhat.com>
Date: Thu, 07 Sep 2023 16:16:41 +0200
In-Reply-To: <ZPnJRVnC13X25orb@redhat.com> (Kevin Wolf's message of "Thu, 7
 Sep 2023 14:59:49 +0200")
Message-ID: <87cyyu6pbq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 07.09.2023 um 11:33 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> > Am 04.09.2023 um 18:25 hat Daniel P. Berrang=C3=A9 geschrieben:
>> >> I still think for user creatable devices we'd be better off just
>> >> mandating the use of JSON syntax for -device and thus leveraging
>> >> the native JSON array type. This patch was the quick fix for the
>> >> existing array property syntax though.
>> >
>> > I agree, let's not apply this one. It puts another ugly hack in the
>> > common QOM code path just to bring back the old ugly hack in qdev.
>>=20
>> Since -device supports both JSON and dotted keys, we'd still offer a
>> (differently ugly) solution for users averse to JSON.
>
> I'm afraid this is not true until we actually QAPIfy -device and change
> the non-JSON path to the keyval parser. At the moment, it still uses
> qemu_opts_parse_noisily(), so no dotted key syntax.

You're right; we chickened out of switching the parser, and I suppressed
the memory.



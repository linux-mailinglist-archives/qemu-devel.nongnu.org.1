Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E09170B714
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q10Ko-0000z4-Fp; Mon, 22 May 2023 03:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q10Kg-0000ym-5R
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:51:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q10Ke-0005LN-MS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684741911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmOKvy1Q6W6lMzsXWBIIw5mL5m+ZueaVoiKDQa+ESQ0=;
 b=SkWPcVMMZqjokBWWYK7hzm6YoEPEUVlCAkgVyN95wSPXB7Mdy9Bu4p2M27sg/obAoUR6R0
 tkvqYnXlh8v24AldXwZVfkZMQHK8lIXYLavZ3tEyVC9m4rtbpm6UHOv7LDDoES2x4WfKJ5
 KwqPtLed224DJqI2xfaXg2lTWt5uGLA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-tV6RwzC-Ms-jauKnB7TeNA-1; Mon, 22 May 2023 03:51:49 -0400
X-MC-Unique: tV6RwzC-Ms-jauKnB7TeNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BCC93C0012F;
 Mon, 22 May 2023 07:51:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44CA8C54184;
 Mon, 22 May 2023 07:51:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43B6E21E692E; Mon, 22 May 2023 09:51:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com
Subject: Re: [PATCH] qapi/parser: Fix type hints
References: <20230511111709.971477-1-armbru@redhat.com>
 <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org>
 <87sfbwx339.fsf@pond.sub.org>
 <053b071d-9a57-f4c5-b2bd-c2b26ff67c52@redhat.com>
Date: Mon, 22 May 2023 09:51:48 +0200
In-Reply-To: <053b071d-9a57-f4c5-b2bd-c2b26ff67c52@redhat.com> (Paolo
 Bonzini's message of "Wed, 17 May 2023 19:14:48 +0200")
Message-ID: <87zg5wolbf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 5/16/23 07:22, Markus Armbruster wrote:
>>>    File "/builds/qemu-project/qemu/scripts/qapi/parser.py", line 566, in QAPIDoc
>>>      def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
>>> TypeError: 'type' object is not subscriptable
>>
>> Life's too short for wrestling with such pigs.  Unless John has better
>> ideas, I'll *remove*  these return type annotations.  Maybe these pigs
>> will behave after John's Python venv work lands.
>
> re.Match[str] is new in 3.9.  However, typing.Match[str] should work.

We'll try that after John's venv work is in.  Thank you!



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3679D7044A2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 07:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyn90-0002iN-Hq; Tue, 16 May 2023 01:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyn8y-0002iA-DS
 for qemu-devel@nongnu.org; Tue, 16 May 2023 01:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pyn8w-0007xn-Hb
 for qemu-devel@nongnu.org; Tue, 16 May 2023 01:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684214557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DAq6o+o8gfB5BqN029Sfmkpf5x9Dfi/p6dfk+MXQCrI=;
 b=c0Wqt6OBF4/jes0q7/gftkFWKYTBs/70wehkbDHHMP0FWJNRf+lCxU+zAJQyyw1rAsTR7U
 DSxh1M1vlteux//7KPNpzfZ/2lkSFwJpTzffpfK6eQXauA1arEQdZObn411UWzwvOnl79S
 mOlFOobuyXbDDBxeFlNErianuNc4bcY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-bS7HfCzIO1u-mAQcqhi8ww-1; Tue, 16 May 2023 01:22:35 -0400
X-MC-Unique: bS7HfCzIO1u-mAQcqhi8ww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5651E1824600;
 Tue, 16 May 2023 05:22:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D521492B00;
 Tue, 16 May 2023 05:22:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1114521E6806; Tue, 16 May 2023 07:22:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com
Subject: Re: [PATCH] qapi/parser: Fix type hints
References: <20230511111709.971477-1-armbru@redhat.com>
 <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org>
Date: Tue, 16 May 2023 07:22:34 +0200
In-Reply-To: <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org> (Richard
 Henderson's message of "Mon, 15 May 2023 17:30:04 -0700")
Message-ID: <87sfbwx339.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/11/23 04:17, Markus Armbruster wrote:
>> Fixes: 3e32dca3f0d1 (qapi: Rewrite parsing of doc comment section symbols and tags)
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   scripts/qapi/parser.py | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 4923a59d60..9315412ab2 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -563,11 +563,11 @@ def end_comment(self) -> None:
>>           self._switch_section(QAPIDoc.NullSection(self._parser))
>>         @staticmethod
>> -    def _match_at_name_colon(string: str) -> re.Match:
>> +    def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
>>           return re.match(r'@([^:]*): *', string)
>>         @staticmethod
>> -    def _match_section_tag(string: str) -> re.Match:
>> +    def _match_section_tag(string: str) -> Optional[re.Match[str]]:
>>           return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
>>         def _append_body_line(self, line: str) -> None:
>
> Doesn't work:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4289613692#L574
>
>   File "/builds/qemu-project/qemu/scripts/qapi/parser.py", line 566, in QAPIDoc
>     def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
> TypeError: 'type' object is not subscriptable

Life's too short for wrestling with such pigs.  Unless John has better
ideas, I'll *remove* these return type annotations.  Maybe these pigs
will behave after John's Python venv work lands.



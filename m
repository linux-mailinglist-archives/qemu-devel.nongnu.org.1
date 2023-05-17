Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F90705FD1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 08:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzAW0-0006Bw-Nc; Wed, 17 May 2023 02:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzAVq-00067W-St
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzAVp-00067r-9W
 for qemu-devel@nongnu.org; Wed, 17 May 2023 02:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684304388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGDhZq6o+aMcsMoXZxC1345pm3ijUuJlLWZ/oUYb8go=;
 b=fCB61vQ4Ji4s0w8yJAoi7Wr7GXDH5u1ZVzsCvZX6d/LD4OIkR5xBzHdn5sdNgYsJ+um+1U
 EjUhDoLidU3J7hlOE6A5mH0tunm6aoSjB5KHyADfMYBWDMZDiPzlpQdkaJ6yw0U44QBDy5
 YgCDFMKFoLI388yjkuFpDd+lCCLsSbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-kRsKXCIiOo2zmMzloQmL8g-1; Wed, 17 May 2023 02:19:44 -0400
X-MC-Unique: kRsKXCIiOo2zmMzloQmL8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8279585A588;
 Wed, 17 May 2023 06:19:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 618181415304;
 Wed, 17 May 2023 06:19:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5632621E6806; Wed, 17 May 2023 08:19:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  michael.roth@amd.com,  jsnow@redhat.com,
 Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] qapi/parser: Fix type hints
References: <20230511111709.971477-1-armbru@redhat.com>
 <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org>
 <87sfbwx339.fsf@pond.sub.org>
 <d8faf35f-ec66-9bce-e34e-4bde0b4fcd24@linaro.org>
Date: Wed, 17 May 2023 08:19:43 +0200
In-Reply-To: <d8faf35f-ec66-9bce-e34e-4bde0b4fcd24@linaro.org> (Richard
 Henderson's message of "Tue, 16 May 2023 06:29:43 -0700")
Message-ID: <87zg63jx8g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

> On 5/15/23 22:22, Markus Armbruster wrote:
>>> https://gitlab.com/qemu-project/qemu/-/jobs/4289613692#L574
>>>
>>>    File "/builds/qemu-project/qemu/scripts/qapi/parser.py", line 566, in QAPIDoc
>>>      def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
>>> TypeError: 'type' object is not subscriptable
>> 
>> Life's too short for wrestling with such pigs.  Unless John has better
>> ideas, I'll *remove* these return type annotations.  Maybe these pigs
>> will behave after John's Python venv work lands.
>
> That is exactly the idea that I had as well.
>
> r~

Sent:

Subject: [PATCH] qapi/parser: Drop two bad type hints for now
Message-Id: <20230517061600.1782455-1-armbru@redhat.com>



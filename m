Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5855830D9F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 21:02:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQC60-0000V2-8W; Wed, 17 Jan 2024 15:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQC5x-0000UP-AO
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 15:01:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQC5v-00083x-JB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 15:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705521662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MD3Xija6z+LzO9X5SbvXF3ijWkoQZqpZNH/zuGVzXBc=;
 b=HLbCkvTcTF53oPOChB60F0An+uIGxUqS0ZvMZb/x9FUACcZfrkJtTW6kvluoE+LnxNJd9O
 rZzOtTNFeVpofnaXOtQitef3MmisZqKutLTyUKsEJXOhLfuyEyAuR0+v4Ay8I1uIokDFKm
 kYDCJ5J2In+kOvsF0Oki2KBybZFc6jg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-71zuv_GyOlS1eYb6EsMJrQ-1; Wed,
 17 Jan 2024 15:00:59 -0500
X-MC-Unique: 71zuv_GyOlS1eYb6EsMJrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C12A52812FF9;
 Wed, 17 Jan 2024 20:00:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92B2B3C25;
 Wed, 17 Jan 2024 20:00:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B26421E6806; Wed, 17 Jan 2024 21:00:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 11/19] qapi/schema: fix QAPISchemaArrayType.check's
 call to resolve_type
In-Reply-To: <CAFn=p-YuZhn5tBBvkTeDvFH+Sgt0knnpjcJb003FX1FUsBnrXw@mail.gmail.com>
 (John Snow's message of "Wed, 17 Jan 2024 11:48:20 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-12-jsnow@redhat.com>
 <87le8ptqv7.fsf@pond.sub.org>
 <CAFn=p-YuZhn5tBBvkTeDvFH+Sgt0knnpjcJb003FX1FUsBnrXw@mail.gmail.com>
Date: Wed, 17 Jan 2024 21:00:56 +0100
Message-ID: <87edefenlz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Tue, Jan 16, 2024 at 7:17=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Adjust the expression at the callsite to eliminate weak type
>> > introspection that believes this value can resolve to QAPISourceInfo; =
it
>> > cannot.
>>
>> What do you mean by "weak type introspection"?  mypy being underpowered?
>
> Yeah, s'what I meant.

Should be easy to clarify: mention mypy.



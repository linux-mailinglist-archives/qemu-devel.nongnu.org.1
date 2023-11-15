Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938D7EC843
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3IY5-0005lB-0W; Wed, 15 Nov 2023 11:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3IXv-0005f7-UY
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3IXt-0002P0-V0
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700064915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qfx4gIohobWr46SszJdmblBTjzb57bNgE+CFFlirW0k=;
 b=d9TUPcoaMTX3TWVe4vaq6Sb4WD+Oewjy4FeAxR5BhCgo7Es7vvuQuf6yGfQt57jhVODDt9
 sA/h7Mzh0E14mcqI4tOHjGI6TWbzSszNhFBa2eC2J5Ek1SiW5D6+7nAXvj6IiQAVDLHb/N
 t5kSeGbTdwpFld5AFWOn2oaHUEbEvfU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-p3ahkPTgODeUhuOz987HEA-1; Wed, 15 Nov 2023 11:15:14 -0500
X-MC-Unique: p3ahkPTgODeUhuOz987HEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E838C101A52D;
 Wed, 15 Nov 2023 16:15:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4D70492BE0;
 Wed, 15 Nov 2023 16:15:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C11F221E6A1F; Wed, 15 Nov 2023 17:15:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com> <875y23s918.fsf@pond.sub.org>
 <17078387-f782-42dc-a5bf-25ee22bc518a@oracle.com>
Date: Wed, 15 Nov 2023 17:15:12 +0100
In-Reply-To: <17078387-f782-42dc-a5bf-25ee22bc518a@oracle.com> (Steven
 Sistare's message of "Wed, 15 Nov 2023 10:52:43 -0500")
Message-ID: <87a5rfkn73.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 11/15/2023 3:41 AM, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>>>> On 11/3/2023 1:33 PM, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>>>> Buffered monitor output is lost when abort() is called.  The pattern
>>>>>> error_report() followed by abort() occurs about 60 times, so valuable
>>>>>> information is being lost when the abort is called in the context of=
 a
>>>>>> monitor command.
>>>>>
>>>>> I'm curious, was there a particular abort() scenario that you hit ?
>>>>
>>>> Yes, while tweaking the suspended state, and forgetting to add transit=
ions:
>>>>
>>>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>>>         abort();
>>>>
>>>> But I have previously hit this for other errors.
>>=20
>> Can you provide a reproducer?
>
> I sometimes hit this when developing new code.  I do not have a reproduce=
r for upstream
> branches. The patch is aimed at helping developers, not users.

I'm asking because I can't see how the error message could be lost.  A
reproducer would let me find out.  "Apply this set of broken patches,
then do that" would serve.

[...]



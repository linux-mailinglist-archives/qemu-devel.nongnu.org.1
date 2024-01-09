Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D06982843B
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 11:49:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN9eK-0006zL-Lp; Tue, 09 Jan 2024 05:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rN9eI-0006yj-Jz
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rN9eF-0007L0-Dr
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704797273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WeE9p1KtNiMS+m1qiSiYi66/Rm0PEV09UDX3wJbs64A=;
 b=ZT3Bcj6e2NmULIF87C4NaotYT1W5P1l5/xjwqKGNDXs1074gDNx8WDOhrs+T8UA1Aejqru
 Ktr+7ZwfQvJH04OvkgXlvSWPHjHiMMyw6BeJwMnmnbjdyM80TsxfI4CZaRqMODOVnbmWBY
 uAtd2kZOk5DS+QZYhQixeVajGXWXRzE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-5dXObOloPIqrJU1vnaNEbA-1; Tue, 09 Jan 2024 05:47:49 -0500
X-MC-Unique: 5dXObOloPIqrJU1vnaNEbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B8F68E4ABA;
 Tue,  9 Jan 2024 10:47:48 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BADF7C15E6A;
 Tue,  9 Jan 2024 10:47:46 +0000 (UTC)
Date: Tue, 9 Jan 2024 11:47:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Frederic Konrad <fkonrad@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/5] qdev-properties: Try to improve use of dynamic
 property introspection
Message-ID: <ZZ0kUcy14YA8t3Pd@redhat.com>
References: <20240102160455.68612-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102160455.68612-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 02.01.2024 um 17:04 hat Philippe Mathieu-Daudé geschrieben:
> Hi,
> 
> This RFC series tries to work over some limitations exposed in
> https://lore.kernel.org/qemu-devel/9293e63b-8032-4ea0-b516-9db6949fb607@linaro.org/
> 
> Eventually all QDev objects would use static QOM properties,
> but in some cases we can not. ARMv7MState is a such example
> adding properties that might end up irrelevant.
> 
> This is just an example, but thinking long term (in particular
> in the context of dynamic machines) I'm looking at how this
> could be improved. Thus this series. I don't like much this
> current approach (because more boiler place and complexity)
> however this seems to DTRT for the user.

This doesn't feel like the right approach to me. If you were to describe
the properties of armv7m in the QAPI schema language without looking at
the implementation, you would never add something like OptionalBool.

I'm not entirely sure if I understand the details of the problem, so if
I make wrong assumptions below, please correct me.

I think what you would get instead is a union with the different CPU
types as union variants. You would have few fields in the base type
(cpu-type, memory, etc.), and everything specific to the variant, you
wouldn't even want to look at in armv7m, but just forward it to the CPU.

Now of course actually getting this QAPIfied is not something to expect
in the next few days, so let's get back to the QOM level, but keep the
general idea in mind.

Based on the above, I'd argue that armv7m shouldn't even have the
properties that it only uses to forward them. Instead, we should let the
CPU grab its properties directly from the configuration. The way we
create objects currently is not really designed for this. But let's get
back to the QOM/QAPI integration patches [1] I sent two years ago and
suddently it becomes quite easy: armv7m's .instance_config simply calls
the CPU's .instance_config and passes its visitor. Then the CPU takes
the options it needs for its properties and that's it.

I discussed this series with Markus recently, and I actually assume that
he at least mentioned it to you when you discussed things with him. I
believe the part that you would need here (only up to patch 4 really) is
pretty much uncontroversial.

Of course, I ignored several "details" here, but I think the idea should
still be workable. Some of those details:

* This approach requires that the CPUs are first converted to have
  static properties, but given that making everything static is your
  goal, I assume that's not a problem.

* The CPU must actually exist when you want to set properties for it.
  This probably means moving creating the CPU from realize to the new
  instance_config.

* My patches are for object-add, but we're coming from board code here.
  So the callers would have to be changed to call .instance_config
  (probalby indirectly through object_configure()) instead of setting
  individual properties.

All of this is additional work, but it doesn't look like exceedingly
hard work.

Kevin

[1] https://patchew.org/QEMU/20211103173002.209906-1-kwolf@redhat.com/



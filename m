Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC07A8BF1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj25c-0005FY-T7; Wed, 20 Sep 2023 14:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj25a-0005EA-MZ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj25Y-0004Ci-MM
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695235095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxEGOomhqeD2FENw5ngprh+gOOO1TwTmrMgyNhueWdc=;
 b=QIT1NiF2dbzSg7TZ8imdUsLATkpp7TNnxQ3VRik1OEwfOi8xYWlTBv0PcDXDeA4l/dFah8
 VnzLEg8+/ZUzPFIgh6S+h4q0NpmHPryD9DyozTTn6SWj2gQxo8Fw2ikpJvsMF9br0eBdDf
 SI4RKzEvq50QN7vSqtJzuTLGLgdjVI4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-Cvh_KjQYPDypz5oj_Dlmow-1; Wed, 20 Sep 2023 14:38:10 -0400
X-MC-Unique: Cvh_KjQYPDypz5oj_Dlmow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C88B1C06369;
 Wed, 20 Sep 2023 18:38:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8BBA20268CF;
 Wed, 20 Sep 2023 18:38:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7ACFF21E6900; Wed, 20 Sep 2023 20:38:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 laurent@vivier.eu,
 qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
 <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
 <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
 <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org>
 <87ledd1eaz.fsf@pond.sub.org>
 <ae8d9cc8-d633-0ea0-3714-352e87bddede@ilande.co.uk>
Date: Wed, 20 Sep 2023 20:38:07 +0200
In-Reply-To: <ae8d9cc8-d633-0ea0-3714-352e87bddede@ilande.co.uk> (Mark
 Cave-Ayland's message of "Wed, 20 Sep 2023 16:41:33 +0100")
Message-ID: <87r0msbshc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 11/09/2023 06:15, Markus Armbruster wrote:
>
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

[...]

>>> I'm not sure when we want a write-only QOM boolean property, so I
>>> genuinely ask, since I agree introspecting QOM object fields from
>>> the monitor is helpful.
>>
>> I suspect write-only properties came out of QOM's generality curse.  Do
>> we have even one?  QOM's design makes this somewhat to tell.
>
> Good question. Given that it's towards the beginning of the next dev cycl=
e, perhaps it is worth sending a patch to find out? ;)

Getting rid of unused generality / unnecessary complexity is good.



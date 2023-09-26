Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DBE7AE641
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1us-0008K2-GY; Tue, 26 Sep 2023 02:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1uk-0008Ao-BH
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ql1ui-0002Ht-TX
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695711079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRnVZH4Xpq9UPqnu+4CjwJAcPIDD7ypTdPecbJ/zx3o=;
 b=QGJRzC9d1eBTuURfuG1i/Yn4bvtVtbLDFUMOT4sZxLEnm/yuEMW4OjWSZCcEMA7pThCGBZ
 t/hX3cmKrSmXcZCGUDZAsSMuY7JfvHk2Qd5nPlNNCM055lMmyFcLPIYjxJj57RGk8LV+9f
 KaU8oh/JzIMLqGgZ+3ULTS77d//Jxwo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-HGpQj9j4PuiAVQca91XXNw-1; Tue, 26 Sep 2023 02:51:17 -0400
X-MC-Unique: HGpQj9j4PuiAVQca91XXNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 777303C23FCB;
 Tue, 26 Sep 2023 06:51:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51F5740C6EA8;
 Tue, 26 Sep 2023 06:51:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C92721E6900; Tue, 26 Sep 2023 08:51:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,  Philippe =?utf-8?Q?Mathie?=
 =?utf-8?Q?u-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 13/15] hw/qdev: Remove DEFINE_PROP_DMAADDR() and
 'hw/qdev-dma.h'
References: <20230203145536.17585-1-philmd@linaro.org>
 <20230203145536.17585-14-philmd@linaro.org>
 <87zg1a8r5v.fsf@pond.sub.org> <87bkdq8qh1.fsf@pond.sub.org>
 <0e258375-e3a0-8b5d-189e-cb2cea913ecb@redhat.com>
Date: Tue, 26 Sep 2023 08:51:14 +0200
In-Reply-To: <0e258375-e3a0-8b5d-189e-cb2cea913ecb@redhat.com> (Paolo
 Bonzini's message of "Mon, 25 Sep 2023 18:41:12 +0200")
Message-ID: <878r8tjul9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 9/25/23 13:03, Markus Armbruster wrote:
>> +David
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>
>>>> DEFINE_PROP_DMAADDR() is only used once. Since it doesn't
>>>> add much value, simply remove it, along with the header
>>>> defining it.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>
>>> DEFINE_PROP_DMAADDR() lets you wrap a property around a dma_addr_t
>>> member without assuming anything about dma_addr_t.
>>>
>>> Whether that's worth avoiding I can't say.  Depends on how much the
>>> abstraction leaks in other ways.  Thoughts?
>
> I think it's okay to simplify things.  If anybody ever has a reason to ma=
ke dma_addr_t variable sized (probably a bad idea because many of its users=
 are compiled once only) they have one extra place to fix.  Tough luck. :)

Makes sense.

Reviewed-by: Markus Armbruster <armbru@redhat.com>



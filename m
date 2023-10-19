Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 024CF7CEEFA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 07:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtLUM-0007GT-Um; Thu, 19 Oct 2023 01:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtLUL-0007GK-G4
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 01:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtLUJ-0007Vt-Lx
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 01:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697692946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtfV+H6okNA4wZcfRZ3QoKrj2CyB9Ytptylan0K7sBc=;
 b=exQpuyxuxjsk6rISRfoPtnwoGYiRI0GuiWA/SHjQcz+PdQagG/bbdx9bGyqTzdQ6iINx19
 EMjRTwAs9KY5GDaV3ZsSeFhuw0X+6Uq/WZZ9AeL81XfuLJGuMsbprA5lqIk47EJ1uReIU8
 4J2X3BP0pZ0w8vX1nHNyjhQ8rY2I+a8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-0VcG6mnbMpejxovrw9k36w-1; Thu, 19 Oct 2023 01:22:22 -0400
X-MC-Unique: 0VcG6mnbMpejxovrw9k36w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C0273806107;
 Thu, 19 Oct 2023 05:22:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EFB0225C8;
 Thu, 19 Oct 2023 05:22:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E850A21E6A1F; Thu, 19 Oct 2023 07:22:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v3] qapi: provide a friendly string representation of
 QAPI classes
References: <20231018120500.2028642-1-berrange@redhat.com>
 <87y1g0nm1y.fsf@pond.sub.org> <ZS/XgggmI0aoYJR0@redhat.com>
 <f12e8129-a77d-e8ee-2a25-b31b5729a0f5@linaro.org>
Date: Thu, 19 Oct 2023 07:22:20 +0200
In-Reply-To: <f12e8129-a77d-e8ee-2a25-b31b5729a0f5@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 18 Oct 2023 15:20:10
 +0200")
Message-ID: <87il73mbjn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 18/10/23 15:02, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Oct 18, 2023 at 02:37:45PM +0200, Markus Armbruster wrote:
>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>
>>>> If printing a QAPI schema object for debugging we get the classname and
>>>> a hex value for the instance:
>>>>
>>>>    <qapi.schema.QAPISchemaEnumType object at 0x7f0ab4c2dad0>
>>>>    <qapi.schema.QAPISchemaObjectType object at 0x7f0ab4c2dd90>
>>>>    <qapi.schema.QAPISchemaArrayType object at 0x7f0ab4c2df90>
>>>>
>>>> With this change we instead get the classname and the human friendly
>>>> name of the QAPI type instance:
>>>>
>>>>    <QAPISchemaEnumType:CpuS390State at 0x7f0ab4c2dad0>
>>>>    <QAPISchemaObjectType:CpuInfoS390 at 0x7f0ab4c2dd90>
>>>>    <QAPISchemaArrayType:CpuInfoFastList at 0x7f0ab4c2df90>
>>>>
>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>> ---
>
>
>>> Mind if I swap things?  Like so:
>>>
>>>      def __repr__(self):
>>>          if self.name is None:
>>>              return "<%s at 0x%x>" % (type(self).__name__, id(self))
>>>          else:
>>>              return "<%s:%s at 0x%x>" % (type(self).__name__,
>>>                                          self.name, id(self))
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Actually, I'd like to make this

    def __repr__(self):
        if self.name is None:
            return "<%s at 0x%x>" % (type(self).__name__, id(self))
        return "<%s:%s at 0x%x>" % type(self).__name__, self.name, id(self)

to avoid pylint's refactoring checker message

    +scripts/qapi/schema.py:77:8: R1705: Unnecessary "else" after "return",=
 remove the "else" and de-indent the code inside it (no-else-return)

Queued.  Thanks!



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3F786741
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 07:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ3IY-0002YM-0E; Thu, 24 Aug 2023 01:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZ3IW-0002Y9-GZ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 01:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZ3IS-0000Xp-EZ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 01:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692856458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jpgbh+1g4UlCGAndm6EgiOuGYQAZDsGP7BnVnoFa+wA=;
 b=XC7/ClIyH4JYZ0qrJEjEEOl8zfzfxBBTVRCuD5CWP0uFEpLUFhJdCCP+7QFlekxCw/bAdn
 i1tP3cT3W35mBYT/qTZnZOjGbYTJrEulHnKIr5K8n1KNT3omopipHWnFOXKppdWbsYaWao
 Dv49l2rg3hCdd3p3ZtMMCq1NDqxcldc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-bvBV7N93O7GEUNv-LClPfQ-1; Thu, 24 Aug 2023 01:54:16 -0400
X-MC-Unique: bvBV7N93O7GEUNv-LClPfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D9F185A791;
 Thu, 24 Aug 2023 05:54:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA1D2492C13;
 Thu, 24 Aug 2023 05:54:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C524F21E690D; Thu, 24 Aug 2023 07:54:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Liu Jaloo <liu.jaloo@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: constructor vs. __constructor__
References: <CAOYM0N261g8zrDKq2jQo4mriHEhNXWo-oXZ0LCryL+BmUX-h6g@mail.gmail.com>
Date: Thu, 24 Aug 2023 07:54:14 +0200
In-Reply-To: <CAOYM0N261g8zrDKq2jQo4mriHEhNXWo-oXZ0LCryL+BmUX-h6g@mail.gmail.com>
 (Liu Jaloo's message of "Thu, 24 Aug 2023 11:24:00 +0800")
Message-ID: <87jztlt27t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Liu Jaloo <liu.jaloo@gmail.com> writes:

> What's the difference between  "__attribute__((constructor))" and
> "__attribute__((__constructor__))" in qemu source?

Reading the fine manual helps:

    You may optionally specify attribute names with =E2=80=98__=E2=80=99 pr=
eceding and
    following the name.  This allows you to use them in header files
    without being concerned about a possible macro of the same name. For
    example, you may use the attribute name __noreturn__ instead of
    noreturn.

https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html



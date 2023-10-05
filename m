Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351A7B9D97
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOki-0004N9-SZ; Thu, 05 Oct 2023 09:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoOkg-0004MI-AL
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:50:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoOke-000869-Sw
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696513850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+aTixGgJote8cKgx77d6vFHfq7qN1ogOnnuXux4EvA=;
 b=H+H/n6EyvEwOlpqXMLkAW1DY2G+URADX+6P5hKg8EkJTjNM5egk8aKFTc5qdw5NmU70ZPE
 5LALCRMgZGJze4q3tXgM/CzkN0T5JfFrI/sT8l03luC7RJBuv0rPAfHoF/EuqUw/tbrnAz
 LjW5GTl0bKmRRVqE9LQi4kS7XgZjJt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-A6vpPNqnPUSpI2ExPGPkHA-1; Thu, 05 Oct 2023 09:50:37 -0400
X-MC-Unique: A6vpPNqnPUSpI2ExPGPkHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93AEF811E8F;
 Thu,  5 Oct 2023 13:50:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68A9E40C2015;
 Thu,  5 Oct 2023 13:50:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7940221E6904; Thu,  5 Oct 2023 15:50:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Daniel
 Henrique Barboza <danielhb413@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: MAINTAINERS still leaves more files uncovered than I'd like
References: <87lecp6w7x.fsf@pond.sub.org>
 <88854727-a895-3727-8cd9-592caa41c3fc@kaod.org>
Date: Thu, 05 Oct 2023 15:50:35 +0200
In-Reply-To: <88854727-a895-3727-8cd9-592caa41c3fc@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Mon, 2 Oct 2023 13:35:48 +0200")
Message-ID: <87v8blxjo4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Regarding PPC, I am not sure where these common PPC files should go :
>
>  configs/targets/ppc*
>  docs/system/ppc/embedded.rst
>  docs/system/target-ppc.rst
>  hw/ppc/meson.build
>  hw/ppc/trace*
>
> under "PowerPC TCG CPUs" may be ?
>
> These files :
>
>  tests/tcg/ppc*
>
> should go under "PPC TCG target" I believe.

Suggest to check other targets for precedence you like.  Preferably
well-maintained ones.

For what it's worth, Risc-V and CRIS keep it under "RISC-V TCG CPUs" and
"CRIS TCG CPUs", respectively.  S390 keeps it under "S390 general
architecture support".

> I have patches for the rest.
>
> Thanks,
>
> C.



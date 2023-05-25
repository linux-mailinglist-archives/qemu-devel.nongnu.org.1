Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F08710B12
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q290k-0005oO-Ep; Thu, 25 May 2023 07:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q290i-0005o9-6X
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q290g-0005WN-6y
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685013596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kEWNqiKYOt7grnFxmTR+S5vzgdpFP6NAU91irTmCwW4=;
 b=bGKxbWkfO4bamf0g0t85FKjLg4kH5yxNyfyZRbE0v25M4mIOw2orow9NDOGLpYHxEtLru9
 w2N4kUuzQtnXsTfxJPive9mAmhnpeeEZRCY0u/54eD1ZkiuydlIHqGRgBSLA6QVLPXL07Y
 ZDtYagyt7YRmCuzcpywrrV+/5SALXUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-YVfV8NmAOTuDUQ_27Q9WAA-1; Thu, 25 May 2023 07:19:53 -0400
X-MC-Unique: YVfV8NmAOTuDUQ_27Q9WAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3148101A52C;
 Thu, 25 May 2023 11:19:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6304140E961;
 Thu, 25 May 2023 11:19:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D797E21E692E; Thu, 25 May 2023 13:19:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  qemu-devel@nongnu.org,  Kyle
 Evans <kevans@freebsd.org>,  libvir-list@redhat.com,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Greg Kurz
 <groug@kaod.org>,  Eric
 Blake <eblake@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Michael Roth <michael.roth@amd.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Christian Schoenebeck
 <qemu_oss@crudebyte.com>,  Riku Voipio <riku.voipio@iki.fi>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [PATCH v5 04/10] scripts/qapi: document the tool that generated
 the file
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
 <20230524133952.3971948-5-alex.bennee@linaro.org>
Date: Thu, 25 May 2023 13:19:50 +0200
In-Reply-To: <20230524133952.3971948-5-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Wed, 24 May 2023 14:39:46 +0100")
Message-ID: <87jzwwslnt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This makes it a little easier for developers to find where things
> where being generated.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20230523125000.3674739-5-alex.bennee@linaro.org>
> ---
>  scripts/qapi/gen.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index 8f8f784f4a..2ea27ef31c 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -13,6 +13,7 @@
>=20=20
>  from contextlib import contextmanager
>  import os
> +import sys
>  import re
>  from typing import (
>      Dict,
> @@ -162,7 +163,7 @@ def __init__(self, fname: str, blurb: str, pydoc: str=
):
>=20=20
>      def _top(self) -> str:
>          return mcgen('''
> -/* AUTOMATICALLY GENERATED, DO NOT MODIFY */
> +/* AUTOMATICALLY GENERATED by %(tool)s DO NOT MODIFY */
>=20=20
>  /*
>  %(blurb)s
> @@ -174,6 +175,7 @@ def _top(self) -> str:
>   */
>=20=20
>  ''',
> +                     tool=3Dstr(os.path.basename(sys.argv[0])),
>                       blurb=3Dself._blurb, copyright=3Dself._copyright)
>=20=20
>      def _bottom(self) -> str:
> @@ -195,7 +197,9 @@ def _bottom(self) -> str:
>=20=20
>  class QAPIGenTrace(QAPIGen):
>      def _top(self) -> str:
> -        return super()._top() + '# AUTOMATICALLY GENERATED, DO NOT MODIF=
Y\n\n'
> +        return super()._top() + (
> +            '# AUTOMATICALLY GENERATED by '
> +            f"{os.path.basename(sys.argv[0])}, DO NOT MODIFY\n\n" )

Style nitpicks:

* Please don't mix single and double quotes like that.

* You use an f-string to concatenate strings, within a string
  concatenation with operator +.  Let's to mix two ways to do the same
  thing.

* I find the way you break the long line hard to read.

I'd do

        return (super()._top()
                + '# AUTOMATICALLY GENERATED by '
                + os.path.basename(sys.argv[0])
                + ', DO NOT MODIFY\n\n')

>=20=20
>=20=20
>  @contextmanager

With that
Reviewed-by: Markus Armbruster <armbru@redhat.com>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C13F07D103F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAv-0001MZ-Q8; Fri, 20 Oct 2023 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtpAr-00014Y-TD
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qtpAq-0005NN-AW
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697807058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JCM6hHA8vqMFLZhCMsVwBf3PmmmXEemNFWhJU6oiIs=;
 b=PyXv+y9i6qsqFGBDVsdtXsWTN58kH3ChjBOU5P4BmzU1zVjx3ZcAlMflVDsF9s8DbEu1O6
 5LfzV4ZOCOOzENzYpBea401jI5z9VzygdGqS2uC01CXUtEWeK1MsHocWkDjPZHHKAqXCRR
 pTORxEbEaOjuabQakV0Rm+WlhJKgSB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Qjc4ONc0O1O8nYgaTd453w-1; Fri, 20 Oct 2023 09:03:50 -0400
X-MC-Unique: Qjc4ONc0O1O8nYgaTd453w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47E6510201E0;
 Fri, 20 Oct 2023 13:03:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22B1040C6F7B;
 Fri, 20 Oct 2023 13:03:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 088A621E6A1F; Fri, 20 Oct 2023 15:03:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 20/22] qapi: Inline and remove
 QERR_QGA_COMMAND_FAILED definition
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-21-philmd@linaro.org>
Date: Fri, 20 Oct 2023 15:03:49 +0200
In-Reply-To: <20231005045041.52649-21-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:37
 +0200")
Message-ID: <877cnh1m4q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using the following
> coccinelle semantic patch:
>
>     @match exists@
>     expression errp;
>     expression errmsg;
>     @@
>          error_setg(errp, QERR_QGA_COMMAND_FAILED, errmsg);
>
>     @script:python strformat depends on match@
>     errmsg << match.errmsg;
>     fixedfmt; // new var
>     @@
>     # Format skipping '"'.
>     fixedfmt =3D f'"Guest agent command failed, error was \'{errmsg[1:-1]=
}\'"'
>     coccinelle.fixedfmt =3D cocci.make_ident(fixedfmt)
>
>     @replace@
>     expression match.errp;
>     expression match.errmsg;
>     identifier strformat.fixedfmt;
>     @@
>     -    error_setg(errp, QERR_QGA_COMMAND_FAILED, errmsg);
>     +    error_setg(errp, fixedfmt);
>
> then manually removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/qapi/qmp/qerror.h |  3 ---
>  qga/commands-win32.c      | 38 ++++++++++++++++++++------------------
>  qga/commands.c            |  7 ++++---
>  3 files changed, 24 insertions(+), 24 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index e094f13114..840831cc6a 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,9 +17,6 @@
>   * add new ones!
>   */
>=20=20
> -#define QERR_QGA_COMMAND_FAILED \
> -    "Guest agent command failed, error was '%s'"
> -
>  #define QERR_UNSUPPORTED \
>      "this feature or command is not currently supported"
>=20=20
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 946dbafbb6..aa8c9770d4 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -245,7 +245,8 @@ int64_t qmp_guest_file_open(const char *path, const c=
har *mode, Error **errp)
>=20=20
>  done:
>      if (gerr) {
> -        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
> +        error_setg(errp,
> +                   "Guest agent command failed, error was 'err -> messag=
'");

Oopsie :)

Two more below.

>          g_error_free(gerr);
>      }
>      g_free(w_path);
> @@ -279,8 +280,8 @@ static void acquire_privilege(const char *name, Error=
 **errp)
>          TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &token))
>      {
>          if (!LookupPrivilegeValue(NULL, name, &priv.Privileges[0].Luid))=
 {
> -            error_setg(errp, QERR_QGA_COMMAND_FAILED,
> -                       "no luid for requested privilege");
> +            error_setg(errp,
> +                       "Guest agent command failed, error was 'no luid f=
or requested privilege'");
>              goto out;
>          }
>=20=20

I don't like this error message.  I'm going to pretend I didn't see it.

[...]



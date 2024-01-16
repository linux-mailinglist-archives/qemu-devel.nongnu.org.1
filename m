Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963782F447
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 19:30:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPoBS-0001Kn-7g; Tue, 16 Jan 2024 13:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPoBQ-0001KJ-HN
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 13:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPoBN-0007Jm-PK
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 13:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705429745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wtVaNj9yM+ZQPfYZrNpMFmaAXCev1wDs/radnSCPDQ8=;
 b=MNyxL9vXF9Gnlfx8WV+SeVf1jnN1ibBtNHzvYEf3KOFOtN+zmsZgvWABci7Z3jYrVkV/Pi
 A58AI3umKt8yCBGxmRobRlVF/DMzJqNllnAaqPPh1gqMTcOaf2kN4P/meDOJXPs7W/T5el
 Q0gOa4s9dmBytsC7PhP7Db5VBaQChpQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-L-rACjusPDeTT2mfh2KIgQ-1; Tue,
 16 Jan 2024 13:29:01 -0500
X-MC-Unique: L-rACjusPDeTT2mfh2KIgQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CDBD38130B5;
 Tue, 16 Jan 2024 18:29:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A85A492BC6;
 Tue, 16 Jan 2024 18:29:00 +0000 (UTC)
Date: Tue, 16 Jan 2024 13:28:58 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, aliang@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] string-output-visitor: Fix (pseudo) struct handling
Message-ID: <20240116182858.GA945942@fedora>
References: <20240109181717.42493-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tGZuV6WhliwM9J/h"
Content-Disposition: inline
In-Reply-To: <20240109181717.42493-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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


--tGZuV6WhliwM9J/h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 07:17:17PM +0100, Kevin Wolf wrote:
> Commit ff32bb53 tried to get minimal struct support into the string
> output visitor by just making it return "<omitted>". Unfortunately, it
> forgot that the caller will still make more visitor calls for the
> content of the struct.
>=20
> If the struct is contained in a list, such as IOThreadVirtQueueMapping,
> in the better case its fields show up as separate list entries. In the
> worse case, it contains another list, and the string output visitor
> doesn't support nested lists and asserts that this doesn't happen. So as
> soon as the optional "vqs" field in IOThreadVirtQueueMapping is
> specified, we get a crash.
>=20
> This can be reproduced with the following command line:
>=20
>   echo "info qtree" | ./qemu-system-x86_64 \
>     -object iothread,id=3Dt0 \
>     -blockdev null-co,node-name=3Ddisk \
>     -device '{"driver": "virtio-blk-pci", "drive": "disk",
>               "iothread-vq-mapping": [{"iothread": "t0", "vqs": [0]}]}' \
>     -monitor stdio
>=20
> Fix the problem by counting the nesting level of structs and ignoring
> any visitor calls for values (apart from start/end_struct) while we're
> not on the top level.
>=20
> Fixes: ff32bb53476539d352653f4ed56372dced73a388
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2069
> Reported-by: Aihua Liang <aliang@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/string-output-visitor.c | 46 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Thanks for getting to this before I could:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

> diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
> index f0c1dea89e..5115536b15 100644
> --- a/qapi/string-output-visitor.c
> +++ b/qapi/string-output-visitor.c
> @@ -65,6 +65,7 @@ struct StringOutputVisitor
>      } range_start, range_end;
>      GList *ranges;
>      void *list; /* Only needed for sanity checking the caller */
> +    unsigned int struct_nesting;
>  };
> =20
>  static StringOutputVisitor *to_sov(Visitor *v)
> @@ -144,6 +145,10 @@ static bool print_type_int64(Visitor *v, const char =
*name, int64_t *obj,
>      StringOutputVisitor *sov =3D to_sov(v);
>      GList *l;
> =20
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      switch (sov->list_mode) {
>      case LM_NONE:
>          string_output_append(sov, *obj);
> @@ -231,6 +236,10 @@ static bool print_type_size(Visitor *v, const char *=
name, uint64_t *obj,
>      uint64_t val;
>      char *out, *psize;
> =20
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      if (!sov->human) {
>          out =3D g_strdup_printf("%"PRIu64, *obj);
>          string_output_set(sov, out);
> @@ -250,6 +259,11 @@ static bool print_type_bool(Visitor *v, const char *=
name, bool *obj,
>                              Error **errp)
>  {
>      StringOutputVisitor *sov =3D to_sov(v);
> +
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      string_output_set(sov, g_strdup(*obj ? "true" : "false"));
>      return true;
>  }
> @@ -260,6 +274,10 @@ static bool print_type_str(Visitor *v, const char *n=
ame, char **obj,
>      StringOutputVisitor *sov =3D to_sov(v);
>      char *out;
> =20
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      if (sov->human) {
>          out =3D *obj ? g_strdup_printf("\"%s\"", *obj) : g_strdup("<null=
>");
>      } else {
> @@ -273,6 +291,11 @@ static bool print_type_number(Visitor *v, const char=
 *name, double *obj,
>                                Error **errp)
>  {
>      StringOutputVisitor *sov =3D to_sov(v);
> +
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      string_output_set(sov, g_strdup_printf("%.17g", *obj));
>      return true;
>  }
> @@ -283,6 +306,10 @@ static bool print_type_null(Visitor *v, const char *=
name, QNull **obj,
>      StringOutputVisitor *sov =3D to_sov(v);
>      char *out;
> =20
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      if (sov->human) {
>          out =3D g_strdup("<null>");
>      } else {
> @@ -295,6 +322,9 @@ static bool print_type_null(Visitor *v, const char *n=
ame, QNull **obj,
>  static bool start_struct(Visitor *v, const char *name, void **obj,
>                           size_t size, Error **errp)
>  {
> +    StringOutputVisitor *sov =3D to_sov(v);
> +
> +    sov->struct_nesting++;
>      return true;
>  }
> =20
> @@ -302,6 +332,10 @@ static void end_struct(Visitor *v, void **obj)
>  {
>      StringOutputVisitor *sov =3D to_sov(v);
> =20
> +    if (--sov->struct_nesting) {
> +        return;
> +    }
> +
>      /* TODO actually print struct fields */
>      string_output_set(sov, g_strdup("<omitted>"));
>  }
> @@ -312,6 +346,10 @@ start_list(Visitor *v, const char *name, GenericList=
 **list, size_t size,
>  {
>      StringOutputVisitor *sov =3D to_sov(v);
> =20
> +    if (sov->struct_nesting) {
> +        return true;
> +    }
> +
>      /* we can't traverse a list in a list */
>      assert(sov->list_mode =3D=3D LM_NONE);
>      /* We don't support visits without a list */
> @@ -329,6 +367,10 @@ static GenericList *next_list(Visitor *v, GenericLis=
t *tail, size_t size)
>      StringOutputVisitor *sov =3D to_sov(v);
>      GenericList *ret =3D tail->next;
> =20
> +    if (sov->struct_nesting) {
> +        return ret;
> +    }
> +
>      if (ret && !ret->next) {
>          sov->list_mode =3D LM_END;
>      }
> @@ -339,6 +381,10 @@ static void end_list(Visitor *v, void **obj)
>  {
>      StringOutputVisitor *sov =3D to_sov(v);
> =20
> +    if (sov->struct_nesting) {
> +        return;
> +    }
> +
>      assert(sov->list =3D=3D obj);
>      assert(sov->list_mode =3D=3D LM_STARTED ||
>             sov->list_mode =3D=3D LM_END ||
> --=20
> 2.43.0
>=20

--tGZuV6WhliwM9J/h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWmyuoACgkQnKSrs4Gr
c8i2hwf/SHj2plbFxqoZktWhifh6Wvz3W9jcL4bqV+IaeqT7vIORTrfo6QG2SNku
r8/NpbJW2XEAWEF4X3F0zedBwVD0ciCfs/e/unvNzUfBsB868pjEgRFPwzq98e/3
k+ryTAt39p8O0aPYqpfOBuYXf/+bn1Fftm0aqYQ+P1Ld1X8gg2SgS60I8CCte3bG
WfI097joKdW1QEYH/MiqMgK9Cniyo27KD3hgiMolzlMj+6DO8ERTz0x1SAT+HMx3
u+PxmP8Yr24LIA3o8By7fJoe+74WitkCCuvZKeuhem4HUmBOMUL1/DSskRMTO8Ht
VMXAouE9GCTjPjYHlfGhK+TAqel9zg==
=D5nX
-----END PGP SIGNATURE-----

--tGZuV6WhliwM9J/h--



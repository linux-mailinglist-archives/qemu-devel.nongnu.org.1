Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F027BBED7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 20:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoplY-0000s0-2t; Fri, 06 Oct 2023 14:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoplT-0000qa-Tu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 14:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoplN-0007bi-Bu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 14:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696617683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRouWiO/ByfbBTP2+9Old0e5rG+ytuJBjx3d90TjyeM=;
 b=Tc1NwLO3F6nKDIp7oKHKgTTXsTAwVUSDMowch8exMWAHKNAfXmqhisg8lQURQcDdkYOppK
 nL6D6DdMsp66H/FlAJmi8Tp7UF+jpi7PUkdgovZibNAsx1SzztCOjnNXXOq59YHcSWUxZW
 Gm+5tuMm7BCDvyVGy0p/usponMcIoIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-A0Uzeh6vMLKvhBZFcvH6gw-1; Fri, 06 Oct 2023 14:41:22 -0400
X-MC-Unique: A0Uzeh6vMLKvhBZFcvH6gw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C203118153E3
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 18:41:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F8B52027019
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 18:41:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8FE2221E6904; Fri,  6 Oct 2023 20:41:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [v3] Help wanted for enabling -Wshadow=local
References: <87mswvg683.fsf@pond.sub.org>
Date: Fri, 06 Oct 2023 20:41:20 +0200
In-Reply-To: <87mswvg683.fsf@pond.sub.org> (Markus Armbruster's message of
 "Fri, 06 Oct 2023 16:45:16 +0200")
Message-ID: <874jj3egq7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Markus Armbruster <armbru@redhat.com> writes:

> Local variables shadowing other local variables or parameters make the
> code needlessly hard to understand.  Bugs love to hide in such code.
> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> on polling error".
>
> Enabling -Wshadow would prevent bugs like this one.  But we have to
> clean up all the offenders first.
>
> Quite a few people responded to my calls for help.  Thank you so much!
>
> I'm collecting patches in my git repo at
> https://repo.or.cz/qemu/armbru.git in branch shadow-next.  All but the
> last two are in a pending pull request.
>
> My test build is down to seven files with warnings.  "[PATCH v2 0/3]
> hexagon: GETPC() and shadowing fixes" takes care of four, but it needs a
> rebase.
>
> Remaining three:
>
>     In file included from ../hw/display/virtio-gpu-virgl.c:19:
>     ../hw/display/virtio-gpu-virgl.c: In function =E2=80=98virgl_cmd_subm=
it_3d=E2=80=99:
>     /work/armbru/qemu/include/hw/virtio/virtio-gpu.h:228:16: warning: dec=
laration of =E2=80=98s=E2=80=99 shadows a previous local [-Wshadow=3Dcompat=
ible-local]
>       228 |         size_t s;                                            =
           \
>           |                ^
>     ../hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro =
=E2=80=98VIRTIO_GPU_FILL_CMD=E2=80=99
>       215 |     VIRTIO_GPU_FILL_CMD(cs);
>           |     ^~~~~~~~~~~~~~~~~~~
>     ../hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration i=
s here
>       213 |     size_t s;
>           |            ^
>
>     In file included from ../contrib/vhost-user-gpu/virgl.h:18,
>                      from ../contrib/vhost-user-gpu/virgl.c:17:
>     ../contrib/vhost-user-gpu/virgl.c: In function =E2=80=98virgl_cmd_sub=
mit_3d=E2=80=99:
>     ../contrib/vhost-user-gpu/vugpu.h:167:16: warning: declaration of =E2=
=80=98s=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>       167 |         size_t s;                                            =
   \
>           |                ^
>     ../contrib/vhost-user-gpu/virgl.c:203:5: note: in expansion of macro =
=E2=80=98VUGPU_FILL_CMD=E2=80=99
>       203 |     VUGPU_FILL_CMD(cs);
>           |     ^~~~~~~~~~~~~~
>     ../contrib/vhost-user-gpu/virgl.c:201:12: note: shadowed declaration =
is here
>       201 |     size_t s;
>           |            ^
>
>     ../contrib/vhost-user-gpu/vhost-user-gpu.c: In function =E2=80=98vg_r=
esource_flush=E2=80=99:
>     ../contrib/vhost-user-gpu/vhost-user-gpu.c:837:29: warning: declarati=
on of =E2=80=98i=E2=80=99 shadows a previous local [-Wshadow=3Dlocal]
>       837 |             pixman_image_t *i =3D
>           |                             ^
>     ../contrib/vhost-user-gpu/vhost-user-gpu.c:757:9: note: shadowed decl=
aration is here
>       757 |     int i;
>           |         ^
>
> Gerd, Marc-Andr=C3=A9, or anybody else?

Thomas posted patches:

    [PATCH] hw/virtio/virtio-gpu: Fix compiler warning when compiling with =
-Wshadow
    [PATCH] contrib/vhost-user-gpu: Fix compiler warning when compiling wit=
h -Wshadow

> More warnings may lurk in code my test build doesn't compile.  Need a
> full CI build with -Wshadow=3Dlocal to find them.  Anybody care to kick
> one off?

Thomas did; see his reply downthread.

Thank you, Thomas!



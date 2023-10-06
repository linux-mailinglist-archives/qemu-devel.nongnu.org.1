Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871937BBAB1
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 16:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qom50-0006nE-Ee; Fri, 06 Oct 2023 10:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qom4x-0006n2-NL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 10:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qom4v-00077S-2S
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 10:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696603519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0msHmLMhDB9eOh7d8vMJI2gMMzuw3Fsi3idR3jjf9kQ=;
 b=HtUntz4taH3h4A8FllTdBmw/UMH2IcFon6Uxs0Mh8+HMaBZcCFoBnksnZCStskliDxcexg
 E3tWcI9rRwHz9tlqNLQgJ4a1CE3NQSPBsB3ZubzWV8DVOA1RLxrQFkqKQMi6bZOHhk+W5S
 pZlz7Gj48lML95GNscGtoW7oCCeEAtM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-8MfIRgZ9N8On55_uul-HPg-1; Fri, 06 Oct 2023 10:45:17 -0400
X-MC-Unique: 8MfIRgZ9N8On55_uul-HPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6173985A5BE
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 14:45:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4091310EE859
 for <qemu-devel@nongnu.org>; Fri,  6 Oct 2023 14:45:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3499B21E6904; Fri,  6 Oct 2023 16:45:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [v3] Help wanted for enabling -Wshadow=local
Date: Fri, 06 Oct 2023 16:45:16 +0200
Message-ID: <87mswvg683.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Bugs love to hide in such code.
Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
on polling error".

Enabling -Wshadow would prevent bugs like this one.  But we have to
clean up all the offenders first.

Quite a few people responded to my calls for help.  Thank you so much!

I'm collecting patches in my git repo at
https://repo.or.cz/qemu/armbru.git in branch shadow-next.  All but the
last two are in a pending pull request.

My test build is down to seven files with warnings.  "[PATCH v2 0/3]
hexagon: GETPC() and shadowing fixes" takes care of four, but it needs a
rebase.

Remaining three:

    In file included from ../hw/display/virtio-gpu-virgl.c:19:
    ../hw/display/virtio-gpu-virgl.c: In function =E2=80=98virgl_cmd_submit=
_3d=E2=80=99:
    /work/armbru/qemu/include/hw/virtio/virtio-gpu.h:228:16: warning: decla=
ration of =E2=80=98s=E2=80=99 shadows a previous local [-Wshadow=3Dcompatib=
le-local]
      228 |         size_t s;                                              =
         \
          |                ^
    ../hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro =E2=
=80=98VIRTIO_GPU_FILL_CMD=E2=80=99
      215 |     VIRTIO_GPU_FILL_CMD(cs);
          |     ^~~~~~~~~~~~~~~~~~~
    ../hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration is =
here
      213 |     size_t s;
          |            ^

    In file included from ../contrib/vhost-user-gpu/virgl.h:18,
                     from ../contrib/vhost-user-gpu/virgl.c:17:
    ../contrib/vhost-user-gpu/virgl.c: In function =E2=80=98virgl_cmd_submi=
t_3d=E2=80=99:
    ../contrib/vhost-user-gpu/vugpu.h:167:16: warning: declaration of =E2=
=80=98s=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
      167 |         size_t s;                                              =
 \
          |                ^
    ../contrib/vhost-user-gpu/virgl.c:203:5: note: in expansion of macro =
=E2=80=98VUGPU_FILL_CMD=E2=80=99
      203 |     VUGPU_FILL_CMD(cs);
          |     ^~~~~~~~~~~~~~
    ../contrib/vhost-user-gpu/virgl.c:201:12: note: shadowed declaration is=
 here
      201 |     size_t s;
          |            ^

    ../contrib/vhost-user-gpu/vhost-user-gpu.c: In function =E2=80=98vg_res=
ource_flush=E2=80=99:
    ../contrib/vhost-user-gpu/vhost-user-gpu.c:837:29: warning: declaration=
 of =E2=80=98i=E2=80=99 shadows a previous local [-Wshadow=3Dlocal]
      837 |             pixman_image_t *i =3D
          |                             ^
    ../contrib/vhost-user-gpu/vhost-user-gpu.c:757:9: note: shadowed declar=
ation is here
      757 |     int i;
          |         ^

Gerd, Marc-Andr=C3=A9, or anybody else?

More warnings may lurk in code my test build doesn't compile.  Need a
full CI build with -Wshadow=3Dlocal to find them.  Anybody care to kick
one off?



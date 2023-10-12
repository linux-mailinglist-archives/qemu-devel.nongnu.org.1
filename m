Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C97C74B6
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 19:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqzOj-0000je-Ca; Thu, 12 Oct 2023 13:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqzOh-0000iP-UG; Thu, 12 Oct 2023 13:22:55 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqzOg-0003Gi-5z; Thu, 12 Oct 2023 13:22:55 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c62cb79b02so758414a34.2; 
 Thu, 12 Oct 2023 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697131372; x=1697736172; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiNqpYEJTtJsO9bPPrHInuJcWC7cRz74Dz0U6YnlimM=;
 b=YHxKvZjlpBsCUGaNAc5DeSdNTbrdCx8htKFNHIvJIZwOASAgP9DdoPvYCKEHhuj6zL
 4HS+aI28wGNWHVz9jN4P8FObVzm5xFeVYOedUUz7nRoGX2FqZxqtq7J4l6WVBK95BMZN
 lcJaznFHeQwyaBRqbiR4iuznzB5rqYxvl/Urks864QUfwMPB5N335lRdupGy1qPQFPCb
 vxeZF2KzDHF0fbEZ7biuaySvfYb2viaOnaLltfBXoRnn6jkDPIHvDN1B8LHu2BArhL4e
 OJbw6sJeTZpx5D3i0WmXKnJzKQogQ8RP73k8KLVgRSdg1QLdWO71qfJZ4AG1xHa/b0yY
 T1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697131372; x=1697736172;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiNqpYEJTtJsO9bPPrHInuJcWC7cRz74Dz0U6YnlimM=;
 b=ic9MHD9jla4BKO403r/oa9jMOkSL7dxkGXI/le8Y3Q291ONa9Y6RiEdOaV5/EBbMFE
 nr2rdYCRoCZX1KbyCCgjw3NefzHWh8r6ysOhJFiTwKJ4AHSosZkkhZlJZbvwNptujetR
 ARf/Q8VwJnn9YjZBTRDaExF6/a+8WxsEGYiHY8CgXXzl2KJn1h2xiOG4z255NcjGciac
 lLE33HWoa6+a2Dm1ya5Ukbc77vo64sxKGHYZNOX/STSIFmirgCyLWF3Rf2mc32btVN+2
 DVdmq/fdKR7EqBhiwyzdmuPWMoDeUj6j50hwh8f3SGWVqP8/7iKdycX+K19AlivKRFRE
 gJlQ==
X-Gm-Message-State: AOJu0YwdntA9OpInJPjEbtUEeEe8HQQA00QUb3m0k4W3794E8jlUr/So
 P+FJ+T7/O4BfW5rsRPhqnCrgWBrrkiEbGlCwL4Y=
X-Google-Smtp-Source: AGHT+IFhtVh07em5aOtjXKGkzn6PYffglH9OVzKhTD/pMebZCugnStUyli3M+P49b9ilp0IhrdgFOfXRuAa26UQg5zM=
X-Received: by 2002:a9d:6f9a:0:b0:6b9:14bf:7097 with SMTP id
 h26-20020a9d6f9a000000b006b914bf7097mr23812494otq.9.1697131372219; Thu, 12
 Oct 2023 10:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697090890.git.jeuk20.kim@samsung.com>
In-Reply-To: <cover.1697090890.git.jeuk20.kim@samsung.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 12 Oct 2023 13:22:40 -0400
Message-ID: <CAJSP0QUp22nzGQ01z7zgOy8qDOaM03AXSE8DhZzdB++rTzrkpw@mail.gmail.com>
Subject: Re: [PULL 0/2] hw/ufs: fixes
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, bmeng.cn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 12 Oct 2023 at 02:33, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5e=
b2:
>
>   Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu in=
to staging (2023-10-11 09:43:10 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20231012
>
> for you to fetch changes up to 8466aa53d623377e114895c6563face25370d7da:
>
>   hw/ufs: Fix incorrect register fields (2023-10-12 14:29:20 +0900)
>
> ----------------------------------------------------------------
> hw/ufs: fixes

The following CI failure has occurred:

>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon=
 G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qe=
mu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_BINA=
RY=3D./qemu-system-aarch64 MALLOC_PERTURB_=3D72 /home/gitlab-runner/builds/=
-LCfcJ2T/0/qemu-project/qemu/build/tests/qtest/qos-test --tap -k
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
**
ERROR:../tests/qtest/ufs-test.c:113:ufs_send_nop_out:
'FIELD_EX32(ufs_rreg(ufs, A_IS), IS, UTRCS)' should be TRUE
(test program exited with status code -6)

https://gitlab.com/qemu-project/qemu/-/jobs/5281094630

Please take a look and send a v2 pull request once it has been fixed. Thank=
s!

Stefan

>
> ----------------------------------------------------------------
> Jeuk Kim (2):
>       hw/ufs: Fix code coverity issues
>       hw/ufs: Fix incorrect register fields
>
>  hw/ufs/lu.c            | 16 +++++++---------
>  hw/ufs/ufs.c           | 10 +++++-----
>  include/block/ufs.h    |  4 ++--
>  tests/qtest/ufs-test.c |  2 +-
>  4 files changed, 15 insertions(+), 17 deletions(-)
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 915157E1859
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 02:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzoUr-0007Q0-I7; Sun, 05 Nov 2023 20:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qzoUm-0007Ph-LM
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 20:33:41 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qzoUk-00074x-Cs
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 20:33:40 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5875e2b27c5so2096552eaf.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 17:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699234417; x=1699839217; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UhJEbIMpYGQXpluS3MwgnixomBKzFuGEX0uA8gUuChk=;
 b=nQFjisb7BqkWvnm/K6qV8A7KdCoaOKQZOH8BJcfbCosOMtGJawbqQqzJRJjtSN75L6
 SvEyHkjZJIC9Zsy6yCAs6OpLPooGIgMQRXZq+RH7rTQToad6SF2yziYJQe5BAU0EXu97
 jpDe2RVaLCkBcQuuX5pxjNCKIN1O8BdL+72gO7VFpSeANAOYv1zfV+ice5LMIpfX1lid
 KqG4HAgmfh9mf5qLU1w/0Apns4DVhUHy15K64wE+/JmBHnHXE/m7ADkTMsGgTmwgURh9
 ImGV3z5RsuIoL4EbdjQA91z3RBUmXH8aLp0t8EGb6giPu7jDrOwDlMeBLYGOMgIIBTqY
 GuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699234417; x=1699839217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UhJEbIMpYGQXpluS3MwgnixomBKzFuGEX0uA8gUuChk=;
 b=crac/XbH9Vo82g8ujRSr6EVMXF2mfaO3LRnSm0HJX0YrYKnCMyGGZZqt4KuM3Z1I41
 K3nmzPZqyf/AEc0HTjLuSv52z8TAEVgydngUwi9PFxrx6FbgJva5vqfvUxBByJS0zH8v
 +FGQnlUV8KkKxf8BtxcwxCEQCqUXqe7ofoA0uZnTRql995zDs2c7oqo1BFuvJ98j7x3+
 WGrAzwo4/pqq+m/nfATCxIZgscNg3L6Nq6iFIqhf/TfExZ2mAy3QEN1lO8E2xLPRdTK/
 fr3YRQz/TCS7NuAlRR7wFFuH/uw7aqMlP9nLLUpI6z5lBcNzy3uoXsDqK+oJhGcG5nyt
 Ruvg==
X-Gm-Message-State: AOJu0YzFp4FfytfTyukLygZYig5vEowG951pGq2ZG3FoVr1r9ViY0fmS
 4kbRjmau5M+wBGAdkZFBYlEuYAQrsHzMPsi2gqc=
X-Google-Smtp-Source: AGHT+IFtWtv+lVVopeTO+TQql9ZUjVrwb9YV3dkChw/ejEHCUxaAWjj43rFu7/1fHGGg9DPckYK7A2y8gxVqCCXbGpU=
X-Received: by 2002:a4a:b487:0:b0:581:ff09:62e4 with SMTP id
 b7-20020a4ab487000000b00581ff0962e4mr25959491ooo.2.1699234416738; Sun, 05 Nov
 2023 17:33:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699184105.git.maciej.szmigiero@oracle.com>
In-Reply-To: <cover.1699184105.git.maciej.szmigiero@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 Nov 2023 09:33:24 +0800
Message-ID: <CAJSP0QX7SxmMZDP4kQKQt6wkMTiVY6hVSoEtSBN4874NaxbJuw@mail.gmail.com>
Subject: Re: [PULL 0/9] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, 5 Nov 2023 at 19:49, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> The following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:
>
>   Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)
>
> are available in the Git repository at:
>
>   https://github.com/maciejsszmigiero/qemu.git tags/pull-hv-balloon-20231105
>
> for you to fetch changes up to 2b49ecabc6bf15efa6aa05f20a7c319ff65c4e11:
>
>   MAINTAINERS: Add an entry for Hyper-V Dynamic Memory Protocol (2023-11-03 20:31:10 +0100)

Hi Maciej,
Please take a look at this CI system build failure:

/usr/bin/ld: libqemuutil.a.p/meson-generated_.._qapi_qapi-commands-machine.c.o:
in function `qmp_marshal_query_hv_balloon_status_report':
/builds/qemu-project/qemu/build/qapi/qapi-commands-machine.c:1000:
undefined reference to `qmp_query_hv_balloon_status_report'

https://gitlab.com/qemu-project/qemu/-/jobs/5463619044

I have dropped this pull request from the staging tree for the time being.

You can run the GitLab CI by pushing to a personal qemu.git fork on
GitLab with "git push -o ci.variable=QEMU_CI=1 ..." and it's often
possible to reproduce the CI jobs locally using the Docker build tests
(see "make docker-help").

Stefan

>
> ----------------------------------------------------------------
> Hyper-V Dynamic Memory protocol driver.
>
> This driver is like virtio-balloon on steroids for Windows guests:
> it allows both changing the guest memory allocation via ballooning and
> inserting pieces of extra RAM into it on demand from a provided memory
> backend via Windows-native Hyper-V Dynamic Memory protocol.
>
> * Protocol definitions.
>
> * Hyper-V DM protocol driver (hv-balloon) base (ballooning only).
>
> * Hyper-V DM protocol driver (hv-balloon) hot-add support.
>
> * qapi query-memory-devices support for the driver.
>
> * qapi HV_BALLOON_STATUS_REPORT event.
>
> * The relevant PC machine plumbing.
>
> * New MAINTAINERS entry for the above.
>
> ----------------------------------------------------------------
> David Hildenbrand (2):
>       memory-device: Support empty memory devices
>       memory-device: Drop size alignment check
>
> Maciej S. Szmigiero (7):
>       Add Hyper-V Dynamic Memory Protocol definitions
>       Add Hyper-V Dynamic Memory Protocol driver (hv-balloon) base
>       Add Hyper-V Dynamic Memory Protocol driver (hv-balloon) hot-add support
>       qapi: Add query-memory-devices support to hv-balloon
>       qapi: Add HV_BALLOON_STATUS_REPORT event and its QMP query command
>       hw/i386/pc: Support hv-balloon
>       MAINTAINERS: Add an entry for Hyper-V Dynamic Memory Protocol
>
>  Kconfig.host                              |    3 +
>  MAINTAINERS                               |    8 +
>  hw/core/machine-hmp-cmds.c                |   15 +
>  hw/hyperv/Kconfig                         |   10 +
>  hw/hyperv/hv-balloon-internal.h           |   33 +
>  hw/hyperv/hv-balloon-our_range_memslots.c |  201 ++++
>  hw/hyperv/hv-balloon-our_range_memslots.h |  110 ++
>  hw/hyperv/hv-balloon-page_range_tree.c    |  228 ++++
>  hw/hyperv/hv-balloon-page_range_tree.h    |  118 ++
>  hw/hyperv/hv-balloon.c                    | 1766 +++++++++++++++++++++++++++++
>  hw/hyperv/meson.build                     |    1 +
>  hw/hyperv/trace-events                    |   18 +
>  hw/i386/Kconfig                           |    1 +
>  hw/i386/pc.c                              |   22 +
>  hw/mem/memory-device.c                    |   49 +-
>  include/hw/hyperv/dynmem-proto.h          |  423 +++++++
>  include/hw/hyperv/hv-balloon.h            |   18 +
>  include/hw/mem/memory-device.h            |    7 +-
>  meson.build                               |   28 +-
>  meson_options.txt                         |    2 +
>  monitor/monitor.c                         |    1 +
>  qapi/machine.json                         |  101 +-
>  scripts/meson-buildoptions.sh             |    3 +
>  23 files changed, 3153 insertions(+), 13 deletions(-)
>  create mode 100644 hw/hyperv/hv-balloon-internal.h
>  create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.c
>  create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.h
>  create mode 100644 hw/hyperv/hv-balloon-page_range_tree.c
>  create mode 100644 hw/hyperv/hv-balloon-page_range_tree.h
>  create mode 100644 hw/hyperv/hv-balloon.c
>  create mode 100644 include/hw/hyperv/dynmem-proto.h
>  create mode 100644 include/hw/hyperv/hv-balloon.h
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35680DD88
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:49:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCo8H-0005tR-Cm; Mon, 11 Dec 2023 16:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rCo8D-0005sz-4W
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:48:05 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rCo81-00023K-1P
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:47:55 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d9d2f2b25aso3512684a34.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702331271; x=1702936071; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/COn9gkV6weRcdfjom1M/ZiENmELMvaSBzb8U5l0ybA=;
 b=Y4BQe4UjW5VgIghI2vsXO19xxIcgvMXtH7NFQNxT+DKv9yO7a0IaXr/H4Idnn6r8O4
 nWr20rcl7yVQyF+XVwIjjypMwCAmrOuMkgHJ/cjmi2v8QY/AttnXsrtESzgojMGTd9Yx
 KgcQQZgyqYtAsWUDqp/tgW5hctgJ6/5eUm8dZwefexw7WRlBbZM0oPlm/E1QgmlBFAeW
 fGYPHS40yYTrB/jgtli3f/98gjPn92IjyTB8lchAm3qIjjPDBnN67cI5y6wzvl5bbINJ
 WjcJ+Z7lkkdLPfmhv26HCouPqce971qoS5UceMhbA52j3aS5iRAirQv/sZMf9pRibIKV
 GKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702331271; x=1702936071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/COn9gkV6weRcdfjom1M/ZiENmELMvaSBzb8U5l0ybA=;
 b=Jo7NV22L5PstR98wAfmIg28TlOpIxZn0CM+1HvWGFxW/qqqKugAvdjXJqvILWEqiAG
 2kgP9Q9vXseybV0VYTK2p9IVv89EkII6T3t64jM8KYZ2FgLR37qWwPSESR2mHQ1sZMrV
 JwY6Umkmxamn9qPmMmDcBpQtZI+5yXSnPDYlchgzOf04HePlVXqN1Zvc7OlxFj5voRqQ
 IUuc9Z1jHA0+w920/Ixa+Rmg47hHWXib9d4+MfdgUyk79Do9XFh0eFdlhRyqVnTafZ87
 x7X2KZzXgnttwRB/KAVSuWkKq3bWTIfnhMKxt6SvjXoiAhU3edzWy35s7WLfl0+MLern
 ksIg==
X-Gm-Message-State: AOJu0Yx3LwP0wVcx86FKMsPjR1NjtIAvuvm1gtsqO8S5REygpEtOgPKF
 rVOVNCaD6+Xx0n6/1HcJ2+9xAP8rJpzbdSUvVmQ=
X-Google-Smtp-Source: AGHT+IG2TQoL+IUpdo1CSK/EZdnwSvVwoYM8UixD0uf8IigW8GmcksKeLUFwxLMs4aiii7nQmkqhfX5DB0qcxBPoU+k=
X-Received: by 2002:a05:6870:7ecb:b0:1fb:2e1:bf67 with SMTP id
 wz11-20020a0568707ecb00b001fb02e1bf67mr5851455oab.49.1702331270915; Mon, 11
 Dec 2023 13:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20231207145545.783877-1-aesteve@redhat.com>
In-Reply-To: <20231207145545.783877-1-aesteve@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 11 Dec 2023 16:47:39 -0500
Message-ID: <CAJSP0QVGwTOgtRSaN3JbRKs4h2c_wH1WGTDLaBKme+vhTuDQsQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Virtio dmabuf improvements
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, kraxel@redhat.com, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32a.google.com
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

On Thu, 7 Dec 2023 at 09:55, Albert Esteve <aesteve@redhat.com> wrote:
>
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
> v1 -> v2:
>   - Solved an unitialized uuid value on vhost-user source
>   - Changed cleanup strategy, and traverse all objects in the
>     table to remove them instead.

Please update the vhost-user specification
(docs/interop/vhost-user.rst) so people implementing front-ends and
back-ends are aware that only the back-end that added a shared
resource can remove it.

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> Various improvements for the virtio-dmabuf module.
> This patch includes:
>
> - Check for ownership before allowing a vhost device
>   to remove an object from the table.
> - Properly cleanup shared resources if a vhost device
>   object gets cleaned up.
> - Rename virtio dmabuf functions to `virtio_dmabuf_*`
>
> Albert Esteve (3):
>   hw/virtio: check owner for removing objects
>   hw/virtio: cleanup shared resources
>   hw/virtio: rename virtio dmabuf API
>
>  hw/display/virtio-dmabuf.c        | 36 ++++++++++++---
>  hw/virtio/vhost-user.c            | 31 ++++++++++---
>  hw/virtio/vhost.c                 |  3 ++
>  include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------
>  tests/unit/test-virtio-dmabuf.c   | 77 ++++++++++++++++++++++---------
>  5 files changed, 138 insertions(+), 52 deletions(-)
>
> --
> 2.43.0
>


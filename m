Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC6815D05
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 02:24:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEfru-0007F1-89; Sat, 16 Dec 2023 20:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rEfrs-0007EU-8G; Sat, 16 Dec 2023 20:22:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rEfrq-0008Uz-PW; Sat, 16 Dec 2023 20:22:56 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33660cf2296so469501f8f.3; 
 Sat, 16 Dec 2023 17:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702776173; x=1703380973; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AAyZfDwgssLPIdO80C9/nGxlALQOVBVsLWzgfbzb650=;
 b=P2ioePhRE7bHE/vac2M7YzwvHkEHejUUlUmvyzrCXYzk/tl3tgwSAUd+QjtHZnZmP0
 A9Wl4deYrcZfWw+qDoww0rn60Y8k5kEDZ/m5EcVWShokGSTJSCtPrN6L8GJRn7vY263Z
 bvxL0p0HS+2YewrL+T0WQ6+BfUfxc8ejoHhajFAhJ/dhLm9a2bGO9Kp/NPfzsDBL1uby
 T6U0zT0hjoBACUIj3zaAD/71FsUKLHu2MYPiTeDmEv6FlJpOKNcQ7COCjOX4O3YB8Tc2
 q6KJEw91P4uu75t5jgG3+SBJu3wph/xA3hzB4AfdfN2D6Ah2CJu6GOB7qD5C9ZfFaYuC
 zwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702776173; x=1703380973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AAyZfDwgssLPIdO80C9/nGxlALQOVBVsLWzgfbzb650=;
 b=Yue389GK5u3jn93rIHMU0pXnnUjB5uDWPT+fDF+vJh+pwq2fh1hChKenyLdCB7C24q
 cYOc/cjKZ+ihzpR9PgyRHGn6vUDVd4KbrGOEs567NwDFqAH6I5y9bBcE4UGhUQDa0Uci
 RTtzISa6Y9zxK/xcUJCJpzJC+sfY4fo5eyhp73nD+slue522qm9I11N9JSxruGj9aPkk
 Ex84g/jQ1HM2dDiCNzDvgrX7sVt6SdpgalQpGveBUddlKSTJm36x7S5ILDzHIq7fqxuh
 wOfD80HccPkNTC4TDE56Pc1HxU/W+VOCp+wyxUmY/XJ5Smt8bK5f6uclULnzB0DGD3Fs
 zYPQ==
X-Gm-Message-State: AOJu0YyibP+QbcgWqa0whdY0i3Qtv0KLrZBBLYA7eNtgVCFpkNAxfsq1
 qzX3m4ff7YIfogqx4xI8j8m9tKc1LqJSGwyBnfM=
X-Google-Smtp-Source: AGHT+IF12LnG6vvw2yQsdvvyy177PtzD2THuYS3nu0WgowFbFGXIGRGjNC/2cPCdlnlj+1Npg5Xy96C/lrgu9O+s+5Q=
X-Received: by 2002:adf:f410:0:b0:336:3674:5001 with SMTP id
 g16-20020adff410000000b0033636745001mr4510879wro.66.1702776172611; Sat, 16
 Dec 2023 17:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20231127043703.49489-1-faithilikerun@gmail.com>
 <87leafejhf.fsf@pond.sub.org>
In-Reply-To: <87leafejhf.fsf@pond.sub.org>
From: Sam Li <faithilikerun@gmail.com>
Date: Sun, 17 Dec 2023 02:22:26 +0100
Message-ID: <CAAAx-8L0a1SaGO4YsMm4BT9QiouzUJgJ98juJtgAJP91_3SjNw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add full zoned storage emulation to qcow2 driver
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dmitry.fomichev@wdc.com, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, hare@suse.de, 
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=faithilikerun@gmail.com; helo=mail-wr1-x42e.google.com
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

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8830=
=E6=97=A5=E5=91=A8=E5=9B=9B 09:25=E5=86=99=E9=81=93=EF=BC=9A
>
> Clang reports
>
> ../block/qcow2.c:4066:5: error: mutex 'graph_lock' is not held on every p=
ath through here [-Werror,-Wthread-safety-analysis]
>     blk_co_unref(blk);
>     ^
> ../block/qcow2.c:3928:5: note: mutex acquired here
>     bdrv_graph_co_rdlock();
>     ^
> ../block/qcow2.c:4066:5: error: mutex 'graph_lock' is not held on every p=
ath through here [-Werror,-Wthread-safety-analysis]
>     blk_co_unref(blk);
>     ^
> ../block/qcow2.c:3928:5: note: mutex acquired here
>     bdrv_graph_co_rdlock();
>     ^
> 2 errors generated.
>

Turns out that my gcc 12.0 does not support -Wthread-safety-analysis
flag. Need to use --cc=3Dclang to reproduce it. Thanks!

Sam


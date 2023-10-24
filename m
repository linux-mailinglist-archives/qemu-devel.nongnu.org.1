Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 157E47D5993
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:15:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvL02-0004pX-2s; Tue, 24 Oct 2023 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKzs-0004nd-Np
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:15:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvKzr-0007Ga-1V
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:15:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2737039f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 10:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698167713; x=1698772513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rohQWxVwWTGxxrSiola3bwmXiJJ+17R1oWlnzR2/H38=;
 b=Y+cGE7kwb7v3E6KW7ltuMSTOkXu7eKMwbJKVaV6UUBdJ2jWY3Esjoxxeg2B4rOSJf8
 jxZCq9znmkMYYX/wDuwZGZDSuBLkactHSfTK2pE8s+u8+0aXJBZeaXdDKeB4O3B+m6oQ
 DbiCbNjjqU3DFyMQbnNeC8zen5UzLNzwjgp8xsZI2Ym9V2e0ckYuH3D1tIZwG8G+BZPd
 +MmtYMs1IimxlTvwYH/VqRnv28XY+hS8Tm+cmmKkUjSK7bpSsUSK+UHrWPCoPLxJLr93
 3Xmj4tphviyuf6S9MHEqfBG+LMBhulVKwGgU/y01yzeH98IkdwlQJkZtbTubZ4HduCW5
 oNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698167713; x=1698772513;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rohQWxVwWTGxxrSiola3bwmXiJJ+17R1oWlnzR2/H38=;
 b=A2uk0kPTUc50Dwd3/O7UdVHdSuyMrbVs7FkZDdlQck6G3cVxdXKyMEZERf5+5n3sI2
 jgBxyd7pYTmr/VowJOjGRIHbihwHLHzl7zPxfefhJ5mzE+JNwwSzlXQdfTg3oDVfE8Dc
 RapjLc4R7POQvLQpFcHFrjitNZ9pEzd0BeylRAIwhA7OEW7OB6HoyEgn8hS3Bm5Dc/1r
 NYc+T+fDfg5Nzvwbhc8uevnIRy1QZOrugpAsq5vNCUiMjbQWfMmsz4MZyvLYqxTuZo6V
 tbM5UjkPtxFH/J4rwYI96gjAE6eEOBqf5UAcdkBi21oDTy481FAS3+uj9OB1fGE/v5O0
 hyHQ==
X-Gm-Message-State: AOJu0Yy0jYw4/8tGu/ashHn0/18HZtCi+Z14da7E8DDuEU+qCMzxOnGZ
 v3mIDgpDlE7JxV/V5fAFGB7+gQ==
X-Google-Smtp-Source: AGHT+IGFixlav0nOKYbr1HUfP6BhJE5Kb983vgcTVlXUAXfXGENQzgMEUUiuQ2ZF/1jQAnoEaAcbqg==
X-Received: by 2002:adf:a29d:0:b0:32d:a4d0:1364 with SMTP id
 s29-20020adfa29d000000b0032da4d01364mr15850793wra.29.1698167713302; 
 Tue, 24 Oct 2023 10:15:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adffe4a000000b0032ddc3b88e9sm10377999wrs.0.2023.10.24.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 10:15:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7C13B1FFBB;
 Tue, 24 Oct 2023 18:15:12 +0100 (BST)
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>, Fam Zheng
 <fam@euphon.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Date: Tue, 24 Oct 2023 18:14:36 +0100
In-reply-to: <20231019095610.2818087-1-alex.bennee@linaro.org>
Message-ID: <878r7s0wnz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
>
> I've also added Manos' vhost-user-sound while I was at it.

Ping MST. Any more comments or happy to take as is?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


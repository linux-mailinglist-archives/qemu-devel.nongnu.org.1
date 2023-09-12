Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BBF79DC78
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 01:08:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgCTe-0007x9-8G; Tue, 12 Sep 2023 19:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgCTc-0007x1-6x
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 19:07:24 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgCTZ-0002DQ-Pl
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 19:07:23 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1c504386370so4179679fac.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694560040; x=1695164840; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hNxavf4uSggFasx9glYjIOk2EPVVAKLZsZqqPfBn0M8=;
 b=PCBKe/A0Dht88Ob7yamOzXB6r/yefubz3tja+DCKeS7JIGLfuruQLjHHQcgI5tL+91
 c0oKSZ1W4Hr1u437N11h2kdmBrujbs3C/nodvOvH8bdy1Ylp2+YnpZLGaM6NPCVa3mW5
 8H9D809XDp4OhNDKWgHTS4OKQu6WC7XFr4SqKaUld9FpsUGrQ8/Sy9pGKHmfgFkWUXaD
 cOtAE7cbJfa3TWASD+KVeuQe7y4PF4oWUxENbwIU4CxvSVpKDjgkGbgVhrz4WGSKI+Vq
 mlFy1ELKW2o0wJ38qFe4F8CtJ43NOhaj9WcFGIOQnDGhGvReQ6I5jrv3ttIQe3e245pt
 F/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694560040; x=1695164840;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNxavf4uSggFasx9glYjIOk2EPVVAKLZsZqqPfBn0M8=;
 b=DW+ar84BaBU7+WGdH7GKeH8uPi36y1uCGhPyPQUlPylHla5L0O9nvbwKiNkWnEREHj
 jXoKHcXZo+C1IWP3/qGoboBCFwg9Mhs6C876azboF3iAjqzLGRkQL1cD2ZMyOoTEvm8Z
 CCR0GyToVWW1KjVJRFb5pYsUYksLftzSlUW8mPZbKLPNQsusVTOWLhmQ8nQdXjzuc+By
 Xx+qtu53JiwqSjTtvTljJiaQXT1ETMcDObQpJyzyKjX/agnQBx2mGorkQZs/M7TZNnY3
 U3Q+mwobHNmCiZB31Di4D6IOCuEg6jekoNdJ163Wc5JBJIe5+QTv7s28yZSeGYoXrJxT
 GcHQ==
X-Gm-Message-State: AOJu0YxyVdJPp5xfpnR7P2BokZOyj3q2s+fBM2CFrA5Qwb2NtKVI0Lbz
 Qz0G3/GdldXuSuk3WNS07y5E4Zlf76bOtKsukF/MNAoj8Lo=
X-Google-Smtp-Source: AGHT+IGOOecwPIQFQzW+71TKUjPePGbSP8I840j0wh0hUXcbclu3W2sO2xD/vyU06ldNRa3ibnMUzgvcTaCZEzFpiDo=
X-Received: by 2002:a05:6870:d58e:b0:1d4:cebb:63ba with SMTP id
 u14-20020a056870d58e00b001d4cebb63bamr950695oao.1.1694560038338; Tue, 12 Sep
 2023 16:07:18 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 19:07:06 -0400
Message-ID: <CAJSP0QXukZuLRF0x1Yt06n2rbeOMAAG0SRsx4Z_QTTro9vMFTw@mail.gmail.com>
Subject: CI container image interference between staging and staging-7.2
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x31.google.com
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

Hi,
TL;DR Michael: Please check that the staging-7.2 branch has Dan's
commit e28112d00703abd136e2411d23931f4f891c9244 ("gitlab: stable
staging branches publish containers in a separate tag").

I couldn't explain a check-cfi-x86_64 failure
(https://gitlab.com/qemu-project/qemu/-/jobs/5072006964), so I reran
build-cfi-x86_64 to see if it has an effect on its dependencies.

To my surprise the rerun of build-cfi-x86_64 failed:
https://gitlab.com/qemu-project/qemu/-/jobs/5072087783

The first run was successful:
https://gitlab.com/qemu-project/qemu/-/jobs/5071532799

Diffing the output shows that the software versions are different. The
successful run has Python 3.11.5 and meson 1.0.1 while the failed run
has Python 3.10.8 and meson 0.63.3.

I think staging and staging-7.2 pipelines are interfering with each
other. My understanding is that build-cfi-x86_64 uses
registry.gitlab.com/qemu-project/qemu/qemu/fedora:latest and that
should be built from fedora:38. Python 3.10.8 is what Fedora 35 uses.
The staging-7.2 branch's fedora.docker file uses fedora:35.

Stefan


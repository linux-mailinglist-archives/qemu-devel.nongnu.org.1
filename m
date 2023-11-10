Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2CE7E7819
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 04:37:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1IJA-0001gd-HF; Thu, 09 Nov 2023 22:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r1IJ6-0001ZN-Vz
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 22:35:45 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r1IJ5-0005DB-DH
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 22:35:44 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-586ae6edf77so809491eaf.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 19:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699587341; x=1700192141; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0e4YAhPlkCnvITlRJ2VmQnfi2D0MaGlp1n1lP3t1X0=;
 b=g7VmQ2xcJmrMrZ7rSthzfY+gKNvb26AtEoUGN/PcvWFuiTjNmqIKeli+eo4dC6weDH
 ztV+aCz8BKcQh1zY5uD1K1mPo2S5luAd3DrLk1ITEN6tr2u6yQKJMiG0TdqU9LXvGQ3N
 vklncLsl2+TI2gRnLarmkyvKLruqr6wHzNUKoP7Mn7VkBuc54qEUn79/YAHOr/uBAHaF
 6PDTYhugxdeqXgiV1bWR48b3adYgrqkDeCK+nuicALMO+LnlDruSEAxS4mhlHDS2IcJ1
 G4oep/4HHTdJt25MCSS1Q2hSFaJ91H/+xU8OvbeQNY7N6inTeQZx5Xcfr46f7iOxN1jN
 RYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699587341; x=1700192141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0e4YAhPlkCnvITlRJ2VmQnfi2D0MaGlp1n1lP3t1X0=;
 b=AXzOfhQJVcVr4c6WozIUNqg3/eKKufU0ZZXYWHXPgdlGY6CuuJQ5ZhEW+m0+WmQa0f
 uhmFafiGUus5QT5iUxc/Fg/0fG5RcxRYg6DSxiLREKtN20x3Lzgo6AFsnzXNH8IZ03zH
 jquYMQAOI30enG+xBhJTQy6GfHeHw1Zek/gt3AHXwonBDztW+FCaw2wvX1fsSbYdfbbq
 +egb2/PqE2vxUbzrh2TjmNGsArNdh544W7iuDaNnJ8CtmzvrF1MXtSU/4pnw62C8KKCq
 lkgBLrne/86SrMItvYrT/WEHt6/i8fBAXX8HzguvKEqpKGqE/GTZvpDHkGgylyJIQOmj
 rM0Q==
X-Gm-Message-State: AOJu0YyjJXhwz+ga6JEO2V+Bw6fPFJXFqv7tGZkyHU7o78Fhwmi0+Qzj
 1gzHO1i3o4w/+bGAO8gth+Dy4Cz4rt1sF+TEEeM=
X-Google-Smtp-Source: AGHT+IFJJY2/DVqdymiKj2YWkOBPS2lOjAd3bOmlVjA1Rpxx4fxQ0gDoosQJ+wW6ZhSEewFak6daYg07bvUWP5//Qc4=
X-Received: by 2002:a4a:a543:0:b0:57b:86f5:701c with SMTP id
 s3-20020a4aa543000000b0057b86f5701cmr6059456oom.4.1699587341752; Thu, 09 Nov
 2023 19:35:41 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2311071310190.3478774@ubuntu-linux-20-04-desktop>
 <20231110022539.GA101613@fedora>
In-Reply-To: <20231110022539.GA101613@fedora>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 10 Nov 2023 11:35:29 +0800
Message-ID: <CAJSP0QUAQ99UruNo3wvPFwcTOWiCR7JGvOMds5FMteOGvt+1jQ@mail.gmail.com>
Subject: Re: [PULL 0/1] xen-virtio-fix-1-tag
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
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

Hi Stefano,
I merged this, but please renew your GPG key and use the standard pull
request format where the git ref is included after the repo URL in the
future so that tooling is able to process your pull request:

  are available in the Git repository at:

    https://gitlab.com/sstabellini/qemu.git tags/xen-virtio-fix-1-tag

Thanks,
Stefan


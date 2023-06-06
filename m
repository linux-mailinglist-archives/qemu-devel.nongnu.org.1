Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB272455B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XOq-00032X-AW; Tue, 06 Jun 2023 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6XOk-0002wn-GN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:10:58 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6XOi-0005CO-FB
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:10:57 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5584f8ec391so2143094eaf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686060650; x=1688652650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TViX6xHrhcipZ2N/daIpqjUHG9frSaIxXBNYbl7z694=;
 b=l61eo7UrDoqW+squDjZ3SmRRl/dT2Kg31PMtoroXDAxOUYq/rje5oJf4G8AAUL5LCj
 smy90xkJZ6qiTG+fB2K6pk+yrmnEKJGBalDnwFnkywvxYAIxSTTmR4kQ1qhuhKMuSXAH
 6EJIVUTLnmbjsQHL7tHgJzIYMu5H6FyW7mHQrGATblln4g3QqU1bG7h49QBgxbmg3PAE
 cpqoa3yWD3O3SJJpGTYEkGZUhd34Q75IjTxL+I1nzfngMWnZ/wINZsBYZ7tYE+YYC2CW
 T2+uyWR0odYbfLDXSImeX0A67z+crRz/FRmF2gGN2dp88H2XFvn5FdtfnTcJIqMRSm3x
 tb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686060650; x=1688652650;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TViX6xHrhcipZ2N/daIpqjUHG9frSaIxXBNYbl7z694=;
 b=Vc8Ope4VGg28oEwdldc09qJ3opnm7E1MQumL4N32z4oExI6XQdUZ3l297GAMbjAh+g
 LwqwBYWAHWxTXgMUYxKF5QR/UFv5W+NEIFPCFKkEb0+o+G2dLEHsiJtx3ZHzfEcYLNLy
 tE/pwJ9oo/aUFGr8OqorgFa52aVigURWEIxpWr7FYbFH8O2/R1a9ja/t3fDOOX9HIR2d
 cxCLzOahzI6TQkBFwHSxmZUecRB7rpxRSLZ8xm9R8+8QO13csCzhK8/8Kdzin01hz56o
 8qhrmMGfZReLykz4aeNgc4HCFjgtY97ZEtITdEhfk/Fn0rbKWU9rSFN/IHHE6XdsWynU
 1m/A==
X-Gm-Message-State: AC+VfDxuTpACF1xrQmc2qY4BOGxrse5T7v8ikxBs4R3e9hBbu5IJWlMp
 rdniQ3gGDSOgV/dt82gSawQDXQ7Erp8/cS/8bSVnsojw
X-Google-Smtp-Source: ACHHUZ47m9LBAa9sLajZqWGXzSxIslOwuf6WvHTE6pCZjKYgsSLzasUOUYd5Le4RuySA9edAZquZH/d+VatjdDXUL60=
X-Received: by 2002:a05:6808:248:b0:39a:9e83:e712 with SMTP id
 m8-20020a056808024800b0039a9e83e712mr867232oie.44.1686060650397; Tue, 06 Jun
 2023 07:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230606131605.55596-1-anthony.perard@citrix.com>
In-Reply-To: <20230606131605.55596-1-anthony.perard@citrix.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Jun 2023 10:10:38 -0400
Message-ID: <CAJSP0QX4XEPK53PM616yPrCfMXRxMRpOab--wo7GO=F5qJ5nYQ@mail.gmail.com>
Subject: Re: [PATCH] xen-block: fix segv on unrealize
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
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

Sorry!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


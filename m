Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D67843D0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:20:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSDh-000406-EL; Tue, 22 Aug 2023 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qYSDe-0003zi-Mm
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:18:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1qYSDb-0006pU-VZ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:18:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c615eb6feso609179f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1692713930; x=1693318730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q27+LWN1bNyyzovD2YQut2GgRuRs31gDmmY/cO3TRyc=;
 b=VIiLD/mCV6XtOkjpZbX7OMblP++lK/rWS9RvV3fk1AANmQDPNBTvjMNcfIvgN43XxU
 /nokuC7YO4hR+aa/a8h9eorVYMU0AW8etxmoydrxvXuxBchvlVxn17qt6ldxqXX3SiCA
 hPT/qHOCaiIYNT/JDUcEKCcihjBnWCY6BQzUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692713930; x=1693318730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q27+LWN1bNyyzovD2YQut2GgRuRs31gDmmY/cO3TRyc=;
 b=OWgxVyvKPkwxmHvf49Yf41O5wBwzWvxo0s1+crsIuA3/lNjxWrpt6sQg/ddEfIOFsn
 o4FwEnolJwvjqWJ9s0BRXne4LJTS2w5ZDEON91Fgrm4zpdx1o+ICb8h7WniOy+7bhpsz
 BPXt4RqeMiemS2lJQ+gR6VItVs4j8MG1KFDDHJ7IhE49ZATPyMqyek1/91Btqdn5eYC5
 mO8nOXVjCbaGSd1g1I3VEpv5V5drI42TVO2t2ykCY1Q103vZFnKLPtwI4jafxOAA157R
 VywzulY2r5nw6fzw6UlRri1nD278cJJCyD2P8U+PNLybrHhcEyFbTpYQSsVUKf/0raRB
 eKvA==
X-Gm-Message-State: AOJu0YzPKRkasgWkU/xbtYSpgIRUFqgdSw/MeNwaVkTr1BDPRkkZ+YH7
 5GIEl+mn/fay4xwqP6CbJmwTBg==
X-Google-Smtp-Source: AGHT+IGD2krpO9tou6EsuN8mDGTEMKpOkvflOcTgQvgTIst5+SYhX/oAjMiHNXFsHGy11QAcnBtu9Q==
X-Received: by 2002:a5d:6949:0:b0:319:7471:2965 with SMTP id
 r9-20020a5d6949000000b0031974712965mr7471099wrw.21.1692713929864; 
 Tue, 22 Aug 2023 07:18:49 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 a14-20020adff7ce000000b0030fd03e3d25sm16095358wrq.75.2023.08.22.07.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 07:18:49 -0700 (PDT)
Date: Tue, 22 Aug 2023 15:18:49 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Joel Upham <jupham125@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/23] Q35 support for Xen
Message-ID: <0b4adb4f-7a66-47a9-bb47-7c73a164a327@perard>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=anthony.perard@cloud.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Joel,

We had a design session about Q35 support during Xen Summit, and I think
the result of it is that some more changes are going to be needed,
right?

So, is it worth it for me to spend some time on review this patch series
in its current form, or should I wait until the next revision? And same
question for the xen toolstack side.

Cheers,

-- 
Anthony PERARD


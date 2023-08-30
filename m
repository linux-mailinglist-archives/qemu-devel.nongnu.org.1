Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5978D59B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJWn-0005a8-28; Wed, 30 Aug 2023 07:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbJWl-0005Xs-6m; Wed, 30 Aug 2023 07:38:27 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbJWi-0001YU-OK; Wed, 30 Aug 2023 07:38:26 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57325fcd970so3381777eaf.1; 
 Wed, 30 Aug 2023 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693395503; x=1694000303; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hMw5ImzAd3xqqkVQMY1Vy9qbztlG2o8kXcN3mqAaWdo=;
 b=JVdps/JEtD2/sxVwDQ+wWWqAWg8TeNF2wTlb+dRxkUxA+XMTpkNDAUaIUGdHhOA5XT
 hAa0TXFlhzkzJkTEUAfxyLqvOAavK9LAsMviHM3ocFU49go0QLM66dJaWuKqYkXad3oV
 rnh5Y0Vsc070BDuWvIX9Ge/p9+SzXY5PB8wuoseZwAop8K/IRulxnb4n2jxKYf+1e6AP
 D0Fld70JmuPplR9Koh5ozFTgDTymAQKNzIFJZBb0utkTszKCcMJl4EokV+CEu/KR3Wvg
 IlOFTHzlm/mlWK0E3CYAQVSr26r2c45+DmxrO50hud4syM/eXk5ody8Srdx6sghK/vv/
 2/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693395503; x=1694000303;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMw5ImzAd3xqqkVQMY1Vy9qbztlG2o8kXcN3mqAaWdo=;
 b=hxujndtkGdmdsFF5YQFQ4uwhqr1uqiky1zmKkquJn9gmJl6CG81pH2IT37W1DNw1fL
 nuWovgOSdXxlcQILLGY8o+sKzaEHOuiIcDktTTJRrIqqxND6QF2fkE8QLq839+KCE0rK
 fpqf3ABofhUewmew9jIbvOQyoMcDegHvaBxvADi73MLSsDlDxsvm3stsoVgMmFPmIDTH
 5POCoo1vTHL1zK5dr+C8lGGqdqsMnTJVc6FOr269xML8e2JVVFJKD9k8nMJJrtftXKfb
 fXMNujBMnOZ7V/7QzCf4wzFVdVNm4Cx2/7iV2PWmfDRpqp+S/MhE3O6BkhHg/frjZSuc
 cr2g==
X-Gm-Message-State: AOJu0YxWtgq6V0ih971i+xhToPsGptxTIvsRMUhUZHUMsnL2Hem5h2Yf
 TFiK0sUKkLCe6yMxAHGKojILmEw+lA+/KjvjsIIInFEdI9Q=
X-Google-Smtp-Source: AGHT+IHiRc1RHmmhtDmZ5JDHpTxAWtHwAMy6XRycl/jBFTk0s8iYGLlC9U/SFfNgnmoqaumdmZ8ve4kIHJDm/lpB0YM=
X-Received: by 2002:a4a:7558:0:b0:571:aceb:26d0 with SMTP id
 g24-20020a4a7558000000b00571aceb26d0mr1585249oof.2.1693395503091; Wed, 30 Aug
 2023 04:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1691062912.git.jeuk20.kim@samsung.com>
In-Reply-To: <cover.1691062912.git.jeuk20.kim@samsung.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Aug 2023 07:38:11 -0400
Message-ID: <CAJSP0QXnydKxy++mJmdt28gULER1grif0uZ-4xr+rpvv-zmuDw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] hw/ufs: Add Universal Flash Storage (UFS) support
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, hreitz@redhat.com, 
 k.jensen@samsung.com, kwolf@redhat.com, pbonzini@redhat.com, 
 qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com, 
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com, 
 philmd@linaro.org, thuth@redhat.com, lvivier@redhat.com, 
 jeuk20.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
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

On Thu, 3 Aug 2023 at 07:49, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>
> Dear Stefan,
> I'm really sorry, but could you please put this patch series
> instead of v8, which was previously merged into block-next?
> The fixes from v8 are below.
> Please let me know if you have any comments or issues.

The CI hit a test failure:
https://gitlab.com/qemu-project/qemu/-/jobs/4977256030

Please investigate how to fix this so this series can be merged. Thanks!

Stefan


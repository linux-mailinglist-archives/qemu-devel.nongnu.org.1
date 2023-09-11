Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E414079A9FD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjDd-0005lO-0J; Mon, 11 Sep 2023 11:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfjDG-0005gt-MU
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:52:37 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfjDD-0006b6-Sj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:52:34 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so6057019a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447550; x=1695052350; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BjlqkDD347RZWi+8GHr7dor4LxcOOjd2oG+x7Xq7W2c=;
 b=XkEcbWhCDeJYsU0cQfY0SaHFn9pdCYzI2S8LD2ZKNoJHF4al00+mgt5DsxsJUeLG4g
 FBwQvNcq9+GaR1tyQvbpQzFTS2pJ7fwlu7++w/YMB5drGZJU8+KOET4J1cB7l8n+uHLZ
 qyd/R+iRGtVnHv6XdMficCEkMHOkd6I32Vr2MV9kc8QFQ8WF6yi8cCKL75mCOgEwRNOJ
 ZXgEEjH8OOnvF80NycegFIv5JE+cV9aKRzwIXtG1RQ9/oV0p1OUc/2/hZQyEeoHyRtYY
 sBgtSOaMIYnHgLsycppOLO+kWCB+XkTdnn9ac9U6PXfBETHiQ0GOolGdLk9dFTh7btka
 UScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447550; x=1695052350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BjlqkDD347RZWi+8GHr7dor4LxcOOjd2oG+x7Xq7W2c=;
 b=OlUN78KO68hSB45gO4S1i/xDx1BoAcYxNAXstiztxMjN/iktbBoiZlpGbdCRXqtSxf
 tX1EuXipE+mxnGfbP0HfzSf2fTZ9qCFPc1qa2/0UCPBtfg9X+X6ffbn0TvZrWO2i4wV9
 NbLRHvoIwqTosSC1YF41UQUN+8arBWFJ51OilYWBeN7ywVcgdH+e6egAzFAGt0rnTOmn
 DZ6Oa8QJCz+JjmKvqf8e64FMK5+OMaAOLtbLWHXEf59vYn/+FftFNdw5GKhT7CddegQv
 p7dUAq87OI4irAU078mceBNvvJPqbEbLkrAjewHOYEINaMTM8bqnYvbW+TdqzNTMqagw
 x3Cg==
X-Gm-Message-State: AOJu0YzYVpWxZxMr296c+tq+jXiC8MKKnNQeDxueqMVw8NcMJk+iFCHF
 rGWQDvGCItNw/GJMwGrKDMhOdHutddGjrby0/NmWqg==
X-Google-Smtp-Source: AGHT+IHTr3obaQlpA1OKNX0x0MJwSPJxtJSL1buAY5pUzczr8cRb0+ITQt/mlb8JZfxyZIQdHu6KZNyy9poBW+t/XDk=
X-Received: by 2002:a50:fc08:0:b0:522:31d5:ee8e with SMTP id
 i8-20020a50fc08000000b0052231d5ee8emr8044417edr.8.1694447550107; Mon, 11 Sep
 2023 08:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-11-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-11-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:52:19 +0100
Message-ID: <CAFEAcA_aNhh1Exqqjtnwpj=mRVYBKgdo7bD282WMKKr07jWf7g@mail.gmail.com>
Subject: Re: [PATCH 10/11] qom: Add object_property_set_default_list()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> This function provides a default for properties that are accessed using
> the list visitor interface. The default is always an empty list.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


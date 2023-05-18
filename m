Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C70E707D9E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaYp-0001Xx-Ev; Thu, 18 May 2023 06:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzaYl-0001XW-6c
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:08:35 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzaYj-0002nJ-LA
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:08:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-50b9ef67f35so3276263a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684404512; x=1686996512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JM/Te4zeKkA1WovpJmHGh4bMjFSCsf1ZEe8BHG9lYaY=;
 b=xgr5RxULpU1g3f0V6h6nGIqbJQu3mwic4R4Vf9fliGw/w46SNy6WQToEG8qOnR5myi
 1ZBJwSzFZtHNUWvtHEZaDt3q/kqdY1bKfNxVym0UsDr9Z5ikjyNbhu6Gk94M9bk0HSUV
 FxLboadsqZ6LPcSdgdwQAyamXcbjeeebwlklHLIuZVLhdNy2aBV4W1AteyutKUsH0jE6
 HYXnvLURIU/wk4OtW8C9yHRyA8cJ0jodIPhbrYdO1xLigt1vKzjan7LfFtDG1wXBEEVF
 ShuPeO4gvloGZaQXuQd/nJfkXompmMRVjjKNFfg8YndO3WJVKgAqjpxGUJM7F/pmj6kr
 lVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684404512; x=1686996512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JM/Te4zeKkA1WovpJmHGh4bMjFSCsf1ZEe8BHG9lYaY=;
 b=MIc6ydpecyxj0igcsq6kyOJdnAlTYtvmAltzOp/20LxXj/V7FIN3+39ih0REzhPc86
 J2z6QgUv8wqLnzE7bTXDmXMVL3tY1yi+bJu4NppWtItGphpDZ+4eJcZIV6L3Og+N1qg7
 N32d5EUd6MdfBaVwkszrsJQ3HpnUXnm3xn/QG7lhj+93iMpU6GU1DS5/jU+KvXSCFFRt
 RnvICgLVns5swi+hzMJY9+SZjXjLTXyvhN6LEadnCzkkcQWz8ZEfZ+SGPJQtYZ893VM4
 zIVn0HqB6CJmZ9J2AFtX18n7GAmmHE6HBCIQuOQwDQPuoJ/4NrjYZ7v4Cwx6WXUEakHZ
 mGkw==
X-Gm-Message-State: AC+VfDz0mXuqWEzD2HdfbMiyH3TqNzlnsbDBLV6GIyOAVAIdO9j3QQ85
 qBzu/3ZACd2UEVaPsN6nkdGj8IrzNxAEe6yhOaa1DQ==
X-Google-Smtp-Source: ACHHUZ4Yr10Ql4qKwH6xWC1T8+PZ1l2ANUkiLYT2/eO829nDN5wNxd7WvWC8aezvIEH0L7Kv2ASg65fYiPs6Hbifz5g=
X-Received: by 2002:a05:6402:31ef:b0:50b:f999:9dee with SMTP id
 dy15-20020a05640231ef00b0050bf9999deemr4386914edb.8.1684404511971; Thu, 18
 May 2023 03:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143753.365591-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230515143753.365591-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 11:08:21 +0100
Message-ID: <CAFEAcA9fkBUfOMfz9yDa2nH=ouCZRDSczfgsMW3-Yr3r7okFug@mail.gmail.com>
Subject: Re: [PATCH] Maintainers: add myself as reviewer for sbsa-ref
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 15 May 2023 at 15:37, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> At Linaro I work on sbsa-ref, know direction it goes.
>
> May not get code details each time.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM


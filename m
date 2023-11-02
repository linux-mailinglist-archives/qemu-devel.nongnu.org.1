Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A37DF2CD
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:51:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyX9i-0003Gn-KR; Thu, 02 Nov 2023 08:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyX9g-0003GE-TV
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:50:36 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyX9f-0002Ke-CG
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:50:36 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so1431888a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698929433; x=1699534233; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3YWZUlJkq0X2GhIVMhPgC9NhAzqhr/3fPWJ1lVu197A=;
 b=PK5kNB2/uMHULxcBhKmOWj6sklkHIPsv6DBzrxNn09Vy+FNisjp1+CdVbjvIDwxw+0
 TZPysdac0gZicCE6q3jsams/VNz2y1oMeMqI4Fj/VvHfqqQiGfl9XBdQJHZGJhDgnk+N
 D/kPA33CkiYhn3egbtiHROGFEHr1J0r5cBhsb4iE5N1OA7Pai/0lGVu0z2tJ4Lu3gtRo
 3c/UBt+Q7jPN8ENBuoRJcdO86kvyaQ01tHIWs9qzGjRqtz6dqsNr8FTFgdsJmuIAUp3T
 SJvY8ZSxm/hzQZTtRkHdIbY8uwHDQJOg0ZFOMqjlP73/eBls8A3dHwTwyANceaFUIzs6
 AHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698929433; x=1699534233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3YWZUlJkq0X2GhIVMhPgC9NhAzqhr/3fPWJ1lVu197A=;
 b=W4TQqOvIHzZC5qVndBbiMAATz1aqmkijzYMqHyZFbHzTXl4mlE31JQ/HVsQagpfnDc
 MGYF9iaHcbC7OPG79uJ2hC4T5tryLy9PgJ2RtKqrXoRyzMwC9GfHgXrh4mvZH64B7149
 btQXol2hn842eR2L0bqeSbAGDIeIHMQ6Tr6NSwWpCUOuQfNKOob0fEK0AV0icRMSCPqJ
 dGL3UfrQhQbQF22dZMA173zjNLHBIk0nvFV8/NG978QyMrpj98j5kRBU7Fa9qn9wrf6E
 OuCREVl8uahrzrF+5ShWZ/faUBOBZ1vcyUhOOkpt79VXGINM/nFl97G4XSiKlq46bogE
 MqBA==
X-Gm-Message-State: AOJu0YyJT2zjQB/oyqs7zYZNzE6tzlN9zvx26plC1UCuU9IyXEWn8lLG
 fRllbPfdFITda9jmyo++m9bLkGP+BetMEc7P0fVlmG5pleq7p/yb
X-Google-Smtp-Source: AGHT+IGDC19dluiZOWAyJK/IBa1D/WrL0n0/c/IHeqgaYsvMNc56aQV8GHRZGVtEAg//b+VWN0x2NJSRcvZoNkIy9mw=
X-Received: by 2002:a50:aad1:0:b0:52e:1d58:a6ff with SMTP id
 r17-20020a50aad1000000b0052e1d58a6ffmr16302830edc.35.1698929433650; Thu, 02
 Nov 2023 05:50:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231102091245.42045-1-quintela@redhat.com>
In-Reply-To: <20231102091245.42045-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 12:50:22 +0000
Message-ID: <CAFEAcA8FiZoSpWHYWn-JmZzmZ56gx+xBX=U2hetG1Dw-oeiJ3Q@mail.gmail.com>
Subject: Re: [PATCH] migration: Unlock mutex in error case
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 2 Nov 2023 at 09:13, Juan Quintela <quintela@redhat.com> wrote:
>
> We were not unlocking bitmap mutex on the error case.
> Coverity discovered the problem.
>
> Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error paths")
> Signed-off-by: Juan Quintela <quintela@redhat.com>

CID 1523750.

thanks
-- PMM


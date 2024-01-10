Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 276E482A34D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:33:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNgBT-0005K6-Uk; Wed, 10 Jan 2024 16:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rNgBR-0005Js-I3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:32:21 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komlodi@google.com>)
 id 1rNgBP-0002uu-Od
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:32:21 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42994a41379so22161cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704922338; x=1705527138; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZFLDlrzD89NHq6uXo/nvPsyAXuc4QT5sAAIGcbHxSg=;
 b=j5EvLD6Y8MPQc+EkAcHDViGvn2w4QDoVP4UXtynKKxHSVt8NJsygaTvjsWLpoJiTQu
 bIDNm1Nzv0v37x9XAfwEqMFeJa7nKx36hBvg6+b6pCE80vALBcPBgsmf5iPemF75qVpu
 zrq6R6u/srbcy736QR3bnBMZHrbp8eDtAymTPmWio+UblSZwFjVBXxuI/Lyka9TZys8r
 yOOD8TF9VK7hVoJ333OR/WKhJpmNz/vOWboQQLcaRqHeiFZMnFNiLNvwNYHhfqjTylSO
 GYrqCqQdsLfXZs9m4ph5rj6gc4S+OXUHj7BvPy3oofcmg6BgeY+Pw/GBSncCKIyOeiQf
 Vr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704922338; x=1705527138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZFLDlrzD89NHq6uXo/nvPsyAXuc4QT5sAAIGcbHxSg=;
 b=K3Fr+9WMjJilD4+KJrMRVz8vkPASz1BRVQQXEzvWm54uScIaUCzQOzOVYuojOD+Qwf
 sDU3x6Ku5QfR9XjOM4tOGExWCUTuIrxZlk7SLu2rIUFrFBR9XNdV+kA4vZKpl+x8VqHz
 a4B+hlvSTF9I6TynN+JioNehHfqimaJ2c3fKP1NtQaErdaae2sYc/ffPcouNgZheMHRu
 YwGSals1uF6V8XYltdH0rd9NMFg/WqeLvOM9k0fCYIPLymm8xIHgGz+twOr7k0ccZjvC
 mSoZRcjKAR4BIplbazcc/PeDRGwvzSxyFS3LlFlfTxf+2spB7iCKLYAWKe9bEfeBl3EC
 ao9A==
X-Gm-Message-State: AOJu0YwfKdyAL30OHxHBOwe6cA8Us3b+1TOPi6dVSokzk8JesJ8fX/TA
 SV6LXS5LfbIoqiG5Q2Un5qlDo9uvAaLbwUalIUKfNIlCmsUHpEO11PlRoOD9xxhclRF3Y9r/qUr
 1zI0Eb8h5asXMKRqKZkHYsuo7YgGWI2bfKoHHjJjJWbRqmfIAkg==
X-Google-Smtp-Source: AGHT+IGQs42GdhO3CbV+FYXCPDOWfy89omBKphA1D3PQU+Vg3ECrF+BVZDowBi1ZaL9KGffBbPaFfnv2GaANRbBbCRY=
X-Received: by 2002:a05:622a:188f:b0:429:bd26:1f6 with SMTP id
 v15-20020a05622a188f00b00429bd2601f6mr21278qtc.3.1704922337624; Wed, 10 Jan
 2024 13:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20240110212641.1916202-1-komlodi@google.com>
In-Reply-To: <20240110212641.1916202-1-komlodi@google.com>
From: Joe Komlodi <komlodi@google.com>
Date: Wed, 10 Jan 2024 13:32:05 -0800
Message-ID: <CAGDLtxs_a-Yz3gs65gX8CZf=PoohdF98AO4SHz4CrdJjefA1FA@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/i2c: smbus: Reset fixes
To: qemu-devel@nongnu.org
Cc: Patrick Venture <venture@google.com>,
 "cminyard@mvista.com" <cminyard@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=komlodi@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

+cminyard

Accidentally typed Corey's email address wrong in the initial send, oops.



On Wed, Jan 10, 2024 at 1:26=E2=80=AFPM Joe Komlodi <komlodi@google.com> wr=
ote:
>
> Hi all,
>
> This series adds some resets for SMBus and for the I2C core. Along with
> it, we make SMBus slave error printing a little more helpful.
>
> These reset issues were very infrequent, they would maybe occur in 1 out
> of hundreds of resets in our testing, but the way they happen is pretty
> straightforward.
> Basically as long as a reset happens in the middle of a transaction, the
> state of the old transaction would still partially be there after the
> reset. Once a new transaction comes in, the partial stale state can
> cause the new transaction to incorrectly fail.
>
> Thanks,
> Joe
>
> Joe Komlodi (4):
>   hw/i2c: core: Add reset
>   hw/i2c/smbus_slave: Add object path on error prints
>   hw/i2c: smbus_slave: Reset state on reset
>   hw/i2c: smbus: mux: Reset SMBusDevice state on reset
>
>  hw/i2c/core.c                | 30 +++++++++++++++++++++++++-----
>  hw/i2c/i2c_mux_pca954x.c     |  5 +++++
>  hw/i2c/smbus_slave.c         | 20 ++++++++++++++++++--
>  include/hw/i2c/i2c.h         |  6 +++++-
>  include/hw/i2c/smbus_slave.h |  1 +
>  5 files changed, 54 insertions(+), 8 deletions(-)
>
> --
> 2.43.0.472.g3155946c3a-goog
>


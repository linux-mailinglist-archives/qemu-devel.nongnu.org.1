Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF177C509C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWqD-0007EQ-QK; Wed, 11 Oct 2023 06:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqWqB-0007Ds-0e
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:53:23 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqWq5-0001da-Uf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:53:22 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57bbb38d5d4so3712342eaf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697021596; x=1697626396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=66iQQ492T8Dw8ahccj86jgt+G4xRS04gbgSyEZjEWno=;
 b=I9Ewr8HcLVa76YvyXLzo1pGmhGRRgRgkj/ttmisz7h/p/6U17VF+F+kTpkNI0b7NtT
 JupA1AJVjQa53VFCcGcCZlQxRCkjRXa6guZ854MPgLemDnH3bAonmr0rYwNAwX6JoREH
 ZJ4THM3olgXvOf741AxLkc8cFPINRnPYHGbtWG0lJCqhoM4IPloWmy8dQ9v+bsQz+CRx
 ksQaqyNqxohBEaxpdIX18m3yeRWL8CLMisQWbmG0AFmiznP6bzAJ2ubPuIsV9zAhsfoT
 ppiz7OS91953ftSU+5moSx5iMSwLs0G9crceunnrS1lwP/nJabKwMFp3CFiug4i4By1x
 CF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021596; x=1697626396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=66iQQ492T8Dw8ahccj86jgt+G4xRS04gbgSyEZjEWno=;
 b=nWKbbezGQybic60fUCF0pFQ0SNTXoYyZU5HmkM1zpLAtKxsXWtDoWPoanzglZokLn0
 m4R6YrldmBkpVUtOzPNQ6QU4+OWWcjuoQhPrHCH1qVrzEMfizjsDt9JZDxLqdIRmBqph
 FUf6i5O19/G32wpzHEXWLl/SvLIZZA/iAjulV/EOurcaHWL9Tt7DffEfpYJg0bGRdOaB
 MTdwwzPhMM6UkTt9tF+wrWZfnIv4Kh+7+PeWyDbx4Fr8/rdwjCgPKDlRv6lRf4OhU7PX
 TBAm7AboewewCJ8yfBOD8PaMgw73wqBvCuS/PvuSRV0fZLPx4obYvIhUb9ymkKEil2DR
 sMWg==
X-Gm-Message-State: AOJu0YxlCJYWFICe1GzMjfQPp9DweHzc077shr2clxG0Hscv++s/yqQv
 Ca3hjwXmOR8ypissmoRNESTKMQhyUUsfCq7t9s0=
X-Google-Smtp-Source: AGHT+IGphAmEbzTHdTDegKQxy3kOhT3yHHag8a3Cr/w6m2wXloLS9nRFImQwfdNJSuoiWOQ3d8mc7y4Ieo2RjMwa8wc=
X-Received: by 2002:a4a:8557:0:b0:57b:5e98:f733 with SMTP id
 l23-20020a4a8557000000b0057b5e98f733mr20331034ooh.3.1697021596336; Wed, 11
 Oct 2023 03:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <d0e0395a-25a9-18a1-ae97-c77708a94adb@linaro.org>
In-Reply-To: <d0e0395a-25a9-18a1-ae97-c77708a94adb@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Oct 2023 06:53:04 -0400
Message-ID: <CAJSP0QXrKjJSQzVQpAKcxaqSOrRmgE4PYR7nbeRMGzKQg7JC-g@mail.gmail.com>
Subject: Re: wiki.qemu.org is experiencing technical difficulties
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,
For some reason the database was not running. It's back now.

Thanks,
Stefan


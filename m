Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3598257BB
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:10:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmkk-00082s-On; Fri, 05 Jan 2024 11:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLmkg-00082W-M3
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:08:54 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLmke-0005Bz-Qs
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:08:54 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5542a7f1f3cso2114707a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704470931; x=1705075731; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JAP7Dx4ZNJHT1kkjtOe9Jq8SlI+uXhrJdbn+85Wu8z4=;
 b=XXkp7Vh0gA5TFw6PoAqpk0f3Qc/25JmFS/+otbSEEqySidAceFljy/9YIM2kfiQViS
 6TS7KxFFPi/nfq2QEFmEsrCPZG23vaLQM5x+Rs1gzkosnXWPjFZI2QtWI49eOFgwDX1Q
 A3gLLWM90COZQ4CODF7E7KJ0bvMD1PCL1WUqSVNpN2aSSKI9OwxqztjbNy2hO4YMuLsF
 qbD1G/1ohN2n1FmNwanLH7UuIhwnMPZrv1Gk0/H4VwL4KlrCqi/AsS4hadyOidSszWzL
 8lGNijudKEsaKD0/RW65GASWegKSUJHiz7i4WRh0CwnludiDEh0V1egX0G33WibAfy9L
 0v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704470931; x=1705075731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JAP7Dx4ZNJHT1kkjtOe9Jq8SlI+uXhrJdbn+85Wu8z4=;
 b=rfE54sYB6vq3OAHFuuqb14IfpXd8PUtZdYGzadOd9YfECKQyuvplwiLN96adNAXl0o
 hnzAvseQXgpw7Rlm8kMw6hpIDp8ln8jQYcdyn8gruj7yRzDax7mr1vWUXuozZAnoxrmb
 W8B6nxO3MCfvrMeNcHUjfm1JUidj6Kh0SfLn8hJwqL9DwLiUzhhg4hL0OX4AS5woW29u
 +2jIAEjWVVwDJl8xmrZIlhsL2EHSoiooRo7E9Q11d1qw+9SiuKQyOXOtuO0epiSCJFno
 TrQaBXwNp+Uhj+1UJKBbHZpY7M2fGmOV90fZwPlGXna3cD/mKSW0U+y8M1PfVtaDOMAX
 CJBQ==
X-Gm-Message-State: AOJu0YzeuB6M7oPbD+K6lFu27Ac20ggSpqwSLfpCRxexiAZtmwSSRLph
 /cALwI6c6EO7nbwHmd24sj9hXbuRuNwzB/SL1XSux+2cD0uN2g==
X-Google-Smtp-Source: AGHT+IG/0TVUndScAgLPwvSlJ2vCFI1zVzN0JRY8KjEEqLopXDwEpJvffay1qnixJ0lEvkmjXzsf5ns5whcY5dt+p+I=
X-Received: by 2002:a50:9550:0:b0:554:7a21:241e with SMTP id
 v16-20020a509550000000b005547a21241emr1201681eda.40.1704470931182; Fri, 05
 Jan 2024 08:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20240104043213.431566-1-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 16:08:40 +0000
Message-ID: <CAFEAcA8iim9vr19DxRDVabdESvcz+pAx91Ff6a7wQB-rrsCxqg@mail.gmail.com>
Subject: Re: [PULL 00/26] Migration 20240104 patches
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>, 
 Juan Quintela <quintela@trasno.org>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 4 Jan 2024 at 04:33, <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> The following changes since commit 7425b6277f12e82952cede1f531bfc689bf77fb1:
>
>   Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-12-27 05:15:32 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20240104-pull-request
>
> for you to fetch changes up to b12635ff08ab2e5a6a955c6866ef4525fb3deb5d:
>
>   migration: fix coverity migrate_mode finding (2024-01-04 09:52:42 +0800)
>
> ----------------------------------------------------------------
> migration 1st pull for 9.0
>
> - We lost Juan and Leo in the maintainers file
> - Steven's suspend state fix
> - Steven's fix for coverity on migrate_mode
> - Avihai's migration cleanup series
>
> ----------------------------------------------------------------

I notice that your gpg key doesn't seem to be signed by anybody
else; you might look at whether it's easy to get it signed
by somebody else (eg some of your redhat colleagues).

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM


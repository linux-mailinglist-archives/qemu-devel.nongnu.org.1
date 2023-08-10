Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587FB777C39
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU7bD-00029I-3v; Thu, 10 Aug 2023 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7bA-000298-Dv
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:29:16 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qU7b8-0001MR-Ok
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:29:16 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b9aa1d3029so16752891fa.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691681352; x=1692286152;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Atz2fNObX3o3xPzGWO9QUy0MFsJpd9IwYleBzZkR6KQ=;
 b=E6HbBUpCF3AzWYadC4DwBK/rle97Ns5bNqO0X7DCdpmy///vfhuNDk4F8if04q9LvL
 mnR7wVQpTG1bma8ITIEj1P7RAJ103ybuOH6Q33nh4CiMg2l//JI0BGiRgcf6qAyl7ogc
 zPiQwZHbGrc/P96C8vmuCTLQ3P+eOgTn+Gk2G6vR9yA45OSXSNWud1/yRhr/Yyy94KuT
 0uUeK4SRK8qBHBU6rz45c8Wr0DnjhQpOG2HHCH+VVWYkHWajUDumCJNQd0OYwBGkQqNi
 UtNEdfMr5q7YJeOnDAqhE+t9Rkg26cRUpoiUdUmZaddtxsYz9D0ex4YFA4PqKWdAtZ6G
 spRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691681352; x=1692286152;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Atz2fNObX3o3xPzGWO9QUy0MFsJpd9IwYleBzZkR6KQ=;
 b=YZvN0wbgjidlUh7Mav5dkKBCbMOwaW88dNK+84z0UNsQ2BQhjtlphve2NTGSOAqcN/
 j1eT5LkzApjXueR/c3V3bqj+d7kYqzbYOnxacyix4MtIM4bswLRJVKBBG4cGEnKGybaN
 w+lze5miIXEzH3KnHNgWVY3fE3KbtBObFoYybdmpvG21P8ppOHgwEaICyRea1TJE/Lm7
 picN5Q6jjhlcgrMa6qlO+ddyVsNVDdXsC4+FLwTyU3+yTO9VwPsam7j1/kO/oJMzLhTs
 jFRLRvHPoBIhjsyKD0xWoANVU0CiIxnPy2Aj0ZtjHPNny0KzcH6EXw65BzqdlyNmvu2t
 HuYw==
X-Gm-Message-State: AOJu0Yx6Q2wWEthtas+e1U1AfvNnR8z2qMm8BZHam2qPVpox4ZI4O5ta
 VEtO++wVYGKkzO/9Nq+PA7DiVw==
X-Google-Smtp-Source: AGHT+IEERfcljLL2JQUq38yINFFH0J0MOeelN/aVALyZoHF87BcmBmykDNXudNjOe1c8xhXqFdDfPQ==
X-Received: by 2002:a2e:b053:0:b0:2b4:45bc:7bd with SMTP id
 d19-20020a2eb053000000b002b445bc07bdmr2325406ljl.4.1691681352571; 
 Thu, 10 Aug 2023 08:29:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a056000114a00b00301a351a8d6sm2459305wrx.84.2023.08.10.08.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 08:29:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB05D1FFBB;
 Thu, 10 Aug 2023 16:29:11 +0100 (BST)
References: <20230804111054.281802-1-berrange@redhat.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/1] gitlab: enable ccache for many build jobs
Date: Thu, 10 Aug 2023 16:29:02 +0100
In-reply-to: <20230804111054.281802-1-berrange@redhat.com>
Message-ID: <87msyy3ohk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Thomas has previously proposed adding ccache:
>
>    https://lists.nongnu.org/archive/html/qemu-devel/2021-04/msg02189.html
>
> This is an pretty much suggesting the same.

Queued to for-8.1/misc-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


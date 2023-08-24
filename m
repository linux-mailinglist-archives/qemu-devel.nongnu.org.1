Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD23F7876A4
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:18:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDyH-0004JK-5Y; Thu, 24 Aug 2023 13:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDyC-0004J4-UO; Thu, 24 Aug 2023 13:18:08 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDyA-0007Fx-KW; Thu, 24 Aug 2023 13:18:08 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so200432a12.0; 
 Thu, 24 Aug 2023 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692897484; x=1693502284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fD2Cm9OG/5aM3oCMmXmoOoi1nGacQfIVXde1uBWrjXk=;
 b=ahvCOqsv1NbFo8dIu0Nmbm3CFbWv8Hf0oAhVNp3nr8CtD1GfuehbpB1VMXdqpfGymn
 HH3W/p4KSIbnxFskDc4EWfOObIe90fk6JXXAOY50V0+faS/nRqWZA3GnI35f64NUWCWz
 4ooO4QiPVgp5/TIj0lNi4Zlj3pS8kOA+fYnGGx+iRzRspWQpgvfgEU898tc9miFTCmah
 eX1bGrxdrlk+yyNTNCWK5UgTBX/8WGaQvPIu/0m6CNtNvFAr5x48SNIP6z+esVYq0So2
 K8+LMMNZ+cVxj1PGLgSMad81XqWJAOS0I8ICcI6yxGM2tqKFB/gHvgVHsVPms3Bx1t58
 zOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692897484; x=1693502284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fD2Cm9OG/5aM3oCMmXmoOoi1nGacQfIVXde1uBWrjXk=;
 b=O/cnWMySv3gywmGRsvBcknZsybTr3qNoIBbp+dGCY4p3F7i+ndzaF6gJ4Pm3Hum3gO
 dDw655FPeTSyeaTIrhv3MWJtctCmfDU2rc2m/GXyr+O4qXFP63bLp8ToqBnRI5i/3kKb
 jez94yo1kTo+/e/GwG7vIppZeWXaWvc545zkM0kIw74FaEK+tcnqByAnRnu/32WP/Had
 AnQ3Bhqgo8GVBxHEFWr0U7nBRVpQ3Lq7NsB+NVWsNgN3lEQYSnmo5nkzBmJND4RATUlG
 +yqQk4vhwaL0rbGJZog7jkCpW2Ai4ofbUusu82dWfIHS6frJgjwYIlRlXwcbOiWABOHW
 qH4g==
X-Gm-Message-State: AOJu0YzjaDOkgFbwY505iBaaHxq5fWsES9z6RPrRMRDt8XixXYnorVqF
 h6utpdvCDNgKw/jiydYiXhD+IqVR2Byf6hpBqoY=
X-Google-Smtp-Source: AGHT+IFeqn9NC4M+/wIvu1WbZLgaR2/kq9XEDtg3+ioylftiQH5nTl9vQN3G/c+LLTDB/nEBwpHwONI52GQa4+hK8UA=
X-Received: by 2002:a05:6402:1001:b0:525:4472:3147 with SMTP id
 c1-20020a056402100100b0052544723147mr12897235edu.34.1692897483670; Thu, 24
 Aug 2023 10:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230824155345.109765-1-hreitz@redhat.com>
 <20230824155345.109765-4-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-4-hreitz@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 01:17:34 +0800
Message-ID: <CAAAx-8LBBdBrbJsTffF-a-WNJ7VhMg01CzDzTs5Q1M-wcrV5Gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] file-posix: Fix zone update in I/O error path
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x533.google.com
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

Hanna Czenczek <hreitz@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A
>
> We must check that zone information is present before running
> update_zones_wp().
>
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2234374
> Fixes: Coverity CID 1512459
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/file-posix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Sam Li <faithilikerun@gmail.com>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61506725FD2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:46:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6sXL-0007bp-Nt; Wed, 07 Jun 2023 08:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6sXI-0007bB-25; Wed, 07 Jun 2023 08:45:12 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6sXG-0001n8-E9; Wed, 07 Jun 2023 08:45:11 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-bad0c4f6f50so824563276.1; 
 Wed, 07 Jun 2023 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686141908; x=1688733908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rwfS5m4D93oRqoCLtUxW4/RjLpBJrLXA/xH4ZgcDbrE=;
 b=NVq+M3ZwNZXlfV4LW9Tfrg4ahzsGPM+QAo8COOFFezH4rcDxCpubp9Bvuha7mE0oS8
 f29DiG1XlUkzqve4b/i8gsGXF8G2yCd5TZ9b7hXN7HPrS8a6hPYZu3dbVdCOA7kJ5B24
 94pixU4f7OotbOKIpIrBP0BwdI0EMHXTzLbJTJ09z9znmhc/JunWMjg5k6rucOaMSiwr
 Je9FrpHVQo3E8I6vCW+Kkd1Zl0tsuj1JsATg1q+WtEZEcf8Meimg7WLBH3UhM/khOlQF
 gh1NF2W41RUocyJgElG03IYF5Vv4S29ogTyxNnOKkaHr3INMXRZzfy40FBwJTaj3qKf8
 mSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686141908; x=1688733908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rwfS5m4D93oRqoCLtUxW4/RjLpBJrLXA/xH4ZgcDbrE=;
 b=BpMgM2jj+V7bCAh87QnGkWsDoEWsmXRBNHGYNNaNBoAO4dOPEKEPdvP+muC/SQxK3o
 47TqgAarqZ803yONey7XfTvoUnu+s1JtFzek2DvHwn3VPbTS8IW3V1eLI11xZl2yE1F+
 Br6c6uKRF8RzicDRoihN5sob2WKhTpa3ODEpd5IERmJreBypKOknmcSQKrrB+wvjshRS
 hJ63l7TVHdvj1skNHsm3Kp+ynysXCfgxe9j2F4tuKOZKaYf6XEDU4pzheAzf13YA7PIO
 borKpEpWnF7pSTitJkkzrU+bZnerCBuwtNq1c8ddfxXup/lkKc2KS7hz1JgYoB5E3OcO
 3Ljg==
X-Gm-Message-State: AC+VfDzRmwFdlCMgXqKfHXGJwLoEM+2zZIddAFZ9bR3UKDi7RDXaAM1y
 cZBzHeqWfDQRl9WxrghxG81qO4o2NM3yNPdVu0Y=
X-Google-Smtp-Source: ACHHUZ6XefuJhlRTGtFYfSNcWfJn1aE4/i228mjoM3Ma+SejGrSqqFtNDw4vIYbs5Te52rFRdR4Zwaiz2X6ahTOpCTY=
X-Received: by 2002:a25:abd0:0:b0:bac:f5ef:fab1 with SMTP id
 v74-20020a25abd0000000b00bacf5effab1mr6828105ybi.12.1686141907846; Wed, 07
 Jun 2023 05:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230606162556.58110-1-richard.henderson@linaro.org>
In-Reply-To: <20230606162556.58110-1-richard.henderson@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 Jun 2023 08:44:55 -0400
Message-ID: <CAJSP0QVwkoAauG37BLgcqsWrjp3rE3-fVdQjeCkB=aboUAKnjw@mail.gmail.com>
Subject: Re: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, berrange@redhat.com, 
 jsnow@redhat.com, qemu block <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=stefanha@gmail.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The line of output that has changed was originally added by the
following commit:

commit ae00aa2398476824f0eca80461da215e7cdc1c3b
Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date:   Fri May 22 01:06:46 2020 +0300

    iotests: 194: test also migration of dirty bitmap

Vladimir: Any idea why the postcopy-active event may not be emitted in
some cases?

Stefan

On Tue, 6 Jun 2023 at 12:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This test consistently fails on Azure cloud build hosts in
> a way that suggests a timing problem in the test itself:
>
> --- .../194.out
> +++ .../194.out.bad
> @@ -14,7 +14,6 @@
>  {"return": {}}
>  {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>  {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
> -{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>  {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>  Gracefully ending the `drive-mirror` job on source...
>  {"return": {}}
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .gitlab-ci.d/buildtest.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index 0f1be14cb6..000062483f 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -236,7 +236,7 @@ build-tcg-disabled:
>      - cd tests/qemu-iotests/
>      - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
>              052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
> -            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
> +            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
>      - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
>              124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
>              208 209 216 218 227 234 246 247 248 250 254 255 257 258
> --
> 2.34.1
>
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D957AB33D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:01:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgiK-0007QP-RH; Fri, 22 Sep 2023 10:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjgiF-0007Os-HR
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:00:55 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjgiD-0006Ly-Rt
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:00:55 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so2593629a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695391252; x=1695996052; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+8rdA7E3EgjYuq/xY5hpkSawi+9QLoNb/NftKSrgH8=;
 b=OrdHDxLgmeopfGIYRJNfaU1H7DSvtP7T/F6hTQMwcLxSmKHVY41KiqvhhvBfnD7moA
 YnDzSqGs3f9j7ZcvbzKQk/TzC5ze12y/L1h4DiqGqdKyXAi6YIhW37dURdPGKywCb+EY
 Enam74DUNvFz66XLcnNSaW35++q6na1EpHtUYUG78WQoGoeoeED4KqyNEKi2A7AhLHbB
 EcaPUmzBY40xukY6BLSyM26jXj0yGDbv24h0VXdpPteS4DF/Pp7vhQfD6GZiI0DaQFDB
 gI7uFm1ArBYpAw4raDWdnZ1rlXmN9rnORu4I/aKxb3u7CPrWj5sPNH6yo+81YfVC2j1q
 uQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391252; x=1695996052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+8rdA7E3EgjYuq/xY5hpkSawi+9QLoNb/NftKSrgH8=;
 b=OObtomF/2Pc/HpwEZGHmj+/pD/7XlJWG0lxAgZJLAQOkE1LwI7cMrL96lm8TBQLAZn
 RifzfEprUIE3ZvesZQeNSjYpoiMGwlt68C7PxNKZQzxV7Oz6QeFmBsaO1dbAjD/XtkBT
 /GJeT6n6ILBBuG2Epw9/WMhNBFSKkwvMEuni4ciqzabVSVkoTZwg1ZLXVCCMWWP+wr7W
 wvIDfu1eByRQ1uzbq7YMEjYwNnriWvttKV0s8t0/kUMZFEizPGzRlNE64aUyrFyv6lcZ
 HiTDqeqPAxUtdfH6uEi3//2v1AbtR42DHaytox5cUpv/ad13EpMC6bt1ZDeqJvbXSMKR
 Gong==
X-Gm-Message-State: AOJu0YylBI898LVuhb0oGGK5/MU+4CL7Lfm0ADNarLgLh/hnREyUqFr6
 mckdSjcTc6xpKlVeDznpPbR+94+Vc5KOYJ5x+2Napw==
X-Google-Smtp-Source: AGHT+IEj3k/xD5542LGi9Y8Ych01KBqzKtXUC9nwQgqVT0V/banlrsoJeuF2Q5MKOi1kvV8e4CF3J0cNvG+EQ/zjfEY=
X-Received: by 2002:aa7:d1c5:0:b0:52f:3b4c:d06e with SMTP id
 g5-20020aa7d1c5000000b0052f3b4cd06emr6656592edp.12.1695391251178; Fri, 22 Sep
 2023 07:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230922135555.241809-1-berrange@redhat.com>
 <20230922135555.241809-2-berrange@redhat.com>
In-Reply-To: <20230922135555.241809-2-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2023 15:00:32 +0100
Message-ID: <CAFEAcA8gPOx6hH9gZxHOvcTwpSuLO5mCc0zqpTEBSidf0_QaaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] configure: support passthrough of -Dxxx args to meson
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 22 Sept 2023 at 14:56, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> This can be useful for setting some meson global options, such as the
> optimization level or debug state, which don't have an analogous
> option explicitly defined in QEMU's configure wrapper script.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The commit message says it's adding support for a new feature...

> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index e08127045d..cbd7e03e9f 100755
> --- a/configure
> +++ b/configure
> @@ -931,6 +931,8 @@ cat << EOF
>    bsd-user        all BSD usermode emulation targets
>    pie             Position Independent Executables
>
> +  -Dmesonoptname=3Dval      passthrough option to meson unmodified
> +
>  NOTE: The object files are built at the place where configure is launche=
d
>  EOF
>  exit 0

...but the patch is only updating the --help text. Is there
a missing piece of code here ?

thanks
-- PMM


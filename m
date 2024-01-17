Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44533830F1E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 23:18:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQEE5-0005NX-Ok; Wed, 17 Jan 2024 17:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQEE2-0005NG-8v
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 17:17:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQEE0-0002CP-Ia
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 17:17:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e8d3b29f2so8286485e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705529850; x=1706134650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+WO0gC0vfz7XBaosdE7QxnmqtWzh72mEiJGdHtFSMQ=;
 b=J88FSgfrUXHE01BCgd7y9KVyfHSpy1GhJSKWeK8+gHd/mvpfbEHTCbQ8AdRr7+DU6F
 TfDYODe5HZSsC8MHFawu7Ai9dsZOpxalj/5il3k3TuEdyFqY0ZALuHKMZKLLNV9iZFtP
 Aa2OZXY6ulTKTVCMaHzvByuST4CGblDQY2Qo8QZUJ2OGQ+Nv1b5OsW69K55HtoGPWaT3
 HVMxKWCV3KFhEPDKTvNaT7Vxzb7kW6SykQEnpg8O33no4tVoHJuI8ezKTEgYxfaxBOiP
 jqWS4DCnzcQSsm+0ZI07dRzbfbW3ktUOD+DsLiN14mzmAA/v4tEBQGp78Ugkg2A7giPa
 v11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705529850; x=1706134650;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r+WO0gC0vfz7XBaosdE7QxnmqtWzh72mEiJGdHtFSMQ=;
 b=K9Z9zjRhmk6TYLLv2B7TtMI2ZqUKyKAxo/k2jGRSUbxlBqY+kyxmfdwMatON/OI+dH
 LU5iDtRE78EKJykBDEUgCWvvd/YJZJ+MRonhNZxRhz4Z/HeHBc16UfbT5yDzCK3aN8rY
 IdThzyU4NS0GkFmd+IJOvnqXQ5hYA2fAGoL4fMtqwZuENJy+I6PAYWj+jR5i/bd3RGlw
 QHC7DZ3ZnbYV/hm8XjxP+I7WkK4fm/5RWiJRNbu/0LbeqhYktizjM0TcerSDSDK0165J
 pqTGsZi+nSfVv87xBRrRmzfIdzveWoq5ACzUfaZviSMYo6y313BazXtRaX79Jsj/rAR9
 UGWw==
X-Gm-Message-State: AOJu0Yx8aAyOEB587BgNecy5ajUmzKoIayPl6q/S6JEm6C9kBCcYU+qZ
 mmPKe0hfURfISGC7kerhAbpIkcsrygg9VA==
X-Google-Smtp-Source: AGHT+IF2PZbboTVitPjcBhp24GOfqOFd0V6MMc+pkqUUDMAZIOOZiuNdkP8l45LhuXXLl2+jyUuGmg==
X-Received: by 2002:a1c:7c03:0:b0:40d:3af5:ea09 with SMTP id
 x3-20020a1c7c03000000b0040d3af5ea09mr3619073wmc.228.1705529849921; 
 Wed, 17 Jan 2024 14:17:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c35c700b0040d1bd0e716sm23887923wmq.9.2024.01.17.14.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 14:17:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A75E5F760;
 Wed, 17 Jan 2024 22:17:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Claudio Fontana
 <cfontana@suse.de>,  Cleber Rosa <crosa@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v2] tests/docker: Add sqlite3 module to openSUSE Leap
 container
In-Reply-To: <20240117164227.32143-1-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 17 Jan 2024 13:42:27 -0300")
References: <20240117164227.32143-1-farosas@suse.de>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 17 Jan 2024 22:17:29 +0000
Message-ID: <87le8nhafa.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Fabiano Rosas <farosas@suse.de> writes:

> Avocado needs sqlite3:
>
>   Failed to load plugin from module "avocado.plugins.journal":
>   ImportError("Module 'sqlite3' is not installed.
>   Use: sudo zypper install python311 to install it")

Queued to testing/next, thanks.

>
> From 'zypper info python311':
>   "This package supplies rich command line features provided by
>   readline, and sqlite3 support for the interpreter core, thus forming
>   a so called "extended" runtime."
>
> Include the appropriate package in the lcitool mappings which will
> guarantee the dockerfile gets properly updated when lcitool is
> run. Also include the updated dockerfile.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/docker/dockerfiles/opensuse-leap.docker | 1 +
>  tests/lcitool/mappings.yml                    | 4 ++++
>  tests/lcitool/projects/qemu.yml               | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker=
/dockerfiles/opensuse-leap.docker
> index dc0e36ce48..cf753383a4 100644
> --- a/tests/docker/dockerfiles/opensuse-leap.docker
> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> @@ -90,6 +90,7 @@ RUN zypper update -y && \
>             pcre-devel-static \
>             pipewire-devel \
>             pkgconfig \
> +           python311 \
>             python311-base \
>             python311-pip \
>             python311-setuptools \
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 0b908882f1..407c03301b 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -59,6 +59,10 @@ mappings:
>      CentOSStream8:
>      OpenSUSELeap15:
>=20=20
> +  python3-sqlite3:
> +    CentOSStream8: python38
> +    OpenSUSELeap15: python311
> +
>    python3-tomli:
>      # test using tomllib
>      apk:
> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qem=
u.yml
> index 82092c9f17..149b15de57 100644
> --- a/tests/lcitool/projects/qemu.yml
> +++ b/tests/lcitool/projects/qemu.yml
> @@ -97,6 +97,7 @@ packages:
>   - python3-pip
>   - python3-sphinx
>   - python3-sphinx-rtd-theme
> + - python3-sqlite3
>   - python3-tomli
>   - python3-venv
>   - rpm2cpio

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


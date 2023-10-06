Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F21557BC07F
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 22:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qorc1-0005Da-CK; Fri, 06 Oct 2023 16:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorc0-0005DO-6J; Fri, 06 Oct 2023 16:39:52 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qorby-0001Vd-FR; Fri, 06 Oct 2023 16:39:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id C3FE7615EA;
 Fri,  6 Oct 2023 23:39:46 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b403::1:3c] (unknown
 [2a02:6b8:b081:b403::1:3c])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jdgIhT7OiuQ0-XY1uDTpp; Fri, 06 Oct 2023 23:39:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696624785;
 bh=6Ty4hkdwZrGvs9Wn/nC/S2Yp5gfHrjfAMAi1St2flSg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ztz4Ggtx/v8GLP63FlyyF/nCsJNUkYTcpiZiuoNs6GkAY8PYAWU9C5ulP87faJgTZ
 o8FX7JzhPfCMzZcVXDpXYOS4fQa2ENUYUL62Tc2GMZ31ivOC/xTItEsDmhsz8Ls+SK
 lx/vEDSZMkNFf9FdBT+qGix3T4oN8S6G5KnZAOrc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c423bb7c-867d-4b43-b472-2c548628e645@yandex-team.ru>
Date: Fri, 6 Oct 2023 23:39:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Python: Enable python3.12 support
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231006195243.3131140-1-jsnow@redhat.com>
 <20231006195243.3131140-5-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231006195243.3131140-5-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 06.10.23 22:52, John Snow wrote:
> Python 3.12 has released, so update the test infrastructure to test
> against this version. Update the configure script to look for it when an
> explicit Python interpreter isn't chosen.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   configure                              | 3 ++-
>   python/setup.cfg                       | 3 ++-
>   tests/docker/dockerfiles/python.docker | 6 +++++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/configure b/configure
> index e9a921ffb0..b480a3d6ae 100755
> --- a/configure
> +++ b/configure
> @@ -561,7 +561,8 @@ first_python=
>   if test -z "${PYTHON}"; then
>       # A bare 'python' is traditionally python 2.x, but some distros
>       # have it as python 3.x, so check in both places.
> -    for binary in python3 python python3.11 python3.10 python3.9 python3.8; do
> +    for binary in python3 python python3.12 python3.11 \
> +                          python3.10 python3.9 python3.8; do
>           if has "$binary"; then
>               python=$(command -v "$binary")
>               if check_py_version "$python"; then
> diff --git a/python/setup.cfg b/python/setup.cfg
> index 8c67dce457..48668609d3 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -18,6 +18,7 @@ classifiers =
>       Programming Language :: Python :: 3.9
>       Programming Language :: Python :: 3.10
>       Programming Language :: Python :: 3.11
> +    Programming Language :: Python :: 3.12
>       Typing :: Typed
>   
>   [options]
> @@ -182,7 +183,7 @@ multi_line_output=3
>   # of python available on your system to run this test.
>   
>   [tox:tox]
> -envlist = py38, py39, py310, py311
> +envlist = py38, py39, py310, py311, py312
>   skip_missing_interpreters = true
>   
>   [testenv]
> diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
> index 383ccbdc3a..a3c1321190 100644
> --- a/tests/docker/dockerfiles/python.docker
> +++ b/tests/docker/dockerfiles/python.docker
> @@ -11,7 +11,11 @@ ENV PACKAGES \
>       python3-pip \
>       python3-tox \
>       python3-virtualenv \
> -    python3.10
> +    python3.10 \
> +    python3.11 \
> +    python3.12 \
> +    python3.8 \
> +    python3.9

Hmm, interesting, how did it work before? Only 3.10 was tested?

>   
>   RUN dnf install -y $PACKAGES
>   RUN rpm -q $PACKAGES | sort > /packages.txt

weak, I'm unsure about how this all works, I just see that 3.12 is added like others in all hunks except python.docker, but I think adding several python versions to docker should be safe anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir



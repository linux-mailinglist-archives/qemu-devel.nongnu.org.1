Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3174A239
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:32:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRu6-0000yX-3m; Thu, 06 Jul 2023 12:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qHRtc-0000bz-Va
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:32:04 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qHRta-0007ZA-SI
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:31:56 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso872325f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688661112; x=1691253112;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeN++xGg8e35F2/9iu+dQUFgpJqc7z1W6P3YqcVFJOE=;
 b=pXSkj25WYSQs7CLVPdNw4g35BU9gLPmRxD74WmerptIruJL+uRKgc9S/aT7b5CIfvL
 GS6B8plfm8vfL01rR0wNJv7nV7FKpq4IpD5KVgCwYOoO1dNLDJ4nGTU6JgOB/xBKzKa1
 ACbf18C8AzHLgE1qaWl9fkGm305RmNv2CMY2WWa/4zwukVQNcGGNR4IHZ5ubxgDdLhHA
 Sc7AXL17RyyPSMrhmdl40ypN12bYvEWG8aFHPMqmh1Pm1E0KdM7GO2+kckpqVImYYPn3
 VwuV3BwtR/iC0CVwnoC1RS6dok6SIouwy0fgr+8B0U7tyo5rppzW5UxKdDqYA7bmcmHR
 J7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688661112; x=1691253112;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oeN++xGg8e35F2/9iu+dQUFgpJqc7z1W6P3YqcVFJOE=;
 b=TZtSy6Be//LRdHfIbef+XawKzb0sH3luxwZZe3y5//Icy69HJqpqgaX+h2agH1C7V6
 tHYvkGNv8S0c59Gj+28wDB6N6I28wftS1aWQH2RPv2UwPVTULChF6J5jsy7m2Tyfd7c2
 do4hrZKF9n+h0l6+zEjbd26X8WGIPcUeM6KVp+N7l9Jx6RF+brX/LkjXGnWqgBTCICXX
 rZ0bBgQ9h7pSP0F6lBP9BDWD+EeDeVqu0nubCq3+/PhkCVesjUd2hqTPcX452vyJhM+k
 GwuvgwK2OccDgvuq7COT8BkWMnaiD27d+PXFChm0qbrwJ5qKXB9ove6drEhFic0BGy00
 SWQA==
X-Gm-Message-State: ABy/qLbDMyY1G8Hy30y2ZFOOh/dTYIjwzYyYxhp5PLfbv3DhZ5lJOByW
 ICIG0QoaUU4cSE9aEJdVK71z2Q==
X-Google-Smtp-Source: APBJJlF1Iu5C6Ts+ksT1Js2KXqV/lcpvvQYluNMhRCdEbsAMS2K8fa/jEnZG+hCERq+/EyXuEF/a9g==
X-Received: by 2002:a5d:5444:0:b0:314:1fdc:796d with SMTP id
 w4-20020a5d5444000000b003141fdc796dmr1805250wrv.70.1688661111900; 
 Thu, 06 Jul 2023 09:31:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adff992000000b003142e438e8csm2291939wrr.26.2023.07.06.09.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:31:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9B821FFBB;
 Thu,  6 Jul 2023 17:31:50 +0100 (BST)
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com, takahiro.akashi@linaro.org,
 erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
 mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature
 for vhost-user
Date: Thu, 06 Jul 2023 17:31:15 +0100
In-reply-to: <20230704123600.1808604-1-alex.bennee@linaro.org>
Message-ID: <873521f1c9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Currently QEMU has to know some details about the back-end to be able
> to setup the guest. While various parts of the setup can be delegated
> to the backend (for example config handling) this is a very piecemeal
> approach.
>
> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> which the back-end can advertise which allows a probe message to be
> sent to get all the details QEMU needs to know in one message.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> Initial RFC for discussion. I intend to prototype this work with QEMU
> and one of the rust-vmm vhost-user daemons.
> ---
>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user.c      |  8 ++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..85b1b1583a 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -275,6 +275,21 @@ Inflight description
>=20=20
>  :queue size: a 16-bit size of virtqueues
>=20=20
> +Backend specifications
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> ++-----------+-------------+------------+------------+
> +| device id | config size |   min_vqs  |   max_vqs  |
> ++-----------+-------------+------------+------------+
> +
> +:device id: a 32-bit value holding the VirtIO device ID
> +
> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_G=
ET_CONFIG``)
> +
> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> +
> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, mu=
st be >=3D min_vqs
> +
>  C structure
>  -----------
>=20=20
> @@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserConfig config;
>            VhostUserVringArea area;
>            VhostUserInflight inflight;
> +          VhostUserBackendSpecs specs;
>        };
>    } QEMU_PACKED VhostUserMsg;
>=20=20
> @@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>  * ``VHOST_USER_GET_VRING_BASE``
>  * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>  * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SH=
MFD``)
> +* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALON=
E``)
>=20=20
>  .. seealso::
>=20=20
> @@ -885,6 +902,13 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
> +
> +Some features are only valid in the presence of other supporting
> +features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
> +backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
> +``VHOST_USER_PROTOCOL_F_STATUS``.
> +

This is too tight a restriction as not all VirtIO backends manage a
config space. So I suggest the following:

  Some features are only valid in the presence of other supporting
  features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
  backend must also support ``VHOST_USER_PROTOCOL_F_STATUS`` and
  optionally ``VHOST_USER_PROTOCOL_F_CONFIG`` (if there is a config space).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


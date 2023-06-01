Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59175719BF5
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hJA-0000yV-5J; Thu, 01 Jun 2023 08:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hIP-0000U8-GX
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hIG-0008KQ-QS
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622039;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRrQ9tkVapgOodtMzHj88IpGNoUxHpryTzy01XzUn68=;
 b=jH8O7nYv2kZySoloRRVMwToFygtSj9UnAsFPTYp+tUSlfNyargbhzspxziEfzagaLfEUK7
 AimJsfVoWuHafuXpQE49z2KxfrISiiXlVOjdByPFY/4J6kyyOVPNzk+fc1cHPZVRoFk+S+
 ubdFVQWNwIGTdp+LLGlEN0yIwiBkzLo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-JWcb9hs9PS2NASTPFRQamQ-1; Thu, 01 Jun 2023 08:20:38 -0400
X-MC-Unique: JWcb9hs9PS2NASTPFRQamQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af28aae675so6875891fa.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622037; x=1688214037;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oRrQ9tkVapgOodtMzHj88IpGNoUxHpryTzy01XzUn68=;
 b=KEVYkJW6KYmhkL8299a5NgJ35a6XTbRFptxfG3EGkB5y84NXcr0PhhFVaVL5cNi584
 8o6ZlkrlJqd1/wLMct27f4WT9N5wlN4YXPi1P2YAa2I81VunQysEkNQr2sRTFA+QKHJR
 sYJ3OWiy2osnsO2FcCbJbXDeZooi0b5E0RTP1t0K1ICl1OqvhR4Qle55Ggi597p16qPw
 Bf2pbLI6zofe4PDI8iIo//dIRQIesNVSerays7izQnSjJjlTymseL9IAyO1dj3yRV9AD
 iKN2feWsUfnmC7VmZxFe2CO3cU86AybecByITacrKq/yy+V2r0j6PvguT0Ik6CmSurJ5
 rBkw==
X-Gm-Message-State: AC+VfDyxH70h5Y5aFmLfQz2/OV+82w8nR8TCF0c4jotrYYtwFFkbYj7R
 8CFcThHIwJlOMBuq3PBB6S1Kt1xSSgihjtmvw6XqRCUji0agnC0rEJ4GqSyklJPHp4/6gYOtzFR
 NZoo8XB1raxiFlLS0O/efxxJkxA==
X-Received: by 2002:a2e:9955:0:b0:2af:23b3:afad with SMTP id
 r21-20020a2e9955000000b002af23b3afadmr4184169ljj.10.1685622036812; 
 Thu, 01 Jun 2023 05:20:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6S+2OdxwJRmhIr17R33W/eu+r+/3Rfo/+PIKXPRo5guw1WcU201/5l9dvSLnjDNkr1YdvRMg==
X-Received: by 2002:a2e:9955:0:b0:2af:23b3:afad with SMTP id
 r21-20020a2e9955000000b002af23b3afadmr4184152ljj.10.1685622036388; 
 Thu, 01 Jun 2023 05:20:36 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l9-20020adfe589000000b00307c8d6b4a0sm10238300wrm.26.2023.06.01.05.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:20:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/9] tests/qtest: add various
 qtest_qmp_assert_success() variants
In-Reply-To: <20230531132400.1129576-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:52
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-2-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:20:34 +0200
Message-ID: <87r0qvs7al.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Add several counterparts of qtest_qmp_assert_success() that can
>
>  * Use va_list instead of ...
>  * Accept a list of FDs to send
>  * Return the response data
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/qtest/libqtest.c |  99 +++++++++++++++++++++++++++++++++--
>  tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 209 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index c3a0ef5bb4..603c26d955 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1229,14 +1229,23 @@ void qtest_memset(QTestState *s, uint64_t addr, u=
int8_t pattern, size_t size)
>      qtest_rsp(s);
>  }
>=20=20
> -void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
> +void qtest_vqmp_assert_success(QTestState *qts,
> +                               const char *fmt, va_list args)
>  {
> -    va_list ap;
>      QDict *response;
>=20=20
> -    va_start(ap, fmt);
> -    response =3D qtest_vqmp(qts, fmt, ap);
> -    va_end(ap);
> +    response =3D qtest_vqmp_assert_success_ref(qts, fmt, args);
> +
> +    qobject_unref(response);
> +}
> +
> +QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
> +                                     const char *fmt, va_list args)
> +{
> +    QDict *response;
> +    QDict *ret;
> +
> +    response =3D qtest_vqmp(qts, fmt, args);
>=20=20
>      g_assert(response);
>      if (!qdict_haskey(response, "return")) {
> @@ -1245,8 +1254,88 @@ void qtest_qmp_assert_success(QTestState *qts, con=
st char *fmt, ...)
>          g_string_free(s, true);
>      }
>      g_assert(qdict_haskey(response, "return"));
> +    ret =3D qdict_get_qdict(response, "return");
> +    qobject_ref(ret);
> +    qobject_unref(response);
> +
> +    return ret;
> +}
> +
> +#ifndef _WIN32
> +QDict *qtest_vqmp_fds_assert_success_ref(QTestState *qts, int *fds, size=
_t nfds,
> +                                         const char *fmt, va_list args)
> +{
> +    QDict *response;
> +    QDict *ret;
> +
> +    response =3D qtest_vqmp_fds(qts, fds, nfds, fmt, args);
> +
> +    g_assert(response);
> +    if (!qdict_haskey(response, "return")) {
> +        GString *s =3D qobject_to_json_pretty(QOBJECT(response), true);
> +        g_test_message("%s", s->str);
> +        g_string_free(s, true);

I know we are not consistent ot this file, but what about using autoptr her=
e?

        g_autoptr(GString) *s =3D qobject_to_json_pretty(QOBJECT(response),=
 true);
        g_test_message("%s", s->str);

??

> +    }
> +    g_assert(qdict_haskey(response, "return"));
> +    ret =3D qdict_get_qdict(response, "return");
> +    qobject_ref(ret);
> +    qobject_unref(response);
> +
> +    return ret;
> +}
> +
> +void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfd=
s,
> +                                   const char *fmt, va_list args)
> +{
> +    QDict *response;
> +    response =3D qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, =
args);
>      qobject_unref(response);
>  }
> +#endif /* !_WIN32 */
> +
> +void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response =3D qtest_vqmp_assert_success_ref(qts, fmt, ap);
> +    va_end(ap);
> +    qobject_unref(response);
> +}
> +
> +QDict *qtest_qmp_assert_success_ref(QTestState *qts, const char *fmt, ..=
.)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response =3D qtest_vqmp_assert_success_ref(qts, fmt, ap);
> +    va_end(ap);
> +    return response;
> +}
> +
> +#ifndef _WIN32
> +void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
> +                                  const char *fmt, ...)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response =3D qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, =
ap);
> +    va_end(ap);
> +    qobject_unref(response);
> +}
> +
> +QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_=
t nfds,
> +                                        const char *fmt, ...)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response =3D qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, =
ap);
> +    va_end(ap);
> +    return response;
> +}
> +#endif /* !_WIN32 */
>=20=20
>  bool qtest_big_endian(QTestState *s)
>  {
> diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
> index 8d7d450963..41bc6633bd 100644
> --- a/tests/qtest/libqtest.h
> +++ b/tests/qtest/libqtest.h
> @@ -693,6 +693,73 @@ void qtest_add_abrt_handler(GHookFunc fn, const void=
 *data);
>   */
>  void qtest_remove_abrt_handler(void *data);
>=20=20
> +/**
> + * qtest_vqmp_assert_success:
> + * @qts: QTestState instance to operate on
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + * @args: variable arguments for @fmt
> + *
> + * Sends a QMP message to QEMU and asserts that a 'return' key is presen=
t in
> + * the response.
> + */
> +void qtest_vqmp_assert_success(QTestState *qts,
> +                               const char *fmt, va_list args)
> +    G_GNUC_PRINTF(2, 0);
> +
> +/**
> + * qtest_vqmp_assert_success_ref:
> + * @qts: QTestState instance to operate on
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + * @args: variable arguments for @fmt
> + *
> + * Sends a QMP message to QEMU, asserts that a 'return' key is present in
> + * the response, and returns the response.
> + */
> +QDict *qtest_vqmp_assert_success_ref(QTestState *qts,
> +                                     const char *fmt, va_list args)
> +    G_GNUC_PRINTF(2, 0);
> +
> +#ifndef _WIN32
> +/**
> + * qtest_vqmp_fds_assert_success:
> + * @qts: QTestState instance to operate on
> + * @fds: the file descriptors to send
> + * @nfds: number of @fds to send
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + * @args: variable arguments for @fmt
> + *
> + * Sends a QMP message with file descriptors to QEMU and
> + * asserts that a 'return' key is present in the response.
> + */
> +void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfd=
s,
> +                                   const char *fmt, va_list args)
> +    G_GNUC_PRINTF(4, 0);
> +
> +/**
> + * qtest_vqmp_fds_assert_success_ref:
> + * @qts: QTestState instance to operate on
> + * @fds: the file descriptors to send
> + * @nfds: number of @fds to send
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + * @args: variable arguments for @fmt
> + *
> + * Sends a QMP message with file descriptors to QEMU,
> + * asserts that a 'return' key is present in the response,
> + * and returns the response.
> + */
> +QDict *qtest_vqmp_fds_assert_success_ref(QTestState *qts, int *fds, size=
_t nfds,
> +                                         const char *fmt, va_list args)
> +    G_GNUC_PRINTF(4, 0);
> +#endif /* !_WIN32 */
> +
>  /**
>   * qtest_qmp_assert_success:
>   * @qts: QTestState instance to operate on
> @@ -706,6 +773,54 @@ void qtest_remove_abrt_handler(void *data);
>  void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
>      G_GNUC_PRINTF(2, 3);
>=20=20
> +/**
> + * qtest_qmp_assert_success_ref:
> + * @qts: QTestState instance to operate on
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + *
> + * Sends a QMP message to QEMU, asserts that a 'return' key is present in
> + * the response, and returns the response.
> + */
> +QDict *qtest_qmp_assert_success_ref(QTestState *qts, const char *fmt, ..=
.)
> +    G_GNUC_PRINTF(2, 3);
> +
> +#ifndef _WIN32
> +/**
> + * qtest_qmp_fd_assert_success:
> + * @qts: QTestState instance to operate on
> + * @fds: the file descriptors to send
> + * @nfds: number of @fds to send
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + *
> + * Sends a QMP message with file descriptors to QEMU and
> + * asserts that a 'return' key is present in the response.
> + */
> +void qtest_qmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
> +                                  const char *fmt, ...)
> +    G_GNUC_PRINTF(4, 5);
> +
> +/**
> + * qtest_qmp_fd_assert_success_ref:
> + * @qts: QTestState instance to operate on
> + * @fds: the file descriptors to send
> + * @nfds: number of @fds to send
> + * @fmt: QMP message to send to qemu, formatted like
> + * qobject_from_jsonf_nofail().  See parse_interpolation() for what's
> + * supported after '%'.
> + *
> + * Sends a QMP message with file descriptors to QEMU,
> + * asserts that a 'return' key is present in the response,
> + * and returns the response.
> + */
> +QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_=
t nfds,
> +                                        const char *fmt, ...)
> +    G_GNUC_PRINTF(4, 5);
> +#endif /* !_WIN32 */
> +
>  /**
>   * qtest_cb_for_every_machine:
>   * @cb: Pointer to the callback function



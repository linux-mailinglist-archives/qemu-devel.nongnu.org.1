Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD707196CE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:23:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eWX-00021X-D9; Thu, 01 Jun 2023 05:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4eWU-00021J-5u
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4eWR-000540-DU
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685611386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=36mY+llOLTOBXZuUQFPQB+cqLLNmF6IDdzRRCjkF8d8=;
 b=O4+bp6QDAWzBnfkSDXu9e9MEOLvrjshlTKFq1qWLjxrWW8b879G/ZaabtwrIk3LwI+89NJ
 K9G74BcB54X3lYJBeNJWuxk2HyXTjOurtKqehZ+OvO40kYe7RKJPlD32FGqt7DzehYSkOG
 pox3TvNDr6C0iYGk1y5HEcP2Or10weY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-KCAc1-pyN761rrOq-U1PRQ-1; Thu, 01 Jun 2023 05:23:04 -0400
X-MC-Unique: KCAc1-pyN761rrOq-U1PRQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f517b5309cso447434e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685611383; x=1688203383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=36mY+llOLTOBXZuUQFPQB+cqLLNmF6IDdzRRCjkF8d8=;
 b=PtooFTFZoDPnVJ6Ja5o2R7Wo7WFNtP78qGLK/GSC+r5mXFnrIjNZh8rlOULNWpjED6
 EDBbmcxzOBpfVYdJTatNmR4LN6T20eLr+M/11axjRCB7gfrTuXYlanwd4GE44QHEbZ+K
 NVNy8AaK1iZOKLvlhCPjKzuQEm/SxKeFDyJQaoV4S3li8QZivwbqZqxbFVbpp7FxMVsb
 2IFjPHl7+wiQ//m7fDLiDbt0JTCnuX1zidX56F4n7Bkyez7zHOV+R+22/iE0JZ8d2fzH
 EODqyDjXdge8YKUjK+N+3XpSoWtyyyveU59XrhkrWMrLZKqvMXKJdW/iclxlPVkPQugG
 4v3Q==
X-Gm-Message-State: AC+VfDyz6Q4E3DLuYUH/cHo/OjedQMKlB5VxgZbxcSUJrxs6kbfO136P
 7Zc+bcyimCAMWpIlZMOkFthRi2XvvNrHbv6w3tdRjWWNH3uXdTkoqu0ZOzKeLCjJ1SDDI6YPo5K
 hNEQB7GaKBP9TwDojulEVSCo=
X-Received: by 2002:ac2:5e9d:0:b0:4f3:872d:10ff with SMTP id
 b29-20020ac25e9d000000b004f3872d10ffmr1007135lfq.64.1685611383362; 
 Thu, 01 Jun 2023 02:23:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ62E3o59msn1Zss4LaKjT+GDQcEEFB2VWJsbt1WKbh4uXOFxs/5t3ijRLyaF2FQd8/iNGS7Og==
X-Received: by 2002:ac2:5e9d:0:b0:4f3:872d:10ff with SMTP id
 b29-20020ac25e9d000000b004f3872d10ffmr1007113lfq.64.1685611383027; 
 Thu, 01 Jun 2023 02:23:03 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 hn17-20020a05600ca39100b003f42a75ac2asm1626378wmb.23.2023.06.01.02.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:23:02 -0700 (PDT)
Message-ID: <629f6745-6c36-93a9-8ebe-a8a83fd154c7@redhat.com>
Date: Thu, 1 Jun 2023 11:23:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/9] tests/qtest: add various
 qtest_qmp_assert_success() variants
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> Add several counterparts of qtest_qmp_assert_success() that can
> 
>   * Use va_list instead of ...
>   * Accept a list of FDs to send
>   * Return the response data
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/libqtest.c |  99 +++++++++++++++++++++++++++++++++--
>   tests/qtest/libqtest.h | 115 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 209 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index c3a0ef5bb4..603c26d955 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -1229,14 +1229,23 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
>       qtest_rsp(s);
>   }
>   
> -void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
> +void qtest_vqmp_assert_success(QTestState *qts,
> +                               const char *fmt, va_list args)
>   {
> -    va_list ap;
>       QDict *response;
>   
> -    va_start(ap, fmt);
> -    response = qtest_vqmp(qts, fmt, ap);
> -    va_end(ap);
> +    response = qtest_vqmp_assert_success_ref(qts, fmt, args);
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
> +    response = qtest_vqmp(qts, fmt, args);
>   
>       g_assert(response);
>       if (!qdict_haskey(response, "return")) {
> @@ -1245,8 +1254,88 @@ void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
>           g_string_free(s, true);
>       }
>       g_assert(qdict_haskey(response, "return"));
> +    ret = qdict_get_qdict(response, "return");
> +    qobject_ref(ret);
> +    qobject_unref(response);
> +
> +    return ret;
> +}
> +
> +#ifndef _WIN32
> +QDict *qtest_vqmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
> +                                         const char *fmt, va_list args)
> +{
> +    QDict *response;
> +    QDict *ret;
> +
> +    response = qtest_vqmp_fds(qts, fds, nfds, fmt, args);
> +
> +    g_assert(response);
> +    if (!qdict_haskey(response, "return")) {
> +        GString *s = qobject_to_json_pretty(QOBJECT(response), true);
> +        g_test_message("%s", s->str);
> +        g_string_free(s, true);
> +    }
> +    g_assert(qdict_haskey(response, "return"));
> +    ret = qdict_get_qdict(response, "return");
> +    qobject_ref(ret);
> +    qobject_unref(response);
> +
> +    return ret;
> +}
> +
> +void qtest_vqmp_fds_assert_success(QTestState *qts, int *fds, size_t nfds,
> +                                   const char *fmt, va_list args)
> +{
> +    QDict *response;
> +    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, args);
>       qobject_unref(response);
>   }

<bikeshedding>The ordering is a little bit inconsistent ... for some pairs, 
you do the _success() function first, and for some others you do the 
_success_ref() function first. IMHO it would be nicer to have the same 
ordering everywhere, preferably with the _success_ref() function first 
(since that's the one that is called from the other).</bikeshedding>

> +#endif /* !_WIN32 */
> +
> +void qtest_qmp_assert_success(QTestState *qts, const char *fmt, ...)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response = qtest_vqmp_assert_success_ref(qts, fmt, ap);

You could use qtest_vqmp_assert_success() instead, I think, and dro the 
qobject_unref() below.

> +    va_end(ap);
> +    qobject_unref(response);
> +}
> +
> +QDict *qtest_qmp_assert_success_ref(QTestState *qts, const char *fmt, ...)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response = qtest_vqmp_assert_success_ref(qts, fmt, ap);
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
> +    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, ap);

dito, could use qtest_vqmp_fds_assert_success() instead.

> +    va_end(ap);
> +    qobject_unref(response);
> +}
> +
> +QDict *qtest_qmp_fds_assert_success_ref(QTestState *qts, int *fds, size_t nfds,
> +                                        const char *fmt, ...)
> +{
> +    QDict *response;
> +    va_list ap;
> +    va_start(ap, fmt);
> +    response = qtest_vqmp_fds_assert_success_ref(qts, fds, nfds, fmt, ap);
> +    va_end(ap);
> +    return response;
> +}
> +#endif /* !_WIN32 */

Just nits, so anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>



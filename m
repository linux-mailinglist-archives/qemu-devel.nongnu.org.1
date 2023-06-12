Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944E72C5C8
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hV3-00047l-Oj; Mon, 12 Jun 2023 09:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8hV1-00047V-Rx
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:22:23 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q8hUz-0002Wa-Vi
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:22:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6e68cc738so32063935e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686576139; x=1689168139;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TWiy261DCppPN8YLO5Bsb4zxGjHZyXfIubHw72rag8=;
 b=EangRaJC51dldUZAMyEf2fjxNDfAwqNnBroDrigu4jbAzeRVKq5SkQn2S4hYyin6rq
 qPkCmY+oBU71Sfkxkda7iZGak5+7YZzm7W57w9s5PvrFTU9W482FiW4WOh0FXizC3oTq
 ADPvkowWaqT4ttYrSXKhKCd55p+pF1Afrzbl6JAi1JIt54Q2jqRlHV9MvDV1ybmzsRSI
 2d5VL5lQnNfzSuODBwWOJGAMJVa/hshLpCL6tGauWV5dLLZCYFJdaAvAmGZw3/uDUsHH
 CCG/1zyu7c4Fhvhh/NsjGg7OjPFlsXRGGIL41MQ7yp+e2XDcEx/+C+E9PZ4VkXDSDOTz
 GOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686576139; x=1689168139;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6TWiy261DCppPN8YLO5Bsb4zxGjHZyXfIubHw72rag8=;
 b=S5LScUApaPpUA6t21f/sfYGBedEk8ijEoq8fs/LwhJKmVAxCQMG2vtv6W2wicVhL08
 h4ucaQhO/IA/WdhdoO+3BGEmQZv8e+AZqp3qThKXYNFOV4r23GcZm2q6YVWsjCOvMPbA
 Lc1YzH6ftyn+5IGpLobZrJ7umDY3W3UGMz3vLc5z3sYolSV4QILz1/O5ZWW2ED/bKgCP
 eMjVu17jgXd6GUtsgbpKv9l/uarxi8kuxtDs75yy04orpMlDnFGYbQDz8+6zn+T2ekQ6
 pSaixURQUsSBLbxus2dzxz/gQLl+P62qCwDa8+BtgqsDF1D/r5qE1rXBqmZ2S1NU0JL5
 drjg==
X-Gm-Message-State: AC+VfDwANK7sbfu8dIT8vhM3hoSi+f8OzpT4h1PbgG4UhRaAGilEU2k9
 BidRQqvO/W3oEKDFu86oRs3Y6Q==
X-Google-Smtp-Source: ACHHUZ6YQH+XMg14Xeusn/cWo3BzA0VNZ39NnXtYlPmrRBuixtbbeNj2QrNocgZZydmhmOeu94iHAQ==
X-Received: by 2002:a1c:7713:0:b0:3f6:784:9617 with SMTP id
 t19-20020a1c7713000000b003f607849617mr5830880wmi.11.1686576139565; 
 Mon, 12 Jun 2023 06:22:19 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a7bc5c6000000b003f7f87ba116sm11395126wmk.19.2023.06.12.06.22.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:22:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9518F1FFBB;
 Mon, 12 Jun 2023 14:22:18 +0100 (BST)
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
 <20230607164750.829586-7-fufuyqqqqqq@gmail.com>
 <vz1az.urjahnph4c90@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Subject: Re: [RFC v2 6/6] linux-user: Add '-native-bypass' option
Date: Mon, 12 Jun 2023 14:06:35 +0100
In-reply-to: <vz1az.urjahnph4c90@linaro.org>
Message-ID: <878rco7r3p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Wed, 07 Jun 2023 19:47, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
>>--- a/linux-user/main.c
>>+++ b/linux-user/main.c
>>+    /* Set the library for native bypass  */
>>+    if (native_lib !=3D NULL) {
>>+        char *token =3D malloc(strlen(native_lib) + 12);
>
> malloc() can fail (in rare circumstances). Check for the return value
> here. Or use g_malloc() which terminates on alloc failure.

We avoid malloc in favour of g_malloc(). You can use g_try_malloc for
certain cases (although this is not one of them). However you can make
this glibs problem with something like:

    /* Set the library for native bypass  */
    if (native_lib !=3D NULL) {
        GString *lib =3D g_string_new(native_lib);
        lib =3D g_string_prepend(lib, "LD_PRELOAD=3D");
        if (envlist_appendenv(envlist, g_string_free(lib, false), ":") !=3D=
 0) {
            usage(EXIT_FAILURE);
        }
    }


>
>>+        strcpy(token, "LD_PRELOAD=3D");
>>+        strcat(token, native_lib);
>
> (You could alternatively use snprintf() here)

We have a section on strings in the developer manual:

 https://qemu.readthedocs.io/en/latest/devel/style.html#string-manipulation

so we have things like pstrcat and pstrcpy. However this isn't criticl
performance path so GString provides a nice memory safe wrapper for all
this sort of manipulation.

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F4C7070E6
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:37:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzM0P-0001GQ-6O; Wed, 17 May 2023 14:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzM0N-0001Ew-0E
 for qemu-devel@nongnu.org; Wed, 17 May 2023 14:36:07 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzM0L-0001hl-7Z
 for qemu-devel@nongnu.org; Wed, 17 May 2023 14:36:06 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-50bc5197d33so2104230a12.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684348563; x=1686940563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VvTnUKgMw/Xi78WyYLSbWROu16HcP9Szbvysei+mIEs=;
 b=RU9+gCtSY9N47G5NWKv/Uz/t603HDkgOSiaUenjUBFFnr1TvkLzMWWVRGKye55Szs0
 JGf7W9e+zI9gzqia/8vCl2CIsnxszrsVKd4lMZFrvOg1fe1svqRWQDnCqV1h1b1sExvm
 /9yNeFnd3QiwAJBB6HhfiLtkoq/Vl0luGwzKHptVzOEhQnO+nUxTrqnw6kdAsBqDsLIO
 YCPkYlSedh/ejYdozvplFy8K7BC/qpfkV5OcGIshwuVokwD+b0VQWujAy4ELiwaS9PM3
 YqxH/Md3oQNqUunxRIUUxIpR3yVmeoLbvSQ45whLzpAVfW6Idp0AV3lh/AYFsxmzKD4C
 oahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684348563; x=1686940563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VvTnUKgMw/Xi78WyYLSbWROu16HcP9Szbvysei+mIEs=;
 b=LDooEvMGDfIkYE11KPnmbxLfh3D57C9iUiFBroL9VJBhDPEg1gQWSPROVKzPpLtHYS
 nn7M35D8V625hajZ+wvelbnSRQDGEu4/ipJVa5Cy0F+IVF2NLoDK5o4mbAyGcaEMfSwp
 cFKFdQYhqViwjMw3Jdg6Ig1FZamCBZu4hprCbUA4N+QsrSEY5lSGxeH+kaauecwGknXq
 w1LFCgIUvMg7vW78MkPA61qlEjQMjbpBnrEsVuymsDxy6TUSJNyeopSXwaqO8g0+t+dg
 s57UCKx1XPf6Wypr+YWabDY2mUAPcRH6TIpoUTQDPUOpmLxK4ZbyZ60pD8NesxCuwnjT
 HWSQ==
X-Gm-Message-State: AC+VfDy9S/Wn3XFJXE1BHQayyNg5/bFVL1eNuRU4OiLWaW3HXtu8S++w
 mn5AvtU1PbKJpWghvvyWiJVKSnCvfYcFrEFdRgqD4A==
X-Google-Smtp-Source: ACHHUZ6pMEI01F2SesCdeZ4fV82n1XMYA72Qabgzp9cqSMxK12gXLA2tK/GFb61jFlC99k6GT8hnvDmRNAAxjkuMcvY=
X-Received: by 2002:aa7:d551:0:b0:508:3f06:8fd1 with SMTP id
 u17-20020aa7d551000000b005083f068fd1mr2735915edr.29.1684348563656; Wed, 17
 May 2023 11:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230517152516.1884640-1-armbru@redhat.com>
 <4d3356c0-2e9e-bc3c-5200-88a3b5edd3e4@linaro.org>
In-Reply-To: <4d3356c0-2e9e-bc3c-5200-88a3b5edd3e4@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 May 2023 19:35:41 +0100
Message-ID: <CAFEAcA8MinW8wVeP8v4-7ktwCW3xbW6VTHkMDGTQay6n=Q_h0Q@mail.gmail.com>
Subject: Re: [PULL 0/5] QAPI patches patches for 2023-05-17
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 17 May 2023 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
> https://gitlab.com/qemu-project/qemu/-/jobs/4303506102#L3766
> https://gitlab.com/qemu-project/qemu/-/jobs/4303506050#L5856
> https://gitlab.com/qemu-project/qemu/-/jobs/4303506047#L3654
>
> /home/gitlab-runner/builds/Jpwtyaz7/0/qemu-project/qemu/docs/interop/qmp-spec.rst:71:Error
> in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> .. code-block::
>    { "QMP": { "version": json-object, "capabilities": json-array } }

Looks like whatever version of Sphinx this is enforces that
code-block comments specify a language. The system I tested on
didn't care.

In theory these blocks should be ".. code-block:: json", you
might think, but for me that results in

Warning, treated as error:
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/docs/interop/qmp-spec.rst:71:Could
not lex literal_block as "json". Highlighting skipped.

(which I think means my system doesn't have the json lexer,
but who knows...)

So the simplest fix is to turn all the no-language code-blocks into
plain old literal blocks (the ones which are "QMP" format are fine,
but specifying QMP doesn't work for these blocks, because the QMP lexer
insists on seeing the -> and <- that indicate a command/response
direction). This should work as a fixup to the patch.

Markus, could I ask you to squash it in for the next round of this pullreq ?

diff --git a/docs/interop/qmp-spec.rst b/docs/interop/qmp-spec.rst
index 2609b3ff9b2..23ddcc853e5 100644
--- a/docs/interop/qmp-spec.rst
+++ b/docs/interop/qmp-spec.rst
@@ -68,7 +68,7 @@ ready for capabilities negotiation (for more
information refer to section

 The greeting message format is:

-.. code-block::
+::

   { "QMP": { "version": json-object, "capabilities": json-array } }

@@ -94,13 +94,13 @@ Issuing Commands

 The format for command execution is:

-.. code-block::
+::

   { "execute": json-string, "arguments": json-object, "id": json-value }

 or

-.. code-block::
+::

   { "exec-oob": json-string, "arguments": json-object, "id": json-value }

@@ -164,7 +164,7 @@ Success

 The format of a success response is:

-.. code-block::
+::

   { "return": json-value, "id": json-value }

@@ -183,7 +183,7 @@ Error

 The format of an error response is:

-.. code-block::
+::

   { "error": { "class": json-string, "desc": json-string }, "id": json-value }

@@ -208,7 +208,7 @@ response. They are called "asynchronous events".

 The format of asynchronous events is:

-.. code-block::
+::

   { "event": json-string, "data": json-object,
     "timestamp": { "seconds": json-number, "microseconds": json-number } }

thanks
-- PMM


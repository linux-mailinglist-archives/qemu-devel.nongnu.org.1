Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CDF7032B9
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:19:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyauV-0004mp-Lj; Mon, 15 May 2023 12:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyauT-0004l2-Dq
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:18:53 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyauR-0004Z7-FJ
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:18:53 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-50bc0117683so23034979a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684167530; x=1686759530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EtMZJVWJBxNJ9ga2Ot7OWQ0H/WyOg92wHrydY6buqjg=;
 b=VtLTANPms2egnPH0ydZ7LD20fchzrF9KAql6lbmjJuZs2nS5IHdlmahmlVOP2a1EQH
 +ynnvdBmLraLueC552A5a0BWSdGpF/aJEwf9ncFxVVQAGoLKR2iXSVzoEeZHRYEjm/2q
 zM+GUxSCnHZchyUTt42KDaUChbT0uNrSM7MCOSMQPYao2YqvcVnGdxuDXAXnXOsES33w
 bc/c+TUguC6kCAiA0jDBbTqoGevwuBt3kqlPWaTMoPZ4t8Pt95c9H3NfwC2V0Ii5JbWu
 RoP/VQAn7TLTGOZeVfS8U4PGmdWmFh42w0dnysGYvz0wESo5mLepl9XayW5sESF+IfD7
 Jy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684167530; x=1686759530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EtMZJVWJBxNJ9ga2Ot7OWQ0H/WyOg92wHrydY6buqjg=;
 b=WIxIOd9bdG4bs8zIk6x6Az+BDDcy00lQZ+kVdvp1fybyzrVAqQNwcHgdQj0mi94xac
 9iRNlx19vc8Kw9eiGk2luV0NOTR92H60Gz1kNuQXD5zeh7vLR5Ui1zN5W07kgCoDJIoW
 MpzxqWt+lRWAV+5fvMEFKfK7l6f9NuCyst/Jrz3ZeXkEA7JRXSw8HodoJlEha8yPgpQx
 zUg2pdVy+XDF7DrrCGjM6QhkuBLDLXr6lA5p9DLGlsUMHeUD5ZcNsQNk8eIEDPDgYKZK
 dG24FPODcY5rCu4tw8EI26jzSct1IZA8ybt1p00Ki0RsOMpnL7OOoConYaRCz6OKSkfi
 oqoA==
X-Gm-Message-State: AC+VfDx5HhTYcnfK+UfwAJa/6pA0/CJH+yHzbPbY5aifw5i/ScVNG+wF
 9zPlq2e63ut4BvMBGtt2w0uMNHDek66jLr4Ijh9TgcAIAm61ZP0u
X-Google-Smtp-Source: ACHHUZ5QAQ5fbmQ/cKifuMsTHYqWclbitZjmpRdwSKJr2ztS3tCxFdP8EwBeczfhYi/GTL7H6OiCpiUQp/dDJ23cqw4=
X-Received: by 2002:a05:6402:14d3:b0:508:4120:202a with SMTP id
 f19-20020a05640214d300b005084120202amr30546249edx.10.1684167529593; Mon, 15
 May 2023 09:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230511121553.3356127-1-peter.maydell@linaro.org>
 <20230511121553.3356127-2-peter.maydell@linaro.org>
 <87353xydog.fsf@pond.sub.org>
In-Reply-To: <87353xydog.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 17:18:38 +0100
Message-ID: <CAFEAcA_iD3VGgHYs8q5BuF5xLh8iY5OqQZhVw6MfFOco71bYfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs/interop: Convert qmp-spec.txt to rST
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

On Mon, 15 May 2023 at 13:36, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Convert the qmp-spec.txt document to restructuredText.
> > Notable points about the conversion:
> >  * numbers at the start of section headings are removed, to match
> >    the style of the rest of the manual
> >  * cross-references to other sections or documents are hyperlinked
>
> You also add new references to QMP and QGA reference manuals.
> Thoughtful!
>
> >  * various formatting tweaks (notably the examples, which need the
> >    -> and <- prefixed so the QMP code-block lexer will accept them)
>
> You could add
>
>    * English prose fixed in a few places.
>
> Appreciated!
>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > v1->v2: minor tweaks per Eric's review
> >  * consistently use '.' at end of sentences in Where: lists
> >  * s/the same of the/the same as for the/
> > ---
> >  docs/interop/index.rst                      |   1 +
> >  docs/interop/{qmp-spec.txt => qmp-spec.rst} | 337 +++++++++++---------
> >  2 files changed, 186 insertions(+), 152 deletions(-)
> >  rename docs/interop/{qmp-spec.txt => qmp-spec.rst} (55%)
>
> Leaves a few dangling references:
>
>     $ git-grep -F qmp-spec.txt
>
>     docs/devel/qapi-code-gen.rst:See qmp-spec.txt for out-of-band execution syntax and semantics.
>     python/qemu/qmp/models.py:    Defined in qmp-spec.txt, section 2.2, "Server Greeting".
>     python/qemu/qmp/models.py:    Defined in qmp-spec.txt, section 2.2, "Server Greeting".
>     python/qemu/qmp/models.py:    Defined in qmp-spec.txt, section 2.4.2, "error".
>     python/qemu/qmp/models.py:    Defined in qmp-spec.txt, section 2.4.2, "error".
>     python/qemu/qmp/qmp_client.py:            # See "NOTE" in qmp-spec.txt, section 2.4.2
>     python/qemu/qmp/qmp_client.py:        # qmp-spec.txt, section 2.4:
>     qapi/control.json:#     docs/interop/qmp-spec.txt)
>     qapi/control.json:#     qmp-spec.txt for more information on OOB)
>     qapi/qapi-schema.json:# Please, refer to the QMP specification (docs/interop/qmp-spec.txt)
>     qobject/json-lexer.c:         * state; see docs/interop/qmp-spec.txt.
>
> Easy enough to fix up.

Yep, I'll correct these in v3. (The section numbers all have to go,
as the sections aren't numbered any more. The refs in qapi-code-gen.rst
and qapi-schema.json can turn into hyperlinks now.)

> > @@ -45,83 +45,89 @@ important unless specifically documented otherwise.  Repeating a key
> >  within a json-object gives unpredictable results.
> >
> >  Also for convenience, the server will accept an extension of
> > -'single-quoted' strings in place of the usual "double-quoted"
> > +``'single-quoted'`` strings in place of the usual ``"double-quoted"``
> >  json-string, and both input forms of strings understand an additional
> > -escape sequence of "\'" for a single quote. The server will only use
> > +escape sequence of ``\'`` for a single quote. The server will only use
>
> Pre-patch plain text "\'" becomes just \' in HTML output, but rendered
> as code, i.e. in a fixed-width font.  I'd prefer to retain the quotation
> marks, like ``"\'"``, just like in JSON RFC 8259, but then plain text
> output becomes ""\'"".
>
> Likewise, ``'single-quoted'`` and ``"double-quoted"`` produce
> "'single-quoted'" and ""double-quoted"" in plain text output.
>
> Can't win.
>
> git-grep '``"' docs/ shows preexisting instances.
>
> More of the same below, not flagging again.  No use fighting the tool.

I'm not sure if this is requesting a change, so I'm going to
assume it is not :-)

> > -3.2 Capabilities negotiation
> > -----------------------------
> > +  .. code-block:: QMP
> >
> > -C: { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }
> > -S: { "return": {}}
> > +    <- { "QMP": {"version": {"qemu": {"micro": 0, "minor": 0, "major": 3},
> > +         "package": "v3.0.0"}, "capabilities": ["oob"] } }
>
> Opportunity to adjust the spacing to match what the server actually
> sends:
>
>        <- {"QMP": {"version": {"qemu": {"micro": 0, "minor": 0, "major": 3},
>            "package": "v3.0.0"}, "capabilities": ["oob"]}}
>
> May want to adjust spacing in input as well for a more consistent look.
>
> Suggestion, not demand.

I think this is more change than I want to do at this point,
since it would require testing all the JSON examples in the
doc and fixing all the other bits of JSON in it.

> > +
> > +.. admonition:: Example
> > +
> > +  Parsing error
> > +
> > +  .. code-block:: QMP
> > +
> > +    -> { "execute": }
> > +    <- { "error": { "class": "GenericError", "desc": "Invalid JSON syntax" } }
>
> This error changed long ago (I believe).  Actual response is
>
>           {"error": {"class": "GenericError", "desc": "JSON parse error, expecting value"}}
>
> Please update this one even if you decide to leave the spacing as is.

OK, but that should definitely be a separate patch.

thanks
-- PMM


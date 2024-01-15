Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1A82E113
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 21:00:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPT6y-0003i1-4J; Mon, 15 Jan 2024 14:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rPT6v-0003hh-AU
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 14:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rPT6t-0005Ld-LR
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 14:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705348741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLdITcWjmZ6wKoqb9AzWajOR53vwyQdRse4ePVi9rBY=;
 b=YN2syTrzQJyDwU+vixpNhv0RjQViDbpT1v1HxxQaB/SrdSlvhOH7v5w5umLNt2j/LjNp9Z
 T8k4XqZm3c0TuLkkmh4pawAGKykPjI9ARwi9H2OoIQMS1Al7JMeMU8451FGEsX9lFcWDLz
 0ASHoSgCIuImKW4Eh6HRrH5VrvoTtXU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-LLtUE-XSPs20wnKRKa8UEw-1; Mon, 15 Jan 2024 14:58:59 -0500
X-MC-Unique: LLtUE-XSPs20wnKRKa8UEw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6da83a2cf03so6576786b3a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 11:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705348738; x=1705953538;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLdITcWjmZ6wKoqb9AzWajOR53vwyQdRse4ePVi9rBY=;
 b=LineOzJLzzBBObqDfCvZRo8YQ2jaE+qbrTTmTZ4MjIr+2/MkKIP3qkigGLtavwcT0t
 g5Kqvr/xP4njTcBoXCFnZpuuAJxUxbHmaIP6ASRFcHFeLjXVXqHuFYuw2UL6ZUKqsDcq
 UjU9/lX0R/SlJISxi5jJJr0cdgNdS5yxVahgWtc/TPn6K6oarlQyntYUIuGIoY4S0T8N
 CC+nldBCZb4Xq1/e1uPk0Z3gvIHcwJhq288ihZBhiChE91rHPza3lm2cYpwePk3H3RBu
 4n/VUIFeHSBXGd+EaGUgydFmSDzSDLPQHsP6QeF5teBxTNuyiZE8YEtC2Nj1jeQuPXCx
 bjMA==
X-Gm-Message-State: AOJu0Yz0DJeid5a+FrGSb+NEce89uunNqWh9nk6Jjvv/MM/i8ZQjZDme
 qZID3IUVy5Tl6dJhtpdg5gc0AfrYTFZOe6oeJxWUPXcC6FZNLG66ezkXESBrQiJScPc2FE9y5MR
 NUVYoJGrZxKFcxtzyghMal8bzSr6HdgsI0OcNgCc=
X-Received: by 2002:a05:6a20:970d:b0:19a:485a:bd02 with SMTP id
 hr13-20020a056a20970d00b0019a485abd02mr2601900pzc.81.1705348738714; 
 Mon, 15 Jan 2024 11:58:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaDIOUpVJGS232VlMs8ocllMpxPJCWa4S15yT5rUOUYh9CVgIPvYEvD6iymcNHI625ddg6hGiGb8D0EuzfeBg=
X-Received: by 2002:a05:6a20:970d:b0:19a:485a:bd02 with SMTP id
 hr13-20020a056a20970d00b0019a485abd02mr2601896pzc.81.1705348738443; Mon, 15
 Jan 2024 11:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-2-jsnow@redhat.com>
 <8734uyeqng.fsf@pond.sub.org>
In-Reply-To: <8734uyeqng.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 15 Jan 2024 14:58:47 -0500
Message-ID: <CAFn=p-YAm6WR-zzDjR_xcNo8evQN57JVf6sd1qDOMNV5rhWxfQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/19] qapi: sort pylint suppressions
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 15, 2024 at 7:18=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/pylintrc | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
> > index 90546df5345..78b63af4df6 100644
> > --- a/scripts/qapi/pylintrc
> > +++ b/scripts/qapi/pylintrc
> > @@ -16,14 +16,14 @@ ignore-patterns=3Dschema.py,
> >  # --enable=3Dsimilarities". If you want to run only the classes checke=
r, but have
> >  # no Warning level messages displayed, use "--disable=3Dall --enable=
=3Dclasses
> >  # --disable=3DW".
> > -disable=3Dfixme,
> > +disable=3Dconsider-using-f-string,
> >          missing-docstring,
> >          too-many-arguments,
> >          too-many-branches,
> > -        too-many-statements,
> >          too-many-instance-attributes,
> > -        consider-using-f-string,
> > +        too-many-statements,
> >          useless-option-value,
> > +        fixme,
> >
> >  [REPORTS]
>
> Any particular reason for putting fixme last?
>

Uhh. You know, I have no idea? I swore I just used emacs to sort the
lines, but ... lol? You'd think I'd notice that this wasn't in
alphabetical order, but...

*cough* sorry



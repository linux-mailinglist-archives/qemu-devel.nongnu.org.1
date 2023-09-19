Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C147A5BB6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 09:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiVYd-0001kw-6P; Tue, 19 Sep 2023 03:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiVYZ-0001kW-Jd
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:54:03 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiVYY-0001Ql-1y
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 03:54:03 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-773bd514996so191549085a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695110041; x=1695714841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQXgsU4RZ5I1NRE5t7sRu1JVh0G05gyB1Ad+fK3odLA=;
 b=KJB0UIILwZ86h80V2aMRbIp36reYzccaYtiitANkUJOVXUNiDik2ZnX6ijeV53+YOE
 Y9JIUIv0iAZYiqE56pCtt019j4fef/bNMP8ElSIcBtYE21cnjMF8BBNEM8pf9M2EoPTB
 YF9oEVdMdwb8yySPjEs+qDlc54Q/1izSYKIOW2lb3WiD95i/wBWHVyD3yZwXf3TA1AgR
 rWB31oo2r0S//DhEcUJUyOJCldkDmATq0wAXM+JV/0NSABYSpqT53AkaItm7vgvrKjH9
 6EBbNQ886szk9utNi/YtzjbyDjnjz2AIb+EXgrLg5hVIin600UYhKbFCTlr4jq7QdQiY
 a1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695110041; x=1695714841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQXgsU4RZ5I1NRE5t7sRu1JVh0G05gyB1Ad+fK3odLA=;
 b=SmkBF1g+OtscxWjNmXResxLI9HL0HCzwqPfXUk9W/Xp3cZrbrq7f7HOpGoIQEmSLrW
 PbarG2DlYdRBzf52A1QP5v/2JRJggs+rsai3Rb9cQr6Io+LNWDyM3Wz176EtVobNj0+g
 7Fz4+Q+2CXsxQgIFChWTYhJQkyA/m5r+3emMKRDthpahUrTr4enScht8jXUis7GU6e+C
 aWQEW0DfA6xXI6VQcnpobICflzoI9k2dm3xjywrTcDqnMd9jwOZ1+d6fpC5N+wLpFKD5
 Bg7nRQXhxdakms+G7TOKbF6/LwpOgVa5qiFg6Xxjy8ENG6tjmzXjQNIt1ImmvClNs9+L
 wGXg==
X-Gm-Message-State: AOJu0YzO6/3uEpbhFLenGtL1FUcXFbFcWY4OQQp9DHUm5XmCTCsHKyIR
 DyqWYabKg87gQ51rcwthiEaZ0BtZ/q6O6CCmC9U=
X-Google-Smtp-Source: AGHT+IHklbOAD1AVVEnNry7IGaqM4zFleJ07wtPLX/VPsVMSoptSSqBifjm52FrTpnLbsyRZTWRZv1MvggCClyY0mls=
X-Received: by 2002:a05:622a:4a16:b0:412:2284:cb33 with SMTP id
 fv22-20020a05622a4a1600b004122284cb33mr13432757qtb.48.1695110040960; Tue, 19
 Sep 2023 00:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
In-Reply-To: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2023 11:53:49 +0400
Message-ID: <CAJ+F1CLLgb=mYxf69gb+DpNQHrdOFY24Ax0eYfkVS4NxQ=NEgg@mail.gmail.com>
Subject: Re: [PATCH v3 qemu 0/3] Allow dump-guest-memory to output standard
 kdump format
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Sep 19, 2023 at 3:32=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hello all,
>
> This is the third version of the kdump patch series, the first and
> second revisions being visible at [1] and [2] respectively. You can see
> the history and motivation for the patch series described in the cover
> letter of [2].
>
> Thank you for your continued feedback and review.
> Stephen
>
> Changes from v2 to v3:
> - Rather than use "reassembled" flag in QMP API, represent each kdump
>   format "kdump-X" with a new enumerator "kdump-raw-X". (The HMP
>   interface retains the -R option)
> - Return an error if the file descriptor passed in is not seekable, yet
>   the requested dump format is kdump-raw-*
>
> Changes from v1 to v2:
> - Keep the default as the flattened format
> - Add QMP / HMP arguments for "reassembled"
>
> [1]: https://lore.kernel.org/qemu-devel/20230717163855.7383-1-stephen.s.b=
rennan@oracle.com/
> [2]: https://lore.kernel.org/qemu-devel/20230914010315.945705-1-stephen.s=
.brennan@oracle.com/
>
> Stephen Brennan (3):
>   dump: Pass DumpState to write_ functions
>   dump: Allow directly outputting raw kdump format
>   dump: Add command interface for kdump-raw formats
>
>  dump/dump-hmp-cmds.c  | 21 +++++++--
>  dump/dump.c           | 99 +++++++++++++++++++++++++++++++------------
>  hmp-commands.hx       |  9 +++-
>  include/sysemu/dump.h |  3 +-
>  qapi/dump.json        | 24 +++++++++--
>  5 files changed, 119 insertions(+), 37 deletions(-)
>
> --
> 2.39.3
>

For the series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau


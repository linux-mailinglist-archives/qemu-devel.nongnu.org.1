Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF07E3521
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 07:16:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0FNK-0004qQ-1f; Tue, 07 Nov 2023 01:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0FNI-0004pn-FX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 01:15:44 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0FNF-0000Qd-Lu
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 01:15:44 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cc7379b23so34019371cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 22:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699337740; x=1699942540; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLdhgPf4LdaB4nUthxIWRyr7VExyq8QfIg0WUEm+V+k=;
 b=SqxaiZXd1FXKyiVCP7GqgYDiZIppkmmB8Dh/oK3lGV1omd9iFu1+3f8ySg2uLwz0lt
 Ql6mrnF4jmedxMaUP3fkXVnSShH56sx4pvgBvEFD5qTyrl921auGTUlyGd/hAB2YFYym
 q8dEpqyidmzW9WOGElPSGdXceCJW5vAo2X4xzTMhacy3o8TEDvNNv97Am27cUoBwoAV0
 GcuhTZ7u0VEVi3eItVmf/3pYcHeyIftYMWF4JVLpsOlxnYTfPPvfL4m/RFzYzhMWRl9w
 TMAhA0JLSokOiT2pGfFxxIQL2Qb3//u+VDtFqjjd19mXNcN2q2HxVAr2HtZLFTdp7rd8
 TytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699337740; x=1699942540;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLdhgPf4LdaB4nUthxIWRyr7VExyq8QfIg0WUEm+V+k=;
 b=LwD5iE4blHYerBiinFBRDKcrU56dqtethMtoBwMPaVpIAi2dmBJRY/NQEs6WpAwHwz
 RwX8wOOQ/mxa1DbJdGIzakJvubTSMEAKH0myM0E/TbeUSUhSQHsDFY9+jbpVZZ8ncIAV
 heWgQXmASa0VqC9CM2yauPeaNcaBBq2xIN1bp8fzrIeA8JnlRpDAfIdIFilMD2PWEREh
 3O1M/onsvc2doH3U/SVQkD6rDSAO8Gq2Im2cvAZpHwIdqnauigNxACjSuN3KyNhqVcCq
 9z95VxEJ/MaIr4Ukz2Wk3CHvEdVZhbMfnjEuokVaBHwOvQ6okBbJshOtHZJKbbV69qu8
 +tcw==
X-Gm-Message-State: AOJu0YwRiAX61BDbLPX7Ax5BeM/QmcJf3j6zIC0ou/p9MDVLgnDvr9Ua
 xonwJvd1v7DjacTqN0Dti2tFuTkoMVENYgUsK7SCq0gcmS+R+w==
X-Google-Smtp-Source: AGHT+IHJi3od/MLdgwUuDnUebT99UznkWpKg3sEla88otAJoD5BHnx5UNmuubcKXjZ2MuGq2TNhnZbUSGpiHLG5rBRs=
X-Received: by 2002:a05:622a:30f:b0:41c:d9e7:7782 with SMTP id
 q15-20020a05622a030f00b0041cd9e77782mr37943275qtw.68.1699337740299; Mon, 06
 Nov 2023 22:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20231107024417.585475-1-min_halo@163.com>
In-Reply-To: <20231107024417.585475-1-min_halo@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Nov 2023 10:15:28 +0400
Message-ID: <CAJ+F1C+HqF8646efF7vHGL4jQexUh9Q72T3SPvEXDbj4p7SyDg@mail.gmail.com>
Subject: Re: [PATCH] dump:Add close fd on error return to avoid resource leak
To: Zongmin Zhou <min_halo@163.com>
Cc: qemu-devel@nongnu.org, Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 7, 2023 at 10:07=E2=80=AFAM Zongmin Zhou <min_halo@163.com> wro=
te:
>
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 1c304cadfd..ad5294e853 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*protocol,
>          return;
>      }
>      if (kdump_raw && lseek(fd, 0, SEEK_CUR) =3D=3D (off_t) -1) {
> +        close(fd);
>          error_setg(errp, "kdump-raw formats require a seekable file");
>          return;
>      }
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau


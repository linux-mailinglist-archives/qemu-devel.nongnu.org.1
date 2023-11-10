Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE67E7C97
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 14:37:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Rg5-0006sZ-7r; Fri, 10 Nov 2023 08:36:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r1Rg2-0006sD-QP; Fri, 10 Nov 2023 08:36:02 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r1Rfx-0005oj-VS; Fri, 10 Nov 2023 08:36:02 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso12883161cf.1; 
 Fri, 10 Nov 2023 05:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699623356; x=1700228156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0nymBsNPhPIGdYq6+vcoidwiFlpRSyGxvMWxkNklFQM=;
 b=A7LgEh3KimlJC4MfvH12GFylTkc3/1s6dHdO0RcxgO7maz7hOmfblhzse5Bqdaomoi
 EPGh1OYRzuteFKCHFH0kqeqW6OUSMx9D1bFxXRyJ9S+dIOdz3Lfqok3w8JfYI6S2EnDp
 P0PRiSRbHYJShVipnLmKwTdOviE6Auh5dnqbhLkYl11b+NoozbjOSPKXZWwim6x0OD47
 3rTnYWopP//Cp+/CRJLWHUF2+LVhGPk83yM8EkHq9uLllIzwqvuZ1O6+DVahRyCwwUh1
 dqCDRs/1n5UdvGa+qx/N/YXP0z6CAPPrgmdYHzPlEefwj5rzb2akPqYQlzRomH6M76Mq
 QdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699623356; x=1700228156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0nymBsNPhPIGdYq6+vcoidwiFlpRSyGxvMWxkNklFQM=;
 b=uXogIcn/xQM9P6q+Vp+Jf1b6TC1/FMRJEHSs+1TyGmBV8y7v3//VGoOv3xIEJuZ1mV
 SG4499cZYZolYz0Hsp2UF/EvqutusJuTsBYRp52ptx1xsH8lASd99vNyugoy6zDwF4c0
 RUKW4xhXy/+104cQVHZ3N2GLG9CR1QPEgI6RflpyWgj/Gwb+LNL0dRkOla4SGShC2sTc
 IsMaFOMElC8pbQ3CUApY/3OUi8NhP/+yVmnklEXI6pYZbC761+Cm3WNcE+bXxQG5idQi
 Djwg4iw1Wfxg1bV1MBmpFafnMyxVVn2LJIc/GNhJhw77Jr47b+ngr0E0UFXHNKqR7Wo0
 96VQ==
X-Gm-Message-State: AOJu0YwY7+twvL0bV7VA1AmB8Q+dF1n8DYaT/aF1LNB1bQOa3ROYGarS
 VPzZ1lA+2a+l6sKWmKvYM+UQtooQBMHdmT6O8tA=
X-Google-Smtp-Source: AGHT+IEt39jWu0thFffE2b0idjg9fRKI7mZY202wwJvxvrEtwn8RHIQgGeHxneJKt1oPVKWnNcwpXkLmjHc7di1Y/Pw=
X-Received: by 2002:a05:622a:130f:b0:41e:20b5:fc58 with SMTP id
 v15-20020a05622a130f00b0041e20b5fc58mr9128882qtk.47.1699623356364; Fri, 10
 Nov 2023 05:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20231109120443.185979-1-frankja@linux.ibm.com>
In-Reply-To: <20231109120443.185979-1-frankja@linux.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 Nov 2023 17:35:44 +0400
Message-ID: <CAJ+F1CLSDkE1dxEUwQxSU8u_LQVruSxYF+AozgR+TWgKgLkudA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] dump: Arch info function pointer addition and
 cleanup
To: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, 
 imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Nov 9, 2023 at 4:05=E2=80=AFPM Janosch Frank <frankja@linux.ibm.com=
> wrote:
>
> Small cleanups/fixes to the dump info function pointer assignments as
> well as a new function pointer for cleanup of residual state.
>
> This has come up because test managed to dump a s390 PV vm onto a disk
> that was too small for the dump. After the dump failed, the vm wasn't
> able to resume running since KVM was still in dump mode which blocks
> vcpu entry.
>
> The new function pointer allows cleanup of such a situation.
>
> v2:
>         - Usage of g_autofree
>         - Dropped explicit NULLing of function pointers
>
> Janosch Frank (3):
>   target/s390x/dump: Remove unneeded dump info function pointer init
>   dump: Add arch cleanup function
>   target/s390x/arch_dump: Add arch cleanup function for PV dumps
>
>  dump/dump.c                |  4 ++++
>  include/sysemu/dump-arch.h |  1 +
>  target/s390x/arch_dump.c   | 21 +++++++++++++++++----
>  3 files changed, 22 insertions(+), 4 deletions(-)
>

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau


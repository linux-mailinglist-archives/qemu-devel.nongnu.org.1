Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5447E9A5D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 11:35:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UH5-0004tP-1x; Mon, 13 Nov 2023 05:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r2UH2-0004sZ-N3; Mon, 13 Nov 2023 05:34:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r2UH1-0003oL-3E; Mon, 13 Nov 2023 05:34:32 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc938f9612so25027835ad.1; 
 Mon, 13 Nov 2023 02:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699871669; x=1700476469; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=59HHBygsX/8VsrY7VyDDRil1OBPfv2mut3ir82vY2fY=;
 b=Xiol+cJhgR0WGdF/xssC6L7rFhZlcuZcRHvwVF5kR8Z8eoOz1oTCM85nradn/nGCRv
 Tf+US0JBSnYQDOcxgpsojKqofaYxTW3nPUf6dLUuR+c/kqzkSxonMwzyOEizml0n2H9I
 7IQNar256PwJhBsuukA2fkUzg9N2mw7/mvvdm+5SvLTZdqVeFE5K27uepYBlDhN8YBtY
 pRXKRFSWhbcvm9NH6fzuQ+s4OepladSk8C5NmTEvVc8rRtnlcmXoabJYRJL87FHU4oN+
 aQ/lyJ3kDm5zTRXuxg3FIDv8//nZ49OeR4PE29XIqbouakwJaHUYpRzKKejmzJLk+E2l
 eKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699871669; x=1700476469;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=59HHBygsX/8VsrY7VyDDRil1OBPfv2mut3ir82vY2fY=;
 b=hZb/2tgK+X83e/kdzCOW9j4G00CgUTeokhWbrWuoOQ1sAK+DYMCs58/E0LP9ra7kp6
 GuzgnO4Go28ODna8NCQmRBxNKhqQZ58Ex7BOBd3dDHORmB98Wgknh9bAHEJ+7c9gs5Nc
 rCJme75BqDQfwikO3Q9vxR5Cr8/hHP60Hv7Q79U4dfUrvYzOqacyMeqJLl2Vqtw8+veP
 VoAhCDO4tAzIrmflHcXPiLvZu43IeVo04x15nq7HTshgYjWdDE2w6elDyzGFEj+j9gEY
 cD4cT9RkBE6WM+aALAxx0vEFMt4BhneqWnTkzD9XVtWiFooBRXa6gS6IgcbgtYdsSb81
 TehQ==
X-Gm-Message-State: AOJu0YxbnmFhJWhEriFjK0XiUC1kI96T3+bHY1vhhj+NSiE580c22c0z
 ePfl5Rlmt3Cb8NM5iRrdwc4=
X-Google-Smtp-Source: AGHT+IGXTY5mTeQcO3VUSMaEw/pqZ/uluOjkkEyIXKf62Wfh/6XvrN3Prn//GeXKHTtVMWRYwZhojg==
X-Received: by 2002:a17:903:32c1:b0:1cc:453f:517b with SMTP id
 i1-20020a17090332c100b001cc453f517bmr6129846plr.0.1699871669194; 
 Mon, 13 Nov 2023 02:34:29 -0800 (PST)
Received: from localhost (121-44-82-40.tpgi.com.au. [121.44.82.40])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902d90500b001bc5dc0cd75sm3745389plz.180.2023.11.13.02.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 02:34:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Nov 2023 20:34:23 +1000
Message-Id: <CWXM7PTSELOP.3T6EQY4GSFR59@wheely>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v4 0/8] Misc clean ups to target/ppc exception handling
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1698158152.git.balaton@eik.bme.hu>
 <c5d4e1dd-5da9-8efe-20f4-4bcdc24357fe@eik.bme.hu>
In-Reply-To: <c5d4e1dd-5da9-8efe-20f4-4bcdc24357fe@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Wed Nov 1, 2023 at 8:44 PM AEST, BALATON Zoltan wrote:
> On Tue, 24 Oct 2023, BALATON Zoltan wrote:
> > These are some small clean ups for target/ppc/excp_helper.c trying to
> > make this code a bit simpler. No functional change is intended. This
> > series was submitted before but only partially merged due to freeze
> > and conflicting series os thia was postponed then to avoid conflicts.
>
> Ping?

May just leave this for next release, sorry.

I still didn't like the change to logging -- that's not intended to
print some machine implementation detail, but the address of the
instruction that caused the syscall/hcall. That could be changed
easily enough.

But I am also now in two minds about the change to nip too.
Synchronous interrupt is today handled here with nip at the address
of the instruction that caused it. That's *also* a nice invaraint to
have.

Other patches seem okay.

Thanks,
Nick


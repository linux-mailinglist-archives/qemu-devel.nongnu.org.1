Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7973180E0F5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 02:45:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCroE-0003BL-Gt; Mon, 11 Dec 2023 20:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCroA-0003Aa-7e
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:43:38 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCro6-0001A2-8L
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 20:43:37 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54cd2281ccbso6825444a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 17:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702345411; x=1702950211;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRQdoRkwF8Wc0UNsQmjr2ouiyzqoGdpctCPrsGE4eZk=;
 b=ymH03nq8nQtfRRLZY3AUXnOL0YUoXYwTY19dBBieFFrAcvh8Z2lmWZD1YRnrlL2X5V
 6y6vz7G5+Uo52r+oukyEkQ6bWxye+niWPLHJWm3WXfYIdIZuaYX77pojDseaJ8iUpOiT
 kBdZSvyxWUjCDqE9yX6dpv7tyIQI/lY/Cg+dEZAEaD9fxZcGQ3J5u2MQvcAWOJR0gpfD
 +3ifUgaClG6vfxUJEcMlw8rCHvcHH54WJdItk3cHIwHRbBNgs0iMcfNcTRwKaT5rUGRL
 odsC7QOS3TSmLx+6NwtezaTMI2+TYk6QoxVi01nnbJI346KxQ/M7tOhJHtNUGc0DVw1w
 WJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702345411; x=1702950211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dRQdoRkwF8Wc0UNsQmjr2ouiyzqoGdpctCPrsGE4eZk=;
 b=gBN1pWnK05mnuC8MDjm5OxKakmtV+h9udOu/0tnjwPtS+J4NevdpOv4m6yqQdzgE05
 CdQFCItk/ZteLB9szCFCwAenXeCOBzHtZrRZGsGqjK3FXOAxOpobSjxMiyCfh9VsRCxX
 /BMOcDQd3fIu5kGORLLjgfoNqydYVcCtt3Efvzy8s+QBewe0mZuoY62wsRxYQ6m/bxnf
 fdt/rE/NKU3Eethi2pnxLjs6TqNsfJD03BbUmrYQb85IVBEdBgE7JtJs1hifWrmC59UK
 Y4H2T4YnOKPvy0DIj0oGnXnXxHgRMU6sWcSZ8rEQrOywBCxgs7LqXfTq0F832sbA0sFX
 bOSg==
X-Gm-Message-State: AOJu0YxTP4anTM0kWLZm2sGg+o7RYLd+V2mSqQoc7jju5RqUdlqHJtGU
 EYsHKYFfbtO+s6USAmArKNzcQ9U54KBQLcZ48NlxzQ==
X-Google-Smtp-Source: AGHT+IGuXXbUoHZg8oLKWEqXTnHqBDUXL39uyHqzo9JHsRd6q+l44dw+0yYTG7eiwNUkfKUlnJBvY5D2J/OSjYerYzc=
X-Received: by 2002:a17:907:1c2a:b0:9fc:3aeb:d2b9 with SMTP id
 nc42-20020a1709071c2a00b009fc3aebd2b9mr3476873ejc.71.1702345411024; Mon, 11
 Dec 2023 17:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
 <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
 <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
In-Reply-To: <CAFEAcA90fJgPGAjO0c4a=G+ge9bp1piVw40zt_rNHEoCTc_ngg@mail.gmail.com>
From: Tomoyuki Hirose <tomoyuki.hirose@igel.co.jp>
Date: Tue, 12 Dec 2023 10:43:15 +0900
Message-ID: <CAFS=Ec=fNB11TWWoJ847mF8v6=MkEefcMROwEyPQo9pceipNJg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/usb/hcd-xhci.c: allow unaligned access to
 Capability Registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-ed1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thanks for comment.

On Mon, Dec 11, 2023 at 10:57=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> We should definitely look at fixing the unaligned access
> stuff, but the linked bug report is not trying to do an
> unaligned access -- it wants to do a 2-byte read from offset 2,
> which is aligned. The capability registers in the xHCI spec
> are also all at offsets and sizes that mean that a natural
> read of them is not unaligned.

Shouldn't I link this bug report?
Or is it not appropriate to allow unaligned access?

thanks,
Tomoyuki HIROSE


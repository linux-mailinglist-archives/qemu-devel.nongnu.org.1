Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F5D815B8F
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 21:09:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEaxW-0000vJ-Dh; Sat, 16 Dec 2023 15:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEaxP-0000ux-Uu
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:08:19 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEaxN-0007rW-D7
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:08:19 -0500
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2ca208940b3so20924861fa.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 12:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702757296; x=1703362096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wW4LgyNHmAdgCexAKLTr6w0NP0rhJ/u40FZcWo59P9s=;
 b=eCI6s9I/VO8AqZCU2b5ruSs/ZVZoETJVXeYqFU70WpJwK5EJe3nZd36Wc7ZwuHfVjY
 uSHRZc9gaivOH8SJfa2cMWmxGH4gIEaF2uzGSyTe9DoabSkx0C082T8Q62tl9xBMQJkE
 tIfakgxvu7aVouXWaXUyxAYb+rxt9ixndYTncNi2w6OhH+EnzD9lVFwbmnMlIa6zyAJL
 wxxz1OI25Gc/Xd7ob+hd4HTFAtmS0JgMH3cfwWDF9GsJ8U3DNiWFfK6Fgs2SsmpKrdJv
 EvtsGyHuOxy5zOCY5JPjAYQ9H7fu1YQomTJ4G5/x9OA61mGd1bWUcm2ajGOwSmxnfaF3
 zxkw==
X-Gm-Message-State: AOJu0YxHEwa8hx7uMGGwbjxS2zNZ+SqLUQkph9kFXBc1/uQTZVzKPpIv
 MjJ3Ou6P2/87qD6P3DfeXrIVZmKcw8A=
X-Google-Smtp-Source: AGHT+IGtJ3ATKvYdpAscGOs5PbQ6sNu+1PvlmYLWvLmUYyO9OK4T0AGE3O5JRJlzdsFnQP7Kmjjepg==
X-Received: by 2002:a05:6512:3c95:b0:50e:20a6:2a36 with SMTP id
 h21-20020a0565123c9500b0050e20a62a36mr1536654lfv.133.1702757295528; 
 Sat, 16 Dec 2023 12:08:15 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a0565123e0800b0050bfb00108bsm2469447lfv.71.2023.12.16.12.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 12:08:15 -0800 (PST)
Date: Sat, 16 Dec 2023 21:08:12 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 07/12] next-cube.c: move static phase variable to NextRtc
Message-ID: <20231216210812.22c23f82@fedora>
In-Reply-To: <20231215200009.346212-8-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.169; envelope-from=th.huth@gmail.com;
 helo=mail-lj1-f169.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri, 15 Dec 2023 20:00:04 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The phase variable represents part of the state machine used to clock data out
> of the NextRtc device.
> 
> Note that this is a migration break for the NeXTRtc struct, but as nothing will
> currently boot then we simply bump the migration version for now.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE4A8309BA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:27:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7p9-0004WK-2l; Wed, 17 Jan 2024 10:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7p7-0004Uj-IY
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:27:25 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQ7p5-0000Cv-JX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:27:25 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-36074b286d6so56838235ab.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705505242; x=1706110042; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54nnBInn+lTaw6GFWx8aXkB+EeQC/m/n3UKJQHwCrjw=;
 b=C4z97PE48quFegB/oQORklOrM6ZEjurrUTqbUy6GUaNfzoY+tBjo1VfNEdsubDHxnR
 1wujatvx2A0atD9cL4pjRO0nNRpGIFIJU7pfiwohz2aQQ0Rz27YHCQMSXsH3M4nCSHnm
 qcE3PXOkGCQHe0afN0FO6/hSsKOO5Y2q+LXYX39c+vCvmWxUK2gDlkFSzCfo3Kfp1rr1
 Q3F9KtjVZihdDhjN5ALbBwkbGsAgM5VgUr37/7XfWz/b+iwAnt71rW0ho4xjecjJEW1b
 uSCxPrVcfBfoyVodDXahgoLzgR0w3xkOi1Fg4PQ6tPciB9/O5ZaSZSugTuhsxu82Jiqk
 iVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505242; x=1706110042;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54nnBInn+lTaw6GFWx8aXkB+EeQC/m/n3UKJQHwCrjw=;
 b=ZfgejmZd9LnbauxE5BuHQm/LkjYX6q17MuxidM6HIHEdnEdy8jyqB4taniDdhUNm07
 01u3tJVsxEeSupjV4g52dEl8YaWXLkZD+2mW+ErulJAxgqAV6HPmBsxQ7JX+TO0nJvaC
 qIzrXBuEShTkdqX3AuJrG5+2Ze3VbxJiDFrV5Nv9i9d83/bl/ZiULwedfVrVDeX3rVZp
 MCGA+YS0336FPRAbbVGtSYvSJmICDgba+11Apv2BR5xoZJUg4ZT2svdMVx0rYTIcwiEd
 9t5/Yme4XnbxeudclAYdxgYFgvg7y1HpGbxEJAUVDel39+VHp9duZBwdIL4DMfwqwrF1
 +H1Q==
X-Gm-Message-State: AOJu0YxwWEQ82QRH+YYF6+WqGuyL+OxxY6woD+84SlOT4x8hH9KKWt/0
 LC4D3e7qnwqMNxWxQObfjq/MMl81XgVzKeYyoyA=
X-Google-Smtp-Source: AGHT+IHDJ9ljuyujZu8BhewDToYXoZvVpj2iQfRFF9cNdoVPVmKE40VlXpYMbUZEvFEcS24aoMrbdIUNBpBKzPjt9ZQ=
X-Received: by 2002:a05:6e02:1b04:b0:360:e6b:bc65 with SMTP id
 i4-20020a056e021b0400b003600e6bbc65mr9888635ilv.55.1705505242183; Wed, 17 Jan
 2024 07:27:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
 <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
 <20240117143306.lnycf2ijwkzycowj@begin>
 <CAHP40mkk4aRG+9PGjoW2U38WXSvd1NpvDgMet4AQASg3=H=UdA@mail.gmail.com>
 <20240117150323.xn5otaf2ovg3hyp5@begin>
 <CAHP40mmG_SxUqhwysVzYt-c+UF5YVNqk2fBTZpHzAhLn7BCijw@mail.gmail.com>
 <20240117152230.bnnjln5mnhxuh5ib@begin>
In-Reply-To: <20240117152230.bnnjln5mnhxuh5ib@begin>
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Wed, 17 Jan 2024 16:27:17 +0100
Message-ID: <CAHP40mnLoa2TUh2MHyppYSicQeJgC8vUKwbYufRBGMGX+48DFA@mail.gmail.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
To: Manolo de Medici <manolodemedici@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, bug-hurd@gnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=manolodemedici@gmail.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Ok Samuel,
in the v2 of this patch series I will fix this bug in qemu.


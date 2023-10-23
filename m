Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F25787D373B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuRE-0000fr-8x; Mon, 23 Oct 2023 08:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1quuR2-0000eB-L3
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:53:34 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1quuR1-0005Or-8G
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:53:32 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7dafb659cso32496907b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698065608; x=1698670408; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0dDF3t2Y3R42MV4MvN3OUdTDsXY0CKI7/snKq5SAc4=;
 b=R5vPVvfEs3AoaKiZQQeRlLubCLQ6CIIJ+N50z+hCg8c/wwyFoJ6NuoWGqBCR97gz5Z
 HBXPm3lVaNycb/TBGcitK1vHiPjf0POUX6mFThBEpcOhLMtw+cd0k3OWP+DTGC4UI5vk
 ZW1djIoxMpTPnyxZBPQip2W9JIwh2bQoMGezzyymWYL6u/M7wGQ0knwYYJ6GTj88Yn6r
 jv/Xh4BJQT2Qy9DE3L21W5Xg9ES+fmB79Cr5hQ6CDWp+/qiKoKk4WBwL+DDOn9PHWFUP
 8VVp1vacTesWyHo1RL7jAkgAI+I5G4X8LnO4G8FLDQYFKhdbCdrbYFpRia/Wa0oUwLul
 yMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698065608; x=1698670408;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a0dDF3t2Y3R42MV4MvN3OUdTDsXY0CKI7/snKq5SAc4=;
 b=hAyFbexq/SxRtAiGN1T1hrPIaBdWD4UExxKULipdEwEUhuIOATD1tBIJ6WknRYa9h8
 noFa8hBMi/cazjKOQtYyFNG3UTAzLRIeJesAyT1fb7UK+BS9nVtNndbu+tvlfA7yRPzL
 iEHA3i/iNm+gIOP/1YVMMJNqFbXVSFjF1nh9uIf3Co0tYddZPFEfpRUTxU7PJmkTw/Qy
 VAR5Vso4+1L+kAV1Hw/4HFTOy6taqXhHU5rNJe0oWG+g61xvFZONv09PWI3+p5Bve6Ws
 C8Bs9YLKOJ2Pw4mfLMScjBzXjpvXZz+sD8S9UJo1pC4nju/KdFWjuAKKADGsfZpEm+r6
 wsLA==
X-Gm-Message-State: AOJu0Yy16/F2vwfDmVBpNpBQAjWQxkFBfzrkE/lWj95iBtzjdfGPddmM
 OzTZrL9BgjeDQTtmIyU6TJBTku23dg==
X-Google-Smtp-Source: AGHT+IEMi4W8m0puJVNpP1ZBEzlmfq4I3CmFYKoG4YFLgsxwMB3ol87bsecVta6rFbp/zmbQaEK3ig==
X-Received: by 2002:a0d:d989:0:b0:5a7:bfbf:691d with SMTP id
 b131-20020a0dd989000000b005a7bfbf691dmr9328525ywe.42.1698065608594; 
 Mon, 23 Oct 2023 05:53:28 -0700 (PDT)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 t78-20020a0dea51000000b005a7e6a68f0fsm3096353ywe.25.2023.10.23.05.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:53:27 -0700 (PDT)
Received: from mail.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:939d:9bb3:396f:9748])
 by serve.minyard.net (Postfix) with ESMTPSA id 2472B18000C;
 Mon, 23 Oct 2023 12:53:27 +0000 (UTC)
Date: Mon, 23 Oct 2023 07:53:25 -0500
From: Corey Minyard <minyard@acm.org>
To: Juan Quintela <quintela@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/ipmi: Don't call vmstate_register() from
 instance_init() functions
Message-ID: <ZTZsxfUm+ECJMpB4@mail.minyard.net>
References: <20231020145554.662751-1-thuth@redhat.com>
 <87pm15shj2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm15shj2.fsf@secure.mitica>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=tcminyard@gmail.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: minyard@acm.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Oct 23, 2023 at 01:30:09PM +0200, Juan Quintela wrote:
> Thomas Huth <thuth@redhat.com> wrote:
> > instance_init() can be called multiple times, e.g. during introspection
> > of the device. We should not install the vmstate handlers here. Do it
> > in the realize() function instead.
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> It fixes my issues.
> 
> Should I take this through the Migration tree?

That's fine with me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 


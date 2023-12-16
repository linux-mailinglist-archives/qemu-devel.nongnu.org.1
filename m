Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB51815B76
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 20:52:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEagr-0004BG-Ml; Sat, 16 Dec 2023 14:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEago-0004B7-Qu
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:51:10 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEagm-0000w7-P5
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:51:10 -0500
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-552d39ac3ccso2787299a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 11:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702756267; x=1703361067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xnq4OgtkzAJaq6d/jyLlY65i5ziV8GAqBorpFX3JDkg=;
 b=EG15pt9uoqfpS4VlHUOJ/1IpJGCJmk2+M+Rc9QXf2dQc6kvp3z85dCoTdZ4FpS2ySq
 dAkt9o9mrd6WhtHF8gJA6ZQ48B3lIe/FSgLENObc6tpW3X6WqR2zSp+/SETiIWBuzN7a
 xJihiZY03lYFf3i/oiQ6GUX/jnyGMhUMPxtwtsCiASI4cddKiGsmPwxcOD/wdVTc8wGT
 e3sA61MuRuD/RlxTh9Jr8FaI0zXJmegzXUDxuhxANPQtACXjpWA7Hohn0V6vuRsw88wZ
 o0IR4ETIiDCUHuqSfnM7X175HxKgI0ZX2Q7vbrHeUdSxoGBROJ80HfgVikeOIwVLjDbo
 Dzzg==
X-Gm-Message-State: AOJu0YwQBBFF3u5vnqqVXUCQAB4Zkk2frDi7dlCzJasPo+qlhMWYhXcd
 bqDpn9TYep7D3Il5WM7gjf2FvMoB780=
X-Google-Smtp-Source: AGHT+IHauVIPMjKIk1nQTpBD3/PQ+ZJ76y/CKVnEjFtJHC/g2PSIVzyCiklj74HXvlQgDTbvs/cO1A==
X-Received: by 2002:a17:906:f142:b0:a1d:5483:d152 with SMTP id
 gw2-20020a170906f14200b00a1d5483d152mr12965014ejb.68.1702756266937; 
 Sat, 16 Dec 2023 11:51:06 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 vw12-20020a170907a70c00b00a1c904675cfsm12101252ejc.29.2023.12.16.11.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 11:51:06 -0800 (PST)
Date: Sat, 16 Dec 2023 20:51:05 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 04/12] next-cube.c: update scr_ops to properly use
 modern memory API
Message-ID: <20231216205105.13cbe114@fedora>
In-Reply-To: <20231215200009.346212-5-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.48; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f48.google.com
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

Am Fri, 15 Dec 2023 20:00:01 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The old QEMU memory accessors used in the original NextCube patch series had
> separate functions for 1, 2 and 4 byte accessors. When the series was finally
> merged a simple wrapper function was written to dispatch the memory accesses
> using the original functions.
> 
> Convert scr_ops to use the memory API directly renaming it to next_scr_ops,
> marking it as DEVICE_BIG_ENDIAN, and handling any unaligned accesses.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 155 ++++++++++++++++----------------------------
>  1 file changed, 55 insertions(+), 100 deletions(-)


Reviewed-by: Thomas Huth <huth@tuxfamily.org>


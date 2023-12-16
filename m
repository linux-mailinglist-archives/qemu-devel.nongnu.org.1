Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DF815B4E
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 20:27:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEaIY-0006bQ-Jv; Sat, 16 Dec 2023 14:26:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEaIR-0006b0-A0
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:25:59 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEaIO-0006xr-71
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:25:58 -0500
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-a1f8f470903so209549166b.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 11:25:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702754754; x=1703359554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUEJPRrnTXK9AkdPglTkH+ukAqiV9x3V6exp85hPd90=;
 b=EQNoFdEUxUCANdrP0cdfkE+q6UJGKlH7IMfFFFouu4SVhOeLmv/+XSLDzP4wxzkDO9
 qk7D8HITNa4bajcsqE9mBbkqELoT5u2SCda7vvVypNK7h+TPrCoQSBHwaKz9litA7bGc
 dC3iuWBvNwrNhHvqeAe8IVHA/fuw/oR1/cfQn35Rx5K0mDb0/peVJhBig73DhRZyqtRP
 AoX2xhVG+xvnogxJnrkjv1JiwKL4CU/xW9FLJtWBD64nhqenRcmAhD7JlBAyKfx6BkDh
 ObDioRS4VPO2JWThi4gm3oLxj2/sc2gbKl1paUJCYQSK6bHGRcMwwdTc436OGCwmclNu
 W9NQ==
X-Gm-Message-State: AOJu0YwVRTtfOnhDVxn0T93/0mQkt45Jt8v8inwOJMAhJnp6wQ+H4KmC
 hcoiiWnlRLp9ajgBpUJvblM=
X-Google-Smtp-Source: AGHT+IFm/Ois9clZNFMp0+D0RgETTATwneyZTKntPQJppuerA4RJN1P4O9AkFY8BUQKxXBwM6VK/lg==
X-Received: by 2002:a17:906:c258:b0:a19:a19b:c701 with SMTP id
 bl24-20020a170906c25800b00a19a19bc701mr6481090ejb.81.1702754754028; 
 Sat, 16 Dec 2023 11:25:54 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 vv8-20020a170907a68800b00a1d2b0d4500sm12145888ejc.168.2023.12.16.11.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 11:25:53 -0800 (PST)
Date: Sat, 16 Dec 2023 20:25:51 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 03/12] next-cube.c: update mmio_ops to properly use
 modern memory API
Message-ID: <20231216202551.5eb03d57@fedora>
In-Reply-To: <20231215200009.346212-4-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.49; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f49.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am Fri, 15 Dec 2023 20:00:00 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The old QEMU memory accessors used in the original NextCube patch series had
> separate functions for 1, 2 and 4 byte accessors. When the series was finally
> merged a simple wrapper function was written to dispatch the memory accesses
> using the original functions.
> 
> Convert mmio_ops to use the memory API directly renaming it to next_mmio_ops,
> marking it as DEVICE_BIG_ENDIAN, and handling any unaligned accesses.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 156 +++++++++++++-------------------------------
>  1 file changed, 45 insertions(+), 111 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>


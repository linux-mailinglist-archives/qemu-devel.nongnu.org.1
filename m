Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D919B9E6D
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Nov 2024 10:49:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Akf-0001YQ-UY; Sat, 02 Nov 2024 05:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7Akd-0001Xy-KF
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:48:59 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t7Akc-00051z-7w
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 05:48:59 -0400
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so20695045e9.1
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 02:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730540936; x=1731145736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPHrCc02NPJwtTeEqmHlm7VloXH48XC6Hkj5eR7tmWg=;
 b=Lw1AJUvjKPyexx/2h/1SweDwspRLQ6DCOqkjE+i5NUBTk1t9aRB4eid+W1X4cW/2bq
 Il1wkfYe0KsVVa/DyCQxQDS2mvQt/3G02jYcggqVXKhHNl48SQvvTF6SPAYQtSziEsHb
 1HQY1FZ5tvJgWyvzNAmwmXH0TkNX+1OiFQRdQFLCKmtUwhu7A8caaYI8qhaYFafoHmBJ
 lkvbIVPokwkN7cmZFzV2eQgdlTGI1g8t2C3JUVrPHSKlxk/s+W3EJSiuD4ihjRqjMNOV
 bnV8BsXsoAuLwbQ63mPLkJMZgC8kxuHCLE2xcaiKH42QuRBcaI7K9gUjciIanhsXZzLj
 i0tg==
X-Gm-Message-State: AOJu0YyNOaso2k4oP2eHlyCyoCHBA30WoBASohEADxfEiH2fmH3yNERk
 dCI4w0MXjSF+RAMEE9+sNpxB1Jzb3W7zlmWXT2ullIQQCmSaFce8Jc7QpA==
X-Google-Smtp-Source: AGHT+IGm8Vk61k1SK2pExxRweJVvdpLrS2XvL/J8R1m0/P7M5jrah2lPz3aiJ0kSuOq39c3C2SunrA==
X-Received: by 2002:a05:600c:3107:b0:431:5871:6c5d with SMTP id
 5b1f17b1804b1-431bb976d71mr124712205e9.3.1730540936252; 
 Sat, 02 Nov 2024 02:48:56 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8524sm118184085e9.5.2024.11.02.02.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 02:48:55 -0700 (PDT)
Date: Sat, 2 Nov 2024 10:48:54 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 19/36] next-cube: convert next-pc device to use
 Resettable interface
Message-ID: <20241102104854.6efb2d78@tpx1>
In-Reply-To: <20241023085852.1061031-20-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.41; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am Wed, 23 Oct 2024 09:58:35 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Thomas Huth <huth@tuxfamily.org>


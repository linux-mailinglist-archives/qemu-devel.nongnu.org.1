Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79B9B95D5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Nov 2024 17:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ung-0004IV-Eh; Fri, 01 Nov 2024 12:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6unJ-0004GH-Mi
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:46:43 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t6unD-0003WA-99
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:46:36 -0400
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so23127295e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730479593; x=1731084393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcwsikpe009D1RghHL/7vrw0I3bK5cTMV+Ha8ezqBC0=;
 b=Zke65s4vhzg5EU6WScGQrRJUseGsy+nLCdkdC70Ppvk0UsB64YQwwqWsFbpTa7yLZY
 CIMznrl0nLxq+KP0mHduU1inv3q2CirOhNgvfwAEkROLIfioJPaaor1lyiUcYv1j4cDF
 vCeBHtPomh+sfXMmGjXs2+w/v7vxnFc9+7+8sdd862xVtYaMNRQkS14q5776rLpd6pQu
 HP6qP5pXMOgFavWNwZec08I2iyF+d9SRXl1eUmONlEASfi2dhuhgryARUt7tBhzmB8cr
 rJh3K4rutx0wrayTJVikZe1NXbrF5lIJ9amwzx9tVtJ6A/eW9Uw1k1GIif+P43IB268d
 0DsQ==
X-Gm-Message-State: AOJu0YwLYyAR8QYASi/lk9r4bUy4Y0Kd6bHukmTo11d8CijK/LzAPB+h
 QgPBHR9xuxUmvOhakIHI8HeATtDckNvpFDQ4KgnCYkxHhMfqMwwf
X-Google-Smtp-Source: AGHT+IF4IYoswEdFdKwD0CI9m8lYOqXng4Fkf+26qpswJn5k1q/l50TpxHktvzIqr5kT78GqRacP7g==
X-Received: by 2002:a05:6000:3c2:b0:37d:4cd6:e8e with SMTP id
 ffacd0b85a97d-381c7ae09fbmr3566893f8f.48.1730479593325; 
 Fri, 01 Nov 2024 09:46:33 -0700 (PDT)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983ddsm68730815e9.44.2024.11.01.09.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:46:32 -0700 (PDT)
Date: Fri, 1 Nov 2024 17:46:31 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 14/36] next-cube: move timer MMIO to separate memory
 region on next-pc device
Message-ID: <20241101174631.0f034827@tpx1>
In-Reply-To: <20241023085852.1061031-15-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.45; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f45.google.com
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

Am Wed, 23 Oct 2024 09:58:30 +0100
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Move the timer MMIO accesses to a separate memory region on the next-pc device
> instead of being part of the next.scr MMIO memory region.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 63 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 50 insertions(+), 13 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

